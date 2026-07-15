Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F339AD39;
	Wed, 15 Jul 2026 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125818; cv=none; b=i/kVO9pFJhdb02hj0lD04hhDrzM7q7Yx1vxmLVv51dKzZUuSTO7s0z+1ul4g1Fe9zPyy/uN7PqkyZ3T6g7NxWuX0eihwjfEFN5k3OODgIbToF18v4XZz4TdEYtG2bbQHqiJMiszLMbQvg57LxGnZvkGTisAejUBJW5X+qOKrZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125818; c=relaxed/simple;
	bh=Di6moiyL3Uc6xzFsmxWAbvvhEPlL5pZDxBhR7OCRcfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn5dSOpgWpoClSA2+txHFDnh7hxghcJSiKWUWf5FhyOgeuXf+K0hRZo2ZutWqqAdK3rnogALozGMNkTg0JWe/q5ZXEqKM16VXT46MK6CJpLxeKxodM/Tlg4tCVbArPCD3ngwY6umxyuUHCKfhfS0yFLy+8QvaQSrjH0F1CTx1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WXHRNLDn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WXHRNLDn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Fa1wUg6AnrecDaVuSFq5udeGp4PQ959n27DL7jhHaOY=; b=WXHRNLDnLopQBVzuQb85wq8BD8
	PH4WWbVVialuwuYsb9Q7Hc9KJI2sgfyc1mWLCb8UdbrirIyC+W8g21cBLYNxlr+bMQyeySgRZoIDA
	z7/BWWEK95025TN65r208tLYfd8keehadXLFIoOg48VLw2X2GEb78iBZX1Hc0iw8v4PmJIyC9iOUu
	+xFTKV39flOEkfqddseVj85SDUqbEaFyq//3q9Gwa5hk1rB+s28kf8V9h/F1wFB/tB4vImX6KgKKX
	4Nc1oHKkDL/4dXfaVj97PM0mEoB4mzMSDlcXctmW4DNiU2FjoiYyNqSOx5rB/NdjSvoWTyIHE1Eas
	x+/QJSvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk0cc-0000000F8dl-1JBZ;
	Wed, 15 Jul 2026 14:30:02 +0000
Date: Wed, 15 Jul 2026 07:30:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-next@vger.kernel.org, axboe@kernel.dk
Subject: Re: [linux-next:master] [loop]  d908729e74:
 stress-ng.umount.ops_per_sec 100.0% regression
Message-ID: <aleZammRRSVN4dl0@infradead.org>
References: <202607151655.9d74999d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202607151655.9d74999d-lkp@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

It's also a patch that has never been added to the maintainer
tree for goot reson. Tetsuo keeps doing this, so can we please
stop including their trees in linux-next as there seems to be
no other way to stop this?

