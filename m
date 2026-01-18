Received: from mail-m1973171.qiye.163.com (mail-m1973171.qiye.163.com [220.197.31.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95A3281356
	for <linux-block@vger.kernel.org>; Sun, 18 Jan 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744226; cv=none; b=rhxFtF1ZYPQVUitgOMD31MkQ9eRMgK/twlfv/BalQb902HL5lrrFfvBLi1/rJ6aMuaUVJTElXirE/QoJ5FC9fB66LO0SbEHd7v8RocvrEhhBh5UcuwGI8rr8m4FDpRVzY8x8X2amoqFLThYZQcvM8CwOJr823nLAf7INsc6XSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744226; c=relaxed/simple;
	bh=1o/EF8AWyPT4QqbLzcVzEU5bFzAd+3QtcbKXpivvatk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I52pwSZgls7hT1tyxp6m2NRZc5xyTBs+MQypkh2ZHuTuyPx/G5TricS4dSQu0cB3oI2t8DHPZEuOAa6Y5r3mgBMV0SPSDH+FbidM0lpxDaP4E2ePmgqcJ/+ehgfpGIQkQR6yHy3WMkI1Dr8BURTlMjYvWmG7lcZ+nsqCyCNV6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com; spf=pass smtp.mailfrom=deepseek.com; dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b=DZOhPV0X; arc=none smtp.client-ip=220.197.31.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepseek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b="DZOhPV0X"
Received: from localhost.localdomain (unknown [IPV6:2402:f000:5:c001:5d8e:8961:95e5:4104])
	by smtp.qiye.163.com (Hmail) with ESMTP id 310a7cb68;
	Sun, 18 Jan 2026 21:14:48 +0800 (GMT+08:00)
From: huang-jl <huang-jl@deepseek.com>
To: ming.lei@redhat.com
Cc: huang-jl@deepseek.com,
	linux-block@vger.kernel.org
Subject: Re: [BUG] ublk: ublk server hangs in D state during STOP_DEV
Date: Sun, 18 Jan 2026 21:14:48 +0800
Message-Id: <20260118131448.57138-1-huang-jl@deepseek.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <aWzI8XXbN7z2JcNh@fedora>
References: <aWzI8XXbN7z2JcNh@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd13e706109d9kunm3af4555e7e6871
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkkfVkIfTR1LTRlJGB8dTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJT0tJQR1LS0tBTkEYS0tKQU4fQx5BQ0JNSkFCTh5OQU9KS09ZV1kWGg
	8SFR0UWUFZT0tIVUlJTUtNTkpVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DZOhPV0Xak22cxcgjBCHQW7KIEEU7JGPFJOpOQKQb3uNORYJg6+VfEQQDM84gpCznyMjUJBGi6/YAsdplQpNk3dFdINDj+Ok7w4N8n7X+eCYXpXFt5ToteNY+w2gW+bYmROo8ocuD2PKgKY9R4lJAlQIwL9X4CBUmSJIInkX4hU=; c=relaxed/relaxed; s=default; d=deepseek.com; v=1;
	bh=I0jaUoTAyJjgiZ6gu0P7z+ZdevBgv26DTaw4E+n1A1w=;
	h=date:mime-version:subject:message-id:from;

> > > > - Upon receiving SIGINT, our ublk server will sends UBLK_U_CMD_STOP_DEV to the
> > > > driver.
> > > 
> > > Can you share how your server sends STOP_DEV when receiving SIGINT?
> > > 
> > > If it prevents normal IO command handling, ublk_stop_dev() will cause deadlock.
> > > 
> > > For example, follows the preferred IO handling in ublk server:
> > > 
> > > prepare UBLK_IO_FETCH_REQ uring_cmds;
> > > while (1) {
> > > io_uring_enter(submission & wait event);
> > > }
> > > 
> > > If you send STOP_DEV command inside the above loop, you will get the
> > > deadlock, because inflight and new IOs can't be handled any more.
> > 
> > My ublk server has two threads:
> > 
> > - The main thread: opens /dev/ublk-control and create an io uring. It handles
> >   all control uring cmd (e.g., ADD_DEV, START_DEV, STOP_DEV).
> > 
> > - A worker thread: also creates an io uring. It will send UBLK_U_IO_FETCH_REQ
> >   and UBLK_U_IO_COMMIT_AND_FETCH_REQ uring cmd, and handle IO request.
> > 
> > Main thread will first ADD and START device, then listens for SIGINT signal.
> > Upon receiving SIGINT, main thread issues a STOP_DEV cmd.
> > The worker thread continues running independently and is not directly affected
> > by this signal.
> > 
> > (Implementation detail: I am using Rust and the Tokio async runtime. The SIGINT
> > is handled within the userspace rather than directly inside the signal handler.)
> > 
> > > If that is the case, you may remove the sending of STOP_DEV simply in your
> > > implementation, and let ublk server exit. Then delete the ublk device before
> > > ublk server is exiting to kernel, or let your monitor process remove the
> > > ublk device, which becomes DEAD state after ublk server exits.
> > > 
> > > Otherwise, you may have to investigate why ublk server can't handle IO
> > > command after sending STOP_DEV command.
> > 
> > Based on my previous post [1], **the ublk server gets SIGKILL after sending
> > STOP_DEV command**, so it cannot handle IO request.
> > 
> > In detail:
> > 
> > 1. Flush Kernel Thread: A kworker/flush thread attempts to write dirty pages
> > to the ublk device. It acquires a folio lock but then enters a sleep state
> > in wbt_wait() due to Writeback Throttling (WBT).
> > 
> > 2. STOP_DEV Command: The ublk server issues a STOP_DEV command. This uring cmd
> > is processed by an uring kernel thread.
> > 
> > 3. Resource Conflict: When handle STOP_DEV, the uring kernel thread also tries
> > to flush dirty pages. It needs to acquire the same folio lock held by the flush
> > kworker to submit the I/O.
> > 
> > 4. Termination Signal: At this point, the ublk server receives a SIGKILL.
> 
> It is _not_ related with WBT or write cache.
> 
> When your monitor sends SIGKILL, do_exit() is actually called, but
> io_uring_cancel_generic() blocks on io_wq_put_and_exit() because STOP_DEV
> can't be completed, then do_exit() can't move on, and finally the ublk cancel
> function can't be called, then ublk char device can't be closed.
> 
> Looks something which might be improved in future, but it highly depends on
> (complicated) io_uring's cancel code path, and I believe there isn't
> any way for ublk to get notified when do_exit() happens from `kill -9`.

Ok, the reason I mention about WTB is we find a flush kernel thread, whose name
is kworker/u775:1+flush-259:11. Note that 259:11 is exactly the major and minor
number of our broken ublk device. The stack of this flush kworker is:

[<0>] rq_qos_wait+0xcf/0x180
[<0>] wbt_wait+0xb3/0x100
[<0>] __rq_qos_throttle+0x25/0x40
[<0>] blk_mq_submit_bio+0x168/0x6b0
[<0>] __submit_bio+0xb3/0x1c0
[<0>] submit_bio_noacct_nocheck+0x13c/0x1f0
[<0>] submit_bio_noacct+0x162/0x5b0
[<0>] submit_bio+0xb2/0x110
[<0>] submit_bh_wbc+0x156/0x190
[<0>] __block_write_full_folio+0x1da/0x3d0
[<0>] block_write_full_folio+0x150/0x180
[<0>] write_cache_pages+0x15b/0x430
[<0>] blkdev_writepages+0x6f/0xb0
[<0>] do_writepages+0xcd/0x1f0
[<0>] __writeback_single_inode+0x44/0x290
[<0>] writeback_sb_inodes+0x21b/0x520
[<0>] __writeback_inodes_wb+0x54/0x100
[<0>] wb_writeback+0x2df/0x350
[<0>] wb_do_writeback+0x225/0x2a0
[<0>] wb_workfn+0x5f/0x240
[<0>] process_one_work+0x181/0x3a0
[<0>] worker_thread+0x306/0x440
[<0>] kthread+0xef/0x120
[<0>] ret_from_fork+0x44/0x70
[<0>] ret_from_fork_asm+0x1b/0x30

It is actually get stuck in wbt_wait (writeback throttling), holding a folio lock
of a dirty page.

But after I read more kernel code, I find out: yes, as you said, it does not
related to WBT. Even if there is no such a flush kworker, the ublk server will
still get stuck in io_wq_put_and_exit(), after been SIGKILL.

> > Conclusion:
> > This creates a circular dependency: the flush kworker cannot be woken from WBT
> > because the ublk server is no longer processing I/O requests.
> > Simultaneously, the ublk server cannot exit because it is waiting for the
> > STOP_DEV command to complete. However, the uring kernel thread remains stuck
> > waiting for the folio lock held by the flush kworker.
> > 
> > Should we avoid having the ublk server issue STOP_DEV command by it self? As it
> > is highly prone to deadlocks if a SIGKILL occurs during the shutdown sequence.
> 
> So far there are at least two ways:
> 
> 1) don't provide signal handler for SIGINT, or simply call exit() in the
> signal handler, and ublk block device is removed automatically when ublk
> server is done in case of !USER_RECOVERY.
> 
> OR
> 
> 2) provide signal SIGINT handler to stop device, meantime not send SIGKILL
> in your monitor process. This way works just fine if your ublk server is
> well implemented, which often requires you to handle timeout in the server
> implementation.

Appreciate your suggestions, I will remove my signal handler for SIGINT.

Thanks,
huang-jl
