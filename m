Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987575;
	b=PEpv8geqHSMwTOE6kyJAs4n9fwmgeOMmHbcxA1ET21uKWHiUPzCNYwXFLZCs86W3n47Q
	 5oHC9opGYO3ZVeg5ENDj5EknLK5RkN/RGUa+IADtpuEIQu1UfFWlsFr2WDehmrUm8z7Mx
	 wfZRYTrFq5vPknmVPkN+qP+V89yeYHh4COh6/oQ1KhnHUUDuNVeacIEMKzIwQ/PBUZrhA
	 F6a4EK8Kx3fCI7XcWvgq/rlTbVXJdtmR5CyGYwoZGrQvcwjkUvuNCInyeY7QI1z/X0WxI
	 APARiulcipxmmS7j1YVvDgN1lawFI5T1MtDVxvuImtjRbWGPj0eIDpnCi7VgQw6ePjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987575;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=LH3cAN2f+M47HT94GXo4CX39wD6DPIcKQ9zFQmQCpeQ=;
	b=3CZDOrBls9XOQN1IRoRz5qhJRSFd2YT7MmVPceWNZgdNGIeGm68iXKdWQr5neZ/LkUIJ
	 oFy6KvjllxbK+lg7tnk8Z04+omynYZ9Ppurx7LedNLiAsQaQoT0UOE3KKuBHaJ2XsayRV
	 zs0K/dSAGkqriUOWxBLt7gxu5EGIb76jyQMcn5p5RwimIWKkb2E2WaxztxLQMoUoqnpz7
	 ejg3//qvuJnu18a+e53SbDf/G9fLLPVO/3sYZWkLaaN/1ou+bZVBzP3UTEHYx3llDJ3IW
	 PDZOXZzA1xydGitM96TpoBaI1vA/04jZbYoqFoeB1uDRhmqbns3kOQr/xM12zhRB5/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA68606A329
	for <linux-block@vger.kernel.org>; Fri,  6 Nov 2026 17:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA68606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c55ba309c2so1059817b6e.1
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2026 09:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987574; x=1794592374;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LH3cAN2f+M47HT94GXo4CX39wD6DPIcKQ9zFQmQCpeQ=;
        b=yfyB2OhTYd0Dqfeg1ec3rSN2imQQfP2E0+VHFZlNtinpEfkMhoJlnM0t9aZZmo8RDp
         KIKmfLeKKLf6ka2Gk3JQHydUtkMU+ji0uEyATHfNPfxM02h6GHGzqIwFdZq+Oz4HjD5o
         ZIZ4+juTNvb8X0QG0onHw1vmdialxbjLScbpcGNHKQdRMB9YoZKHNdj5PThM7Zfkyco0
         tJXugP7E2tmwsSr02g6XqYEclKdSsD7xaFU+sxq/3XetK78ybWIu1USR4Wl+KEgL6INw
         crNxEgeFAc01E97FYoU/QrS90te+acRAfXvTDSGkkZm0y/l1hgsGkxDIzt8Ld9STdL/M
         EQqQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0AA5S92rEVRM85ef4/RFEshuaeTF081ww0lbaN/cJmgWA8hW7SsmKucpocGvGyUBKk2TPkjJWXZdVyA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+EkcaEXwDamqeZCq3WMLOGTEuX1pGhSdbcpmyW6b9A5HNa44CC
	H8G31thdaPVrBIS++molyoBYp1n9lTC4Gia/rYVeYqMHa2DvP+4edFLXkG59Z0cxmvRxJqOZXJk
	2mxc6DkeG8xnqxOIKIfO2BmKS6OX6k78bRu7a/U1JjpaJeCML4ZR1GpTWw0c=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:192a:b0:567:c9d6:b2b2 with SMTP id
 5614622812f47-567e15b4486mr2747150b6e.47.1793987573896; Fri, 06 Nov 2026
 09:52:53 -0800 (PST)
Date: Fri, 06 Nov 2026 09:52:53 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aee13f5.02d3f859.2829d1.0014.GAE@google.com>
Subject: [syzbot] [block?] WARNING in bd_unlink_disk_holder
From: syzbot <syzbot+0a8119ab801b078213ea@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b0958b1397fb arm64: mm: validate /dev/mem mmap ranges with..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1018bddd580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a58b6b4d667e7a61
dashboard link: https://syzkaller.appspot.com/bug?extid=0a8119ab801b078213ea
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1418bddd580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1caa79f24c0/disk-b0958b13.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/99b068dd4197/vmlinux-b0958b13.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e135f96e545e/Image-b0958b13.gz.xz

