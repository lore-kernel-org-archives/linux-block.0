Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE41FAEF5
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015198; cv=none; b=NJdymnD6cMtMHcKIjZAT6RuWwUBaoCQVI6IzMK0ocwaQRlZCghrQle+TO4pg8Al61WgnqHDkjwnnnbjgp0pMxSjrSSXf6BgQXd3t4XOKG/zXqQr6ttJDycxFLvGi6ezK8aCiMM+NxhNB2F2N/KvHWhhkre1z6NRq66TqWhnzwNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015198; c=relaxed/simple;
	bh=Ei9SOqD1qJytXA7b4l+/Gotyc9WG17t5YbvDcSzKCeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wh7pPpcJ4X1N1Ksx9YZhsBRiM+1B7KbSG568oE9CXWDNmOocUuYwkTUR9v6P2MyW2eNwkdeZQgbDOj5gKWUx0FztxGez3e6W9eOf2zLePmZ85l2uy7Qj6enPVX9zhmIuz0w5R9y/UAIbcVl+LyZhnHmXw8nx4K7lh+U8BzNHHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=lxU7l4S3; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="lxU7l4S3"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea7e2204d1so252098a12.0
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1729015195; x=1729619995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAtJBGi6fAvQTIR+iqLPKpUBRjL87AWD66jsjBGh+iE=;
        b=lxU7l4S3h8MqNNX9846tgS+UtzrvwdKKKvypeC9Svnt772Pwn3EYQcFc7mca+nuSOE
         Eka8gOQ1fI8QvYTai1SH4nckfQirWd6dJUUW1v6lOpNcA6R3v04SEVWph6jjnN3o4kbK
         RRaethK/E5rmMy+fHqX/9JqmjqxuA0QMVcfhTeQ1M7R+9IYOtkaZpHNFY2hddUk2o0eX
         +Gu+W22+E/XezPpwHRFcT6lxjUPNemdXwMWhl1TsL9oOf+e1oW0lUrWQHB133I0qB6YB
         gCGrt+JHXesaovPAVFXkHhr0+P1fHcTq0xFCnFdDr7EM6M07zIAH/XA3K7gRtstbrVjI
         DyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015195; x=1729619995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAtJBGi6fAvQTIR+iqLPKpUBRjL87AWD66jsjBGh+iE=;
        b=ise/OoY4WobZpuUQv8Ghz2Hj40EfvAPoMce1533AR1+rzGWVOfYqs+EjkAcWdTEEdI
         o6TvQawYIQcPoDntgDenWNoqI6M/hfQarkIQ6I8sLz0wK6qR5dMYPfPsrCJQmMsp7f2+
         WBmJFVtr7b6PKAK8EU/V+3+ui3UItA7r0+3BN3x3c0R7xXeJ3yPHKInXJAJMOoRWhuo5
         ovfBcm4+5ykoS0DDZ16DizOj3k01FDl6iDO6t6zd/SypZU00aI1NccqKppwUWYnl+iIW
         9SwNO8ZrFwXwCIiu62QySOngWhrj+jV+0yd8UENj/G8kOhPXiJfm5/ItRBkJ2+T5vpVL
         kwrg==
X-Gm-Message-State: AOJu0YzRqZqCaIHlUl7g32f2i2DpGW+enHQBKXNvpNByFyFN9pCWwMU0
	ThcIaL9CzZn+j75ktAn4Pct5buqCl42gUXpMI1PsFfjkXspKTx0yVmeebI/hnVNhcCngFwKX3mN
	L
X-Google-Smtp-Source: AGHT+IFkWF+muw0AgX3KeIzZteJJurxRSuJ1eMHx8aZbC67WLYsrDkn1/kxXq4oDFGSStsi9Wonghg==
X-Received: by 2002:a17:902:cecb:b0:20c:d71d:cbb5 with SMTP id d9443c01a7336-20cd71dcdf3mr61555985ad.6.1729015195259;
        Tue, 15 Oct 2024 10:59:55 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17fa48c4sm14872925ad.92.2024.10.15.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 10:59:54 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_function race
Date: Tue, 15 Oct 2024 10:59:46 -0700
Message-ID: <d3bee2463a67b1ee597211823bf7ad3721c26e41.1729014591.git.osandov@fb.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

