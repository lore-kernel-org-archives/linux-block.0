Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A5AC43461
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 20:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4282166E
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 20:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="k9tL+OK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgIHUqv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIHUqu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Sep 2020 16:46:50 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC294C061573
        for <linux-block@vger.kernel.org>; Tue,  8 Sep 2020 13:46:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so379059pgl.10
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2020 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iq8WFFrjCkQJ1nlVaRK9H+9ActveZxtO8gIQ2OH3USM=;
        b=k9tL+OK2Y5Ejx16Xj15HgZdKnBvjU9QiTXOoVM2loy3op4Hq3hqVQK2rRLrhh1kbH2
         NWO42qMowqH2G/KeybjFWItRsVAJGt1ZP8VWhSiT5qkQpL+VKX5bavw/uL66d0MMyNEb
         ktA2goXwGyhkc65TZXk10++XrvRN5CiAk8j5Yd4/B6LnosCbK7gXH+QbBH0eHR4U55wr
         0BfIlySbXBSyzbFe7bDj9W0RCWfS6AsrnEzOVM1I8Fq3yo6Am5LCZJVJqj2833EP730B
         aL+NqXVgnFRPEGb/kt7zmNoK6lMsxhAvJKpvoJ4Xa9AQVOMIDP1Gx3r46AU2zdpYpGm9
         baJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iq8WFFrjCkQJ1nlVaRK9H+9ActveZxtO8gIQ2OH3USM=;
        b=PBA5Ss94CC8j9WNhvbNU0/9qnIh1iggRvhe9zB4RelcjcCi3s7Iwy/zCzxmaOE8Ieo
         qfCPJctPP64P9Es4uRtXQkoTzhHZ156+mmLXNE0mdKqiJJ6uWmicfIJMUu6xMYwmik8d
         EHR0Fcmc5OyCnmzG2VcUvzr38yxdSv1pJbEtDGPUj3uOc60vdRs7dN5AJdMpzvFaJx3j
         5k3Lnb5Fpn+2cu8YKjewcfr2JHhyFkh6f8QT09s3incAnNFb/GyO4MCtyd/7+Ic8uToe
         QCUZg9V8CaKL9NTeVwoJNR6hItLSi5FCic/ZMB7e2ApgE4RPy7FBQv/FQu3Dfn+kIbP9
         kI4w==
X-Gm-Message-State: AOAM532xvHFJpZ7VWnuBneWOBRRdIsJg9uOMDorxXCG+xk2gUkbOa03h
        JUsuVGm6NDp6lFLx6UHlg1q5suFyMi71jA==
X-Google-Smtp-Source: ABdhPJyzm6QeVDfV/1V9L7NLwj72wwT6GRy8YQSqQ1x28q05qLHjvcH/YVUjCu3hVX7zWkeUOYs0gA==
X-Received: by 2002:a62:17cd:0:b029:13c:1611:652b with SMTP id 196-20020a6217cd0000b029013c1611652bmr760080pfx.11.1599598006841;
        Tue, 08 Sep 2020 13:46:46 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ec83])
        by smtp.gmail.com with ESMTPSA id 63sm300611pfw.42.2020.09.08.13.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:46:45 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, kernel-team@fb.com,
        Yang Yang <yang.yang@vivo.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH] block: only call sched requeue_request() for scheduled requests
Date:   Tue,  8 Sep 2020 13:46:37 -0700
Message-Id: <80b64d8a0408e7c8c30b363aaf6d39e735521c1d.1599597940.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Yang Yang reported the following crash caused by requeueing a flush
request in Kyber:

  [    2.517297] Unable to handle kernel paging request at virtual address ffffffd8071c0b00
  ...
  [    2.517468] pc : clear_bit+0x18/0x2c
  [    2.517502] lr : sbitmap_queue_clear+0x40/0x228
  [    2.517503] sp : ffffff800832bc60 pstate : 00c00145
  ...
  [    2.517599] Process ksoftirqd/5 (pid: 51, stack limit = 0xffffff8008328000)
  [    2.517602] Call trace:
  [    2.517606]  clear_bit+0x18/0x2c
  [    2.517619]  kyber_finish_request+0x74/0x80
  [    2.517627]  blk_mq_requeue_request+0x3c/0xc0
  [    2.517637]  __scsi_queue_insert+0x11c/0x148
  [    2.517640]  scsi_softirq_done+0x114/0x130
  [    2.517643]  blk_done_softirq+0x7c/0xb0
  [    2.517651]  __do_softirq+0x208/0x3bc
  [    2.517657]  run_ksoftirqd+0x34/0x60
  [    2.517663]  smpboot_thread_fn+0x1c4/0x2c0
  [    2.517667]  kthread+0x110/0x120
  [    2.517669]  ret_from_fork+0x10/0x18

This happens because Kyber doesn't track flush requests, so
kyber_finish_request() reads a garbage domain token. Only call the
scheduler's requeue_request() hook if RQF_ELVPRIV is set (like we do for
the finish_request() hook in blk_mq_free_request()). Now that we're
handling it in blk-mq, also remove the check from BFQ.

Reported-by: Yang Yang <yang.yang@vivo.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/bfq-iosched.c  | 12 ------------
 block/blk-mq-sched.h |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a4c0bec920cb..ee767fa000e4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5895,18 +5895,6 @@ static void bfq_finish_requeue_request(struct request *rq)
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 	struct bfq_data *bfqd;
 
-	/*
-	 * Requeue and finish hooks are invoked in blk-mq without
-	 * checking whether the involved request is actually still
-	 * referenced in the scheduler. To handle this fact, the
-	 * following two checks make this function exit in case of
-	 * spurious invocations, for which there is nothing to do.
-	 *
-	 * First, check whether rq has nothing to do with an elevator.
-	 */
-	if (unlikely(!(rq->rq_flags & RQF_ELVPRIV)))
-		return;
-
 	/*
 	 * rq either is not associated with any icq, or is an already
 	 * requeued request that has not (yet) been re-inserted into
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 126021fc3a11..e81ca1bf6e10 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -66,7 +66,7 @@ static inline void blk_mq_sched_requeue_request(struct request *rq)
 	struct request_queue *q = rq->q;
 	struct elevator_queue *e = q->elevator;
 
-	if (e && e->type->ops.requeue_request)
+	if ((rq->rq_flags & RQF_ELVPRIV) && e && e->type->ops.requeue_request)
 		e->type->ops.requeue_request(rq);
 }
 
-- 
2.28.0

