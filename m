Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD9438472
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243506; cv=none; b=OLnY06zqTmdDphXCLKxqhJ242TR7NAhSWgo3xIg1NX/ZSI5OOz7bgmu6Tl4E/cAEdYKbNr+EmKCN+2tQT4Sal5zCRcbgOHF0QlE6omRJ+xNxFQoKm2/RV8hVtJFTvc5ZMXewAnygUNY0SySaadzOvrrrFPUFymi5mbWxGowih6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243506; c=relaxed/simple;
	bh=ixas0KYKGbKQeKRHRc5bey5LfsdW4XoTh6cWp70bu+Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BO1xpPeozg+pNujozpcflbcRg3xIDWlHVO/1lOSmCIK3dJxta+clEvzFlsVinrp4XSJoNppBlfQXIpHKmeF1fX43SLKRGlLz4p6MO5cZg+Hc0zgMPmuniZJ/zAxgggv62diwWn864rsvFqpYvFbGHaGLuBfXtgoF+TjUgOd2GdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-49ab6a82cd5so5032963b6e.2
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 05:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243503; x=1785848303;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZLnj6zZUprtiqaAMGSQ88ksQ8rIQm7u/CEFtblZzPQ=;
        b=i9ZK6qtNxPMXqhbmrZtEsUZMxojm0dKJSzQ2gi2WPsE9UU0Cwhd+aIFx03gJVTuszn
         5lQR8bBvyx//JfzM77liTAmaK0TfG3eN8NqKgQUTjpG+CH8ktIRQlunz+q9oJ2WGXiTv
         DkpA6Zxfm6zdhFokljwtSR9YFPMt8ScVG+clTLrDIKRGF9DJeaUJVdexTEh/ygT0UW6/
         wBrQo4eD9OFno2bQRKPTh1s9Yza1u0qPmlfPHOOhm0bp8RAObQQHpa3WQqSlRrdXLvXh
         Qc9UOBbEUhWvKmbc72I7PcBwJMMtPaXvRI/zN/XRUCKOL/tpUqnA6Zlf8Bahbzhk19rs
         iz6w==
X-Forwarded-Encrypted: i=1; AHgh+Ro00B80QYsQt+hMompiHXX7/ZBbqGJqiPu3/h7DUNUPhKyT5hP+2UBZ2Iw3gGh1UVA37r+BpiH1bMc06Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUEYjxo2KMJ5mRQK6LilawmIIXDSR/mqdsbdRk1FJXHVp9axW
	05hLW4as2l6gnKKPa4TrE6+P7ikBgxcopHvogG3gdn2vcCddmQIwoIYhNqnq9gWHmQgjo7Z/bYb
	0kXt93+d7++C/O6yoLM+6zK7CpWewGuIdCjU3cPfAgDafzb6wuSnpkYldnJA=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:23d4:b0:497:da7f:179e with SMTP id
 5614622812f47-4ad5bbd9caamr1454130b6e.38.1785243503340; Tue, 28 Jul 2026
 05:58:23 -0700 (PDT)
Date: Tue, 28 Jul 2026 05:58:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a68a76f.4c659fcc.19cd90.001c.GAE@google.com>
Subject: [syzbot] [block?] WARNING in blk_mq_alloc_tag_set
From: syzbot <syzbot+18431bc7dccedc61778f@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d326f83e819c Merge tag 'net-7.2-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129f3bde580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c4196ba0e33631d
dashboard link: https://syzkaller.appspot.com/bug?extid=18431bc7dccedc61778f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9359ac22935d/disk-d326f83e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c8a632e638dc/vmlinux-d326f83e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db78e854ce3e/bzImage-d326f83e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18431bc7dccedc61778f@syzkaller.appspotmail.com

blk-mq: failed to allocate request map
------------[ cut here ]------------
rcu_segcblist_n_cbs(&sdp->srcu_cblist)
WARNING: kernel/rcu/srcutree.c:730 at cleanup_srcu_struct+0x369/0x470 kernel/rcu/srcutree.c:730, CPU#1: iou-wrk-11407/11411
Modules linked in:
CPU: 1 UID: 0 PID: 11411 Comm: iou-wrk-11407 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/10/2026
RIP: 0010:cleanup_srcu_struct+0x369/0x470 kernel/rcu/srcutree.c:730
Code: 7c 35 00 00 74 08 4c 89 ff e8 b3 44 89 00 49 c7 07 00 00 00 00 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d e9 34 80 65 ff cc 90 <0f> 0b 90 eb e6 90 0f 0b 90 eb e0 90 0f 0b 90 eb da 90 0f 0b 90 eb
RSP: 0018:ffffc9001e1f7740 EFLAGS: 00010202
RAX: 1ffffd1ffff92d11 RBX: 1ffffffff1c9f5de RCX: b62894e921e22600
RDX: 0000000000000001 RSI: ffffffff8e4b12ee RDI: ffff888034b93e00
RBP: ffffe8ffffc96888 R08: ffffe8ffffc96927 R09: 1ffffd1ffff92d24
R10: dffffc0000000000 R11: fffff91ffff92d25 R12: ffff8880330a4160
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000607edad447c0
FS:  00007f420a7846c0(0000) GS:ffff888125052000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000029000 CR3: 000000007d20d000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 blk_mq_alloc_tag_set+0xc77/0x1000 block/blk-mq.c:4928
 ublk_ctrl_add_dev+0x903/0xbc0 drivers/block/ublk_drv.c:4797
 ublk_ctrl_uring_cmd+0x696/0x7e0 drivers/block/ublk_drv.c:5783
 io_uring_cmd+0x2e6/0x8b0 io_uring/uring_cmd.c:271
 __io_issue_sqe+0x188/0x4d0 io_uring/io_uring.c:1395
 io_issue_sqe+0x16d/0x1020 io_uring/io_uring.c:1418
 io_wq_submit_work+0x7ab/0xc90 io_uring/io_uring.c:1534
 io_worker_handle_work+0x72e/0x10d0 io_uring/io-wq.c:652
 io_wq_worker+0x452/0xf10 io_uring/io-wq.c:706
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
