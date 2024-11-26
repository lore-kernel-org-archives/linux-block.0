Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553614A85
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610081; cv=none; b=sBsovAJ+qSnyB+Bw9reP2zsLGJ/LACh0q43BeGHtSuBd49ruNRjLFUl/8IvbZMOoMyT9SP8dLgJrlFV+kxKTTTNJ8fTT/3mgtTNEtIN9dFHczPEdco8kyA/glBv94rXIBvrBNHB2AK42/THBGM12zglRb+OZIvPkNcCViu4/azw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610081; c=relaxed/simple;
	bh=NOCyNaTODo42sVrDBMLU41zVu+Pm5iCUGFIRv6Qz6vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4IdTgc+oXNDJvAAOow+8VlapYd7rcvtBwc6rEFLRUqhaKOkJxlS5PbzdElN6xF+k0kR1PmmVCaQQ4EXa4zqayGUXa8ba7U2hl20aGwE1MX5AyNJcmj27QtZn+IUdl4S1rYSLH7j6O2Uhs07F6aVsiAceikmSt0pebEZJFVSbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZPp3REm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZPp3REm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40B7C4CECF;
	Tue, 26 Nov 2024 08:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732610081;
	bh=NOCyNaTODo42sVrDBMLU41zVu+Pm5iCUGFIRv6Qz6vk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MZPp3REmR97jIbvn9+6ROANmyps4SMI/fbALNIrpO3xfWJmrMKCnMZ5DC1LhlGF3t
	 OE9BBzVjN/KKQsg5I3CjUsTFE6pcevE8QnzDpQTDM1sdbn3WxxSwMh0gqlKHNjj5dL
	 CZRTbv6GtIQAOYEgv0fmL+38rkT7pnmk2LC34P3GtZJuVqq4/sP7rhzrVkhzOVKixj
	 RWwQWnqZ4lEJqcuUCQpDb1S8l6rUU1VHNm+ak72blTEwrfZbDP2GIrUruUyz29iued
	 IaEwTeTtOS12fXbCF86/Gs01fLvO/hhKRO+e2QXVSmXpRgGMSY/mMG8EADgdRcftO3
	 q0o3QssG8arAA==
Message-ID: <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
Date: Tue, 26 Nov 2024 17:34:39 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Bart Van Assche <bvanassche@acm.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
References: <20241125211048.1694246-1-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241125211048.1694246-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 06:10, Bart Van Assche wrote:
> Test concurrent requeuing of zoned writes and request queue freezing. While
> test test passes with kernel 6.9, it triggers a hang with kernels 6.10 and
> later. This shows that this hang is a regression introduced by the zone
> write plugging code.

Instead of this sentence, it would be nicer to describe the hang...
I could recreate it: I end up with fio blocked on queue enter trying to issue a
read, the sysfs attribute write blocked on queue freeze and one write plugged
waiting, but no thread trying to do anything about it, which is weird given that
the workload is QD=1, so the write should be in the submission path and not
plugged at all. So something weird is going on.

Of note, is that by simply creating the scsi_debug device in a vm manually, I
get this lockdep splat:

