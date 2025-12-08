Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7A18C008
	for <linux-block@vger.kernel.org>; Mon,  8 Dec 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765164005; cv=none; b=PJTFkFaQXdjEDMpHtQV2LGYYEr2onemKbW7EBB7AkvaPCsxcvR3Pkd0KLrWwWnvuqNnx8YmRfPuTv1dNrga944UZRgLxtzyQjzsn9YXqcd6Oe21IrmDIE0uOREGBscR4Dqvp8YP2RbHfo/FlTo8jv/AIQDJvPYqule0qEDX1XpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765164005; c=relaxed/simple;
	bh=8lzD5P6I+Miyvb0H+1yw95cC+3fivbe6YUpbLZDv1VA=;
	h=In-Reply-To:References:To:From:Date:Mime-Version:Subject:
	 Message-Id:Content-Type; b=m23zdWhGmGlWYtAFP7ksR8mRfVn2zkzCzQlQnfLkjZURBNugK+fjuMfA1yTcGXJKFG+789uniAWGNxoo55lc0qgQKnQIOeai66cmLZjzHjgs8mBLqIRb31d8VJFxOM1wP9diTsKBPtt+Iu7tDc+wICPIzxvqqkTTvXcrGQmG9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=kwVXxiVD; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="kwVXxiVD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1765163996;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rvXG/uSEBRiSwheoF0MVrA96pszmD4Rg+IKQ9Ozcjtc=;
 b=kwVXxiVDOyxA12BcWebbh8ZS3vysDj/s8fESlgDAllnBLX1r/VW1G5RGbdV1WMPxjiC/QA
 26eTeLDjDBiwc06EM28K4vTK/Mp9FzmyUQ00r+f9FauN/I32s48dNU0dMUr3J1ERcNRukq
 dcD8b7fGiKaiCmwJPFcw/9TNgcSdVuc5mame7luLQjejABh4v1MQie4nNXJLsRJ+9Pcwqt
 vKrSf3kK6QECdbQK4dnufnakdcD9o5+Cm5gKYGZIV4DpoBZB+cl94RnTMAo7szSAHIZAov
 J6dsBm88usdcTwmBoUn2wf6sd+3PDpIEhG+PZaOtcuL64Jp/XKBjGpr2sFH9NA==
Reply-To: yukuai@fnnas.com
Content-Transfer-Encoding: quoted-printable
Received: from [192.168.1.104] ([39.182.0.160]) by smtp.feishu.cn with ESMTPS; Mon, 08 Dec 2025 11:19:53 +0800
In-Reply-To: <3c088265-f6d8-4a91-b6a0-972d45afa056@linux.ibm.com>
References: <20251201083415.2407888-1-yukuai@fnnas.com> <20251201083415.2407888-9-yukuai@fnnas.com> <3c088265-f6d8-4a91-b6a0-972d45afa056@linux.ibm.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <tj@kernel.org>, <ming.lei@redhat.com>, 
	<bvanassche@acm.org>, <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Mon, 8 Dec 2025 11:19:52 +0800
X-Lms-Return-Path: <lba+2693643da+14468b+vger.kernel.org+yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 08/12] blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
Message-Id: <88a61575-9750-4b9a-9186-3df7bf1bd208@fnnas.com>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Language: en-US

Hi,

