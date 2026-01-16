Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com [45.254.49.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40338E5DA
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573865; cv=none; b=l2QQfABfa+WCHCvlKjlqTWIU0dcTXd3MvL/+Q33M72mXmNhhRIZRsLgA91wxqwQ46XrzHo5RryxD3xpgHJJDWTyTM5+gYcjR9l9Aor4hUIbMpgrbZ5VnfrNtVXJhY6WSIxlb5u9804oOKsDYO8GyzfABogM0o4gdebpiTCfjxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573865; c=relaxed/simple;
	bh=FoUvpqph+5SqbKMCQuJStRHysTpu5223UDa+ERnaEdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g975tYeeHmA78rNjvKYRkLBhHo/jxcWDij71k4uUv5nKHO138HTjDbiDCM9rn0H0v9RItBeipEYkldrOe7xoqw+UYpQ+O0fpM6EH4lolT5tZRpXvC10wG2z+W8ED52hl+Czvll/kP95RDlITK77D5YCNXbqVrubCVtzKBzENEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com; spf=pass smtp.mailfrom=deepseek.com; dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b=HIuilLG6; arc=none smtp.client-ip=45.254.49.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepseek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b="HIuilLG6"
Received: from localhost.localdomain (unknown [210.12.28.78])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30ef4cd10;
	Fri, 16 Jan 2026 22:15:35 +0800 (GMT+08:00)
From: huang-jl <huang-jl@deepseek.com>
To: ming.lei@redhat.com
Cc: linux-block@vger.kernel.org
Subject: [BUG] ublk: ublk server hangs in D state during STOP_DEV
Date: Fri, 16 Jan 2026 22:15:32 +0800
Message-Id: <20260116141532.45377-1-huang-jl@deepseek.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc7295ba409d9kunmfac338536a1c16
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTx1MVkpIT05DQk1JHUMaTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJSktVSklVSUNVTENZV1kWGg8SFR0UWUFZT0tIVUpLSUJNSEtVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HIuilLG6F8BGh0mwUSHLIOXdr5eYTkY1Km/n/+rOMFUs3sTOPCjijfScoTP3PG9ymC7wBqm23uUxRbC/lot0JrwCYjfj4PfkUtLvz9xG0BDTwnVGevCwDI8MuPBRTLYtW0fEhsVydtTKdNx3LQdRKFOGiXFTQKup6xJEIy80qQ0=; c=relaxed/relaxed; s=default; d=deepseek.com; v=1;
	bh=7C38hxvkMxnKo0930aGOXegDjWPBSvt65Kz3t1+6QtU=;
	h=date:mime-version:subject:message-id:from;

Hello,

I am reporting a bug in the ublk driver observed during production usage.
Under specific conditions during device removal, the ublk server process
enters an uninterruptible sleep (D state) and becomes unkillable,
subsequently blocking further device deletions on the system.

[1. Description]
We run a customized ublk server with the following configuration:

- ublksrv_ctrl_dev_info.flags = 0 (UBLK_F_USER_RECOVERY is not enabled).
- Environment: Frequent creation/deletion of ublk devices (400–500 active
  devices, one device at most 5-hour lifespan).
- Upon receiving SIGINT, our ublk server will sends UBLK_U_CMD_STOP_DEV to the
  driver.
- A monitor process will send SIGINT to the ublk server when deleting. If it
  finds the ublk server does not stopped within 10 seconds, the monitor will
  send SIGKILL.


On one production node, a ublk server process (PID 348910) failed to exit and
entered D state. Simultaneously, related kworkers also entered D state:

$ ps -eo pid,stat,lstart,comm | grep -E "^ *[0-9]+ D"
 77625 D    Wed Jan 14 15:23:57 2026 kworker/303:0+events
348910 Dl   Wed Jan 14 23:00:20 2026 uvm_ublk
355239 D    Wed Jan 14 23:04:18 2026 kworker/u775:1+flush-259:11

The device number of the ublk device is exact 259:11.

After this hang occurs, we can still create new ublk devices, but we cannot
delete them. While UBLK_U_CMD_STOP_DEV can be sent, UBLK_U_CMD_DEL_DEV never
receives a response from io_uring, and the issuing process hangs in S state.

I give the process's stack in the following:

# The kworker/303:0+events
$ cat /proc/77625/stack 
[<0>] folio_wait_bit_common+0x136/0x330
[<0>] __folio_lock+0x17/0x30
[<0>] write_cache_pages+0x1cd/0x430
[<0>] blkdev_writepages+0x6f/0xb0
[<0>] do_writepages+0xcd/0x1f0
[<0>] filemap_fdatawrite_wbc+0x75/0xb0
[<0>] __filemap_fdatawrite_range+0x58/0x80
[<0>] filemap_write_and_wait_range+0x59/0xc0
[<0>] bdev_release+0x18e/0x240
[<0>] blkdev_release+0x15/0x30
[<0>] __fput+0xa0/0x2e0
[<0>] delayed_fput+0x23/0x40
[<0>] process_one_work+0x181/0x3a0
[<0>] worker_thread+0x306/0x440
[<0>] kthread+0xef/0x120
[<0>] ret_from_fork+0x44/0x70
[<0>] ret_from_fork_asm+0x1b/0x30

# The ublk server
$ cat /proc/348910/stack 
[<0>] io_wq_put_and_exit+0xa6/0x210
[<0>] io_uring_clean_tctx+0x8c/0xd0
[<0>] io_uring_cancel_generic+0x19b/0x370
[<0>] __io_uring_cancel+0x1b/0x30
[<0>] do_exit+0x17a/0x530
[<0>] do_group_exit+0x35/0x90
[<0>] get_signal+0x96e/0x9b0
[<0>] arch_do_signal_or_restart+0x39/0x120
[<0>] syscall_exit_to_user_mode+0x15f/0x1e0
[<0>] do_syscall_64+0x8c/0x180
[<0>] entry_SYSCALL_64_after_hwframe+0x78/0x80

# kworker/u775:1+flush-259:11
$ cat /proc/355239/stack
cat /proc/355239/stack 
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

There is also and iou-wrk of that ublk server process:

$ cat /proc/348910/task/348911/stack 
[<0>] folio_wait_bit_common+0x136/0x330
[<0>] __folio_lock+0x17/0x30
[<0>] write_cache_pages+0x1cd/0x430
[<0>] blkdev_writepages+0x6f/0xb0
[<0>] do_writepages+0xcd/0x1f0
[<0>] filemap_fdatawrite_wbc+0x75/0xb0
[<0>] __filemap_fdatawrite_range+0x58/0x80
[<0>] filemap_write_and_wait_range+0x59/0xc0
[<0>] bdev_mark_dead+0x85/0xd0
[<0>] blk_report_disk_dead+0x87/0xf0
[<0>] del_gendisk+0x37f/0x3b0
[<0>] ublk_stop_dev+0x89/0x100 [ublk_drv]
[<0>] ublk_ctrl_uring_cmd+0x51a/0x750 [ublk_drv]
[<0>] io_uring_cmd+0x9f/0x140
[<0>] io_issue_sqe+0x193/0x410
[<0>] io_wq_submit_work+0xe2/0x380
[<0>] io_worker_handle_work+0xdf/0x340
[<0>] io_wq_worker+0xf9/0x350
[<0>] ret_from_fork+0x44/0x70
[<0>] ret_from_fork_asm+0x1b/0x30

[2. Kernel version]

Linux  6.8.0-87-generic #88-Ubuntu SMP PREEMPT_DYNAMIC Sat Oct 11 09:28:41 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

I am running Ubuntu 24:

Distributor ID: Ubuntu
Description:    Ubuntu-Server 24.04.2 2025.05.26 (Cubic 2025-05-27 05:35)
Release:        24.04
Codename:       noble

[3. Steps to reproduce]
Sorry, as this happens only in one process among one of our production servers,
I do not find an easy way to reproduce the error.

[4. Dmesg/Logs]
I can only find the logs like following. Apart from the kworker, there are
similar logs for the ublk server iou-wrk.

Jan 15 00:53:02 kernel: INFO: task kworker/303:0:77625 blocked for more than 122 seconds.
Jan 15 00:53:02 kernel:       Tainted: G           OE      6.8.0-87-generic #88-Ubuntu
Jan 15 00:53:02 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan 15 00:53:02 kernel: task:kworker/303:0   state:D stack:0     pid:77625 tgid:77625 ppid:2      flags:0x00004000
Jan 15 00:53:02 kernel: Workqueue: events delayed_fput
Jan 15 00:53:02 kernel: Call Trace:
Jan 15 00:53:02 kernel:  <TASK>
Jan 15 00:53:02 kernel:  __schedule+0x27c/0x6b0
Jan 15 00:53:02 kernel:  schedule+0x33/0x110
Jan 15 00:53:02 kernel:  io_schedule+0x46/0x80
Jan 15 00:53:02 kernel:  folio_wait_bit_common+0x136/0x330
Jan 15 00:53:02 kernel:  ? __pfx_wake_page_function+0x10/0x10
Jan 15 00:53:02 kernel:  __folio_lock+0x17/0x30
Jan 15 00:53:02 kernel:  write_cache_pages+0x1cd/0x430
Jan 15 00:53:02 kernel:  ? __pfx_blkdev_get_block+0x10/0x10
Jan 15 00:53:02 kernel:  ? __pfx_block_write_full_folio+0x10/0x10
Jan 15 00:53:02 kernel:  blkdev_writepages+0x6f/0xb0
Jan 15 00:53:02 kernel:  do_writepages+0xcd/0x1f0
Jan 15 00:53:02 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 15 00:53:02 kernel:  filemap_fdatawrite_wbc+0x75/0xb0
Jan 15 00:53:02 kernel:  __filemap_fdatawrite_range+0x58/0x80
Jan 15 00:53:02 kernel:  filemap_write_and_wait_range+0x59/0xc0
Jan 15 00:53:02 kernel:  bdev_release+0x18e/0x240
Jan 15 00:53:02 kernel:  blkdev_release+0x15/0x30
Jan 15 00:53:02 kernel:  __fput+0xa0/0x2e0
Jan 15 00:53:02 kernel:  delayed_fput+0x23/0x40
Jan 15 00:53:02 kernel:  process_one_work+0x181/0x3a0
Jan 15 00:53:02 kernel:  worker_thread+0x306/0x440
Jan 15 00:53:02 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 15 00:53:02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jan 15 00:53:02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jan 15 00:53:02 kernel:  kthread+0xef/0x120
Jan 15 00:53:02 kernel:  ? __pfx_kthread+0x10/0x10
Jan 15 00:53:02 kernel:  ret_from_fork+0x44/0x70
Jan 15 00:53:02 kernel:  ? __pfx_kthread+0x10/0x10
Jan 15 00:53:02 kernel:  ret_from_fork_asm+0x1b/0x30
Jan 15 00:53:02 kernel:  </TASK>

[5. Technical Hypothesis]
I suspect a deadlock occurs during the following sequence (assuming ublk id
is 123):

1. User program writes to /dev/ublkb123 via cached I/O, leaving dirty pages
   in the page cache.
2. The ublk server receives SIGINT and issues UBLK_U_CMD_STOP_DEV.
3. The kernel path STOP_DEV -> del_gendisk() -> bdev_mark_dead() attempts to
   flush dirty pages.
4. This flush generates new I/O requests directed back to the ublk server.
5. The ublk server receives SIGKILL at this moment, its threads stop and can
   no longer handle the I/O requests generated by the flush in step 3.
6. The server remains stuck in del_gendisk(), waiting for I/O completion that
   will never happen.

[6. My Question]
1. Would enable UBLK_F_USER_RECOVERY solve this bug? I find UBLK_F_USER_RECOVERY
   allows  ublk_unquiesce_dev() to be called during ublk_stop_dev.
2. Should userspace strictly forbid to send SIGKILL to ublk server?
3. I try to search the related bug fix or patches, but does not find.
   Are there known fixes in later kernels (6.10+) that address this specific
   interaction between del_gendisk and server termination?

Thanks,
huang-jl
