Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9BD7E0E4;
	Tue, 18 Feb 2025 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739846960; cv=none; b=t5wUA8F3dna+5bz3hzgO3Ww7gPa/cFaFlLNa0SoTwVRSqI9jiAXB3ANFQsLKvL6ynfBEAtVodWBeostOk+jloXDF7XS0t8YR47OH525utKVilHWp5je3aU9VAf/BcxcepYZTBpXsG+tlUn2bkzlSOss7w8AlulXdn1isIsdWYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739846960; c=relaxed/simple;
	bh=94TuEB17GLW+0pTmgy4/+P8vnYkcpd8MTTgU+xtDw+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=emwPoUOWJkrB4p8GIavjLoj0r+u3mi+skbHd7H7J2Zju4BRsv4TKiPte87lAIVCi1bVqiGgGm26WGwrfatFIjhsnvgWpgqYt9WKKDf0Cr8jNScQV/F9Pr35Guah+1oBkNE6AZNc64Gfip1vq3lrdKA/IB5JQeFZqKoWV6E91AO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc/sRB+/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc/sRB+/"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30926d77366so1923631fa.1;
        Mon, 17 Feb 2025 18:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739846956; x=1740451756; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cejasenhaJOltFSQYB7sMlh4MJD60pJcoSmwimDCWsM=;
        b=Rc/sRB+/Thb+MHh1Xy+GmB+jj2ijcsgZzW1bMRkcIyPLzjYB+7UbLvMYQz/jiYWsqz
         dRwRvQ5ztuAS2Z3m6LnFDtlO0L2dP8Hryw7VuLkTcuF4bO+2UgzFpgh2F6QA1lce4jtq
         h3hDWmDlpUbwRYtfi6LgH9w4gspILew3rYgcGdPkMgvHkOLMll+DCcvq93FacQkJ6VjU
         /FP5hR/lCzndH+tb/OdZXtVj3HkvSAcC2qUTOKjXdkFABGAnCY+rt8HRDTI80nAltswI
         /cERESbwYUd7CNsDDqEdBHJPgdHHD+77Ff+Qh9K5IknOtAv586m2v/EZ2fJygXr0kZQR
         SjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739846956; x=1740451756;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cejasenhaJOltFSQYB7sMlh4MJD60pJcoSmwimDCWsM=;
        b=WDn0AT1e+3yDVD/DODPfXP30q/brdjUp8TJqZ4e7/bf7BawJzN22IZlqgF0GumrrmO
         f843nRYV5bPWnfWwYXL1Bgvl8jGyQpwnTsxv6JMYauUPC6a5UhG2MAgPX+F/ogJxp6Fz
         rcx7aBG8Pn0SYPWNi1rphE9mIy0XwXrbkg3X7jb8pamyYIdzDu8FB1vxvodXlfF/ImBi
         XhqsanECXxIeMyJ87p7Jg9LRcugkZt1S6ynS1QpkLWmOw4OioUdVHmfG5666gXe7ZOtr
         A+k2tZWO8pskmX3YMxpzloEO591Pk9Ud9EeCRRHIYE7ggd6PT5L8ZJzmWTNpxxN9XaT6
         3Fdw==
X-Forwarded-Encrypted: i=1; AJvYcCVytBF2eQ7HhdxQs6okMZi8uVv4eD4+YWUN0yg3xVrvPRZWuOHWRKIyayC+lza6qCk3+p5KkfILH38hGw==@vger.kernel.org, AJvYcCWPGF+/Qj4J6ziCSh2ELWIW2RK1NbZTdBtAxJSq2lswAfQ0ldddRwf/h/3zeDZbXl3wHjMQlK/WxpG/1S1p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09CjwNzO+REsAhl+ahPOzd8JXnO8zMSfkV1xpoRn9MMbeIwSD
	Ug6vdBb5dYtwJzs9oU1GCg/zViScLWHOQynBfh8MJwJ6RTRNwWqHn7S+3/jXhydeKF5k+G9bxn2
	/CXMZM6Th0Ov8nwc+HONP7H2sW6M=
X-Gm-Gg: ASbGncsEY1FkMcZVy4Vo8lF409U0M0LTHeByMo1UJ/iqqPiuZLtPHy+mdLeUYJ2qlN1
	lg9hiubVd8L/SQalbNAdkbihpjMSVPkNYnDNhLWdwYkx+DBtEilJXE3a6iTrz+PG04z/j2wVSNg
	==
X-Google-Smtp-Source: AGHT+IH8wXRnwMjaqZO5yPpB5ju366TC1Nxn/UnLJWw1YO9UjUzlAyVrHoDyJEvlplqwQD8FbfPUN8UJZyHTX+GYbSE=
X-Received: by 2002:a2e:a809:0:b0:308:f5f0:c406 with SMTP id
 38308e7fff4ca-30927b1eb02mr13291881fa.9.1739846955303; Mon, 17 Feb 2025
 18:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67afa060.050a0220.21dd3.0051.GAE@google.com> <1739771872662.83054@unisoc.com>