=E5=9C=A8 2025/12/1 23:00, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 12/1/25 2:04 PM, Yu Kuai wrote:
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index c471d11b756f..e035331a800f 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -759,7 +759,12 @@ void wbt_enable_default(struct gendisk *disk)
>>   		struct rq_wb *rwb =3D wbt_alloc();
>>  =20
>>   		if (rwb) {
>> +			unsigned int memflags;
>> +
>> +			memflags =3D blk_mq_freeze_queue(q);
>>   			wbt_init(disk, rwb);
>> +			blk_mq_unfreeze_queue(q, memflags);
>> +
> Moving ->freeze_lock out of rq_qos_add() and moving it here before
> calling wbt_init() makes sense, however this change now causes
> the below lockdep splat while running blktests throtl/001. Looking
> at the below splat, it seems blk_throtl_init() should run under
> GFP_NOIO scope.

Looks correct, thanks for the test! I'll fix this in the next version.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.18.0 #90 Not tainted
> ------------------------------------------------------
> check/95765 is trying to acquire lock:
> c000000002bc4c60 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_node_nopro=
f+0x80/0x9c8
>
> but task is already holding lock:
> c000000149a6f330 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_conf_open_bdev+=
0x118/0x1b8
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&q->rq_qos_mutex){+.+.}-{4:4}:
>         __lock_acquire+0x6b4/0x103c
>         lock_acquire.part.0+0xd0/0x26c
>         __mutex_lock+0xf0/0xeb8
>         wbt_init+0x110/0x1b8
>         wbt_enable_default+0x140/0x198
>         blk_register_queue+0x138/0x278
>         __add_disk+0x2e0/0x4c4
>         add_disk_fwnode+0x90/0x1f0
>         sd_probe+0x2e0/0x5ec [sd_mod]
>         really_probe+0x104/0x4c4
>         __driver_probe_device+0xb8/0x200
>         driver_probe_device+0x54/0x128
>         __driver_attach_async_helper+0x7c/0x150
>         async_run_entry_fn+0x60/0x1cc
>         process_one_work+0x2ac/0x7e4
>         worker_thread+0x238/0x460
>         kthread+0x158/0x188
>         start_kernel_thread+0x14/0x18
>
> -> #1 (&q->q_usage_counter(io)){++++}-{0:0}:
>         __lock_acquire+0x6b4/0x103c
>         lock_acquire.part.0+0xd0/0x26c
>         blk_alloc_queue+0x3ac/0x3e8
>         blk_mq_alloc_queue+0x88/0x11c
>         scsi_alloc_sdev+0x270/0x454
>         scsi_probe_and_add_lun+0x2e4/0x56c
>         __scsi_scan_target+0x170/0x2e8
>         scsi_scan_channel+0x9c/0xe8
>         scsi_scan_host_selected+0x158/0x1f8
>         do_scan_async+0x2c/0x284
>         async_run_entry_fn+0x60/0x1cc
>         process_one_work+0x2ac/0x7e4
>         worker_thread+0x238/0x460
>         kthread+0x158/0x188
>         start_kernel_thread+0x14/0x18
>
> -> #0 (fs_reclaim){+.+.}-{0:0}:
>         check_prev_add+0x170/0x1248
>         validate_chain+0x7f0/0xba8
>         __lock_acquire+0x6b4/0x103c
>         lock_acquire.part.0+0xd0/0x26c
>         fs_reclaim_acquire+0xe0/0x120
>         __kmalloc_cache_node_noprof+0x80/0x9c8
>         blk_throtl_init+0x4c/0x214
>         tg_set_limit+0x424/0x5a8
>         cgroup_file_write+0xec/0x364
>         kernfs_fop_write_iter+0x1c0/0x2b8
>         vfs_write+0x45c/0x64c
>         ksys_write+0x84/0x140
>         system_call_exception+0x134/0x360
>         system_call_vectored_common+0x15c/0x2ec
>
> other info that might help us debug this:
>
> Chain exists of:
>    fs_reclaim --> &q->q_usage_counter(io) --> &q->rq_qos_mutex
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&q->rq_qos_mutex);
>                                 lock(&q->q_usage_counter(io));
>                                 lock(&q->rq_qos_mutex);
>    lock(fs_reclaim);
>
>   *** DEADLOCK ***
>
> 4 locks held by check/95765:
>   #0: c0000000b737f410 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x84/0x=
140
>   #1: c0000000b5bb0c88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_i=
ter+0x168/0x2b8
>   #2: c00000014b9cf788 (kn->active#164){.+.+}-{0:0}, at: kernfs_fop_write=
_iter+0x180/0x2b8
>   #3: c000000149a6f330 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_conf_open=
_bdev+0x118/0x1b8
>
> stack backtrace:
> CPU: 9 UID: 0 PID: 95765 Comm: check Not tainted 6.18.0-dirty #90 VOLUNTA=
RY
> Hardware name: IBM,9008-22L POWER9 (architected) 0x4e0202 0xf000005 of:IB=
M,FW950.80 (VL950_131) hv:phyp pSeries
> Call Trace:
> 	dump_stack_lvl+0xe8/0x150 (unreliable)
> 	print_circular_bug+0x248/0x2d8
> 	check_noncircular+0x1cc/0x1ec
> 	check_prev_add+0x170/0x1248
> 	validate_chain+0x7f0/0xba8
> 	__lock_acquire+0x6b4/0x103c
> 	lock_acquire.part.0+0xd0/0x26c
> 	fs_reclaim_acquire+0xe0/0x120
> 	__kmalloc_cache_node_noprof+0x80/0x9c8
> 	blk_throtl_init+0x4c/0x214
> 	tg_set_limit+0x424/0x5a8
> 	cgroup_file_write+0xec/0x364
> 	kernfs_fop_write_iter+0x1c0/0x2b8
> 	vfs_write+0x45c/0x64c
> 	ksys_write+0x84/0x140
> 	system_call_exception+0x134/0x360
> 	system_call_vectored_common+0x15c/0x2ec
>
>
>
