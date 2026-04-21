Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D101B4F09
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769560; cv=none; b=tU7eGwB4hr+oywDaiHb9w2RjNPvnJD/OCCz8HdwxRwX4TNLlyxGslSbCkj3nUK4lg8NJYFS4jDD9g2FE4DClPVY469O9QXp5ZuWUYYb3kKh6TGBaCZKuQ1ITgmLkp/TA+GnyLCludyOoE4xmyRJezBs0eGmwKhI7SJvTa0xuYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769560; c=relaxed/simple;
	bh=S6wmBYopRig5xGjbi9+oKtefiDkoa5YATrQmehlJdsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ptqreOI9s0wiAsN9aiyRKabcKb5VnEnjfTYqaxyNS2bTaVgQos7JjB0G5NGeeWDBvIB9PAm3s6Sf7QZTae+CcMfeJKam8VQ+ksSs5wX+feFsI44IdMJaWCyLAdOSi3frHjGkvQxAMm97nO1iYHfxGs2veKw2gdj/HiUrbB4jNHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 63LB5pO3049656;
	Tue, 21 Apr 2026 20:05:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 63LB5prW049388
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 21 Apr 2026 20:05:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
Date: Tue, 21 Apr 2026 20:05:52 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] general protection fault in lo_rw_aio
To: syzbot <syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp

I confirmed that this NULL pointer dereference is triggered by
__loop_clr_fd() clearing lo->lo_backing_file before aio request
is processed. A debug printk() patch at
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/block/loop.c?h=next-20260420&id=7454b88731fd320e7dbfbf1ea72f25705c3befc0
generated the following output.


file == NULL
Last __loop_clr_fd() call was 5 jiffies ago by udevd (16676)
     lo_release+0x35b/0x9d0
     blkdev_release+0x15/0x20 block/fops.c:705
     __fput+0x461/0xa70 fs/file_table.c:510
     fput_close_sync+0x11f/0x240 fs/file_table.c:615
     __do_sys_close fs/open.c:1507 [inline]
     __se_sys_close fs/open.c:1492 [inline]
     __x64_sys_close+0x7e/0x110 fs/open.c:1492
     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
     do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000014: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
CPU: 0 UID: 0 PID: 180 Comm: kworker/u8:6 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: loop4 loop_workfn
RIP: 0010:file_inode include/linux/fs.h:1353 [inline]
RIP: 0010:kiocb_start_write include/linux/fs.h:2756 [inline]
RIP: 0010:lo_rw_aio+0xb88/0x1190 drivers/block/loop.c:429
Code: 1e d8 34 fc 45 85 e4 0f 84 d8 00 00 00 48 8b 44 24 58 48 8d 98 a0 00 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 8a 4c 9e fc 48 8b 1b 48 83 c3 28 49
RSP: 0018:ffffc90003907660 EFLAGS: 00010206
RAX: 0000000000000014 RBX: 00000000000000a0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900039077d0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc90003907723 R11: fffff52000720ee6 R12: 0000000000000001
R13: ffff888026ca2c90 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125eb7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b199a28 CR3: 000000003a2c0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_req_filebacked drivers/block/loop.c:461 [inline]
 loop_handle_cmd drivers/block/loop.c:1960 [inline]
 loop_process_work+0x647/0x1560 drivers/block/loop.c:1995
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3312
 process_scheduled_works kernel/workqueue.c:3403 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3489
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:file_inode include/linux/fs.h:1353 [inline]
RIP: 0010:kiocb_start_write include/linux/fs.h:2756 [inline]
RIP: 0010:lo_rw_aio+0xb88/0x1190 drivers/block/loop.c:429
Code: 1e d8 34 fc 45 85 e4 0f 84 d8 00 00 00 48 8b 44 24 58 48 8d 98 a0 00 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 8a 4c 9e fc 48 8b 1b 48 83 c3 28 49
RSP: 0018:ffffc90003907660 EFLAGS: 00010206
RAX: 0000000000000014 RBX: 00000000000000a0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900039077d0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc90003907723 R11: fffff52000720ee6 R12: 0000000000000001
R13: ffff888026ca2c90 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125eb7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b199a28 CR3: 000000003a2c0000 CR4: 00000000003526f0


Either fput() is called without corresponding fget(), or some recent changes
has changed timing of start processing aio request?

Since this problem started after the merge window opened, the culprit commit
might be in between commit a028739a4330 ("Merge tag 'block-7.0-20260305' of
git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux") and
commit 7fe6ac157b7e ("Merge tag 'for-7.1/block-20260411' of
git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux").
Also, syzbot was not testing changes in linux-next since next-20260403,
and found this problem in next-20260413.