In-Reply-To: <1739771872662.83054@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 18 Feb 2025 10:49:04 +0800
X-Gm-Features: AWEUYZlitddjFf8m3lDAtMeqY3-6bG4KYKDmLbUmOTQGnqftrPKQkWjOqAemdc8
Message-ID: <CAGWkznFFN-wBXFc4ReCdEpFFNuc_m_EXDDopfQzZtTHt2t-wKw@mail.gmail.com>
Subject: Re: reply: [syzbot] [block?] BUG: corrupted list in loop_process_work
To: syzbot <syzbot+c104904eeb2c0edbdb06@syzkaller.appspotmail.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c674aa7c289e Add linux-next specific files for 20250212
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=125063f8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0fd539126ae5541
> dashboard link: https://syzkaller.appspot.com/bug?extid=c104904eeb2c0edbdb06
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158a3bdf980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e18aa4580000
 #syz test

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 68c943a77e41..354d77f9228b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1972,7 +1972,8 @@ static void loop_process_work(struct loop_worker *worker,
         * *and* the worker will not run again which ensures that it
         * is safe to free any worker on the idle list
         */
-       if (worker && !work_pending(&worker->work)) {
+       if (worker && !work_pending(&worker->work)
+               && list_empty(&worker->idle_list)) {
                worker->last_ran_at = jiffies;
                list_add_tail(&worker->idle_list, &lo->idle_worker_list);
                loop_set_timer(lo);

>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cc5b357d26d3/disk-c674aa7c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/11dcf272a27b/vmlinux-c674aa7c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4e487b1c1c6e/bzImage-c674aa7c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/4ea41e9eae4d/mount_0.gz
>
> The issue was bisected to:
>
> commit 3bee991f2b68175c828dc3f9c26367fe1827319a
> Author: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> Date:   Fri Feb 7 09:19:42 2025 +0000
>
>     loop: release the lo_work_lock before queue_work
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161029b0580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=151029b0580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=111029b0580000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c104904eeb2c0edbdb06@syzkaller.appspotmail.com
> Fixes: 3bee991f2b68 ("loop: release the lo_work_lock before queue_work")
>
> list_add double add: new=ffff88807fe21c70, prev=ffff88807fe21c70, next=ffff888024c29160.
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:37!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.14.0-rc2-next-20250212-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> Workqueue: loop0 loop_workfn
> RIP: 0010:__list_add_valid_or_report+0xa4/0x130 lib/list_debug.c:35
> Code: f7 74 11 b0 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 c7 c7 40 e5 60 8c 4c 89 fe 4c 89 e2 4c 89 f1 e8 fd 88 35 fc 90 <0f> 0b 48 c7 c7 40 e3 60 8c e8 ee 88 35 fc 90 0f 0b 48 c7 c7 e0 e3
> RSP: 0018:ffffc90000117628 EFLAGS: 00010046
> RAX: 0000000000000058 RBX: 1ffff1100ffc438e RCX: 89e05f8d6ffcb000
> RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
> RBP: 1ffff1100498522d R08: ffffffff819f562c R09: 1ffff92000022e60
> R10: dffffc0000000000 R11: fffff52000022e61 R12: ffff88807fe21c70
> R13: dffffc0000000000 R14: ffff888024c29160 R15: ffff88807fe21c70
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff4b64ffe00 CR3: 000000007cfa4000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __list_add_valid include/linux/list.h:88 [inline]
>  __list_add include/linux/list.h:150 [inline]
>  list_add_tail include/linux/list.h:183 [inline]
>  loop_process_work+0x1f96/0x21c0 drivers/block/loop.c:1977
>  process_one_work kernel/workqueue.c:3236 [inline]
>  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3398
>  kthread+0x7a9/0x920 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__list_add_valid_or_report+0xa4/0x130 lib/list_debug.c:35
> Code: f7 74 11 b0 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 c7 c7 40 e5 60 8c 4c 89 fe 4c 89 e2 4c 89 f1 e8 fd 88 35 fc 90 <0f> 0b 48 c7 c7 40 e3 60 8c e8 ee 88 35 fc 90 0f 0b 48 c7 c7 e0 e3
> RSP: 0018:ffffc90000117628 EFLAGS: 00010046
> RAX: 0000000000000058 RBX: 1ffff1100ffc438e RCX: 89e05f8d6ffcb000
> RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
> RBP: 1ffff1100498522d R08: ffffffff819f562c R09: 1ffff92000022e60
> R10: dffffc0000000000 R11: fffff52000022e61 R12: ffff88807fe21c70
> R13: dffffc0000000000 R14: ffff888024c29160 R15: ffff88807fe21c70
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff4b64ffe00 CR3: 000000007cfa4000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