AI-generated root cause summary:
In drivers/md/md.c:bind_rdev_to_array(), an rdev is added to mddev->disks and
bd_link_disk_holder() is called to create the holder/slave relationship without
checking its return value. If bd_link_disk_holder() fails (for example,
returning -EINVAL when an array's own block device or partition is imported into
itself, or on memory/sysfs failures), no bd_holder_disk entry is added to
disk->slave_bdevs, yet the device remains bound to the array. When the array is
subsequently stopped via do_md_stop() -> export_array() ->
md_kick_rdev_from_array(), bd_unlink_disk_holder() is called and
bd_find_holder_disk() returns NULL, triggering WARN_ON_ONCE(holder == NULL) at
block/holder.c:147.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=0a8119ab801b078213ea

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a8119ab801b078213ea@syzkaller.appspotmail.com

md: md4 stopped.
------------[ cut here ]------------
WARNING: block/holder.c:147 at bd_find_holder_disk block/holder.c:18 [inline], CPU#0: syz.4.21/5133
WARNING: block/holder.c:147 at bd_unlink_disk_holder+0xd8/0x2d4 block/holder.c:146, CPU#0: syz.4.21/5133
Modules linked in:
CPU: 0 UID: 0 PID: 5133 Comm: syz.4.21 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : bd_unlink_disk_holder+0xd8/0x2d4 block/holder.c:18
lr : bd_find_holder_disk block/holder.c:18 [inline]
lr : bd_unlink_disk_holder+0xd8/0x2d4 block/holder.c:146
sp : ffff800098f877e0
x29: ffff800098f877e0 x28: 1fffe000192c2f06 x27: ffff0000d92043d0
x26: 1fffe00018291306 x25: 1fffe0001b240879 x24: ffff0000d92043c8
x23: dfff800000000000 x22: ffff0000c1489830 x21: ffff0000c1489700
x20: ffff0000d9204000 x19: ffff0000d92043d0 x18: 1fffe000359cf228
x17: 0000000000000003 x16: ffff8000898b7000 x15: ffff80008996b2a0
x14: 00000000005a60a9 x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000000001 x9 : 0000000000000000
x8 : 0000000000000000 x7 : ffff8000818fb144 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008046bc7c
x2 : 0000000000000001 x1 : ffff0000d96b0000 x0 : 0000000000000000
Call trace:
 bd_find_holder_disk block/holder.c:18 [inline] (P)
 bd_unlink_disk_holder+0xd8/0x2d4 block/holder.c:146 (P)
 md_kick_rdev_from_array+0x8c/0x324 drivers/md/md.c:2683
 export_array drivers/md/md.c:2714 [inline]
 do_md_stop+0x708/0xe6c drivers/md/md.c:7252
 md_ioctl+0x14ec/0x23e4 drivers/md/md.c:8462
 blkdev_ioctl+0x574/0x904 block/ioctl.c:798
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __arm64_sys_ioctl+0x154/0x1cc fs/ioctl.c:583
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:796
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:815
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 2038
hardirqs last  enabled at (2037): [<ffff8000804a3fb4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (2038): [<ffff800086953878>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:483
softirqs last  enabled at (1948): [<ffff8000801373b8>] local_bh_enable include/linux/bottom_half.h:33 [inline]
softirqs last  enabled at (1948): [<ffff8000801373b8>] put_cpu_fpsimd_context arch/arm64/kernel/fpsimd.c:251 [inline]
softirqs last  enabled at (1948): [<ffff8000801373b8>] do_sve_acc+0x3ac/0x56c arch/arm64/kernel/fpsimd.c:1333
softirqs last disabled at (1946): [<ffff800080137110>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (1946): [<ffff800080137110>] get_cpu_fpsimd_context arch/arm64/kernel/fpsimd.c:234 [inline]
softirqs last disabled at (1946): [<ffff800080137110>] do_sve_acc+0x104/0x56c arch/arm64/kernel/fpsimd.c:1308
---[ end trace 0000000000000000 ]---


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
