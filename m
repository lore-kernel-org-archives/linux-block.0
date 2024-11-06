Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FDA18FDB1
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730860165; cv=none; b=EwMTCi/4xWKs6SqeK6/JNiAutjLvt1KVcnxaxDAn9XTFaOFIlt8m75qp4PlUHMaWj2i/OH1slg/JhvW/xF2BQq/6UX7LkGDKXGq5jvr0cV/JhSQIYy5UxZpvL9N5jNieDDZZLmAPYRSDMkbBMvGo6jKNk2gObVzMvuO0bhpnrt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730860165; c=relaxed/simple;
	bh=IBdg2Bt0HwnQgeOdaWbIXBiypwjEJVsrD8ry0xyzL58=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=skuXBBn31cW77pkd+OkRojXwpPCChOlT5Ta4XWlDdg3DKWa/eJkn1nT7dmduIO0mOlUeUTExpIeneoBX477zacf+UDqU8I30R95+eZ8Vj/ry+Q52n09iqlNu6brf/8WVDbrW7S+yESDa0cX2pduY9uJWg8UauP91OikuFE49PxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83a8c0df400so633845639f.1
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2024 18:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730860163; x=1731464963;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqvDHUXChDs5WDe5/A0Lk/jE4efsnc49CyWjy/J1UDk=;
        b=c4sHtMf947+CVv0SjxeVcFeKD71AHjgSR7+rkeNe/Jg2zzWhZcs5qSnqx0DIx23REt
         blC755Mxzx3qUaA4XXD7YmMVCGct34FFBihXYzDhyPKGtyFo7k4poGpuGdDgqiOqxSD1
         B+i8i5woFGKF1Yl5RCoy5LTEwJL8HES6fvapae0XaQlS+MUu84iIFreJUeWmudAY6YFq
         XiINSYIW977p91PdcIwR/ttLu2GzxMPV7l68ENOzINabiAClm/ncOdHbNvhu2+S/ZRVJ
         ec5q/KX7bj6T4R+HHJs91OqXphSKvs27TgIeO+5Qgo5sxgvePvJe3U//cstvDtvp4iyr
         ZJAA==
X-Forwarded-Encrypted: i=1; AJvYcCXZp6HXuedMpmSwRwt0ssCClV+ZFS1n5QGV8kaESrfxl0j09nkAH2rTf8uDZCSChxk/zC4c2212mgxw+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIOjsIdN29HbEHCCO5dl+pTDK2jw/mFHL2q0h0BEArmfk+9m2
	HmuABI1gPW0BX1qECoQMNjMt5xrbPv6louIRbNwrAlu0KFCaQ3T+NimgK6paKheeHQ7AfQ/LuDD
	n4P+4RSFKMFvh4eNfM3XmgQ4eLxpiH9a//+v/oxkSvvwidHef7p2Q+Z4=
X-Google-Smtp-Source: AGHT+IF0PM6LpNGmfDNDBX/JVebDF8JkusyPUeZZAlJmS18m15mJWEpE7hw3epPNz8/f4UjHrjOPiaU1a7Eme+e35jDB0BhYHIvO
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c544:0:b0:3a0:8d60:8ba7 with SMTP id
 e9e14a558f8ab-3a6b02f128cmr186708005ab.14.1730860163216; Tue, 05 Nov 2024
 18:29:23 -0800 (PST)
Date: Tue, 05 Nov 2024 18:29:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ad483.050a0220.2edce.1518.GAE@google.com>
Subject: [syzbot] [block?] [usb?] WARNING: bad unlock balance in blk_mq_update_tag_set_shared
From: syzbot <syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d34740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=5007209c85ecdb50b5da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d34740580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/760a8c88d0c3/disk-c88416ba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46e4b0a851a2/vmlinux-c88416ba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/428e2c784b75/bzImage-c88416ba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
6.12.0-rc5-next-20241101-syzkaller #0 Not tainted
-------------------------------------
kworker/1:1/57 is trying to release lock (&q->q_usage_counter(queue)) at:
[<ffffffff8497aa7f>] blk_mq_update_tag_set_shared+0x27f/0x350 block/blk-mq.c:4131
but there are no more locks to release!

