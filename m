Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9962D028F;
	Mon, 11 Aug 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911545; cv=none; b=SdFfUQ/IrbyHhAQ+nL0/e0rAg9K+w6buUyNre8HIS1Va9RNAnBk/jrjlAr8f4wpYCPa/OMXYBZ18/fjjghw88u/2OJf+ZnddCvvKHehccovT1psrcsItfDp49n5q8rZbd6ww5jWElh5Zr+G3QzdN4PqNQS3fOZLFLfTQABob3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911545; c=relaxed/simple;
	bh=0MxY8AVsxSKKR9+MvllHi1SUJ/aKgMZtuFNPjuADw8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbVDd+nn4ZFPbrP639HBgtOvfw0fOMtbu98KTfXyipwC+5LQuU1ppbPfFL3/QkWUqojrVA2Oud0lelvwrissjs5T8RTLsB8fkamoAHbDGKJs3njWm0AwVT2MbaR6B/eYhWPMZnNg/UHFrHygkFzX+iCdKpay3YOlSGrBEb/SFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A2E368AA6; Mon, 11 Aug 2025 13:25:37 +0200 (CEST)
Date: Mon, 11 Aug 2025 13:25:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: Re: [linus:master] [block]  9b8b84879d:  fio.read_iops 59.4%
 regression
Message-ID: <20250811112537.GA7448@lst.de>
References: <202508110626.949b00b5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202508110626.949b00b5-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 11, 2025 at 01:10:07PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 59.4% regression of fio.read_iops on:

From looking at the changes below, this applies to the iops reported
by vmstat.  Assuming that's the ones reported by vmstat -d, it counts
the disk IOPS.  Reducing them for the same large I/O size workload
would indeed by the intent of this change.