On Wed, Jul 15, 2026 at 09:55:01PM +0800, kernel test robot wrote:
> 
> hi, Tetsuo Handa,
> 
> this report is just FYI.
> we understand d908729e74 is an experimental patch, and it seems there are lots
> of print while running stress-ng.umount tests (one dmesg is attached)
> 
> [   59.370110][T10457] do_umount: task=stress-ng-umoun[10457] propagate_mount_busy()!=0
> [   59.394831][T10476] do_umount: task=stress-ng-umoun[10476] propagate_mount_busy()!=0
> [   59.404989][T10477] do_umount: task=stress-ng-umoun[10477] propagate_mount_busy()!=0
> [   59.414578][T10473] do_umount: task=stress-ng-umoun[10473] propagate_mount_busy()!=0
> [   59.423911][T10460] do_umount: task=stress-ng-umoun[10460] propagate_mount_busy()!=0
> 
> ....
> 
> 
> so the very slow performance is expected?
> 
> just FYI what we observed in our tests.
> 
> 
> 
> Hello,
> 
> kernel test robot noticed a 100.0% regression of stress-ng.umount.ops_per_sec on:
> 
> 
> commit: d908729e7467462bce1db3bc1bffec2e2d1f6c81 ("loop: Fix NULL pointer dereference in lo_rw_aio()")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [still regression on linux-next/master bee763d5f341b99cf472afeb508d4988f62a6ca1]
> 
> testcase: stress-ng
> config: x86_64-rhel-9.4
> compiler: gcc-14
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> parameters:
> 
> 	nr_threads: 100%
> 	testtime: 60s
> 	test: umount
> 	cpufreq_governor: performance
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202607151655.9d74999d-lkp@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260715/202607151655.9d74999d-lkp@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-spr-2sp4/umount/stress-ng/60s
> 
> commit: 
>   c84e50ccc1 ("net: add "struct dst_entry" debugging")
>   d908729e74 ("loop: Fix NULL pointer dereference in lo_rw_aio()")
> 
> c84e50ccc177911c d908729e7467462bce1db3bc1bf 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      60.09          +312.8%     248.06 ±  5%  stress-ng.time.elapsed_time
>      60.09          +312.8%     248.06 ±  5%  stress-ng.time.elapsed_time.max
>      52760 ±  2%     -81.8%       9620 ±  7%  stress-ng.time.involuntary_context_switches
>     149488 ±  2%     +61.8%     241879        stress-ng.time.minor_page_faults
>       2821           -53.9%       1300 ±  4%  stress-ng.time.percent_of_cpu_this_job_got
>       1677           +92.6%       3230 ±  8%  stress-ng.time.system_time
>      17.97           -97.9%       0.37 ± 11%  stress-ng.time.user_time
>   77874729           -99.8%     190900 ± 11%  stress-ng.time.voluntary_context_switches
>     804634           -99.9%     470.83 ± 10%  stress-ng.umount.ops
>      13417          -100.0%       2.76 ± 11%  stress-ng.umount.ops_per_sec
>  1.203e+10 ±  4%    +327.1%  5.137e+10 ±  4%  cpuidle..time
>   94349745           -95.2%    4565944 ±  2%  cpuidle..usage
>    1703024 ± 34%     -76.9%     392929 ± 20%  numa-numastat.node0.local_node
>    1773100 ± 31%     -73.7%     466314 ± 18%  numa-numastat.node0.numa_hit
>     123.98          +151.7%     312.11 ±  3%  uptime.boot
>      25137          +155.4%      64209 ±  2%  uptime.idle
>    6352999 ± 29%     -74.7%    1607659 ±106%  numa-meminfo.node0.FilePages
>     704881 ± 39%     -94.1%      41446 ± 99%  numa-meminfo.node0.Mapped
>    8518453 ± 23%     -61.7%    3261125 ± 55%  numa-meminfo.node0.MemUsed
>    1588258 ± 29%     -74.7%     401984 ±106%  numa-vmstat.node0.nr_file_pages
>     176266 ± 39%     -94.1%      10389 ± 99%  numa-vmstat.node0.nr_mapped
>    1773189 ± 31%     -73.7%     466366 ± 18%  numa-vmstat.node0.numa_hit
>    1703113 ± 34%     -76.9%     392981 ± 20%  numa-vmstat.node0.numa_local
>     185.00 ±  5%     -95.4%       8.50 ± 27%  perf-c2c.DRAM.local
>       5701 ±  2%     -98.1%     107.83 ± 21%  perf-c2c.DRAM.remote
>       7783 ±  2%     -98.6%     112.50 ± 11%  perf-c2c.HITM.local
>       3903 ±  2%     -98.2%      71.50 ± 23%  perf-c2c.HITM.remote
>      11686 ±  2%     -98.4%     184.00 ±  7%  perf-c2c.HITM.total
>      86.78            +5.7%      91.72        vmstat.cpu.id
>    8536351 ±  3%     -48.1%    4429833        vmstat.memory.cache
>      33.29 ± 13%     -39.3%      20.20 ±  2%  vmstat.procs.r
>    2684019 ±  3%     -99.8%       6591 ±  3%  vmstat.system.cs
>    1442389 ±  3%     -97.2%      41079 ±  2%  vmstat.system.in
>      86.39            +5.2       91.64        mpstat.cpu.all.idle%
>       0.72 ±  3%      -0.7        0.04 ±  5%  mpstat.cpu.all.irq%
>       0.23 ±  4%      -0.2        0.02 ±  3%  mpstat.cpu.all.soft%
>      11.97 ±  3%      -3.7        8.25 ±  2%  mpstat.cpu.all.sys%
>       0.70 ±  3%      -0.6        0.06 ±  6%  mpstat.cpu.all.usr%
>      12.17 ± 20%     -83.6%       2.00        mpstat.max_utilization.seconds
>      49.16 ±  2%     +33.8%      65.80 ±  9%  mpstat.max_utilization_pct
>    2823884 ±  3%     -99.8%       6491 ±  2%  perf-stat.i.context-switches
>      84670 ±  4%     -99.6%     307.43 ±  2%  perf-stat.i.cpu-migrations
>       0.22 ±129%    +706.3%       1.80 ± 10%  perf-stat.i.major-faults
>       9097 ±  4%     -60.6%       3586 ±  4%  perf-stat.i.minor-faults
>       9097 ±  4%     -60.6%       3587 ±  4%  perf-stat.i.page-faults
>    2775019 ±  3%     -99.8%       6370 ±  2%  perf-stat.ps.context-switches
>     220452            +1.2%     223093        perf-stat.ps.cpu-clock
>      83771 ±  4%     -99.7%     289.14 ±  2%  perf-stat.ps.cpu-migrations
>       0.22 ±129%    +641.0%       1.63 ±  9%  perf-stat.ps.major-faults
>       8892 ±  4%     -65.0%       3116 ±  3%  perf-stat.ps.minor-faults
>       8892 ±  4%     -64.9%       3118 ±  3%  perf-stat.ps.page-faults
>     220452            +1.2%     223093        perf-stat.ps.task-clock
>    4979826 ±  5%     -82.7%     859490        meminfo.Active
>    4979826 ±  5%     -82.7%     859490        meminfo.Active(anon)
>      67874 ±  3%    +218.5%     216208 ±  4%  meminfo.AnonHugePages
>     773451            -8.5%     707773        meminfo.AnonPages
>    8352548 ±  3%     -48.8%    4276142        meminfo.Cached
>   11362980 ±  2%     -56.4%    4957049        meminfo.Committed_AS
>     161454            -6.7%     150606        meminfo.KReclaimable
>      54472            -9.1%      49515        meminfo.KernelStack
>     869412 ±  6%     -87.2%     111056        meminfo.Mapped
>   12558346 ±  2%     -39.8%    7562575        meminfo.Memused
>      96084 ±  4%     -36.3%      61182        meminfo.PageTables
>     123466            -5.4%     116846        meminfo.Percpu
>     161454            -6.7%     150606        meminfo.SReclaimable
>    4211290 ±  6%     -96.3%     155777 ±  6%  meminfo.Shmem
>   12813481 ±  2%     -30.9%    8854911        meminfo.max_used_kB
>     493.83 ±  3%     -34.1%     325.67 ±  2%  turbostat.Avg_MHz
>      17.34 ±  3%      -8.6        8.76 ±  2%  turbostat.Busy%
>       2847           +30.5%       3716        turbostat.Bzy_MHz
>       0.73 ±  3%      -0.7        0.00        turbostat.C1%
>      63.69 ±  3%     -61.1        2.60 ±  3%  turbostat.C1E%
>      19.01 ± 15%     +69.6       88.65        turbostat.C6%
>      66.25 ±  3%     -78.0%      14.56        turbostat.CPU%c1
>       4.74 ± 69%   +1352.9%      68.84        turbostat.CPU%c6
>      57.83           -12.1%      50.83 ±  2%  turbostat.CoreTmp
>       0.40           -54.4%       0.18 ±  2%  turbostat.IPC
>   94123962           -89.4%    9950194 ±  4%  turbostat.IRQ
>    1479952           -46.5%     792469 ±  2%  turbostat.NMI
>       0.50 ±  4%      -0.5        0.00        turbostat.POLL%
>       1.34 ± 92%     -88.7%       0.15 ± 70%  turbostat.Pkg%pc2
>      58.33           -12.0%      51.33        turbostat.PkgTmp
>     444.18            -6.5%     415.23        turbostat.PkgWatt
>      24.82            -3.2%      24.01        turbostat.RAMWatt
>       2500           -39.3%       1516 ±  2%  turbostat.UncMHz
>    1245044 ±  5%     -82.7%     215013        proc-vmstat.nr_active_anon
>     193369            -8.5%     176889        proc-vmstat.nr_anon_pages
>      33.14 ±  3%    +221.0%     106.39 ±  4%  proc-vmstat.nr_anon_transparent_hugepages
>   12797945            +1.0%   12922865        proc-vmstat.nr_dirty_background_threshold
>   25627182            +1.0%   25877327        proc-vmstat.nr_dirty_threshold
>    2088218 ±  3%     -48.8%    1069227        proc-vmstat.nr_file_pages
>      54471            -9.2%      49470        proc-vmstat.nr_kernel_stack
>     217415 ±  6%     -87.3%      27713 ±  2%  proc-vmstat.nr_mapped
>      24021 ±  4%     -36.6%      15219 ±  2%  proc-vmstat.nr_page_table_pages
>    1052903 ±  6%     -96.3%      39135 ±  6%  proc-vmstat.nr_shmem
>      40363            -6.7%      37664        proc-vmstat.nr_slab_reclaimable
>     117592            -1.9%     115335        proc-vmstat.nr_slab_unreclaimable
>      76848            -1.4%      75760        proc-vmstat.nr_vmalloc
>    1245044 ±  5%     -82.7%     215013        proc-vmstat.nr_zone_active_anon
>      64270 ± 35%     -69.1%      19860 ± 76%  proc-vmstat.numa_hint_faults
>      43950 ± 48%     -73.5%      11651 ± 54%  proc-vmstat.numa_hint_faults_local
>    2412834 ±  3%     -56.1%    1059866        proc-vmstat.numa_hit
>    2176941 ±  4%     -62.0%     826445        proc-vmstat.numa_local
>     129575 ± 26%     -71.0%      37602 ± 94%  proc-vmstat.numa_pte_updates
>    2488714 ±  3%     -51.6%    1204079        proc-vmstat.pgalloc_normal
>     750242 ±  3%     +20.9%     906839 ±  2%  proc-vmstat.pgfault
>     664570 ±  2%     +68.4%    1118975        proc-vmstat.pgfree
>      36925 ±  5%     +16.8%      43128 ±  6%  proc-vmstat.pgreuse
>     825.17         +1301.6%      11565 ±  5%  proc-vmstat.unevictable_pgs_culled
>       7006 ±  2%    +325.6%      29822 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.avg
>      40462 ± 10%    +737.4%     338834 ± 21%  sched_debug.cfs_rq:/.avg_vruntime.max
>       3981 ±  3%     +28.2%       5102 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.min
>       5154 ±  7%    +782.7%      45498 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.stddev
>     710829 ± 34%     +49.1%    1059534 ± 11%  sched_debug.cfs_rq:/.load.max
>     150111 ± 10%     +37.8%     206893 ±  6%  sched_debug.cfs_rq:/.load.stddev
>       2208 ± 27%     -64.7%     779.66 ± 41%  sched_debug.cfs_rq:/.load_avg.avg
>      40413 ±  8%     -57.6%      17125 ± 10%  sched_debug.cfs_rq:/.load_avg.max
>       5.08 ± 26%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
>       7737 ± 16%     -63.3%       2839 ± 22%  sched_debug.cfs_rq:/.load_avg.stddev
>      76.72 ±118%     -94.9%       3.87 ± 36%  sched_debug.cfs_rq:/.removed.load_avg.avg
>      15144 ±136%     -98.5%     221.87 ± 10%  sched_debug.cfs_rq:/.removed.load_avg.max
>       1038 ±130%     -97.3%      28.42 ± 17%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>     249.83 ± 17%     -55.0%     112.31 ± 10%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>     249.75 ± 17%     -55.0%     112.31 ± 10%  sched_debug.cfs_rq:/.removed.util_avg.max
>       1081 ±  6%     +14.2%       1234 ±  7%  sched_debug.cfs_rq:/.runnable_avg.max
>       5.00 ± 25%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
>     162.44 ±  4%     +46.5%     238.00 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
>     108.77 ±  2%     -10.9%      96.96 ±  7%  sched_debug.cfs_rq:/.util_avg.avg
>       4.92 ± 25%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
>     162.14 ±  4%     +41.0%     228.54 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
>      10.43 ± 21%    +218.8%      33.23 ± 27%  sched_debug.cfs_rq:/.util_est.avg
>      80.66 ±  7%     +87.0%     150.81 ± 10%  sched_debug.cfs_rq:/.util_est.stddev
>       7006 ±  2%    +325.6%      29822 ±  7%  sched_debug.cfs_rq:/.zero_vruntime.avg
>      40462 ± 10%    +737.4%     338834 ± 21%  sched_debug.cfs_rq:/.zero_vruntime.max
>       3981 ±  3%     +28.2%       5102 ± 10%  sched_debug.cfs_rq:/.zero_vruntime.min
>       5154 ±  7%    +782.7%      45498 ± 10%  sched_debug.cfs_rq:/.zero_vruntime.stddev
>     624650 ±  2%     +53.9%     961556        sched_debug.cpu.avg_idle.avg
>      22687 ± 24%    +662.8%     173061 ±  8%  sched_debug.cpu.avg_idle.min
>     251512 ±  3%     -54.5%     114548 ±  8%  sched_debug.cpu.avg_idle.stddev
>      91182 ±  2%     +89.7%     172996 ±  7%  sched_debug.cpu.clock.avg
>      91204 ±  2%     +89.7%     173016 ±  7%  sched_debug.cpu.clock.max
>      91159 ±  2%     +89.7%     172961 ±  7%  sched_debug.cpu.clock.min
>      90721 ±  2%     +90.4%     172755 ±  7%  sched_debug.cpu.clock_task.avg
>      90895 ±  2%     +90.3%     172941 ±  7%  sched_debug.cpu.clock_task.max
>      76103 ±  2%    +104.2%     155431 ±  7%  sched_debug.cpu.clock_task.min
>     989.42           +18.4%       1171 ±  2%  sched_debug.cpu.clock_task.stddev
>      10278           +18.0%      12129 ±  2%  sched_debug.cpu.curr->pid.max
>       1.17 ± 20%     +45.7%       1.70 ± 14%  sched_debug.cpu.nr_running.max
>     385890           -98.9%       4198 ± 10%  sched_debug.cpu.nr_switches.avg
>     443274           -89.4%      47022 ± 29%  sched_debug.cpu.nr_switches.max
>     235117 ± 13%     -99.5%       1244 ±  6%  sched_debug.cpu.nr_switches.min
>      26366 ±  9%     -79.6%       5375 ± 19%  sched_debug.cpu.nr_switches.stddev
>     117.33 ± 11%     -26.5%      86.22 ± 24%  sched_debug.cpu.nr_uninterruptible.max
>    -112.67           -85.1%     -16.74        sched_debug.cpu.nr_uninterruptible.min
>      39.13 ±  2%     -77.0%       8.99 ± 17%  sched_debug.cpu.nr_uninterruptible.stddev
>      91161 ±  2%     +89.7%     172977 ±  7%  sched_debug.cpu_clk
>       0.01 ±149%    +393.8%       0.03 ± 62%  sched_debug.dl_rq:.dl_nr_running.avg
>       0.03 ±117%    +248.3%       0.12 ± 34%  sched_debug.dl_rq:.dl_nr_running.stddev
>      90093 ±  2%     +90.8%     171916 ±  7%  sched_debug.ktime
>      93416 ±  2%     +87.6%     175231 ±  7%  sched_debug.sched_clk
>       0.02 ± 54%   +4401.9%       0.79 ±106%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
>       0.01 ±  9%    +4e+05%      30.47 ±141%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.11 ±  7%    +254.0%       0.38 ± 66%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       0.01 ± 16%   +1511.8%       0.09 ± 81%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       0.03 ± 23%     -98.7%       0.00 ±223%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsconfig
>       0.09 ±164%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsopen
>       0.02 ± 48%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.move_mount
>       0.30 ±203%  +56061.3%     165.77 ±150%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
>       0.02 ± 26%     -97.4%       0.00 ±223%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.exp_funnel_lock.synchronize_rcu_expedited.namespace_unlock.do_umount
>       0.98 ± 39%     -97.8%       0.02 ± 39%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.[unknown]
>       0.02 ± 79%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.clock_nanosleep.[unknown]
>       0.02 ± 59%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.shim_nanosleep_uint64.[unknown]
>       0.02 ± 13%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_mwc1
>       0.01 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_mounter.[unknown]
>       0.03 ± 82%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_umount
>       0.02 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_umounter
>       0.04 ±112%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount
>       0.04 ± 85%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount2
>       0.03 ±104%     -97.1%       0.00 ±223%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_call_function_single.[unknown]
>       0.00 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_call_function_single.umount2
>       0.01 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__pi_memset
>       0.05 ±109%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt._raw_spin_unlock_irqrestore
>       0.00 ±101%  +11082.1%       0.52 ± 94%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.path_init
>       0.04 ±114%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pcpu_alloc_noprof
>       0.01 ±107%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.__mutex_lock.constprop.0
>       0.44 ± 14%     -82.3%       0.08 ± 96%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.__sync_rcu_exp_select_node_cpus.kthread_worker_fn.kthread
>       0.15 ± 69%     -99.6%       0.00 ±141%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__do_sys_fsmount.do_syscall_64
>       1.31 ±222%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__unlock_mount.do_move_mount
>       0.01 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.attach_recursive_mnt.isra
>       0.10 ±198%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.clone_mnt.copy_tree
>       0.11 ± 48%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_lock_mount.part
>       0.02 ± 72%    +231.7%       0.06 ± 14%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_umount.path_umount
>       0.04 ±181%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.get_mountpoint.attach_recursive_mnt
>       0.10 ± 48%     -80.2%       0.02 ±193%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.namespace_unlock
>       0.12 ± 76%     -99.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.path_umount
>       0.14 ±110%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.prepend_path.__d_path
>       0.02 ±102%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.set_root.nd_jump_root
>       0.29 ±174%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.sget_fc.get_tree_nodev
>       0.02 ±149%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.xa_erase.cleanup_mnt
>       0.08 ± 21%   +3073.8%       2.48 ± 10%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       0.01 ± 55%    +288.0%       0.03 ± 52%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.sched_exec
>       0.01 ± 91%  +67526.8%       4.62 ±137%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.d_path.perf_event_mmap_event.perf_event_mmap
>       0.09 ± 97%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_lock_mount.part
>       0.07 ±193%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_umount.path_umount
>       0.22 ±212%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.fast_dput.dput.path_umount
>       0.02 ±155%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.fast_dput.dput.terminate_walk
>       0.08 ± 97%     -93.9%       0.00 ±223%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.flush_tlb_mm_range.tlb_finish_mmu.change_prot_numa
>       0.03 ± 91%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.prepend_path.__d_path.seq_path_root
>       0.00 ±223%  +76560.0%       0.64 ±163%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy.complete_walk.do_open
>       0.00 ±223%   +1211.1%       0.02 ± 95%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy.lookup_fast.link_path_walk
>       0.00 ±223%   +8280.0%       0.07 ± 18%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy.pick_link.step_into_slowpath
>       0.04 ±105%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_move_mount
>       0.03 ±125%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_umount
>       0.82 ± 15%     -97.2%       0.02 ± 63%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.vprintk_emit.devkmsg_emit.constprop
>       0.06 ± 28%   +2032.7%       1.30 ± 81%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       0.02 ± 33%    +311.1%       0.08 ± 98%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_umount
>       0.02 ± 53%    +332.3%       0.07 ± 31%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.schedule_timeout.kcompactd.kthread.ret_from_fork
>       0.01 ± 67%  +19158.2%       1.77 ±148%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.schedule_timeout.wait_for_completion_state.kernel_clone.__x64_sys_vfork
>       0.03 ± 25%  +44693.6%      11.65 ± 39%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.01 ± 13%    +944.1%       0.06 ± 93%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>       0.23 ± 23%  +12972.2%      30.35 ± 26%  perf-sched.sch_delay.avg.ms.perf_trace_sched_switch.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.02 ± 34%  +2.3e+06%     367.57 ±141%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
>      10.68 ± 73%   +1737.5%     196.31 ± 64%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>      11.85 ±110%     -99.0%       0.12 ± 55%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       1.61 ± 36%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsconfig
>       5.09 ±148%     -99.5%       0.03 ±223%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsmount
>       0.50 ±149%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsopen
>       4.53 ±155%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.move_mount
>      42.98 ± 29%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.exp_funnel_lock.synchronize_rcu_expedited.namespace_unlock.do_umount
>       4.53 ± 32%     -99.5%       0.02 ± 37%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.[unknown]
>       3.12 ± 23%     -99.4%       0.02 ±223%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>       0.04 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.clock_nanosleep.[unknown]
>       0.33 ±150%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.shim_nanosleep_uint64.[unknown]
>       0.06 ± 34%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_mwc1
>       0.02 ± 22%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_mounter.[unknown]
>       0.30 ±173%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_umount
>       0.08 ± 99%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_umounter
>       0.06 ±107%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount
>       0.68 ±132%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount2
>       0.04 ±132%     -97.4%       0.00 ±223%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_call_function_single.[unknown]
>       0.01 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_call_function_single.umount2
>       0.03 ± 24%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__pi_memset
>       0.57 ±131%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt._raw_spin_unlock_irqrestore
>       0.01 ± 85%  +1.5e+05%      11.24 ± 85%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.path_init
>       0.55 ±135%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pcpu_alloc_noprof
>       0.02 ±117%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.__mutex_lock.constprop.0
>       2.61 ±  4%     -96.8%       0.08 ± 97%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.__sync_rcu_exp_select_node_cpus.kthread_worker_fn.kthread
>       7.15 ±145%    -100.0%       0.00 ±141%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__do_sys_fsmount.do_syscall_64
>       3.92 ±222%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__unlock_mount.do_move_mount
>       0.04 ±105%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.attach_recursive_mnt.isra
>       0.10 ±182%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.clone_mnt.copy_tree
>       3.73 ± 89%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_lock_mount.part
>       0.04 ±160%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.get_mountpoint.attach_recursive_mnt
>      21.08 ± 80%     -99.9%       0.02 ±188%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.namespace_unlock
>      15.63 ± 89%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.path_umount
>       4.17 ±151%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.prepend_path.__d_path
>       0.07 ±151%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.set_root.nd_jump_root
>       0.30 ±171%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.sget_fc.get_tree_nodev
>       0.10 ±205%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.xa_erase.cleanup_mnt
>      15.32 ± 17%   +6951.2%       1080 ± 22%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       1.11 ± 80%     -96.7%       0.04 ±136%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
>       0.01 ± 87%  +9.6e+05%      78.61 ±133%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.d_path.perf_event_mmap_event.perf_event_mmap
>       0.91 ± 80%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_lock_mount.part
>       2.29 ±219%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_umount.path_umount
>       0.23 ±202%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.fast_dput.dput.path_umount
>       0.05 ±166%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.fast_dput.dput.terminate_walk
>       0.72 ± 95%     -99.4%       0.00 ±223%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.flush_tlb_mm_range.tlb_finish_mmu.change_prot_numa
>       0.32 ± 90%     -92.8%       0.02 ±173%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.lookup_mnt.__traverse_mounts.step_into_slowpath
>       0.27 ±118%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.prepend_path.__d_path.seq_path_root
>       0.00 ±223%  +1.1e+06%       9.42 ±174%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy.complete_walk.do_open
>       0.00 ±223%   +3655.6%       0.06 ±120%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy.lookup_fast.link_path_walk
>       0.00 ±223%  +20840.0%       0.17 ± 21%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy.pick_link.step_into_slowpath
>       0.72 ±117%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_move_mount
>       1.04 ±188%    -100.0%       0.00        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_umount
>       6.34 ± 54%     -98.6%       0.09 ±105%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.vprintk_emit.devkmsg_emit.constprop
>      23.09 ± 36%     -99.1%       0.20 ±101%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.m_start
>      30.80 ± 44%     -99.6%       0.12 ± 47%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_lock_mount
>       0.06 ±164%     -96.3%       0.00 ±223%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
>       9.24 ± 30%  +14386.8%       1338        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      11.70 ±104%     -99.0%       0.12 ± 48%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.synchronize_rcu_expedited.namespace_unlock.do_umount.path_umount
>       0.02 ± 71%   +2303.7%       0.43 ±140%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>      14.59 ±  9%   +9091.4%       1341        perf-sched.sch_delay.max.ms.perf_trace_sched_switch.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.01 ± 21%  +38669.0%       3.75 ± 25%  perf-sched.total_sch_delay.average.ms
>      47.86 ± 25%   +2808.4%       1392 ±  6%  perf-sched.total_sch_delay.max.ms
>       1.06 ±  6%  +14885.1%     159.57 ± 14%  perf-sched.total_wait_and_delay.average.ms
>    6154176 ±  7%     -99.8%      12170 ± 19%  perf-sched.total_wait_and_delay.count.ms
>       3552 ± 15%     +54.4%       5484 ±  9%  perf-sched.total_wait_and_delay.max.ms
>       1.06 ±  6%  +14664.8%     155.82 ± 14%  perf-sched.total_wait_time.average.ms
>       3552 ± 15%     +54.1%       5474 ±  9%  perf-sched.total_wait_time.max.ms
>     799.54           -49.8%     401.38 ± 19%  perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.24 ±  2%    +268.1%       0.89 ± 53%  perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       1.54 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsconfig
>       3.74 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsmount
>       4.49 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.move_mount
>       2.79 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
>       3.38 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.exp_funnel_lock.synchronize_rcu_expedited.namespace_unlock.do_umount
>       2.65 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.[unknown]
>       5.77 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_mounter.[unknown]
>       1.49 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount2
>       2.17 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__pi_memset
>       7.29 ± 68%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt._raw_spin_unlock_irqrestore
>      12.41 ±178%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pcpu_alloc_noprof
>       4.64 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.__mutex_lock.constprop.0
>       5.66 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__do_sys_fsmount.do_syscall_64
>       3.59 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.attach_recursive_mnt.isra
>       6.54 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_lock_mount.part
>       3.37 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_umount.path_umount
>       6.28 ± 72%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.get_mountpoint.attach_recursive_mnt
>       6.08 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.namespace_unlock
>       5.76 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.path_umount
>       8.71 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.prepend_path.__d_path
>       3.22 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.sget_fc.get_tree_nodev
>       5.18 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.xa_erase.cleanup_mnt
>       3.09 ±  9%    +249.9%      10.80 ± 20%  perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       2.87 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
>       3.65 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_lock_mount.part
>       3.37 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_umount.path_umount
>       4.84 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.flush_tlb_mm_range.tlb_finish_mmu.change_prot_numa
>       2.48 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.lookup_mnt.__traverse_mounts.step_into_slowpath
>       9.61 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.prepend_path.__d_path.seq_path_root
>       4.11 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_move_mount
>       3.34 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_umount
>       1.64 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.vprintk_emit.devkmsg_emit.constprop
>      11.23 ± 32%     -81.7%       2.06 ±123%  perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>     129.53 ± 30%    +338.0%     567.28 ±  4%  perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0
>       9.34           -99.5%       0.05 ±100%  perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.m_start
>       2.39 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_lock_mount
>       1.83 ±  3%     -63.4%       0.67 ± 49%  perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_umount
>       3.78           +29.1%       4.88 ± 11%  perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     150.37 ± 16%    +329.8%     646.28 ±  3%  perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       3.21 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.synchronize_rcu_expedited.namespace_unlock.do_umount.path_umount
>      19.36 ±  4%   +4532.3%     896.73 ±  6%  perf-sched.wait_and_delay.avg.ms.perf_trace_sched_switch.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>      37.00           -38.7%      22.67 ± 10%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
>    5439762 ±  4%     -99.9%       5142 ± 36%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       1769 ± 18%     -99.9%       2.00 ±100%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>     474.67 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsconfig
>     426.50 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsmount
>     527.00 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.move_mount
>       4818 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
>      48588 ± 26%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.exp_funnel_lock.synchronize_rcu_expedited.namespace_unlock.do_umount
>       7.83 ± 47%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.[unknown]
>       4.00 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_mounter.[unknown]
>      34.33 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount2
>     249404 ± 65%    -100.0%     118.00 ± 53%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.kthread_worker_fn.kthread.ret_from_fork.ret_from_fork_asm
>      23.67 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__pi_memset
>      16.50 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt._raw_spin_unlock_irqrestore
>       7.67 ± 30%     -93.5%       0.50 ±152%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.memcpy_toio
>      14.83 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pcpu_alloc_noprof
>       3.50 ± 39%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.__mutex_lock.constprop.0
>      49.50 ± 43%     -98.0%       1.00 ±115%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.__sync_rcu_exp_select_node_cpus.kthread_worker_fn.kthread
>     347.00 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__do_sys_fsmount.do_syscall_64
>      12.00 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.attach_recursive_mnt.isra
>     392.00 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_lock_mount.part
>      61.50 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_umount.path_umount
>       2.50 ± 50%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.get_mountpoint.attach_recursive_mnt
>       2442 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.namespace_unlock
>       1462 ± 34%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.path_umount
>     199.67 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.prepend_path.__d_path
>       2.17 ± 67%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.sget_fc.get_tree_nodev
>       3.50 ± 48%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.xa_erase.cleanup_mnt
>       1194 ±  8%     -15.6%       1008 ±  5%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>      56.33 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
>      16.83 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_lock_mount.part
>      47.17 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_umount.path_umount
>      13.67 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.flush_tlb_mm_range.tlb_finish_mmu.change_prot_numa
>      32.50 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.lookup_mnt.__traverse_mounts.step_into_slowpath
>      10.67 ± 64%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.prepend_path.__d_path.seq_path_root
>      20.50 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_move_mount
>      41.00 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_umount
>     139.83 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.preempt_schedule_thunk.vprintk_emit.devkmsg_emit.constprop
>     491.83 ± 35%     -93.2%      33.67 ±106%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>      92.00 ± 25%     -73.2%      24.67 ±  7%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0
>       9630 ± 61%    -100.0%       0.33 ±223%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.schedule_preempt_disabled.__mutex_lock.constprop.0
>     118616           -99.9%     112.50 ±100%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.m_start
>      38829          -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_lock_mount
>     117840 ±  8%     -99.8%     261.33 ± 13%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_umount
>      14376 ± 14%     -87.1%       1849 ±  6%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      17835 ± 65%    -100.0%       0.00        perf-sched.wait_and_delay.count.perf_trace_sched_switch.synchronize_rcu_expedited.namespace_unlock.do_umount.path_umount
>      59489 ±  5%     -99.1%     551.67 ± 17%  perf-sched.wait_and_delay.count.perf_trace_sched_switch.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       1555 ± 23%     +88.4%       2930 ±  5%  perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
>       1001           +13.2%       1133 ±  2%  perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
>      13.17 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsconfig
>      22.89 ± 59%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsmount
>      17.68 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.move_mount
>      28.45 ± 48%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
>      76.49 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.exp_funnel_lock.synchronize_rcu_expedited.namespace_unlock.do_umount
>       9.55 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.[unknown]
>       8.23 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_mounter.[unknown]
>      10.57 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount2
>      11.56 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__pi_memset
>      32.87 ± 81%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt._raw_spin_unlock_irqrestore
>     174.40 ±211%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pcpu_alloc_noprof
>       8.99 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.__mutex_lock.constprop.0
>      28.65 ± 52%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__do_sys_fsmount.do_syscall_64
>      11.22 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.attach_recursive_mnt.isra
>      22.86 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_lock_mount.part
>      11.92 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_umount.path_umount
>       9.11 ± 49%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.get_mountpoint.attach_recursive_mnt
>      36.19 ± 40%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.namespace_unlock
>      38.98 ± 61%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.path_umount
>      20.29 ± 80%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.prepend_path.__d_path
>       5.57 ± 66%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.sget_fc.get_tree_nodev
>      10.36 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.xa_erase.cleanup_mnt
>       1000          +275.2%       3754 ± 38%  perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>      12.97 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
>      11.31 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_lock_mount.part
>      16.26 ± 52%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_umount.path_umount
>      12.30 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.flush_tlb_mm_range.tlb_finish_mmu.change_prot_numa
>      10.89 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.lookup_mnt.__traverse_mounts.step_into_slowpath
>      11.78 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.prepend_path.__d_path.seq_path_root
>       2.24 ±223%   +4440.6%     101.63 ±164%  perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy.complete_walk.path_lookupat
>      11.45 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_move_mount
>      12.15 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_umount
>      12.68 ± 54%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.vprintk_emit.devkmsg_emit.constprop
>      44.52 ± 33%     -99.6%       0.20 ±101%  perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.m_start
>      43.14 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_lock_mount
>       9.93 ± 24%    +641.9%      73.71 ±101%  perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       2661 ± 13%     +26.2%       3359 ± 10%  perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      29.37 ± 66%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.synchronize_rcu_expedited.namespace_unlock.do_umount.path_umount
>       3498 ± 17%     +55.0%       5420 ± 11%  perf-sched.wait_and_delay.max.ms.perf_trace_sched_switch.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>     799.53           -49.8%     401.36 ± 19%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.24 ±  2%    +238.3%       0.80 ± 62%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>      23.57 ± 46%    +145.3%      57.82 ± 15%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group
>       0.48 ±  3%  +34811.7%     168.91 ± 26%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.52 ±  2%     -88.4%       0.18 ±223%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsconfig
>       2.64 ± 53%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsopen
>       4.47 ±  6%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.move_mount
>       0.30 ±203%  +56061.3%     165.77 ±150%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
>       3.36 ±  5%     -94.8%       0.17 ±223%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.exp_funnel_lock.synchronize_rcu_expedited.namespace_unlock.do_umount
>       1.67 ± 50%     -98.7%       0.02 ± 39%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.[unknown]
>       1.06 ±135%     -98.1%       0.02 ±223%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>       0.91 ±204%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.clock_nanosleep.[unknown]
>       0.10 ± 37%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.shim_nanosleep_uint64.[unknown]
>       0.74 ± 54%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_mwc1
>       5.76 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_mounter.[unknown]
>       0.68 ± 81%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_umount
>       0.06 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_umounter
>       0.12 ± 81%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount
>       1.45 ± 24%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount2
>       0.20 ±114%     -99.6%       0.00 ±223%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_call_function_single.[unknown]
>       0.05 ± 30%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_call_function_single.umount2
>       2.16 ± 28%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__pi_memset
>       7.24 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt._raw_spin_unlock_irqrestore
>       3.17 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.copy_folio_from_iter_atomic
>      12.37 ±179%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pcpu_alloc_noprof
>       4.63 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.__mutex_lock.constprop.0
>       5.51 ± 12%     -93.6%       0.35 ±141%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__do_sys_fsmount.do_syscall_64
>       3.52 ± 48%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__unlock_mount.do_move_mount
>       3.58 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.attach_recursive_mnt.isra
>       6.39 ± 59%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.clone_mnt.copy_tree
>       6.43 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_lock_mount.part
>       6.24 ± 72%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.get_mountpoint.attach_recursive_mnt
>       8.57 ± 14%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.prepend_path.__d_path
>       0.24 ±148%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.set_root.nd_jump_root
>       2.93 ± 35%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.sget_fc.get_tree_nodev
>       5.16 ± 23%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.xa_erase.cleanup_mnt
>       3.01 ±  9%    +176.5%       8.32 ± 25%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       2.84 ± 25%     -95.3%       0.13 ±111%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
>       0.00 ±223%    +800.0%       0.01 ± 62%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.sched_exec
>       0.01 ±121%  +82757.6%       4.56 ±137%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.d_path.perf_event_mmap_event.perf_event_mmap
>       3.56 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_lock_mount.part
>       3.31 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_umount.path_umount
>       2.77 ± 61%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.fast_dput.dput.path_umount
>       0.32 ±114%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.fast_dput.dput.terminate_walk
>       4.76 ± 14%     -99.9%       0.00 ±223%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.flush_tlb_mm_range.tlb_finish_mmu.change_prot_numa
>       2.45 ± 27%     -91.1%       0.22 ±129%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.lookup_mnt.__traverse_mounts.step_into_slowpath
>       9.58 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.prepend_path.__d_path.seq_path_root
>       0.00 ±223%   +1144.4%       0.02 ±101%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy.lookup_fast.link_path_walk
>       0.31 ±105%  +2.3e+05%     728.74 ± 32%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy_next.lookup_fast.open_last_lookups
>       4.07 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_move_mount
>       3.31 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_umount
>      11.17 ± 32%     -83.2%       1.88 ± 61%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>     129.48 ± 30%    +338.0%     567.13 ±  4%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0
>       9.31          -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.m_start
>       1.81 ±  3%     -67.4%       0.59 ± 55%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_umount
>      29.92 ± 12%    +545.3%     193.05 ± 63%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.schedule_timeout.msleep.ast_astdp_connector_helper_detect_ctx.drm_helper_probe_detect_ctx
>       3.75           +29.6%       4.86 ± 11%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.66 ±  6%  +29174.6%     193.31 ± 26%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.schedule_timeout.wait_for_completion_state.kernel_clone.__x64_sys_vfork
>     150.35 ± 16%    +322.1%     634.64 ±  3%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       3.20 ± 17%     -51.6%       1.55 ± 58%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.synchronize_rcu_expedited.namespace_unlock.do_umount.path_umount
>       0.00 ± 44%   +1113.3%       0.03 ±178%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>      19.13 ±  4%   +4429.8%     866.39 ±  6%  perf-sched.wait_time.avg.ms.perf_trace_sched_switch.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       1555 ± 23%     +88.4%       2930 ±  5%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
>       1001           +12.4%       1125        perf-sched.wait_time.max.ms.perf_trace_sched_switch.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
>       3.33 ± 15%  +56483.6%       1882 ±  8%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      12.85 ± 12%     -98.6%       0.18 ±223%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsconfig
>      18.69 ± 31%     -84.6%       2.88 ±223%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsmount
>       8.09 ± 68%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsopen
>      17.51 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.move_mount
>      38.20 ± 38%     -99.5%       0.17 ±223%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.exp_funnel_lock.synchronize_rcu_expedited.namespace_unlock.do_umount
>       5.91 ± 17%     -99.6%       0.02 ± 37%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.[unknown]
>     176.10 ±209%    -100.0%       0.02 ±223%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>       1.76 ±212%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.clock_nanosleep.[unknown]
>       1.02 ± 77%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.shim_nanosleep_uint64.[unknown]
>       6.73 ± 47%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_mwc1
>       8.22 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_mounter.[unknown]
>       6.14 ± 78%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_umount
>       0.12 ± 66%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.stress_umount_umounter
>       0.26 ±137%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount
>      10.30 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_apic_timer_interrupt.umount2
>       0.21 ±107%     -99.5%       0.00 ±223%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_call_function_single.[unknown]
>       0.06 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.irqentry_exit.asm_sysvec_call_function_single.umount2
>      11.55 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__pi_memset
>      32.85 ± 81%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt._raw_spin_unlock_irqrestore
>       8.75 ± 48%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.copy_folio_from_iter_atomic
>       0.63 ±145%  +77934.5%     494.87 ± 98%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.path_init
>     174.39 ±211%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pcpu_alloc_noprof
>       8.98 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.__mutex_lock.constprop.0
>      22.98 ± 18%     -98.5%       0.35 ±141%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__do_sys_fsmount.do_syscall_64
>       7.46 ± 43%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.__unlock_mount.do_move_mount
>      11.22 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.attach_recursive_mnt.isra
>       9.16 ± 49%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.clone_mnt.copy_tree
>      21.71 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_lock_mount.part
>      11.91 ±  6%    +908.8%     120.20 ± 86%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.do_umount.path_umount
>       9.08 ± 49%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.get_mountpoint.attach_recursive_mnt
>      23.27 ± 20%     -72.3%       6.45 ±103%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.namespace_unlock
>      25.51 ± 34%     -87.8%       3.12 ±223%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.mntput_no_expire_slowpath.path_umount
>      16.63 ± 58%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.prepend_path.__d_path
>       1.44 ±153%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.set_root.nd_jump_root
>       5.28 ± 72%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.sget_fc.get_tree_nodev
>      10.26 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk._raw_spin_unlock.xa_erase.cleanup_mnt
>       1000          +252.8%       3530 ± 49%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>      12.86 ± 28%     -97.9%       0.27 ±122%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
>       0.01 ±105%  +1.1e+06%      78.73 ±133%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.d_path.perf_event_mmap_event.perf_event_mmap
>      10.97 ± 20%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_lock_mount.part
>      14.01 ± 26%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.down_write.do_umount.path_umount
>       5.92 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.fast_dput.dput.path_umount
>       0.99 ±160%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.fast_dput.dput.terminate_walk
>      12.15 ± 19%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.flush_tlb_mm_range.tlb_finish_mmu.change_prot_numa
>      10.89 ± 21%     -97.4%       0.28 ±138%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.lookup_mnt.__traverse_mounts.step_into_slowpath
>      11.77 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.prepend_path.__d_path.seq_path_root
>       0.00 ±223%   +3655.6%       0.06 ±120%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy.lookup_fast.link_path_walk
>       0.34 ±103%  +2.9e+05%     975.89        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.try_to_unlazy_next.lookup_fast.open_last_lookups
>      11.44 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_move_mount
>      11.49 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.perf_trace_sched_switch.preempt_schedule_thunk.up_write.namespace_unlock.do_umount
>       1038 ± 69%     -94.2%      59.89 ±125%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>      34.79 ± 31%     -99.9%       0.04 ±214%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.m_start
>      26.39 ± 15%     -73.8%       6.92 ± 86%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_lock_mount
>      51.77          +546.3%     334.61 ± 73%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.schedule_timeout.msleep.ast_astdp_connector_helper_detect_ctx.drm_helper_probe_detect_ctx
>       7.70 ± 17%    +738.0%      64.53 ±114%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      14.52 ± 16%     -53.9%       6.69 ± 61%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.schedule_timeout.synchronize_rcu_expedited_wait_once.synchronize_rcu_expedited_wait.rcu_exp_wait_wake
>       0.06 ±164%     -96.3%       0.00 ±223%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
>       3.24 ± 25%  +51835.8%       1681 ± 36%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.schedule_timeout.wait_for_completion_state.kernel_clone.__x64_sys_vfork
>      22.63 ± 29%     -55.0%      10.18 ± 49%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.synchronize_rcu_expedited.namespace_unlock.do_umount.path_umount
>       3498 ± 17%     +53.6%       5373 ± 12%  perf-sched.wait_time.max.ms.perf_trace_sched_switch.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
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
> 


---end quoted text---