other info that might help us debug this:
7 locks held by kworker/1:1/57:
 #0: ffff888144aecd48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888144aecd48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000101fd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000101fd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff8880284ce190 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8880284ce190 (&dev->mutex){....}-{4:4}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff888032eab190 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888032eab190 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0x103/0x950 drivers/usb/core/hub.c:2295
 #4: ffff88807fd02160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88807fd02160 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88807fd02160 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff8880334480e0 (&shost->scan_mutex){+.+.}-{4:4}, at: scsi_remove_host+0x34/0x770 drivers/scsi/hosts.c:169
 #6: ffff8880334482d0 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_del_queue_tag_set block/blk-mq.c:4139 [inline]
 #6: ffff8880334482d0 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_exit_queue+0x1da/0x470 block/blk-mq.c:4461

stack backtrace:
CPU: 1 UID: 0 PID: 57 Comm: kworker/1:1 Not tainted 6.12.0-rc5-next-20241101-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0x25b/0x2d0 kernel/locking/lockdep.c:5287
 __lock_release kernel/locking/lockdep.c:5526 [inline]
 lock_release+0x5cb/0xa30 kernel/locking/lockdep.c:5870
 blk_unfreeze_release_lock block/blk.h:745 [inline]
 blk_mq_unfreeze_queue+0xd2/0x140 block/blk-mq.c:213
 blk_mq_update_tag_set_shared+0x27f/0x350 block/blk-mq.c:4131
 blk_mq_del_queue_tag_set block/blk-mq.c:4145 [inline]
 blk_mq_exit_queue+0x3a4/0x470 block/blk-mq.c:4461
 blk_mq_destroy_queue+0x1c1/0x220 block/blk-mq.c:4284
 __scsi_remove_device+0x1f9/0x3c0 drivers/scsi/scsi_sysfs.c:1512
 scsi_forget_host+0xcf/0x110 drivers/scsi/scsi_scan.c:2068
 scsi_remove_host+0x1dd/0x770 drivers/scsi/hosts.c:181
 quiesce_and_remove_host drivers/usb/storage/usb.c:949 [inline]
 usb_stor_disconnect+0x14e/0x1f0 drivers/usb/storage/usb.c:1178
 usb_unbind_interface+0x25e/0x940 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1296
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
 device_del+0x57a/0x9b0 drivers/base/core.c:3861
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1418
 usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1ebc/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
usb 1-1: new full-speed USB device number 3 using dummy_hcd
usb 1-1: config 0 has an invalid interface number: 189 but max is 0
usb 1-1: config 0 has no interface number 0
usb 1-1: config 0 interface 189 altsetting 0 has an invalid descriptor for endpoint zero, skipping
usb 1-1: config 0 interface 189 altsetting 0 has an endpoint descriptor with address 0xE3, changing to 0x83
usb 1-1: config 0 interface 189 altsetting 0 endpoint 0x83 has invalid maxpacket 33307, setting to 64
usb 1-1: config 0 interface 189 altsetting 0 endpoint 0xB has invalid wMaxPacketSize 0
usb 1-1: config 0 interface 189 altsetting 0 has 3 endpoint descriptors, different from the interface descriptor's value: 2
usb 1-1: New USB device found, idVendor=07b4, idProduct=010a, bcdDevice= 1.02
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
ums-alauda 1-1:0.189: USB Mass Storage device detected
scsi host2: usb-storage 1-1:0.189
usb 1-1: USB disconnect, device number 3
usb 1-1: new full-speed USB device number 4 using dummy_hcd
usb 1-1: config 0 has an invalid interface number: 189 but max is 0
usb 1-1: config 0 has no interface number 0
usb 1-1: config 0 interface 189 altsetting 0 has an invalid descriptor for endpoint zero, skipping
usb 1-1: config 0 interface 189 altsetting 0 has an endpoint descriptor with address 0xE3, changing to 0x83
usb 1-1: config 0 interface 189 altsetting 0 endpoint 0x83 has invalid maxpacket 33307, setting to 64
usb 1-1: config 0 interface 189 altsetting 0 endpoint 0xB has invalid wMaxPacketSize 0
usb 1-1: config 0 interface 189 altsetting 0 has 3 endpoint descriptors, different from the interface descriptor's value: 2
usb 1-1: New USB device found, idVendor=07b4, idProduct=010a, bcdDevice= 1.02
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
ums-alauda 1-1:0.189: USB Mass Storage device detected
scsi host1: usb-storage 1-1:0.189


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
