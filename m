Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FC283FE5
	for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788069457; cv=none; b=DKewHAVbR2+1Zchhm4TspCUK8BcIu9Rh4C1kt2ZX/YFEsvhWtIsmL5mn4uXJxdjLE98SrFEavuTHUXhG0UTOcibSCWE/X0MG7+N49JjNC14QWWfozTF3AR3wW+5UTediex9Uog+PmubN0wsOuV8NFpqPcKIlbKNKQ7u2OBjSMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788069457; c=relaxed/simple;
	bh=RKvjahK235bsSkBPco7W8TPdvlWbJaAhDtFa/GzPnLo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PaGfqrT/VZZHFzJRLb5mIZX8oDRrswF/Ue9H8NzmeFfzG8s/Qe8WWqBonfWqVFKIDGM4r2x/Cc0cDS556Iw3ekOQs5w6xNqbyI45Llq0e7JHMsLlceAK7/uPRfSJDxuYD9bSTxsWEenNte/CK0rVTa1ZqLW2wBWuDL0f6oaEH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f5.google.com with SMTP id 5614622812f47-4b3759b7ff0so1204762b6e.1
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2026 22:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788069448; x=1788674248;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPzYaVT96ZZz0Nmz5XnIq2YVKAVdKMvBMnRhoLzoJmQ=;
        b=sU0XWshvxHCpbSEV4NkuKXI9Z+SD8ORL5aYF0MpP4MO1tKSP94GFDBDGg1Qw6IG9wm
         FRusk6aE34U2s+tMoq4VgDyVfWJdCNwY4ZKIuA7civaqrk4UA+acj+HzZdg7RjOtqijY
         GC1lbOOS5CIMFLgARwX3r4veF4fTVdRn/ziVZ0hoggPFetkZxXNPiAox3EwYyEoWbjo8
         WaNKBfarPims/4buoIzWeiEZZi8USaSS8PvNLXob8mB1TnpzvXuw91MWpZHwexgFtvFx
         BsuXSbVGOdx3O474wfTS+unr4wt+d+su063M8awd+UKkwg4XcqDXL/aOBqz6YkqxW17k
         XR/Q==
X-Forwarded-Encrypted: i=1; AHgh+Roo4bGGRteL3y1KlwfMOD1ZLha6IxrPXlbdu/b5Bj3+LiE81JjMOS6ObAFpGY+mTrpFlPxcrut9xO0mtw==@vger.kernel.org
X-Gm-Message-State: AFuF++naN89GbJbIkGwdaD01E1fCF2PGkAzkaF8XUY4BWNAa5Nici7ef
	wvwGGz0N4Mjf5VIxkrBw+EyBdN40NWPdSCsJFWt35HfqAbswdWh7R6+gqxRbKgu7+vuK68j0ueR
	/s8RwS0CA0mKAam7O+RKIZ6I86abwyA5xY58qDHW2GIBv7RmLiLJB9iM9ojU=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1525:b0:4b2:8e51:aac2 with SMTP id
 5614622812f47-4b398018734mr21779232b6e.8.1788069448281; Sat, 29 Aug 2026
 22:57:28 -0700 (PDT)
Date: Sat, 29 Aug 2026 22:57:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a93c648.08e933ee.dbf97.00fc.GAE@google.com>
Subject: [syzbot] [block?] BUG: unable to handle kernel paging request in __blk_mq_alloc_driver_tag
From: syzbot <syzbot+b380cbb218c1ef0fe808@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f1b8fa82cab7 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10697d79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=b380cbb218c1ef0fe808
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/932d85a2bda2/disk-f1b8fa82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b6b8fb76e8d/vmlinux-f1b8fa82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c246b61ee396/Image-f1b8fa82.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b380cbb218c1ef0fe808@syzkaller.appspotmail.com

nvme nvme0: Does your device have a faulty power saving mode enabled?
nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off" and report a bug
Unable to handle kernel paging request at virtual address dfff800000000000
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
[dfff800000000000] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 4404 Comm: kworker/0:1H Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : blk_mq_tag_is_reserved block/blk-mq.h:224 [inline]
pc : __blk_mq_alloc_driver_tag+0x118/0x554 block/blk-mq.c:1844
lr : blk_mq_tag_busy block/blk-mq.h:211 [inline]
lr : __blk_mq_alloc_driver_tag+0xbc/0x554 block/blk-mq.c:1842
sp : ffff800099507780
x26: 0000000000000000 x25: 1fffe000190d6c82 x24: dfff800000000000
x23: ffff0000c8044400 x22: 0000000000000004 x21: 00000000ffffffff
x20: ffff0000c86b6400 x19: ffff0000c86b6410 x18: 00000000ffffffff
x17: ffff80008a7d6000 x16: 0000000000000004 x15: ffff80008a35fda0
x14: ffff80008a5d5e28 x13: 0000000000000002 x12: 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff80008aa7bd88 x4 : 0000000000000000 x3 : ffff8000817944e8
x2 : 0000000000000000 x1 : ffff0000c81a3a80 x0 : 0000000000000000
Call trace:
 blk_mq_get_driver_tag block/blk-mq.h:374 [inline]
 blk_mq_prep_dispatch_rq block/blk-mq.c:2029 [inline]
 blk_mq_dispatch_rq_list+0x298/0x13a8 block/blk-mq.c:2108
 __blk_mq_sched_dispatch_requests+0x250/0x10e8 block/blk-mq-sched.c:299
 blk_mq_sched_dispatch_requests+0xa8/0x158 block/blk-mq-sched.c:329
 blk_mq_run_work_fn+0x214/0x2e4 block/blk-mq.c:2532
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
 kthread+0x304/0x3d4 kernel/kthread.c:436
Code: 35001b08 910012d6 b94002b5 d343fec8 (38f86908) 
---[ end trace 0000000000000000 ]---
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x14000000,003c0008,27020a02,a84ff6a7
Memory Limit: none
Rebooting in 86400 seconds..
----------------
Code disassembly (best guess):
   0:	35001b08 	cbnz	w8, 0x360
   4:	910012d6 	add	x22, x22, #0x4
   8:	b94002b5 	ldr	w21, [x21]
   c:	d343fec8 	lsr	x8, x22, #3
* 10:	38f86908 	ldrsb	w8, [x8, x24] <-- trapping instruction


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
