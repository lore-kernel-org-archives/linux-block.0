Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37821BC2A
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665822; cv=none; b=SDs5W+6Sz0M9nCwZrB1dEfd58wD1+fbvcpMjqcHBpV2olKxQjZf4I90gm/D0B8Pw7OTKuPp/xClID5pyIEBIGiYEXBaZ3AaEUmcwu6Rhu1ODNrBZGM4cJtETthMvRNwowvl9+kqih0X4sKK3LbIjgWroLVA4Qit76MBWtXTfLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665822; c=relaxed/simple;
	bh=ufCacbsKAwudQq7iL7+KOwpGLn2eguJNXjyGIjMC2T8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t3NKoRfMqU6w2j0e7SxS0LarvbiDmI0bhrMzAmqBAGpkqx7LiMaBzRwaXxHN8iZKGosCS5U1gF+YJdonCmmRIOJYtw/aVKbnJp6vZdD/5JOV3PqswvNK60J/x2WczsjXWK9xKyT3jyA9dsP2o648oqHGSl7debcKan4+rN6Lqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6acbcb92d31so359768eaf.1
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 17:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786665819; x=1787270619;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tPYxnqSuohYUWELVByUhoqfbtM5/bpyWFDe4sWEUaqo=;
        b=HMenYPpRrlA2+68su6okHyRQQ+okkAZLSG0Toa7iERY9N/yb7NUZo6W1Qr8/wjZYUr
         zSi03xRrfwxjV9/8bZqto0s8mfP8JhegcJFtPEIwDUYEN7G5/ZOCs/f/0omINKedxIBX
         g+PnD/7NlAW32OmIvVoRgxoXN9piogJAUebuZS8QfOd7qfmZF56FdWyRbB/LyIHERklw
         KHZIg9jBCT1qeeIr/CkyjaCsy8o/3mweXyNHjhduvTn8mofzlMtuBR7LlAwTNjOHm8tD
         t8mskvntMOLCeBdtV1U/o2y8to25G5e+sMUYLxWq8gFxJJ5pGHYB510jyM98GEleRjtp
         uZ0g==
X-Forwarded-Encrypted: i=1; AHgh+RrhW0cOIpOaua6AY2lP8SOg5NxYCQ+isMZudz+IXxaJkOQN+DQbdUTqtlxxehDn+8ipCnNFdzAN2JQ1xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWlVVAuEPCtY3x+xafPIWEvNgXKq+FZVQl365rCGPYFARoSAqz
	Pj6gjGT6iPsbybVb29fQotFCZzNfvJUudCBQ6SW1kSE1uUkCk7jdjV6IAmPHUmpT79+ydmL18rW
	21OcE3j7BGtwxVR8l9hlYT+G9Si39qjY8vNN/dusEpVmyFK8G/+ky2M8NJj4=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f014:b0:6a1:4a27:cd22 with SMTP id
 006d021491bc7-6b0d5daf712mr1837209eaf.0.1786665819659; Thu, 13 Aug 2026
 17:03:39 -0700 (PDT)
Date: Thu, 13 Aug 2026 17:03:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7e5b5b.f70deec7.2acc03.000e.GAE@google.com>
Subject: [syzbot] [block?] memory leak in null_init_zoned_dev
From: syzbot <syzbot+f57d67a92532a98a562d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06cf61899d64 Merge tag 'x86-urgent-2026-08-08' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146d4149580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6843f8fd2336602d
dashboard link: https://syzkaller.appspot.com/bug?extid=f57d67a92532a98a562d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126d4149580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11531132580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e023ff6ad9bc/disk-06cf6189.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea49527ba5df/vmlinux-06cf6189.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3d6468d0490/bzImage-06cf6189.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f57d67a92532a98a562d@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888126990000 (size 56000):
  comm "syz.0.17", pid 5947, jiffies 4294943074
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 02 00 00 00 01 00 00 00  ................
  backtrace (crc 5c9573f8):
    ___kmalloc_large_node+0xbc/0x100 mm/slub.c:5287
    __kmalloc_large_node_noprof+0x1a/0xb0 mm/slub.c:5305
    __do_kmalloc_node mm/slub.c:5322 [inline]
    __kvmalloc_node_noprof+0x460/0x6f0 mm/slub.c:6905
    null_init_zoned_dev+0x108/0x520 drivers/block/null_blk/zoned.c:94
    null_add_dev+0x8a6/0xae0 drivers/block/null_blk/main.c:1993
    nullb_device_power_store+0xf9/0x1f0 drivers/block/null_blk/main.c:501
    flush_write_buffer fs/configfs/file.c:207 [inline]
    configfs_write_iter+0x10d/0x1a0 fs/configfs/file.c:229
    new_sync_write fs/read_write.c:595 [inline]
    vfs_write+0x3ac/0x720 fs/read_write.c:687
    ksys_write+0xa5/0x170 fs/read_write.c:739
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888127f80000 (size 56000):
  comm "syz.0.18", pid 5951, jiffies 4294943093
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 02 00 00 00 01 00 00 00  ................
  backtrace (crc 5c9573f8):
    ___kmalloc_large_node+0xbc/0x100 mm/slub.c:5287
    __kmalloc_large_node_noprof+0x1a/0xb0 mm/slub.c:5305
    __do_kmalloc_node mm/slub.c:5322 [inline]
    __kvmalloc_node_noprof+0x460/0x6f0 mm/slub.c:6905
    null_init_zoned_dev+0x108/0x520 drivers/block/null_blk/zoned.c:94
    null_add_dev+0x8a6/0xae0 drivers/block/null_blk/main.c:1993
    nullb_device_power_store+0xf9/0x1f0 drivers/block/null_blk/main.c:501
    flush_write_buffer fs/configfs/file.c:207 [inline]
    configfs_write_iter+0x10d/0x1a0 fs/configfs/file.c:229
    new_sync_write fs/read_write.c:595 [inline]
    vfs_write+0x3ac/0x720 fs/read_write.c:687
    ksys_write+0xa5/0x170 fs/read_write.c:739
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
