Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE585335541
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575529; cv=none; b=JlLOFoYppzkAe4W1ICrVG2daSGYIYMGrYRllj9aRyHUTn7WBMd4BD+wIEpZoZnT6NJDv+dpLy2rZ3k6MLO72GjMH378M5qTOig0FhjoUf760zYFHtWVN1fAAoZEAuM0AEDxNj5JHoiJOhlX6KTaL4RVGo4HZYxI7zt84hySjQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575529; c=relaxed/simple;
	bh=AcvcVVpDDWP4PfN5fEYmRivRnsJFEUEXABE9uCVzM3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsTWxwvdBsuxe5I5P8lsG2XS3LjJJIr6JL+bfLsAVcXATzuE+zsDU5rNotSG+v67oy/A1eWB6kDCSetffeQPrJ6K7TXU7u/7UXiNYhWA4CRwnaMB7tIWk/YnB+zMRYMdZXyTwmWNldAftdh1L0AQCmr2sNf64nZW4M5ow8Vazm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWgeOnGs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWgeOnGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768575526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/gK3TrN4qKHGqA2JoFf79R78d75j8SrGkFRWrBK0lc=;
	b=TWgeOnGsQx817/zg2pGYbxUGZK0KE3qIJ1pNAJKSeriLDqgvfzJyVq5r9FoZoXwz1xXOqn
	atTV+N5G7g1IQiuJXn4ZT09jpb2k/GGLKV+I87Uf86/QWCp0t7gVduzq/PIkpVrmGBTJAk
	++RdevKIR1G+canvgt4inGIMsY5wCaQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-Z4YNv09QOTib3tpcKO7IgQ-1; Fri,
 16 Jan 2026 09:58:45 -0500
X-MC-Unique: Z4YNv09QOTib3tpcKO7IgQ-1
X-Mimecast-MFC-AGG-ID: Z4YNv09QOTib3tpcKO7IgQ_1768575524
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F8641956094;
	Fri, 16 Jan 2026 14:58:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5ABAF30002D6;
	Fri, 16 Jan 2026 14:58:41 +0000 (UTC)
Date: Fri, 16 Jan 2026 22:58:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: huang-jl <huang-jl@deepseek.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [BUG] ublk: ublk server hangs in D state during STOP_DEV
Message-ID: <aWpSHIBn_1W_Xo9h@fedora>
References: <20260116141532.45377-1-huang-jl@deepseek.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116141532.45377-1-huang-jl@deepseek.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jan 16, 2026 at 10:15:32PM +0800, huang-jl wrote:
> Hello,
> 
> I am reporting a bug in the ublk driver observed during production usage.
> Under specific conditions during device removal, the ublk server process
> enters an uninterruptible sleep (D state) and becomes unkillable,
> subsequently blocking further device deletions on the system.
> 
> [1. Description]
> We run a customized ublk server with the following configuration:
> 
> - ublksrv_ctrl_dev_info.flags = 0 (UBLK_F_USER_RECOVERY is not enabled).
> - Environment: Frequent creation/deletion of ublk devices (400–500 active
>   devices, one device at most 5-hour lifespan).
> - Upon receiving SIGINT, our ublk server will sends UBLK_U_CMD_STOP_DEV to the
>   driver.
> - A monitor process will send SIGINT to the ublk server when deleting. If it
>   finds the ublk server does not stopped within 10 seconds, the monitor will
>   send SIGKILL.
> 
> 
> On one production node, a ublk server process (PID 348910) failed to exit and
> entered D state. Simultaneously, related kworkers also entered D state:
> 
> $ ps -eo pid,stat,lstart,comm | grep -E "^ *[0-9]+ D"
>  77625 D    Wed Jan 14 15:23:57 2026 kworker/303:0+events
> 348910 Dl   Wed Jan 14 23:00:20 2026 uvm_ublk
> 355239 D    Wed Jan 14 23:04:18 2026 kworker/u775:1+flush-259:11
> 
> The device number of the ublk device is exact 259:11.
> 
> After this hang occurs, we can still create new ublk devices, but we cannot
> delete them. While UBLK_U_CMD_STOP_DEV can be sent, UBLK_U_CMD_DEL_DEV never
> receives a response from io_uring, and the issuing process hangs in S state.
> 
> I give the process's stack in the following:
> 
> 
> # The ublk server
> $ cat /proc/348910/stack 
> [<0>] io_wq_put_and_exit+0xa6/0x210
> [<0>] io_uring_clean_tctx+0x8c/0xd0
> [<0>] io_uring_cancel_generic+0x19b/0x370
> [<0>] __io_uring_cancel+0x1b/0x30
> [<0>] do_exit+0x17a/0x530
> [<0>] do_group_exit+0x35/0x90
> [<0>] get_signal+0x96e/0x9b0
> [<0>] arch_do_signal_or_restart+0x39/0x120
> [<0>] syscall_exit_to_user_mode+0x15f/0x1e0
> [<0>] do_syscall_64+0x8c/0x180
> [<0>] entry_SYSCALL_64_after_hwframe+0x78/0x80

The above trace means that io-wq workers are stuck on blocked I/O.

However, all builtin uring_cmd won't be run from io-wq, so it is very
likely that your target IO handling is stuck somewhere, then some ublk io
commands can't be completed.

If your system supports drgn and it is still ready to collect log, it
should be pretty easy to figure out the reason by writing one drgn script
to dump ublk queue/ublk io of driver.
 
