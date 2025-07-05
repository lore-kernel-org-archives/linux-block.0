Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7718786A
	for <linux-block@vger.kernel.org>; Sat,  5 Jul 2025 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751723311; cv=none; b=A169p+zTanU8c9XFFb8r/GvaT+K3u41FkZVLFYXs2+5cKLg00gNxNPrIH81M1LOlsby89seNGd6FKhhPN4lC/vBKxuE/TA2Cjq3MN7J0ZGVWSSSyiOgPma/kN7MLuAfUMocrZVi/yOAg+v/K86iAej9KkvBqC59QXL/heXQS6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751723311; c=relaxed/simple;
	bh=zTUUdGtNGHNkmgCUfal5d2e0M47bEKBqbh1aser7tow=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tWS3nSN1yVI4dgxa5gCB2X8YvPX1G4Z2cyMw2/9aOJal2fAt41O0xgMCL8uGW5GBts4WSO5p4eyjFoCh1lXQvBA6c/Whw1G6O+vzeygPC07qaMZ8L7XVVuwOwI7uRxtlE330Bi1POYsk2wXU/BBSJAZ2+e9LxBioOm89ukJgHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df6030ea2fso41799955ab.1
        for <linux-block@vger.kernel.org>; Sat, 05 Jul 2025 06:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751723308; x=1752328108;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVre2S1XFioIxKtoHP/JhLuHCaZYd22Gd8jKtVAQeos=;
        b=HzpZDf6qix68rjMq8d/lPYsfkAavMbzS6j9lJs+V1sL7a7F5S1GRSPrd9VZL0BGMaK
         6firjBRgi79Zxavn4DpCljPTOsEPNeIzVW5LDVaWZhWtbMVpRyoputvVXwE+IT8yfP4M
         9TV40ajRlM9XT9/Kdrz9pk357xGNhcDMQUdfzM+suBY3/bacU3oaBQcT30wEL1jJ5cWy
         cUJ/na7+tRg1/MuwioPy5qD51U2Btb4M7fqQ02Nb/vHFFA8OWV2EPDK3BAwUW/8u6gjU
         AksZgSsewB3pbPGfP29TiSCB8LtUanJ1DxNhzvIPYoc1Gp8Fd0szLm4ntp2G6Xsnflcs
         uECg==
X-Forwarded-Encrypted: i=1; AJvYcCWVEH5oA+tizwXMF942QBfyYQRPezPZLOFoYkytcHECd6UI23SxPzXWozJCMGohayia9BTOniLZ4IVDHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUSpNHAToac3QDV7uu+QjqgRQ6ymLQcDV88WU9iFnUwDeIOdn
	o29N3nbfsyqcgYKpUltCVIDo6QxZTxvdREeYC+ZHQT++tCuab47+jUMgvcdZb5AwJaSjv6nzSVv
	G2HLEtgFcLY4ZM2ievv/muXaseJGF7NE5DLWlpDYH8+E7iRGuv3U+ObuZXAk=
X-Google-Smtp-Source: AGHT+IEQIaO6YhD+WdhvriNnAc30MPKxJbNQZAH3mLtBOAfa7jzwdOnfdJe5emo2fk7aZlwa8FntZ/HX/i43qCx06s2xVoLP280k
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0e:b0:3dd:d189:6511 with SMTP id
 e9e14a558f8ab-3e13ef1d79cmr21080295ab.21.1751723308282; Sat, 05 Jul 2025
 06:48:28 -0700 (PDT)
Date: Sat, 05 Jul 2025 06:48:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68692d2c.a00a0220.c7b3.0039.GAE@google.com>
Subject: [syzbot] [block?] WARNING in bioset_exit (2)
From: syzbot <syzbot+1bfac8c74f4f587bf9c7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1343433ed389 Add linux-next specific files for 20250630
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=100c93d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1ce97baf6bd6397
dashboard link: https://syzkaller.appspot.com/bug?extid=1bfac8c74f4f587bf9c7
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3387c64e9ec/disk-1343433e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/abf15e85d8dd/vmlinux-1343433e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/081c344403bc/bzImage-1343433e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1bfac8c74f4f587bf9c7@syzkaller.appspotmail.com

BUG bio-240 (Not tainted): Objects remaining on __kmem_cache_shutdown()
-----------------------------------------------------------------------------
Object 0xffff88806ae61000 @offset=0
Slab 0xffffea0001ab9840 objects=12 used=1 fp=0xffff88806ae61140 flags=0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
Disabling lock debugging due to kernel taint
------------[ cut here ]------------
WARNING: mm/slub.c:1171 at __slab_err+0x15/0x20 mm/slub.c:1171, CPU#0: syz.4.178/6655
Modules linked in:
CPU: 0 UID: 0 PID: 6655 Comm: syz.4.178 Tainted: G    B               6.16.0-rc4-next-20250630-syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__slab_err+0x15/0x20 mm/slub.c:1171
Code: 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 bb ff ff ff bf 05 00 00 00 be 01 00 00 00 e8 1c 6c 5b 00 90 <0f> 0b 90 e9 d3 77 4a 0a cc 66 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000baa7868 EFLAGS: 00010046
RAX: ffffffff81836dfa RBX: ffff888026c3d000 RCX: 0000000000080000
RDX: ffffc9000ce29000 RSI: 000000000007ffff RDI: 0000000000080000
RBP: 0000000000000000 R08: ffffffff92a69fc7 R09: 1ffffffff254d3f8
R10: dffffc0000000000 R11: fffffbfff254d3f9 R12: ffff888077b75648
R13: ffffea0001ab9840 R14: ffff888077b75648 R15: ffff888077b75600
FS:  00007fe6701f66c0(0000) GS:ffff888125c1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9212ee56c0 CR3: 000000007e528000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 free_partial mm/slub.c:5903 [inline]
 __kmem_cache_shutdown+0xd4/0x250 mm/slub.c:5934
 kmem_cache_destroy+0x76/0x160 mm/slab_common.c:523
 bio_put_slab block/bio.c:155 [inline]
 bioset_exit+0x583/0x690 block/bio.c:1764
 __bch2_fs_free fs/bcachefs/super.c:609 [inline]
 bch2_fs_release+0x25c/0x830 fs/bcachefs/super.c:667
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 bch2_fs_get_tree+0xb39/0x14f0 fs/bcachefs/fs.c:2605
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe6723900ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe6701f5e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe6701f5ef0 RCX: 00007fe6723900ca
RDX: 0000200000000140 RSI: 0000200000000100 RDI: 00007fe6701f5eb0
RBP: 0000200000000140 R08: 00007fe6701f5ef0 R09: 0000000002800000
R10: 0000000002800000 R11: 0000000000000246 R12: 0000200000000100
R13: 00007fe6701f5eb0 R14: 0000000000005a7a R15: 0000200000000300
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
