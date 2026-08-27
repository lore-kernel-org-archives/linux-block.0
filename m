Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9A41DED8
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825271; cv=none; b=rmbkXT8j5p274Tpl7YjHw527Rgj+EY47A1ZbUP3E5HOAqmS0/L5ziF8brOJtuqqCU1xz9tDeMRGvy3M40DYb2L1eugzE2p//LrZYTj8be81J+u9x53YzIaUclG1OEfw9OvJqU/DasUK5v/RRu7qJLolwB+iiJYQzm3nYzGo3zb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825271; c=relaxed/simple;
	bh=RVzOCFn/4sEqFpOvd1a0857XGxya77/cuhUokJwqr6g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AcaWOAprchU2o3odtQ8T3z+oVpEJVSJnWF0xGtWrGqMoEMwph2LVRDgu9qRfPEAg0OCOsQYiiYiTj8vDHZGAuTTB1YHVoIZ7Agm52PKJK4BoEffUuC82/Z/FPrFZ9xLoelUVVBdkwUzlQAeEB8E9regKwnLF9EIWsHcACPrtvLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4af7193adb7so174958b6e.0
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 03:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787825264; x=1788430064;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p11dZYhzWvRbix8e2dTeUc0wy381a09q511ebbLUCIA=;
        b=n3Qc6traG3tEhLZMU9K6l3vO2eBxulcXSSiotBTKJoztzMTDOeEzhZ80wm8WjeZlhI
         Yc5whwyH/Nbk267HYAeyaDsu9bJzpqjgmVw2qwn+vzIDw2aNGt8JI3nqlZngvEUeYRvJ
         bsPWGPzeFAx13N1EY6itpaOLCqV9N7Msm/gVZGgtPzvRb0qQB1Qss2qvd1fGWBPLRFZQ
         2ucVDk1KYmiblennRA4H4dV8wcvBHadP2qHSoyF3gi2R+VLn0n3XTBgQr+vj/vz/fayx
         DcgspBkB9UYa2/BlaBWi3tL5rGdq7DrQeDTs5B8I8bum+Y+gXyoh7h/FU3yPTn1vF+Ja
         fSjw==
X-Forwarded-Encrypted: i=1; AHgh+RqTVgqH6ebwWspT3NtIZIcjtZZBL2BHZPYsVC2Zbr7xQD5futRPFH9nzX/rVdL/bXjjTQn/7huFMXD7MA==@vger.kernel.org
X-Gm-Message-State: AFuF++mAQz9X2PqG/idHcWCKk80sFvkXQoAjSN8hTOTAqGUi5K9H1V08
	BiQD42JV+AmBz9ZYiDPM+xhFzA0VDGmNpK0QmTAXo/ad8Z5lp0jk+ZaZaI/tukW+GUk2U/4erQu
	M5SVhsIGg7Zr4WpIwFZsKNMuxOGNxdfAR0fOQ9JN3anJAAdVkCQUe9FUUOkk=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c297:b0:4a1:296:adec with SMTP id
 5614622812f47-4b366a0113cmr17051837b6e.15.1787825264331; Thu, 27 Aug 2026
 03:07:44 -0700 (PDT)
Date: Thu, 27 Aug 2026 03:07:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a900c70.50659fcc.60cd.0013.GAE@google.com>
Subject: [syzbot] [block?] BUG: unable to handle kernel paging request in blk_mq_complete_request_remote
From: syzbot <syzbot+2e3bf0bd49acd9b21d4b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    68f892e99df9 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=135bb415580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=2e3bf0bd49acd9b21d4b
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f98dd20a7b98/disk-68f892e9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/441f1ad32549/vmlinux-68f892e9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8da5227b7dc8/Image-68f892e9.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e3bf0bd49acd9b21d4b@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000031
KASAN: null-ptr-deref in range [0x0000000000000188-0x000000000000018f]
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
[dfff800000000031] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 8684 Comm: kworker/u8:27 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Workqueue: nvme-reset-wq nvme_reset_work
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1297
lr : blk_mq_complete_request_remote+0x88/0x858 block/blk-mq.c:1289
sp : ffff800095647900
x29: ffff800095647980 x28: ffff800095647900 x27: dfff800000000000
x26: 0000000000000000 x25: ffff0000c648326a x24: dfff800000000000
x23: ffff700012ac8f20 x22: 1fffe000192284a4 x21: 1fffe00018c90648
x20: 000000000000018e x19: ffff0000c9142400 x18: 1fffe00034bbbe28
x17: 0000000000000003 x16: ffff800088b37000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000004
x11: ffff700012ac8f3c x10: ffff8000884bb5d7 x9 : 1fffe00019228482
x8 : 0000000000000031 x7 : ffff80008281b4e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008281f228
x2 : 0000000000000000 x1 : ffff0000d604ba80 x0 : 0000000000000000
Call trace:
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1297 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:823 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1590 [inline]
 nvme_poll_cq+0x4ec/0x106c drivers/nvme/host/pci.c:1621
 nvme_reap_pending_cqes drivers/nvme/host/pci.c:2078 [inline]
 nvme_dev_disable+0x384/0x540 drivers/nvme/host/pci.c:3328
 nvme_reset_work+0x510/0x69c drivers/nvme/host/pci.c:3490
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
Code: 97d02797 f9400288 91063914 d343fe88 (38f86908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97d02797 	bl	0xffffffffff409e5c
   4:	f9400288 	ldr	x8, [x20]
   8:	91063914 	add	x20, x8, #0x18e
   c:	d343fe88 	lsr	x8, x20, #3
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
