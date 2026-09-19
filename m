Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5200388E63
	for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789786112; cv=none; b=f0Ne4mrsN5FHEqBnl095DCUrFIs3/F+L4tEz4rFf1PrpSjKVTHByjS3VewbT+FWGesyaTk0BWAJ1Dp3gCdd1SilKWEFf4avgRJk+iuIoD+/Txi22edo4Syku9aBQ1c7AXbrgKJgPkD1d0ddDk6BWmjIcnaBPgL2zgIgNLkA/dDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789786112; c=relaxed/simple;
	bh=nh+Ydm3rUWMGSsSWqSF7Ee4XN4kQwm5jHOh5Y4J3Xb0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=fl4rCl5bke+AE5pvWJbkbmSk0AvlDWJmuM1T0wb/mrxzy4PPHh2kLfhQ7fRgxNNoMSqsxiAQ1KQdsygXN9BuxV8nCO+rk9Z+5mz5Zzmle0abuYcDTsEvSuq7E1BEGExlAcBbIDAWA6vT/VU/5GiAQ3CTx8kTlMlFgnI7XEzP/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-8009280834fso1548942a34.2
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 19:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789786108; x=1790390908;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4PylnLHodzqyTo55OT/B54tvdw5lHhxC53KAGCgawlY=;
        b=tGOAR+juQe1vmvHutHK7PZKhaetSzssQKYGTwvm9VHTvKYwkm9JigLjrm/p/rGMXd2
         K+GxRCdnqua5QoxLFaq43fh1YwgyKrFGknk5jx9whIiLHE3DMMLRvEvSMEBfdICOM/Lf
         IRPNpeiyaLnlHegTbGJMay/XtbRUJUO3FNpOJ1jwvj/gP2geideIJ0r9ONtQ31ZDLM5V
         Y6jo9sa0MoM/T2t+JEPCsV96rODMZ36yDHwqM7mO5aRUHOd99p0klZgSOFNFz5I1FL7/
         zcFwjNnVrh3K4rWswPRxtYadqwlUtnATGoNBlBFFlPgBL+jOdcw03LU8AOLc999Sn6vH
         +95A==
X-Forwarded-Encrypted: i=1; AKwUvBwZPwmr6a4+OlqmYTmLDkQlCtrsAdynTg6adapDUpZZBwcuWoh++jd7eR+kfrtv/BeLFyZGGJA8CvDyRA==@vger.kernel.org
X-Gm-Message-State: AFuF++kxNcObzmxum23t5+qF2dVDg6AHrbxaQbaQdmvJrirML1bpf3py
	RGhm/QlFSuD0tPbXMBWsbSXN6mZp1Hg4sZ/hD+oFjRABO29cakqasXra4bZnoTtNxb7FsDA2fL4
	VIp/IAytqCTeOZ3UidH/UW+9exnCGMW+xjVlkC7KVbrq0Gx/qpS7IXvMIjxQ=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:609:b0:6cd:3fdc:5ff6 with SMTP id
 006d021491bc7-6cd3fdc608amr1630467eaf.71.1789786107887; Fri, 18 Sep 2026
 19:48:27 -0700 (PDT)
Date: Fri, 18 Sep 2026 19:48:27 -0700
In-Reply-To: <cover.1789587960.git.bvanassche@acm.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aadf7fb.71f81b7d.15fa6d.0003.GAE@google.com>
Subject: [syzbot ci] Re: loop: Fix teardown
From: syzbot ci <syzbot+ci95a1b00e6c96231b@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, axboe@kernel.dk, bvanassche@acm.org, 
	gary@garyguo.net, hch@lst.de, linux-block@vger.kernel.org, 
	nilay@linux.ibm.com, ojeda@kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	royenheart@gmail.com, sunke@kylinos.cn
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] loop: Fix teardown
https://lore.kernel.org/all/cover.1789587960.git.bvanassche@acm.org
* [PATCH 1/2] block: Add post_release() operation
* [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex is dropped

and found the following issue:
general protection fault in lo_post_release

Full report is available here:
https://ci.syzbot.org/series/81bfb244-11b0-4b8a-aa02-a212681ff0af

***

general protection fault in lo_post_release

tree:      axboe
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/axboe/linux.git
base:      2dd9768a37dbb99398c5e332485dbb107ac397c8
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/e21a78bb-e498-4518-8734-d31ae58a2538/config

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
CPU: 0 UID: 0 PID: 26297 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:lo_post_release+0x498/0x7f0
Code: 4c 89 ff e8 7a 73 f9 fb bf e0 01 00 00 49 03 3f be 02 00 00 00 e8 18 05 9e 05 48 8b 44 24 10 4c 8d 60 50 4c 89 e0 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 e7 e8 49 73 f9 fb 41 bf e8 00 00 00 4d
RSP: 0018:ffffc90003d6fb60 EFLAGS: 00010206
RAX: 000000000000000a RBX: ffff8881699b3000 RCX: 0000000000000046
RDX: 0000000000000006 RSI: ffffffff8e414976 RDI: ffffffff8c6da780
RBP: ffffc90003d6fd08 R08: ffffffff907a477f R09: 1ffffffff20f48ef
R10: dffffc0000000000 R11: fffffbfff20f48f0 R12: 0000000000000050
R13: 1ffff920007adf74 R14: dffffc0000000000 R15: ffff888169a02080
FS:  00007fa1afb46c80(0000) GS:ffff88818d6ce000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0d423a8440 CR3: 00000001bee1a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 bdev_release+0x59a/0x6b0
 blkdev_release+0x15/0x20
 __fput+0x418/0xa50
 fput_close_sync+0x11f/0x240
 __x64_sys_close+0x7e/0x110
 do_syscall_64+0x166/0x520
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1af7170a8
Code: 48 8b 05 83 9d 0d 00 64 c7 00 16 00 00 00 83 c8 ff 48 83 c4 20 5b c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 5b 48 8b 15 51 9d 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffeef68bbb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007fa1afb46ae0 RCX: 00007fa1af7170a8
RDX: 0000559097caaeb5 RSI: 00007ffeef68b3b8 RDI: 0000000000000008
RBP: 00005595ce9a3e90 R08: 0000000000000006 R09: a8cc15e7d6acaf3b
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000002
R13: 00005595ce999920 R14: 0000000000000008 R15: 00005595ce964910
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lo_post_release+0x498/0x7f0
Code: 4c 89 ff e8 7a 73 f9 fb bf e0 01 00 00 49 03 3f be 02 00 00 00 e8 18 05 9e 05 48 8b 44 24 10 4c 8d 60 50 4c 89 e0 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 e7 e8 49 73 f9 fb 41 bf e8 00 00 00 4d
RSP: 0018:ffffc90003d6fb60 EFLAGS: 00010206
RAX: 000000000000000a RBX: ffff8881699b3000 RCX: 0000000000000046
RDX: 0000000000000006 RSI: ffffffff8e414976 RDI: ffffffff8c6da780
RBP: ffffc90003d6fd08 R08: ffffffff907a477f R09: 1ffffffff20f48ef
R10: dffffc0000000000 R11: fffffbfff20f48f0 R12: 0000000000000050
R13: 1ffff920007adf74 R14: dffffc0000000000 R15: ffff888169a02080
FS:  00007fa1afb46c80(0000) GS:ffff88818d6ce000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556cac6a68 CR3: 00000001bee1a000 CR4: 00000000000006f0


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
