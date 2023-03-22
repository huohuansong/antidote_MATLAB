%% This is the configuration function
%
% Copyright (C) 2022-2023 Huohuansong huohuansong@outlook.com
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
% Only consider the readability and not the operating efficiency. This code can be optimized
% by yourself.

function [...
    ret_figure_dir, ...
    ret_func_logger, ...
    ret_func_progress_bar, ...
    ret_func_start, ...
    ret_func_end ...
] = config(output_dir, output_prefix, output_by)

    real_world_time_begin = datetime;

    if (strcmp(output_by, 'day'))
        now_str = datestr(now, 'yyyymmdd');
    elseif (strcmp(output_by, 'hour'))
        now_str = datestr(now, 'yyyymmdd_HH');
    elseif (strcmp(output_by, 'minute'))
        now_str = datestr(now, 'yyyymmdd_HHMM');
    else
        now_str = datestr(now, 'yyyymmdd_HHMMSS');
    end

    local_output_dir_current = [output_dir, '/', now_str];
    local_output_dir_last = [output_dir, '/last'];
    local_src_backup_dir = [local_output_dir_current, '/src_backup'];
    local_log_file_name = [local_output_dir_current, '/', output_prefix, '_log.txt'];
    local_work_area_file_name = [local_output_dir_current, '/', output_prefix, '_workarea.mat'];
    ret_figure_dir = [local_output_dir_current, '/figure'];

    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end
    if ~exist(local_output_dir_current, 'dir')
        mkdir(local_output_dir_current);
    end
    if ~exist(local_src_backup_dir, 'dir')
        mkdir(local_src_backup_dir);
    end
    if ~exist(local_output_dir_last, 'dir')
        mkdir(local_output_dir_last);
    end
    if ~exist(ret_figure_dir, 'dir')
        mkdir(ret_figure_dir);
    end

    ret_func_logger = @wrap_disp;
    function wrap_disp(msg)
        disp([datestr(now, '[yyyy-mm-dd HH:MM:SS] '), msg]);
    end

    ret_func_progress_bar = @func_progress_bar;
    function func_progress_bar(disp_prefix, progress)
        if ~exist('percent_prev', 'var')
            percent_prev = 0;
        end
        percent_now = 100 * progress;
        if (percent_now - percent_prev > 1) || (abs(percent_now - 100) < eps)
            percent_prev = percent_now;
            wrap_disp([disp_prefix, num2str(percent_now, '%.2f') ,' %']);
        end
    end

    ret_func_start = @func_start;
    function func_start()
        diary(local_log_file_name);
        wrap_disp('Start.');
    end

    ret_func_end = @func_end;
    function func_end()
        %% save work area
        save(local_work_area_file_name);
        wrap_disp('Save work area to file done.');

        %% back up the source files
        copyfile('*.m', local_src_backup_dir);
        wrap_disp(['Back up source files to directory "', local_src_backup_dir, '" done.']);

        %% copy output file to 'last' directory
        copyfile(local_output_dir_current, local_output_dir_last);
        wrap_disp(['Copy output files to directory "', local_output_dir_last, '" done.']);

        %% done
        wrap_disp(['ALL Done. Total time cost: ', char(datetime - real_world_time_begin)]);
        diary off;
    end
end