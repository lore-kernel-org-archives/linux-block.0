Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1640DFDB
	for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776470550; cv=none; b=bcNEUh6I1RzrH93nVpjhrk45SqDPxGK0PWEMoykWVyRAUzzNbT7U/P5sodfcCqzXPW3AkrLlhdWWfHAj3hiDxfHLeJdj8SKgVq4sYP2o+uOyXZEOcJEqEJWcOtrjXnvUKwMuMYv51RVyIqnPTzv5wvB9i2F/VBn987WaNIwFoXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776470550; c=relaxed/simple;
	bh=nnhYGMThL1r3aCacLSIzYXHcxpfH3jMgTJx/gC3IHKQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eUBlDQD3p+6p9wCORgoeOL7dRPo2PuSufZdpy0FhEfR4G25aNU2qLRT5RtMxhv9Mxg8wIkc9YqRhz+O2UQNMA2EjOyGeB+KnhS2C0dGagpVEjicWUFw/+lH9Snc6AgrUbQAn03A48EXnPUgTmBov/U1bG3kGc5XRPrebjSZnxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6930428be16so1752878eaf.2
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 17:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776470548; x=1777075348;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmOGBFFaZh4RIpdobK0n2YavgY3ThfKOxnVBVElSmXQ=;
        b=PJYjZSy+528TcoDlCy0wABOCk6YTCKoOAhuRTWhmnEZOHoodf+zFDFIUFe60XWV1mc
         3uKC0VOCm9sq56h0cU5zGIyuilPraBZnB1WQa/kXaRkvusNsr3bFBtdc8Vr0CzJmYQYt
         gkvur31o5syySSGH38DqeBLF30714HJHTbGZsyx/qys4/ie+NKBkuRWZNg9sA0r42Tqo
         xo+hPt/QKChoGgHA0tDVDezJSE/nzWZ1VeLl1nSxT1bl6zVRPfLCQbFX0cHXYkHcHQ0l
         zqaukUDkQHzsp6M4uI1aEblG6nfFR8waexLMao1xW5IWmqbSjLsK6dGfTQu/3Ru4i4ps
         JKRg==
X-Forwarded-Encrypted: i=1; AFNElJ8+OpCBqZYbJTeyG0aTC7+3jKqWmxgVs9AU44SBzfm4l/yQCbJn0JFgKDBfaS8oEmUAKpvHwt+m0J1wtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2mLr3+0UvIZmKbGgkfuBvoP8GSCQg8s/9BqyKQDCHInhrPLV
	h13izWsmNVhLrdDWSAdpTWrZVMezem/UkDMjMVYszPKSG1v4P/XvEqH07EwzWk1VJzavLYCMmxZ
	9OXzBZFMmKE+YtInnD/7zOUVi2MgDA2nqpQnkia9U1Of5mJ8cM05DtCvyT14=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1886:b0:685:5300:f1ab with SMTP id
 006d021491bc7-69462ee2505mr2714347eaf.34.1776470548133; Fri, 17 Apr 2026
 17:02:28 -0700 (PDT)
Date: Fri, 17 Apr 2026 17:02:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in lo_rw_aio
From: syzbot <syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    43cfbdda5af6 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101e4702580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4660d1ff2985517b
dashboard link: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0867fa0b89e8/disk-43cfbdda.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/754859270006/vmlinux-43cfbdda.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd6cca8d06c9/bzImage-43cfbdda.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000014: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
CPU: 1 UID: 0 PID: 1174 Comm: kworker/u8:8 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: loop2 loop_workfn
RIP: 0010:file_inode include/linux/fs.h:1353 [inline]
RIP: 0010:kiocb_start_write include/linux/fs.h:2763 [inline]
RIP: 0010:lo_rw_aio+0xaa9/0xf00 drivers/block/loop.c:401
Code: 89 33 31 ff 8b 5c 24 44 89 de e8 32 2b 3f fc 85 db 0f 84 ca 00 00 00 48 8b 44 24 58 48 8d 98 a0 00 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 e8 ae a5 fc 4c 89 7c 24 10 48 8b
RSP: 0018:ffffc9000655f620 EFLAGS: 00010206
RAX: 0000000000000014 RBX: 00000000000000a0 RCX: ffff888029649ec0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000655f790 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc9000655f6e3 R11: fffff52000cabede R12: ffff888026c9b090
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888026c9b0b0
FS:  0000000000000000(0000) GS:ffff88812620f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555591947a68 CR3: 000000005515a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_req_filebacked drivers/block/loop.c:433 [inline]
 loop_handle_cmd drivers/block/loop.c:1925 [inline]
 loop_process_work+0x637/0x11b0 drivers/block/loop.c:1960
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3385
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3466
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:file_inode include/linux/fs.h:1353 [inline]
RIP: 0010:kiocb_start_write include/linux/fs.h:2763 [inline]
RIP: 0010:lo_rw_aio+0xaa9/0xf00 drivers/block/loop.c:401
Code: 89 33 31 ff 8b 5c 24 44 89 de e8 32 2b 3f fc 85 db 0f 84 ca 00 00 00 48 8b 44 24 58 48 8d 98 a0 00 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 e8 ae a5 fc 4c 89 7c 24 10 48 8b
RSP: 0018:ffffc9000655f620 EFLAGS: 00010206
RAX: 0000000000000014 RBX: 00000000000000a0 RCX: ffff888029649ec0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000655f790 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc9000655f6e3 R11: fffff52000cabede R12: ffff888026c9b090
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888026c9b0b0
FS:  0000000000000000(0000) GS:ffff88812620f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555591947a68 CR3: 000000005515a000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	89 33                	mov    %esi,(%rbx)
   2:	31 ff                	xor    %edi,%edi
   4:	8b 5c 24 44          	mov    0x44(%rsp),%ebx
   8:	89 de                	mov    %ebx,%esi
   a:	e8 32 2b 3f fc       	call   0xfc3f2b41
   f:	85 db                	test   %ebx,%ebx
  11:	0f 84 ca 00 00 00    	je     0xe1
  17:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
  1c:	48 8d 98 a0 00 00 00 	lea    0xa0(%rax),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 e8 ae a5 fc       	call   0xfca5af21
  39:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


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