[   51.934109] ======================================================
[   51.935916] WARNING: possible circular locking dependency detected
[   51.937561] 6.12.0+ #2107 Not tainted
[   51.938648] ------------------------------------------------------
[   51.940351] kworker/u16:4/157 is trying to acquire lock:
[   51.941805] ffff9fff0aa0bea8 (&q->limits_lock){+.+.}-{4:4}, at:
disk_update_zone_resources+0x86/0x170
[   51.944314]
[   51.944314] but task is already holding lock:
[   51.945688] ffff9fff0aa0b890 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at:
blk_revalidate_disk_zones+0x15f/0x340
[   51.948527]
[   51.948527] which lock already depends on the new lock.
[   51.948527]
[   51.951296]
[   51.951296] the existing dependency chain (in reverse order) is:
[   51.953708]
[   51.953708] -> #1 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
[   51.956131]        blk_queue_enter+0x1c9/0x1e0
[   51.957290]        blk_mq_alloc_request+0x187/0x2a0
[   51.958365]        scsi_execute_cmd+0x78/0x490 [scsi_mod]
[   51.959514]        read_capacity_16+0x111/0x410 [sd_mod]
[   51.960693]        sd_revalidate_disk.isra.0+0x872/0x3240 [sd_mod]
[   51.962004]        sd_probe+0x2d7/0x520 [sd_mod]
[   51.962993]        really_probe+0xd5/0x330
[   51.963898]        __driver_probe_device+0x78/0x110
[   51.964925]        driver_probe_device+0x1f/0xa0
[   51.965916]        __driver_attach_async_helper+0x60/0xe0
[   51.967017]        async_run_entry_fn+0x2e/0x140
[   51.968004]        process_one_work+0x21f/0x5a0
[   51.968987]        worker_thread+0x1dc/0x3c0
[   51.969868]        kthread+0xe0/0x110
[   51.970377]        ret_from_fork+0x31/0x50
[   51.970983]        ret_from_fork_asm+0x11/0x20
[   51.971587]
[   51.971587] -> #0 (&q->limits_lock){+.+.}-{4:4}:
[   51.972479]        __lock_acquire+0x1337/0x2130
[   51.973133]        lock_acquire+0xc5/0x2d0
[   51.973691]        __mutex_lock+0xda/0xcf0
[   51.974300]        disk_update_zone_resources+0x86/0x170
[   51.975032]        blk_revalidate_disk_zones+0x16c/0x340
[   51.975740]        sd_zbc_revalidate_zones+0x73/0x160 [sd_mod]
[   51.976524]        sd_revalidate_disk.isra.0+0x465/0x3240 [sd_mod]
[   51.977824]        sd_probe+0x2d7/0x520 [sd_mod]
[   51.978917]        really_probe+0xd5/0x330
[   51.979915]        __driver_probe_device+0x78/0x110
[   51.981047]        driver_probe_device+0x1f/0xa0
[   51.982143]        __driver_attach_async_helper+0x60/0xe0
[   51.983282]        async_run_entry_fn+0x2e/0x140
[   51.984319]        process_one_work+0x21f/0x5a0
[   51.985873]        worker_thread+0x1dc/0x3c0
[   51.987289]        kthread+0xe0/0x110
[   51.988546]        ret_from_fork+0x31/0x50
[   51.989926]        ret_from_fork_asm+0x11/0x20
[   51.991376]
[   51.991376] other info that might help us debug this:
[   51.991376]
[   51.994127]  Possible unsafe locking scenario:
[   51.994127]
[   51.995651]        CPU0                    CPU1
[   51.996694]        ----                    ----
[   51.997716]   lock(&q->q_usage_counter(queue)#3);
[   51.998817]                                lock(&q->limits_lock);
[   52.000043]                                lock(&q->q_usage_counter(queue)#3);
[   52.001638]   lock(&q->limits_lock);
[   52.002485]
[   52.002485]  *** DEADLOCK ***
[   52.002485]
[   52.003978] 5 locks held by kworker/u16:4/157:
[   52.004921]  #0: ffff9fff002a8d48 ((wq_completion)async){+.+.}-{0:0}, at:
process_one_work+0x4c4/0x5a0
[   52.006864]  #1: ffffb71780e5fe58
((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x1df/0x5a0
[   52.008202]  #2: ffff9fff2d57f378 (&dev->mutex){....}-{4:4}, at:
__driver_attach_async_helper+0x3f/0xe0
[   52.009459]  #3: ffff9fff0aa0b858 (&q->q_usage_counter(io)#3){+.+.}-{0:0},
at: blk_revalidate_disk_zones+0x15f/0x340
[   52.010903]  #4: ffff9fff0aa0b890 (&q->q_usage_counter(queue)#3){++++}-{0:0},
at: blk_revalidate_disk_zones+0x15f/0x340
[   52.013437]
[   52.013437] stack backtrace:
[   52.014691] CPU: 2 UID: 0 PID: 157 Comm: kworker/u16:4 Not tainted 6.12.0+ #2107
[   52.016195] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-3.fc41 04/01/2014
[   52.017376] Workqueue: async async_run_entry_fn
[   52.018050] Call Trace:
[   52.018442]  <TASK>
[   52.018810]  dump_stack_lvl+0x5d/0x80
[   52.019353]  print_circular_bug.cold+0x178/0x1be
[   52.020316]  check_noncircular+0x144/0x160
[   52.021616]  __lock_acquire+0x1337/0x2130
[   52.022350]  lock_acquire+0xc5/0x2d0
[   52.022877]  ? disk_update_zone_resources+0x86/0x170
[   52.023543]  ? lock_is_held_type+0x85/0xe0
[   52.024170]  __mutex_lock+0xda/0xcf0
[   52.024684]  ? disk_update_zone_resources+0x86/0x170
[   52.025411]  ? disk_update_zone_resources+0x86/0x170
[   52.026131]  ? mark_held_locks+0x40/0x70
[   52.026681]  ? disk_update_zone_resources+0x86/0x170
[   52.027390]  disk_update_zone_resources+0x86/0x170
[   52.028074]  ? mark_held_locks+0x40/0x70
[   52.028629]  ? lockdep_hardirqs_on_prepare+0xd3/0x170
[   52.029344]  ? _raw_spin_unlock_irqrestore+0x40/0x50
[   52.030321]  ? percpu_ref_is_zero+0x3a/0x50
[   52.031565]  ? blk_mq_freeze_queue_wait+0x47/0xe0
[   52.032897]  blk_revalidate_disk_zones+0x16c/0x340
[   52.033610]  sd_zbc_revalidate_zones+0x73/0x160 [sd_mod]
[   52.034377]  sd_revalidate_disk.isra.0+0x465/0x3240 [sd_mod]
[   52.035171]  ? save_trace+0x4e/0x360
[   52.035700]  sd_probe+0x2d7/0x520 [sd_mod]
[   52.036314]  really_probe+0xd5/0x330
[   52.036829]  ? pm_runtime_barrier+0x54/0x90
[   52.037421]  __driver_probe_device+0x78/0x110
[   52.038061]  driver_probe_device+0x1f/0xa0
[   52.038631]  __driver_attach_async_helper+0x60/0xe0
[   52.039329]  async_run_entry_fn+0x2e/0x140
[   52.039908]  process_one_work+0x21f/0x5a0
[   52.040471]  worker_thread+0x1dc/0x3c0
[   52.041073]  ? rescuer_thread+0x480/0x480
[   52.041639]  kthread+0xe0/0x110
[   52.042420]  ? kthread_insert_work_sanity_check+0x60/0x60
[   52.043790]  ret_from_fork+0x31/0x50
[   52.044700]  ? kthread_insert_work_sanity_check+0x60/0x60
[   52.046055]  ret_from_fork_asm+0x11/0x20
[   52.047023]  </TASK>

Checking the code, it is a false positive though because sd_revalidate_disk()
calls queue_limits_commit_update() which releases the limits mutex lock before
calling blk_revalidate_disk_zones().
Will see what I can do about it.

See additional comments on this patch below.

> 
> sysrq: Show Blocked State
> task:(udev-worker)   state:D stack:0     pid:75392 tgid:75392 ppid:2178   flags:0x00000006
> Call Trace:
>  <TASK>
>  __schedule+0x3e8/0x1410
>  schedule+0x27/0xf0
>  blk_mq_freeze_queue_wait+0x6f/0xa0
>  queue_attr_store+0x60/0xc0
>  kernfs_fop_write_iter+0x13e/0x1f0
>  vfs_write+0x25b/0x420
>  ksys_write+0x65/0xe0
>  do_syscall_64+0x82/0x160
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/zbd/012     | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/zbd/012.out |  2 ++
>  2 files changed, 72 insertions(+)
>  create mode 100644 tests/zbd/012
>  create mode 100644 tests/zbd/012.out
> 
> diff --git a/tests/zbd/012 b/tests/zbd/012
> new file mode 100644
> index 000000000000..0551d01011af
> --- /dev/null
> +++ b/tests/zbd/012
> @@ -0,0 +1,70 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Google LLC
> +
> +. tests/scsi/rc
> +. common/scsi_debug
> +
> +DESCRIPTION="test requeuing of zoned writes and queue freezing"

There is no requeueing going on here so this description is inaccurate.

> +QUICK=1
> +
> +requires() {
> +	_have_fio_zbd_zonemode
> +}
> +
> +toggle_iosched() {
> +	while true; do
> +		for iosched in none mq-deadline; do
> +			echo "${iosched}" > "/sys/class/block/$(basename "$zdev")/queue/scheduler"
> +			sleep .1
> +		done
> +	done
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local qd=1
> +	local scsi_debug_params=(
> +		delay=0
> +		dev_size_mb=1024
> +		every_nth=$((2 * qd))
> +		max_queue="${qd}"
> +		opts=0x8000          # SDEBUG_OPT_HOST_BUSY
> +		sector_size=4096
> +		statistics=1
> +		zbc=host-managed
> +		zone_nr_conv=0
> +		zone_size_mb=4
> +	)
> +	_init_scsi_debug "${scsi_debug_params[@]}" &&
> +	local zdev="/dev/${SCSI_DEBUG_DEVICES[0]}" fail &&
> +	ls -ld "${zdev}" >>"${FULL}" &&
> +	{ toggle_iosched & } &&
> +	toggle_iosched_pid=$! &&
> +	local fio_args=(
> +		--direct=1
> +		--filename="${zdev}"
> +		--iodepth="${qd}"
> +		--ioengine=io_uring
> +		--ioscheduler=none
> +		--name=pipeline-zoned-writes

Nothing is pipelined here since this is a qd=1 run.

> +		--output="${RESULTS_DIR}/fio-output-zbd-092.txt"
> +		--runtime="${TIMEOUT:-30}"
> +		--rw=randwrite
> +		--time_based
> +		--zonemode=zbd
> +	) &&
> +	_run_fio "${fio_args[@]}" >>"${FULL}" 2>&1 ||
> +	fail=true
> +
> +	kill "${toggle_iosched_pid}" 2>&1
> +	_exit_scsi_debug
> +
> +	if [ -z "$fail" ]; then
> +		echo "Test complete"
> +	else
> +		echo "Test failed"
> +		return 1
> +	fi
> +}
> diff --git a/tests/zbd/012.out b/tests/zbd/012.out
> new file mode 100644
> index 000000000000..8ff654950c5f
> --- /dev/null
> +++ b/tests/zbd/012.out
> @@ -0,0 +1,2 @@
> +Running zbd/012
> +Test complete


-- 
Damien Le Moal
Western Digital Research
