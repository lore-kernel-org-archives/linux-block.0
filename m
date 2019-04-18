Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0522C10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 16:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6942A21479
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 16:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGGIdI/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389316AbfDRQ6q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:58:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38574 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388401AbfDRQ6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 12:58:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so1381968pfo.5;
        Thu, 18 Apr 2019 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=m3DeIylgBdEsp6d+HKmmt5aAC+EP51roAXacfc39ITk=;
        b=eGGIdI/casowTMzeTohXoNW1BWmnAFzab/YrrzDk4Ok95ftVY+l4Ji8cZZrny83Pyz
         AvMcQwj732f3JbbCm7GlfeJCgsf7bILCZM+x/iIvht3466SPJoAWEu3B6cMBLs4h/iwE
         msyhLyvq1B1xcWPyB5i3HG0PPO0qXL5f+0UFaWhmHQpJt0FhV/FroQjji9rKvn8sYDgs
         mxPAa7VJR4TaE4vTMknLJQ5teIBjJC4bbrmK2oYFWuOO3WhN311v9ivQ+Wi1S95mWDWD
         f0UMeHpTiJmBHHQ0Qyrmxh4WoEuYc2LJtCFrLcVCKAEhSTiOxC8Umzmn0ADqUo8dGToa
         jZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=m3DeIylgBdEsp6d+HKmmt5aAC+EP51roAXacfc39ITk=;
        b=O+E3ZW12qIgbTO9oGIT2RL+SdcjTiUMqBgb7JjcDM25UCb1GzA4GlYROMcxMXZw1Oo
         kHX02QA8j58dyv4KfeQM+5MM+nXJO27d0ZBL0i2iG9rElfk4/KatenJvgbmW6eZd2xKt
         /kEH+TwYcPX6OQ6V1+s3XKpaGXeiJTC76VL2lE19bth8OAWIE7HmXRLJ5HDl6eud6JZx
         1kVfrD+PJsJHsj5HjdSeoiOfZRx5AIjQSvQx/atoZ3Yy0pUMGm+ZWawaPuxWPFoh2Oo6
         QZEukFni5s1afDkCEA/NinqfwHs2jQ30uOMIFBg65icsEB6IMXh5YdkTCGH+dWzTJmIJ
         W8wA==
X-Gm-Message-State: APjAAAVntJPCJl8FzT7Q0ZZr49PdEoqf8izx/Oulq4e3riaGR+m1/F92
        yTl1wXvIIvlfuGYpmRxL4C4X9YqR
X-Google-Smtp-Source: APXvYqwP5QwYQQ9HJHPJPbSEQ9o5NaRH5M0s2VmoEe5q5HV/AQncCZk1eBML63WKgZNtEjOdVpiBeQ==
X-Received: by 2002:a62:e418:: with SMTP id r24mr97599861pfh.52.1555606725103;
        Thu, 18 Apr 2019 09:58:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n65sm10179134pfb.160.2019.04.18.09.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:58:43 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH -next] block: Warn if page offset is equal to or larger than page size