> [2. Kernel version]
> 
> Linux  6.8.0-87-generic #88-Ubuntu SMP PREEMPT_DYNAMIC Sat Oct 11 09:28:41 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> 
> I am running Ubuntu 24:
> 
> Distributor ID: Ubuntu
> Description:    Ubuntu-Server 24.04.2 2025.05.26 (Cubic 2025-05-27 05:35)
> Release:        24.04
> Codename:       noble
> 
> [3. Steps to reproduce]
> Sorry, as this happens only in one process among one of our production servers,
> I do not find an easy way to reproduce the error.
> 
> [4. Dmesg/Logs]
> I can only find the logs like following. Apart from the kworker, there are
> similar logs for the ublk server iou-wrk.
> 
> Jan 15 00:53:02 kernel: INFO: task kworker/303:0:77625 blocked for more than 122 seconds.
> Jan 15 00:53:02 kernel:       Tainted: G           OE      6.8.0-87-generic #88-Ubuntu
> Jan 15 00:53:02 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Jan 15 00:53:02 kernel: task:kworker/303:0   state:D stack:0     pid:77625 tgid:77625 ppid:2      flags:0x00004000
> Jan 15 00:53:02 kernel: Workqueue: events delayed_fput
> Jan 15 00:53:02 kernel: Call Trace:
> Jan 15 00:53:02 kernel:  <TASK>
> Jan 15 00:53:02 kernel:  __schedule+0x27c/0x6b0
> Jan 15 00:53:02 kernel:  schedule+0x33/0x110
> Jan 15 00:53:02 kernel:  io_schedule+0x46/0x80
> Jan 15 00:53:02 kernel:  folio_wait_bit_common+0x136/0x330
> Jan 15 00:53:02 kernel:  ? __pfx_wake_page_function+0x10/0x10
> Jan 15 00:53:02 kernel:  __folio_lock+0x17/0x30
> Jan 15 00:53:02 kernel:  write_cache_pages+0x1cd/0x430
> Jan 15 00:53:02 kernel:  ? __pfx_blkdev_get_block+0x10/0x10
> Jan 15 00:53:02 kernel:  ? __pfx_block_write_full_folio+0x10/0x10
> Jan 15 00:53:02 kernel:  blkdev_writepages+0x6f/0xb0
> Jan 15 00:53:02 kernel:  do_writepages+0xcd/0x1f0
> Jan 15 00:53:02 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 15 00:53:02 kernel:  filemap_fdatawrite_wbc+0x75/0xb0
> Jan 15 00:53:02 kernel:  __filemap_fdatawrite_range+0x58/0x80
> Jan 15 00:53:02 kernel:  filemap_write_and_wait_range+0x59/0xc0
> Jan 15 00:53:02 kernel:  bdev_release+0x18e/0x240
> Jan 15 00:53:02 kernel:  blkdev_release+0x15/0x30
> Jan 15 00:53:02 kernel:  __fput+0xa0/0x2e0
> Jan 15 00:53:02 kernel:  delayed_fput+0x23/0x40
> Jan 15 00:53:02 kernel:  process_one_work+0x181/0x3a0
> Jan 15 00:53:02 kernel:  worker_thread+0x306/0x440
> Jan 15 00:53:02 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 15 00:53:02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
> Jan 15 00:53:02 kernel:  ? __pfx_worker_thread+0x10/0x10
> Jan 15 00:53:02 kernel:  kthread+0xef/0x120
> Jan 15 00:53:02 kernel:  ? __pfx_kthread+0x10/0x10
> Jan 15 00:53:02 kernel:  ret_from_fork+0x44/0x70
> Jan 15 00:53:02 kernel:  ? __pfx_kthread+0x10/0x10
> Jan 15 00:53:02 kernel:  ret_from_fork_asm+0x1b/0x30
> Jan 15 00:53:02 kernel:  </TASK>
> 
> [5. Technical Hypothesis]
> I suspect a deadlock occurs during the following sequence (assuming ublk id
> is 123):
> 
> 1. User program writes to /dev/ublkb123 via cached I/O, leaving dirty pages
>    in the page cache.
> 2. The ublk server receives SIGINT and issues UBLK_U_CMD_STOP_DEV.
> 3. The kernel path STOP_DEV -> del_gendisk() -> bdev_mark_dead() attempts to
>    flush dirty pages.
> 4. This flush generates new I/O requests directed back to the ublk server.
> 5. The ublk server receives SIGKILL at this moment, its threads stop and can
>    no longer handle the I/O requests generated by the flush in step 3.
> 6. The server remains stuck in del_gendisk(), waiting for I/O completion that
>    will never happen.
> 
> [6. My Question]
> 1. Would enable UBLK_F_USER_RECOVERY solve this bug? I find UBLK_F_USER_RECOVERY
>    allows  ublk_unquiesce_dev() to be called during ublk_stop_dev.
> 2. Should userspace strictly forbid to send SIGKILL to ublk server?

It is fine to send KILL to ublk server, and actually it is used widely in ublk
kernel selftest.

> 3. I try to search the related bug fix or patches, but does not find.
>    Are there known fixes in later kernels (6.10+) that address this specific
>    interaction between del_gendisk and server termination?

I'd understand why ublk server is stuck in io_wq_put_and_exit() first, so
far it is very likely caused by your ublk target logic...

If the cancel code path can move on, the ublk uring_cmd cancel function will fail
the inflight uring_cmd first, and finally the ublk char device is released
after ublk server is exit really, then all pending ublk block requests are aborted,
and everything can move on.
 

Thanks,
Ming