>        v6.16-rc4 9b8b84879d4adc506b0d3944e20 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     794920           -24.2%     602314        cpuidle..usage
>      19205           -19.2%      15517 ±  3%  meminfo.Shmem
>       1.96           -31.8%       1.34        iostat.cpu.system
>       1.20            -4.1%       1.15        iostat.cpu.user
>       0.46            -0.1        0.39        mpstat.cpu.all.irq%
>       0.41            -0.2        0.19 ±  2%  mpstat.cpu.all.soft%
>       1.07            -0.3        0.74        mpstat.cpu.all.sys%
>     537011           -59.3%     218357 ±  2%  vmstat.io.bi
>       3506           -44.0%       1963        vmstat.system.cs
>       2045           -21.3%       1609        vmstat.system.in
>   20391442           -71.1%    5903000 ±  7%  proc-vmstat.nr_foll_pin_acquired
>   20371384           -71.2%    5868357 ±  7%  proc-vmstat.nr_foll_pin_released
>       4810           -19.2%       3886 ±  3%  proc-vmstat.nr_shmem
>  1.633e+08           -59.3%   66380544 ±  2%  proc-vmstat.pgpgin
>       3372 ±  7%     -75.0%     842.18 ± 12%  sched_debug.cpu.clock_task.stddev
>     362239           -53.4%     168976        sched_debug.cpu.nr_switches.avg
>     573921           -62.6%     214563 ±  3%  sched_debug.cpu.nr_switches.max
>     219534 ±  9%     -40.2%     131216 ±  7%  sched_debug.cpu.nr_switches.min
>     142166 ±  8%     -76.5%      33405 ± 19%  sched_debug.cpu.nr_switches.stddev
>     252.27 ± 12%     -40.1%     151.04 ± 24%  sched_debug.cpu.nr_uninterruptible.max
>    -603.88           -51.9%    -290.65        sched_debug.cpu.nr_uninterruptible.min
>     352.77 ± 10%     -50.7%     173.92 ± 11%  sched_debug.cpu.nr_uninterruptible.stddev
>      79.78           -69.7       10.03 ± 17%  fio.latency_1000ms%
>      19.05 ±  4%     +63.5       82.55        fio.latency_2000ms%
>       0.09 ± 11%      +0.2        0.32 ± 22%  fio.latency_500ms%
>       1.03 ± 15%      +1.0        2.05 ± 16%  fio.latency_750ms%
>     531.17           -59.4%     215.81 ±  2%  fio.read_bw_MBps
>  1.032e+09           +74.2%  1.797e+09 ±  2%  fio.read_clat_90%_ns
>  1.059e+09           +88.5%  1.996e+09 ±  2%  fio.read_clat_95%_ns
>  1.111e+09         +1439.6%  1.711e+10        fio.read_clat_99%_ns
>  9.325e+08          +146.3%  2.296e+09 ±  2%  fio.read_clat_mean_ns
>   81374983 ±  4%   +6906.8%  5.702e+09 ±  7%  fio.read_clat_stddev
>     265.59           -59.4%     107.90 ±  2%  fio.read_iops
>   30096187          +146.2%   74087641 ±  2%  fio.read_slat_mean_us
>    8137305 ±  5%  +12002.2%  9.848e+08        fio.read_slat_stddev
>  3.265e+08           -59.3%  1.328e+08 ±  2%  fio.time.file_system_inputs
>       2.00           -50.0%       1.00        fio.time.percent_of_cpu_this_job_got
>     192892           -65.9%      65682        fio.time.voluntary_context_switches
>      79712           -59.3%      32412 ±  2%  fio.workload
>       0.04 ± 12%     +58.8%       0.06 ±  8%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>       0.04 ±  6%     +26.3%       0.05 ±  7%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.02 ±  9%   +1688.7%       0.28 ±215%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>      20.28           +79.9%      36.48 ±  5%  perf-sched.total_wait_and_delay.average.ms
>      10366           -57.3%       4429 ± 20%  perf-sched.total_wait_and_delay.count.ms
>       2608 ± 10%     +73.2%       4517 ± 16%  perf-sched.total_wait_and_delay.max.ms
>      20.26           +79.8%      36.42 ±  5%  perf-sched.total_wait_time.average.ms
>       2608 ± 10%     +73.2%       4517 ± 16%  perf-sched.total_wait_time.max.ms
>      12.62 ±  5%     -12.2%      11.08 ±  8%  perf-sched.wait_and_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
>      10.19 ±  3%   +2433.3%     258.14 ± 46%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       1251 ±  3%     +12.0%       1401 ±  5%  perf-sched.wait_and_delay.count.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
>       2688           -93.4%     178.00 ±237%  perf-sched.wait_and_delay.count.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio
>      26.88           -10.7%      24.00 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
>     820.75 ±  7%     +12.7%     924.62 ±  5%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      85.75 ± 12%     -30.0%      60.00 ± 21%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       3976           -93.5%     260.25 ±170%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>      12.62 ±  5%     -12.2%      11.08 ±  8%  perf-sched.wait_time.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
>      10.17 ±  3%   +2434.4%     257.87 ± 46%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>   51939177            -9.4%   47072722 ±  2%  perf-stat.i.branch-instructions
>       9.12            -1.5        7.62        perf-stat.i.branch-miss-rate%
>    3695435           -16.8%    3076023 ±  2%  perf-stat.i.branch-misses
>      36.34 ±  3%      +4.6       40.96        perf-stat.i.cache-miss-rate%
>    8932098 ±  2%     -29.9%    6263038        perf-stat.i.cache-misses
>   24645568           -37.9%   15296925        perf-stat.i.cache-references
>       3527           -44.1%       1971        perf-stat.i.context-switches
>       3.78            +7.3%       4.06        perf-stat.i.cpi
>  4.492e+08           -12.4%  3.934e+08        perf-stat.i.cpu-cycles
>      37.18 ±  8%     -35.4%      24.01 ± 16%  perf-stat.i.cpu-migrations
>      47.65 ±  2%     +39.6%      66.51 ±  5%  perf-stat.i.cycles-between-cache-misses
>  2.559e+08            -9.8%  2.309e+08 ±  2%  perf-stat.i.instructions
>       0.17           -16.3%       0.14 ±  3%  perf-stat.i.metric.K/sec
>      34.91 ±  2%     -22.6%      27.02        perf-stat.overall.MPKI
>       7.12            -0.6        6.54        perf-stat.overall.branch-miss-rate%
>      36.25 ±  3%      +4.6       40.89        perf-stat.overall.cache-miss-rate%
>       1.76            -3.1%       1.70        perf-stat.overall.cpi
>      50.32 ±  2%     +25.2%      62.99        perf-stat.overall.cycles-between-cache-misses
>       0.57            +3.2%       0.59        perf-stat.overall.ipc
>     964879          +122.7%    2148375 ±  2%  perf-stat.overall.path-length
>   51775109            -9.1%   47059552        perf-stat.ps.branch-instructions
>    3683872           -16.4%    3079080        perf-stat.ps.branch-misses
>    8902465 ±  2%     -30.0%    6234709        perf-stat.ps.cache-misses
>   24563872           -37.9%   15247155        perf-stat.ps.cache-references
>       3515           -44.2%       1963        perf-stat.ps.context-switches
>  4.477e+08           -12.3%  3.927e+08        perf-stat.ps.cpu-cycles
>      37.05 ±  8%     -35.2%      23.99 ± 16%  perf-stat.ps.cpu-migrations
>  2.551e+08            -9.5%  2.308e+08        perf-stat.ps.instructions
>  7.691e+10            -9.5%  6.959e+10        perf-stat.total.instructions
>      14.40 ± 13%     -11.2        3.15 ± 97%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>      14.28 ± 14%     -11.1        3.14 ± 98%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>       9.53 ± 18%      -7.6        1.95 ±104%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
>       9.40 ± 18%      -7.5        1.94 ±104%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.common_interrupt.asm_common_interrupt.cpuidle_enter_state
>      11.38 ± 10%      -7.4        3.93 ± 81%  perf-profile.calltrace.cycles-pp.syscall
>      10.63 ± 11%      -7.0        3.63 ± 80%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
>      10.43 ± 11%      -6.9        3.56 ± 80%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>       8.43 ± 12%      -6.5        1.92 ±104%  perf-profile.calltrace.cycles-pp.blk_done_softirq.handle_softirqs.__irq_exit_rcu.common_interrupt.asm_common_interrupt
>       9.51 ± 12%      -6.2        3.27 ± 79%  perf-profile.calltrace.cycles-pp.__x64_sys_io_submit.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>       9.40 ± 12%      -6.2        3.22 ± 79%  perf-profile.calltrace.cycles-pp.io_submit_one.__x64_sys_io_submit.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>       9.14 ± 12%      -6.0        3.10 ± 79%  perf-profile.calltrace.cycles-pp.aio_read.io_submit_one.__x64_sys_io_submit.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.04 ± 13%      -6.0        3.06 ± 79%  perf-profile.calltrace.cycles-pp.xfs_file_read_iter.aio_read.io_submit_one.__x64_sys_io_submit.do_syscall_64
>       8.92 ± 12%      -5.9        3.02 ± 78%  perf-profile.calltrace.cycles-pp.xfs_file_dio_read.xfs_file_read_iter.aio_read.io_submit_one.__x64_sys_io_submit
>       8.74 ± 12%      -5.8        2.90 ± 78%  perf-profile.calltrace.cycles-pp.iomap_dio_rw.xfs_file_dio_read.xfs_file_read_iter.aio_read.io_submit_one
>       8.73 ± 12%      -5.8        2.90 ± 78%  perf-profile.calltrace.cycles-pp.__iomap_dio_rw.iomap_dio_rw.xfs_file_dio_read.xfs_file_read_iter.aio_read
>       7.43 ± 10%      -5.7        1.70 ±106%  perf-profile.calltrace.cycles-pp.scsi_io_completion.blk_done_softirq.handle_softirqs.__irq_exit_rcu.common_interrupt
>       7.52 ± 10%      -5.7        1.80 ±107%  perf-profile.calltrace.cycles-pp.scsi_end_request.scsi_io_completion.blk_done_softirq.handle_softirqs.__irq_exit_rcu
>       7.58 ±  8%      -5.2        2.39 ± 79%  perf-profile.calltrace.cycles-pp.iomap_dio_bio_iter.__iomap_dio_rw.iomap_dio_rw.xfs_file_dio_read.xfs_file_read_iter
>       7.56 ± 13%      -4.9        2.62 ± 70%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       5.26 ± 10%      -3.9        1.41 ± 86%  perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.iomap_dio_bio_iter.__iomap_dio_rw.iomap_dio_rw.xfs_file_dio_read
>       5.18 ± 10%      -3.8        1.38 ± 87%  perf-profile.calltrace.cycles-pp.__submit_bio.submit_bio_noacct_nocheck.iomap_dio_bio_iter.__iomap_dio_rw.iomap_dio_rw
>       5.13 ± 10%      -3.8        1.37 ± 86%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck.iomap_dio_bio_iter.__iomap_dio_rw
>       3.73 ±  6%      -2.9        0.78 ±108%  perf-profile.calltrace.cycles-pp.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
>       3.93 ± 13%      -2.9        1.00 ± 74%  perf-profile.calltrace.cycles-pp.__blk_mq_alloc_requests.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck.iomap_dio_bio_iter
>       3.65 ±  7%      -2.9        0.77 ±108%  perf-profile.calltrace.cycles-pp.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state
>       3.81 ± 14%      -2.8        0.99 ± 73%  perf-profile.calltrace.cycles-pp.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck
>       4.21 ± 22%      -2.7        1.48 ± 71%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work.worker_thread.kthread
>       4.24 ± 22%      -2.7        1.53 ± 71%  perf-profile.calltrace.cycles-pp.blk_mq_run_work_fn.process_one_work.worker_thread.kthread.ret_from_fork
>       4.56 ± 20%      -2.7        1.91 ± 68%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       4.04 ± 22%      -2.6        1.48 ± 71%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work.worker_thread
>       3.14 ±  9%      -2.5        0.66 ±109%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt
>       2.91 ±  8%      -2.3        0.59 ±109%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt
>       2.72 ±  9%      -2.2        0.51 ±107%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       2.64 ±  9%      -2.1        0.50 ±108%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
>       2.76 ± 27%      -1.1        1.71 ± 26%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
>       2.64 ± 28%      -1.0        1.64 ± 27%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
>       1.28 ± 20%      -0.8        0.48 ± 85%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.common_startup_64
>       0.98 ± 36%      -0.7        0.31 ±101%  perf-profile.calltrace.cycles-pp.blk_mq_run_hw_queue.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio.__submit_bio
>       0.97 ± 22%      -0.7        0.32 ±103%  perf-profile.calltrace.cycles-pp.tick_nohz_restart_sched_tick.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
>       1.29 ± 11%      -0.3        0.95 ± 20%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
>       0.28 ±100%      +0.7        0.97 ± 35%  perf-profile.calltrace.cycles-pp.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread.ret_from_fork
>       0.26 ±173%      +1.9        2.18 ± 45%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       0.26 ±173%      +1.9        2.18 ± 45%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt
>       0.07 ±264%      +2.0        2.02 ± 69%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
>       0.07 ±264%      +2.0        2.02 ± 69%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
>       0.07 ±264%      +2.0        2.11 ± 66%  perf-profile.calltrace.cycles-pp._Fork
>       1.23 ± 41%      +6.8        7.99 ± 59%  perf-profile.calltrace.cycles-pp.delay_tsc.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
>       3.68 ± 13%     +16.8       20.52 ± 57%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
>       6.33 ±  5%     +23.0       29.34 ± 55%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
>       6.47 ±  4%     +23.4       29.91 ± 55%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit._printk
>      14.58 ± 13%     -11.2        3.34 ± 90%  perf-profile.children.cycles-pp.asm_common_interrupt
>      14.45 ± 13%     -11.1        3.33 ± 90%  perf-profile.children.cycles-pp.common_interrupt
>      11.46 ±  9%      -7.5        3.96 ± 81%  perf-profile.children.cycles-pp.syscall
>       8.70 ± 11%      -6.5        2.18 ± 94%  perf-profile.children.cycles-pp.blk_done_softirq
>       9.51 ± 12%      -6.2        3.27 ± 79%  perf-profile.children.cycles-pp.__x64_sys_io_submit
>       9.40 ± 12%      -6.2        3.22 ± 79%  perf-profile.children.cycles-pp.io_submit_one
>       9.14 ± 12%      -6.0        3.10 ± 79%  perf-profile.children.cycles-pp.aio_read
>       9.04 ± 13%      -6.0        3.06 ± 79%  perf-profile.children.cycles-pp.xfs_file_read_iter
>       8.92 ± 12%      -5.9        3.02 ± 79%  perf-profile.children.cycles-pp.xfs_file_dio_read
>       8.74 ± 12%      -5.8        2.90 ± 78%  perf-profile.children.cycles-pp.iomap_dio_rw
>       8.73 ± 12%      -5.8        2.90 ± 78%  perf-profile.children.cycles-pp.__iomap_dio_rw
>       7.67 ±  9%      -5.7        1.95 ± 95%  perf-profile.children.cycles-pp.scsi_io_completion
>       7.66 ±  9%      -5.7        1.95 ± 95%  perf-profile.children.cycles-pp.scsi_end_request
>       7.59 ±  8%      -5.1        2.45 ± 74%  perf-profile.children.cycles-pp.iomap_dio_bio_iter
>       7.57 ± 13%      -4.9        2.63 ± 70%  perf-profile.children.cycles-pp.worker_thread
>       8.51 ± 11%      -3.8        4.66 ± 30%  perf-profile.children.cycles-pp.__schedule
>       5.28 ± 10%      -3.8        1.52 ± 72%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
>       4.57 ± 21%      -3.7        0.85 ± 46%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
>       5.18 ± 10%      -3.7        1.49 ± 73%  perf-profile.children.cycles-pp.__submit_bio
>       5.13 ± 10%      -3.7        1.48 ± 72%  perf-profile.children.cycles-pp.blk_mq_submit_bio
>       3.45 ± 15%      -3.4        0.08 ±113%  perf-profile.children.cycles-pp.blk_mq_run_hw_queues
>       3.87 ±  6%      -2.9        0.93 ± 84%  perf-profile.children.cycles-pp.__common_interrupt
>       3.78 ±  7%      -2.9        0.92 ± 83%  perf-profile.children.cycles-pp.handle_edge_irq
>       3.93 ± 13%      -2.8        1.11 ± 54%  perf-profile.children.cycles-pp.__blk_mq_alloc_requests
>       4.82 ± 21%      -2.8        2.06 ± 52%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
>       5.42 ±  7%      -2.7        2.69 ± 36%  perf-profile.children.cycles-pp.schedule
>       3.82 ± 13%      -2.7        1.10 ± 54%  perf-profile.children.cycles-pp.blk_mq_get_tag
>       4.57 ± 20%      -2.7        1.91 ± 68%  perf-profile.children.cycles-pp.process_one_work
>       4.24 ± 22%      -2.6        1.59 ± 64%  perf-profile.children.cycles-pp.blk_mq_run_work_fn
>       4.64 ± 20%      -2.6        2.06 ± 52%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
>       3.32 ± 18%      -2.5        0.78 ± 90%  perf-profile.children.cycles-pp.mod_delayed_work_on
>       3.33 ± 18%      -2.5        0.80 ± 90%  perf-profile.children.cycles-pp.kblockd_mod_delayed_work_on
>       3.24 ±  9%      -2.5        0.78 ± 85%  perf-profile.children.cycles-pp.handle_irq_event
>       2.99 ±  8%      -2.3        0.70 ± 85%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
>       2.89 ±  7%      -2.2        0.66 ± 84%  perf-profile.children.cycles-pp.ahci_single_level_irq_intr
>       2.13 ± 12%      -1.8        0.38 ± 95%  perf-profile.children.cycles-pp.io_schedule
>       2.16 ±  4%      -1.6        0.55 ± 82%  perf-profile.children.cycles-pp.ahci_handle_port_intr
>       2.71 ± 13%      -1.6        1.13 ± 89%  perf-profile.children.cycles-pp.__queue_work
>       2.76 ± 10%      -1.5        1.30 ± 25%  perf-profile.children.cycles-pp.__pick_next_task
>       2.41 ± 11%      -1.4        1.06 ± 26%  perf-profile.children.cycles-pp.pick_next_task_fair
>       1.90 ± 16%      -1.3        0.58 ± 94%  perf-profile.children.cycles-pp.blk_update_request
>       2.25 ± 15%      -1.3        0.93 ± 92%  perf-profile.children.cycles-pp.kick_pool
>       3.62 ± 10%      -1.3        2.32 ± 35%  perf-profile.children.cycles-pp.enqueue_task_fair
>       1.71 ±  8%      -1.3        0.43 ± 87%  perf-profile.children.cycles-pp.ahci_qc_complete
>       3.28 ± 23%      -1.2        2.07 ± 27%  perf-profile.children.cycles-pp.schedule_idle
>       2.40 ± 28%      -1.2        1.22 ± 28%  perf-profile.children.cycles-pp.scsi_queue_rq
>       2.44 ± 11%      -1.1        1.33 ± 41%  perf-profile.children.cycles-pp.dequeue_entities
>       2.54 ± 12%      -1.1        1.45 ± 39%  perf-profile.children.cycles-pp.try_to_block_task
>       2.13 ±  9%      -1.0        1.08 ± 40%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
>       1.19 ± 40%      -1.0        0.21 ±123%  perf-profile.children.cycles-pp.__blk_flush_plug
>       1.58 ±  8%      -1.0        0.60 ± 83%  perf-profile.children.cycles-pp.bio_iov_iter_get_pages
>       1.56 ±  9%      -1.0        0.60 ± 84%  perf-profile.children.cycles-pp.__bio_iov_iter_get_pages
>       1.26 ± 14%      -1.0        0.31 ± 44%  perf-profile.children.cycles-pp.sched_balance_newidle
>       1.15 ± 40%      -1.0        0.20 ±122%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
>       1.27 ± 11%      -0.9        0.35 ± 83%  perf-profile.children.cycles-pp.ata_qc_complete_multiple
>       1.32 ± 20%      -0.9        0.42 ± 71%  perf-profile.children.cycles-pp.__wake_up_common
>       1.06 ± 42%      -0.9        0.20 ±122%  perf-profile.children.cycles-pp.blk_mq_dispatch_list
>       1.18 ± 21%      -0.9        0.33 ± 77%  perf-profile.children.cycles-pp.autoremove_wake_function
>       1.04 ± 16%      -0.8        0.21 ± 78%  perf-profile.children.cycles-pp.sbitmap_get
>       1.05 ± 16%      -0.8        0.23 ± 93%  perf-profile.children.cycles-pp.scsi_mq_get_budget
>       1.66 ± 18%      -0.8        0.88 ± 43%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
>       1.01 ± 52%      -0.7        0.26 ±104%  perf-profile.children.cycles-pp.sd_setup_read_write_cmnd
>       1.48 ± 16%      -0.7        0.74 ± 56%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
>       1.50 ± 16%      -0.7        0.75 ± 55%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
>       1.29 ±  9%      -0.7        0.59 ± 29%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
>       1.55 ± 11%      -0.7        0.86 ± 29%  perf-profile.children.cycles-pp.enqueue_dl_entity
>       1.56 ± 11%      -0.7        0.88 ± 28%  perf-profile.children.cycles-pp.dl_server_start
>       1.25 ± 26%      -0.7        0.59 ± 36%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
>       0.77 ± 21%      -0.7        0.12 ± 80%  perf-profile.children.cycles-pp.sbitmap_find_bit
>       1.07 ±  9%      -0.6        0.46 ± 37%  perf-profile.children.cycles-pp.__update_blocked_fair
>       1.38 ± 17%      -0.6        0.79 ± 28%  perf-profile.children.cycles-pp.timerqueue_add
>       0.99 ± 17%      -0.6        0.43 ± 29%  perf-profile.children.cycles-pp.start_dl_timer
>       1.25 ± 18%      -0.6        0.69 ± 43%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
>       0.73 ± 60%      -0.5        0.22 ±100%  perf-profile.children.cycles-pp.scsi_alloc_sgtables
>       0.58 ± 52%      -0.5        0.08 ±101%  perf-profile.children.cycles-pp.dd_dispatch_request
>       0.56 ± 55%      -0.5        0.08 ± 96%  perf-profile.children.cycles-pp.__dd_dispatch_request
>       0.75 ± 20%      -0.5        0.29 ± 96%  perf-profile.children.cycles-pp.iov_iter_extract_pages
>       0.71 ± 19%      -0.4        0.27 ± 93%  perf-profile.children.cycles-pp.pin_user_pages_fast
>       0.66 ± 18%      -0.4        0.24 ± 97%  perf-profile.children.cycles-pp.gup_fast_fallback
>       0.63 ± 18%      -0.4        0.23 ± 98%  perf-profile.children.cycles-pp.gup_fast
>       0.52 ± 77%      -0.4        0.14 ±116%  perf-profile.children.cycles-pp.dd_insert_requests
>       0.50 ± 16%      -0.4        0.13 ± 96%  perf-profile.children.cycles-pp.__x64_sys_io_getevents
>       0.58 ± 20%      -0.4        0.22 ± 95%  perf-profile.children.cycles-pp.gup_fast_pgd_range
>       0.46 ± 41%      -0.4        0.09 ± 91%  perf-profile.children.cycles-pp.scsi_finish_command
>       0.41 ± 17%      -0.4        0.06 ±121%  perf-profile.children.cycles-pp.bio_endio
>       0.46 ± 23%      -0.3        0.11 ±116%  perf-profile.children.cycles-pp.__ata_qc_complete
>       0.80 ± 16%      -0.3        0.47 ± 36%  perf-profile.children.cycles-pp.update_curr
>       0.51 ± 18%      -0.3        0.18 ± 52%  perf-profile.children.cycles-pp.__switch_to_asm
>       0.45 ± 19%      -0.3        0.12 ±104%  perf-profile.children.cycles-pp.do_io_getevents
>       0.46 ± 71%      -0.3        0.14 ± 95%  perf-profile.children.cycles-pp.iomap_iter
>       0.40 ± 20%      -0.3        0.10 ± 93%  perf-profile.children.cycles-pp.blk_mq_complete_request
>       0.38 ± 25%      -0.3        0.10 ±100%  perf-profile.children.cycles-pp.blk_mq_complete_request_remote
>       0.59 ± 14%      -0.3        0.33 ± 45%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
>       0.35 ± 27%      -0.3        0.10 ±104%  perf-profile.children.cycles-pp.gup_fast_pmd_leaf
>       0.33 ± 22%      -0.2        0.08 ±126%  perf-profile.children.cycles-pp.dma_direct_unmap_sg
>       0.36 ± 20%      -0.2        0.11 ±117%  perf-profile.children.cycles-pp.bio_alloc_bioset
>       0.35 ± 25%      -0.2        0.10 ±118%  perf-profile.children.cycles-pp.read_events
>       0.33 ± 31%      -0.2        0.09 ±113%  perf-profile.children.cycles-pp.aio_read_events_ring
>       0.34 ± 28%      -0.2        0.10 ±118%  perf-profile.children.cycles-pp.aio_read_events
>       0.28 ± 28%      -0.2        0.06 ±110%  perf-profile.children.cycles-pp.__sg_free_table
>       0.46 ± 23%      -0.2        0.24 ± 26%  perf-profile.children.cycles-pp.set_next_entity
>       0.27 ± 30%      -0.2        0.05 ±119%  perf-profile.children.cycles-pp.__blk_mq_end_request
>       0.34 ± 17%      -0.2        0.13 ± 75%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.42 ± 14%      -0.2        0.21 ± 35%  perf-profile.children.cycles-pp.switch_hrtimer_base
>       0.27 ± 37%      -0.2        0.07 ±100%  perf-profile.children.cycles-pp.__sg_alloc_table
>       0.47 ± 21%      -0.2        0.29 ± 23%  perf-profile.children.cycles-pp.set_next_task_fair
>       0.29 ± 33%      -0.2        0.11 ± 85%  perf-profile.children.cycles-pp.try_grab_folio_fast
>       0.41 ± 15%      -0.2        0.23 ± 27%  perf-profile.children.cycles-pp.switch_mm_irqs_off
>       0.34 ± 14%      -0.2        0.18 ± 36%  perf-profile.children.cycles-pp.get_nohz_timer_target
>       0.24 ± 89%      -0.2        0.08 ± 61%  perf-profile.children.cycles-pp.xas_find
>       0.20 ± 42%      -0.2        0.04 ±107%  perf-profile.children.cycles-pp._find_next_zero_bit
>       0.18 ± 40%      -0.1        0.05 ±117%  perf-profile.children.cycles-pp.aio_complete_rw
>       0.18 ± 33%      -0.1        0.06 ±101%  perf-profile.children.cycles-pp.refresh_cpu_vm_stats
>       0.24 ± 19%      -0.1        0.15 ± 42%  perf-profile.children.cycles-pp.perf_event_task_tick
>       0.12 ± 30%      -0.1        0.04 ±111%  perf-profile.children.cycles-pp.__dentry_kill
>       0.12 ± 63%      +0.4        0.51 ± 86%  perf-profile.children.cycles-pp.vms_clear_ptes
>       0.53 ± 13%      +0.5        0.99 ± 34%  perf-profile.children.cycles-pp.schedule_timeout
>       0.21 ± 43%      +0.9        1.11 ± 50%  perf-profile.children.cycles-pp.timer_expire_remote
>       0.23 ± 33%      +0.9        1.16 ± 49%  perf-profile.children.cycles-pp.tmigr_handle_remote_cpu
>       0.28 ± 32%      +1.0        1.26 ± 49%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
>       0.30 ± 28%      +1.0        1.29 ± 48%  perf-profile.children.cycles-pp.tmigr_handle_remote
>       0.39 ± 24%      +1.1        1.53 ± 50%  perf-profile.children.cycles-pp.call_timer_fn
>       0.48 ± 21%      +1.2        1.64 ± 50%  perf-profile.children.cycles-pp.__run_timers
>       0.37 ± 25%      +1.6        2.01 ± 70%  perf-profile.children.cycles-pp.__do_sys_clone
>       0.42 ± 20%      +1.7        2.11 ± 66%  perf-profile.children.cycles-pp._Fork
>       2.31 ± 14%      +6.9        9.21 ± 54%  perf-profile.children.cycles-pp.delay_tsc
>       4.38 ±  6%     +17.3       21.68 ± 57%  perf-profile.children.cycles-pp.io_serial_in
>       6.71 ±  4%     +24.2       30.93 ± 56%  perf-profile.children.cycles-pp.wait_for_lsr
>       6.81 ±  4%     +24.6       31.41 ± 56%  perf-profile.children.cycles-pp._printk
>       6.81 ±  4%     +24.6       31.41 ± 56%  perf-profile.children.cycles-pp.console_flush_all
>       6.81 ±  4%     +24.6       31.41 ± 56%  perf-profile.children.cycles-pp.console_unlock
>       6.81 ±  4%     +24.6       31.41 ± 56%  perf-profile.children.cycles-pp.serial8250_console_write
>       6.81 ±  4%     +24.6       31.41 ± 56%  perf-profile.children.cycles-pp.vprintk_emit
>       0.73 ± 23%      -0.6        0.11 ±112%  perf-profile.self.cycles-pp.ahci_single_level_irq_intr
>       1.28 ± 15%      -0.6        0.72 ± 30%  perf-profile.self.cycles-pp.timerqueue_add
>       0.80 ± 15%      -0.4        0.36 ± 43%  perf-profile.self.cycles-pp.__update_blocked_fair
>       0.76 ± 18%      -0.3        0.42 ± 35%  perf-profile.self.cycles-pp.__schedule
>       0.50 ± 20%      -0.3        0.18 ± 52%  perf-profile.self.cycles-pp.__switch_to_asm
>       0.45 ± 28%      -0.3        0.12 ± 78%  perf-profile.self.cycles-pp.ahci_handle_port_intr
>       0.37 ± 28%      -0.3        0.05 ± 88%  perf-profile.self.cycles-pp.__dd_dispatch_request
>       0.88 ± 14%      -0.3        0.57 ± 27%  perf-profile.self.cycles-pp.menu_select
>       0.33 ± 28%      -0.3        0.05 ±102%  perf-profile.self.cycles-pp.sbitmap_find_bit
>       0.31 ± 28%      -0.3        0.05 ±132%  perf-profile.self.cycles-pp.blk_mq_complete_request_remote
>       0.33 ± 22%      -0.2        0.08 ±126%  perf-profile.self.cycles-pp.dma_direct_unmap_sg
>       0.27 ± 22%      -0.2        0.04 ±108%  perf-profile.self.cycles-pp.blk_mq_submit_bio
>       0.50 ± 21%      -0.2        0.27 ± 34%  perf-profile.self.cycles-pp.update_curr
>       0.34 ± 18%      -0.2        0.12 ± 76%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.28 ± 23%      -0.2        0.10 ±105%  perf-profile.self.cycles-pp.dma_direct_map_sg
>       0.26 ± 61%      -0.2        0.08 ±100%  perf-profile.self.cycles-pp.sbitmap_get
>       0.28 ± 27%      -0.1        0.14 ± 35%  perf-profile.self.cycles-pp.dequeue_entity
>       0.22 ± 23%      -0.1        0.11 ± 33%  perf-profile.self.cycles-pp.finish_task_switch
>       2.31 ± 14%      +6.9        9.21 ± 54%  perf-profile.self.cycles-pp.delay_tsc
>       4.38 ±  6%     +17.3       21.68 ± 57%  perf-profile.self.cycles-pp.io_serial_in
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
---end quoted text---