Date:   Thu, 18 Apr 2019 09:58:41 -0700
Message-Id: <1555606721-17679-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prior to commit 8a96a0e40810 ("block: rewrite blk_bvec_map_sg to avoid a
nth_page call"), it was valid to call blk_bvec_map_sg() with an offset
equal to or larger than the page size. blk_bvec_map_sg() would then adjust
page and offset by calling bvec_nth_page(). This is no longer possible.
Large offsets are now directly passed without validation to sg_set_page().
This results in data corruption and crashes such as the following,
observed when trying to boot arm:vexpress from mmc.

Kernel panic - not syncing: Attempted to kill init!  exitcode=0x0000000b
CPU: 0 PID: 1 Comm: init Tainted: G        W
5.1.0-rc5-next-20190418-dirty #1
Hardware name: ARM-Versatile Express
[<c0313188>] (unwind_backtrace) from [<c030d920>] (show_stack+0x10/0x14)
[<c030d920>] (show_stack) from [<c10daad8>] (dump_stack+0xb4/0xc8)
[<c10daad8>] (dump_stack) from [<c03485fc>] (panic+0x110/0x328)
[<c03485fc>] (panic) from [<c034d550>] (do_exit+0xbfc/0xc08)
[<c034d550>] (do_exit) from [<c034e608>] (do_group_exit+0x3c/0xbc)
[<c034e608>] (do_group_exit) from [<c035ace8>] (get_signal+0x13c/0x9c4)
[<c035ace8>] (get_signal) from [<c030cd3c>] (do_work_pending+0x1a8/0x5e0)
[<c030cd3c>] (do_work_pending) from [<c030106c>] (slow_work_pending+0xc/0x20)

The above does not help at all when trying to track down the problem.
Let's at least add a warning to generate a traceback. The crash will
still be observed, but at least we'll have a hint what is causing it.
With this patch applied, we'll see something like the following
prior to the crash.

WARNING: CPU: 0 PID: 84 at block/blk-merge.c:480 blk_rq_map_sg+0x3cc/0x6ac
page offset 19456 larger than page size 4096
Modules linked in:
CPU: 0 PID: 84 Comm: kworker/0:1H Not tainted 5.1.0-rc5-next-20190418-dirty #1
Hardware name: ARM-Versatile Express
Workqueue: kblockd blk_mq_run_work_fn
[<c0313188>] (unwind_backtrace) from [<c030d920>] (show_stack+0x10/0x14)
[<c030d920>] (show_stack) from [<c10daad8>] (dump_stack+0xb4/0xc8)
[<c10daad8>] (dump_stack) from [<c03483ac>] (__warn+0xe0/0xf8)
[<c03483ac>] (__warn) from [<c0348410>] (warn_slowpath_fmt+0x4c/0x70)
[<c0348410>] (warn_slowpath_fmt) from [<c078fb5c>] (blk_rq_map_sg+0x3cc/0x6ac)
[<c078fb5c>] (blk_rq_map_sg) from [<c0eadeec>] (mmc_blk_data_prep+0x1b0/0x2c8)
[<c0eadeec>] (mmc_blk_data_prep) from [<c0eae054>] (mmc_blk_rw_rq_prep+0x50/0x178)
[<c0eae054>] (mmc_blk_rw_rq_prep) from [<c0eb145c>] (mmc_blk_mq_issue_rq+0x294/0x880)
[<c0eb145c>] (mmc_blk_mq_issue_rq) from [<c0eb1e78>] (mmc_mq_queue_rq+0x128/0x230)
[<c0eb1e78>] (mmc_mq_queue_rq) from [<c07957f8>] (blk_mq_dispatch_rq_list+0x3b4/0x5e0)
[<c07957f8>] (blk_mq_dispatch_rq_list) from [<c079ab3c>] (blk_mq_do_dispatch_sched+0x70/0x10c)
[<c079ab3c>] (blk_mq_do_dispatch_sched) from [<c079b238>] (blk_mq_sched_dispatch_requests+0x11c/0x198)
[<c079b238>] (blk_mq_sched_dispatch_requests) from [<c0793e20>] (__blk_mq_run_hw_queue+0xe0/0x170)
[<c0793e20>] (__blk_mq_run_hw_queue) from [<c03665d8>] (process_one_work+0x284/0x6b4)
[<c03665d8>] (process_one_work) from [<c0367914>] (worker_thread+0x44/0x528)
[<c0367914>] (worker_thread) from [<c036cc6c>] (kthread+0x15c/0x164)
[<c036cc6c>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
Exception stack(0xc58d5fb0 to 0xc58d5ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace ef7077b559d20ddc ]---

This patch is needed even if the call from mmc_blk_data_prep() is fixed.
We'll have to expect further problems from callers who are not aware about
the API change. Those problems will be difficult to track down without
extra information.

Use WARN_ONCE to report the problem. If the problem is seen, it may be
seen many times, and we don't want to flood the kernel log with repeated
messages.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I don't know if there are situations where offset >= PAGE_SIZE
is acceptable. A quick comparison with current mainline did not report
any instances where offset >= PAGE_SIZE is passed to sg_set_page().
I do see a number of warnings triggered by this patch in -next
(for example with alpha, m68k, ppc64, and riscv64 emulations) which
do not (or not immediately) result in a crash.

If there is a different / better means to detect a problem, please
let me know and I'll be happy to adjust the patch accordingly.

 block/blk-merge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 247b17f2a0f6..9432cd88bd7e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -475,6 +475,10 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 		unsigned offset = bvec->bv_offset + total;
 		unsigned len = min(get_max_segment_size(q, offset), nbytes);
 
+		WARN_ONCE(offset >= PAGE_SIZE,
+			  "page offset %u larger than or equal to page size %ld\n",
+			  offset, PAGE_SIZE);
+
 		*sg = blk_next_sg(sg, sglist);
 		sg_set_page(*sg, bvec->bv_page, len, offset);
 
-- 
2.7.4