We're seeing crashes from rq_qos_wake_function that look like this:

  BUG: unable to handle page fault for address: ffffafe180a40084
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 100000067 P4D 100000067 PUD 10027c067 PMD 10115d067 PTE 0
  Oops: Oops: 0002 [#1] PREEMPT SMP PTI
  CPU: 17 UID: 0 PID: 0 Comm: swapper/17 Not tainted 6.12.0-rc3-00013-geca631b8fe80 #11
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
  RIP: 0010:_raw_spin_lock_irqsave+0x1d/0x40
  Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 54 9c 41 5c fa 65 ff 05 62 97 30 4c 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 0a 4c 89 e0 41 5c c3 cc cc cc cc 89 c6 e8 2c 0b 00
  RSP: 0018:ffffafe180580ca0 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: ffffafe180a3f7a8 RCX: 0000000000000011
  RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffffafe180a40084
  RBP: 0000000000000000 R08: 00000000001e7240 R09: 0000000000000011
  R10: 0000000000000028 R11: 0000000000000888 R12: 0000000000000002
  R13: ffffafe180a40084 R14: 0000000000000000 R15: 0000000000000003
  FS:  0000000000000000(0000) GS:ffff9aaf1f280000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffafe180a40084 CR3: 000000010e428002 CR4: 0000000000770ef0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
   <IRQ>
   try_to_wake_up+0x5a/0x6a0
   rq_qos_wake_function+0x71/0x80
   __wake_up_common+0x75/0xa0
   __wake_up+0x36/0x60
   scale_up.part.0+0x50/0x110
   wb_timer_fn+0x227/0x450
   ...

So rq_qos_wake_function() calls wake_up_process(data->task), which calls
try_to_wake_up(), which faults in raw_spin_lock_irqsave(&p->pi_lock).

p comes from data->task, and data comes from the waitqueue entry, which
is stored on the waiter's stack in rq_qos_wait(). Analyzing the core
dump with drgn, I found that the waiter had already woken up and moved
on to a completely unrelated code path, clobbering what was previously
data->task. Meanwhile, the waker was passing the clobbered garbage in
data->task to wake_up_process(), leading to the crash.

What's happening is that in between rq_qos_wake_function() deleting the
waitqueue entry and calling wake_up_process(), rq_qos_wait() is finding
that it already got a token and returning. The race looks like this:

rq_qos_wait()                           rq_qos_wake_function()
==============================================================
prepare_to_wait_exclusive()
                                        data->got_token = true;
                                        list_del_init(&curr->entry);
if (data.got_token)
        break;
finish_wait(&rqw->wait, &data.wq);
  ^- returns immediately because
     list_empty_careful(&wq_entry->entry)
     is true
... return, go do something else ...
                                        wake_up_process(data->task)
                                          (NO LONGER VALID!)-^

Normally, finish_wait() is supposed to synchronize against the waker.
But, as noted above, it is returning immediately because the waitqueue
entry has already been removed from the waitqueue.

The bug is that rq_qos_wake_function() is accessing the waitqueue entry
AFTER deleting it. Note that autoremove_wake_function() wakes the waiter
and THEN deletes the waitqueue entry, which is the proper order.

Fix it by swapping the order. We also need to use
list_del_init_careful() to match the list_empty_careful() in
finish_wait().

Fixes: 38cfb5a45ee0 ("blk-wbt: improve waking of tasks")
Cc: stable@vger.kernel.org
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Hi,

I've only managed to reproduce this bug by inserting udelay() calls, so
I don't have a test case, unfortunately. I ran it through fio stress
tests with and without additional udelay() calls.

Note that the bug was introduced in 4.19 in wbt, which was then copied
to the generic rq-qos code in 5.0 in commit 84f603246db9 ("block: add
rq_qos_wait to rq_qos"). If this gets backported to 4.19 LTS, that will
need to be accounted for.

Based on Linus's master branch as of commit
eca631b8fe808748d7585059c4307005ca5c5820.

Thanks,
Omar

 block/blk-rq-qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 2cfb297d9a62..058f92c4f9d5 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -219,8 +219,8 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 
 	data->got_token = true;
 	smp_wmb();
-	list_del_init(&curr->entry);
 	wake_up_process(data->task);
+	list_del_init_careful(&curr->entry);
 	return 1;
 }
 
-- 
2.47.0

