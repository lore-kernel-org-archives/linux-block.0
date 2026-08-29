Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8A322DB7
	for <linux-block@vger.kernel.org>; Sat, 29 Aug 2026 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787981489; cv=none; b=a6tR1kcnPFXCqeMjnSz5On1MI0dRPAqNGFz7nRz8u++rqrn/szUrfF++WU2u0thqZjpRZnGXAst4rFQqUfDsfP8TcHzetSOQurI19SDsV4TTVn618rXhfUWEx7tB1Jm8iJc7LaeH07sJnhKuMf0arHj3HCW+HJBXsdnAs2bLtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787981489; c=relaxed/simple;
	bh=J63cCjU7NQMqNc4BYfZxkPvygTtwZPK/s48tuhKYo9w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tf37BbdFrAxK4bgyxfsZTRt5JcNIIFS4/nqf1oRyCJwOGR3ntu8tr2T2Ddkfmpaa2/exJQxvBC1FhBjzS7svjZraa5qtd/7qVTdpVGK1XrXzrFh7RPocqk6oEnn9JY3Lrp4E2Etafc1ryKb4nUcSKj2zz0/YnBSZYGYXl3mljSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f5.google.com with SMTP id 5614622812f47-4b3759b7ff0so697411b6e.1
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 22:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787981487; x=1788586287;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUjmvQ8X6s/JHGzOzsHlequ1pScp7s06KOL9eRF58EU=;
        b=C0zwdio9nIjoxXSTJcTQtZQ+tl6lYvDFH6rDt9X1FwDtTVlztXO3+W8p7lHtVAX8jP
         zxSoUt8apmO0gP8DlQHW9FKmzvBOVla8nHxt5KrH7hwp1uNV+Gj1S4rDDETsrxHuIufr
         DCRAwQ5X4JMHfBDCV6cW3xcWi/Lj7HmlUsg2a4wZOBhUbYeadw+bN/gV4cBq9IykjY0E
         WGx5UR9iFcpmqKFxE9klWPDCuUTTwZIsxk8s9qlPmYOWvuW6JqIE1Wt+RubZk4j14qeE
         VZz56DxXAdzFz/WnwvBID8W0SP3MrL7OKNj4EGXAC2Noh0h1cb/AxJobcTyRqQxlDsYw
         fFZA==
X-Forwarded-Encrypted: i=1; AHgh+RpijrsxSO+vJOjijdhJI7jnkfTZ5vnEnLXqpg/qlSZJ9mTpz0GUH2A2Ez3tUfMbFJJZFkVsmTBg2u8F8w==@vger.kernel.org
X-Gm-Message-State: AFuF++mXr81dgAEn7u3wzgD9uVRIJ84oKcd1k9m8tgdliaFij5hO6lb1
	Oe5Z15A818D+l/0YHyqq37acUkMOMnSdXSCc4NpA74ve8bhBPp1EIJPfn5zhe6KvJ+HCsUjwbct
	PFjRnWfTq96FF3m/8nZepm5+gqFmnJGiQdIT3mXSoVavEr2AmHzPiyGKckJQ=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c1ad:b0:495:f8a6:81f8 with SMTP id
 5614622812f47-4b3981e5467mr14147676b6e.13.1787981487283; Fri, 28 Aug 2026
 22:31:27 -0700 (PDT)
Date: Fri, 28 Aug 2026 22:31:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a926eaf.1d9ded08.62e62.0102.GAE@google.com>
Subject: [syzbot] [block?] BUG: corrupted list in blk_mq_request_bypass_insert
From: syzbot <syzbot+f4353e96f7004ae5a09e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f1b8fa82cab7 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14f18379580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=f4353e96f7004ae5a09e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/932d85a2bda2/disk-f1b8fa82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b6b8fb76e8d/vmlinux-f1b8fa82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c246b61ee396/Image-f1b8fa82.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4353e96f7004ae5a09e@syzkaller.appspotmail.com

 non-slab/vmalloc memory
list_add corruption. prev->next should be next (ffff0000c8a39040), but was ffff0000c8ab0e48. (prev=ffff0000c8ab0e48).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:34!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 4390 Comm: kworker/0:1H Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Workqueue: kblockd blk_mq_requeue_work
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __list_add_valid_or_report+0x144/0x148 lib/list_debug.c:32
lr : __list_add_valid_or_report+0x144/0x148 lib/list_debug.c:32
sp : ffff8000947079f0
x29: ffff8000947079f0 x28: ffff800094707aa8 x27: ffff800094707aa0
x26: 1fffe00019147209 x25: ffff0000c8a39040 x24: ffff0000c8a39048
x23: 1fffe000191561c9 x22: dfff800000000000 x21: ffff0000c8ab0e48
x20: ffff0000c8ab0e48 x19: ffff0000c8a39040 x18: 1fffe00034bb7428
x17: 3034303933613863 x16: 3030303066666666 x15: 28207478656e2065
x14: 6220646c756f6873 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000002 x9 : d55a73c626cee600
x8 : d55a73c626cee600 x7 : ffff80008048c60c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008049731c
x2 : 0000000100000001 x1 : ffff0000c56f3a80 x0 : 0000000000000075
Call trace:
 __list_add_valid_or_report+0x144/0x148 lib/list_debug.c:32 (P)
 __list_add_valid include/linux/list.h:96 [inline]
 __list_add include/linux/list.h:158 [inline]
 list_add_tail include/linux/list.h:191 [inline]
 blk_mq_request_bypass_insert+0x130/0x1cc block/blk-mq.c:2551
 blk_mq_requeue_work+0x3a4/0x52c block/blk-mq.c:1560
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
Code: 91270000 aa1303e1 aa1403e3 979c2c73 (d4210000) 
---[ end trace 0000000000000000 ]---


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
