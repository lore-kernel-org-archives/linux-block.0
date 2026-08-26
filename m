Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD7416878
	for <linux-block@vger.kernel.org>; Wed, 26 Aug 2026 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746955; cv=none; b=dMwfRbFl+WmQS5gAXE98Z9OSTiN4/lvwIP1Ri725uOnsGgn9hCY75iHpIsIUUXy4ijajb8EgQNErpFl6lwppCN5aPVLXUO++ccJQ+m5plKRXhJHWrbtkTbN8D7PcW/srFi95d0WNk33cA0h3ZAmyM0KolKiKWdtIqM+X92KXuAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746955; c=relaxed/simple;
	bh=vJu/tgezIAyPq/jvVxwLDZ/MvZnGeML+p2SKRSGhOeg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F700/bdbVWOLCqJrDBwwE5Vq6fHxUUXB4wi+NvChIQCew/UScO+i3DMT3ypJwdJKX/SGumJnV2s+ftD7ngIeH7DeJuEeRbSGLO0BsS4bUqWLPuxhvjrG6Z1QroWX3w1EyN2NaRkvkmIlNMcmXIF/WXp3lgbpJ5bDsF+FxyHMWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f5.google.com with SMTP id 5614622812f47-4b3759b7ff0so56016b6e.1
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2026 05:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787746952; x=1788351752;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P5eo3SCH5j3Fs+ZHwEuof0JMA7kWfr4/TVZy9FrVKM4=;
        b=aXJv5O/Lc8NCvcUOsSaxIvjB56mk/Aqjb6mlmvUbLbIeWZqUD/90E/0D6Rk8KC81ZH
         DwTfHK7eAA7pUlMK7A1+I95eT0vqnFjo7jQDAt3taZmopuovfZ+FQtQsgiDAeHPmc4Kr
         jVl9hyM2brdyD1TDJWteXRK5kYqdEfcO18YEphHC+XZNsVSmz8Yy9BbcXy9ZHnAadI3p
         7/W0fGorxQhaKpw8yp/B+1H0Cqe1GSjdleaMWVnkLQmrOISBftcZhQ8f6fg6yDeS3ICp
         Q0QKY8GPhZmFa3OS3u6DVJR1/ZeDdRfvsEsqjGwVFrtF4D53BsdQn916MvcX5vvxlbAf
         FEVg==
X-Forwarded-Encrypted: i=1; AHgh+Roh0gpBpL/XGhB3NvbJiMRvBOXict5NDRQWmNJ5JIehRgIQI8L4Y+24na2MaTIEirtvSQF7/JWhywqdrw==@vger.kernel.org
X-Gm-Message-State: AFuF++mMgkx1K7X6XmSIONK3skrb+5wgpK4gB20Gxkjre4HZ8mDP/nv6
	Q+w5Wdlv7EEQ0IGAM/EPI1DZN+fM88oE8BxvpozJJceCNv+6gdQO0xTr78d2e4NjipUEhuwgCPQ
	5EeN5IsKSkCve0WW9fA/NECLqNIg9VJM2umJO8XW78evFPPY00cAhxC0sQK0=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fd1:b0:4aa:d5f:123e with SMTP id
 5614622812f47-4b366b0ea25mr6875968b6e.9.1787746952438; Wed, 26 Aug 2026
 05:22:32 -0700 (PDT)
Date: Wed, 26 Aug 2026 05:22:32 -0700
In-Reply-To: <6a778cfb.9c11d2ce.289b96.00b7.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8eda88.1d9ded08.62e62.00ad.GAE@google.com>
Subject: Re: [syzbot] [block?] WARNING in blk_mq_free_tag_set
From: syzbot <syzbot+02b37e31e64ea5cb6d29@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a8406e6c0b79 Add linux-next specific files for 20260825
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=114f1625580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da8932b2925a9804
dashboard link: https://syzkaller.appspot.com/bug?extid=02b37e31e64ea5cb6d29
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dad979580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10136979580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd019bacac75/disk-a8406e6c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e47580ccc38d/vmlinux-a8406e6c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b7909a5638c6/bzImage-a8406e6c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02b37e31e64ea5cb6d29@syzkaller.appspotmail.com

------------[ cut here ]------------
timer_delete_sync(&sdp->delay_work) && rcu_segcblist_n_cbs(&sdp->srcu_cblist)
WARNING: kernel/rcu/srcutree.c:707 at cleanup_srcu_struct+0x3d6/0x8b0 kernel/rcu/srcutree.c:706, CPU#0: syz.0.1231/9288
Modules linked in:
CPU: 0 UID: 0 PID: 9288 Comm: syz.0.1231 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:cleanup_srcu_struct+0x3d6/0x8b0 kernel/rcu/srcutree.c:706
Code: f3 8b 00 48 83 7d 00 00 4c 8b 74 24 10 0f 85 dd 03 00 00 41 ff c5 41 83 e5 0f 41 83 fd 07 0f 86 e2 fe ff ff e9 ab 00 00 00 90 <0f> 0b 90 4c 8d b5 00 02 00 00 4c 89 f3 48 c1 eb 03 48 b8 00 00 00
RSP: 0018:ffffc900033c7cf0 EFLAGS: 00010206
RAX: 1ffffd1ffff81745 RBX: 0000607edaf36940 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: ffffffff8e478a87 RDI: 00000000ffffffff
RBP: ffffe8ffffc0b940 R08: ffffffff907a4f7f R09: 1ffffffff20f49ef
R10: dffffc0000000000 R11: fffffbfff20f49f0 R12: ffff888054a1e800
R13: 0000000000000000 R14: ffffe8ffffc0ba28 R15: 1ffffffff1ce95de
FS:  00007f73abf2d6c0(0000) GS:ffff888124cd5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000100 CR3: 0000000076d8a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 blk_mq_free_tag_set+0x617/0x790 block/blk-mq.c:4976
 loop_remove+0x4e/0xc0 drivers/block/loop.c:2143
 loop_control_remove drivers/block/loop.c:2201 [inline]
 loop_control_ioctl+0x4a6/0x5a0 drivers/block/loop.c:2243
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f73aaf9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f73abf2d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f73ab225fa0 RCX: 00007f73aaf9e0d9
RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000003
RBP: 00007f73ab035024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f73ab226038 R14: 00007f73ab225fa0 R15: 00007ffe4f51e5e8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
