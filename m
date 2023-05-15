Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F07C7EE22
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 12:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbjEOM0z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 08:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEOM0y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 08:26:54 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84B10D5
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 05:26:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f5279cc284so5400981cf.2
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684153610; x=1686745610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frVvBnuP2+i1aJfoXn+uOQ4Dz2/3JLy5AwDGkoiWkAA=;
        b=fHaGi/NwOVxcobMw6IFO5ss/FvKw2r+7FXIEJ85Odymwvh1N649DR1PnMuPFs/755N
         8aE+UKy6gqPCSoh6fUUCmr5XSvycsKRwa8ALWDUlN4t7TT9FeaOO1KLD9m1PAEH2+kOW
         OHWALp9MR6n95db+1TPk+5JG1AdHFqy2zery0rj0/3cgPe7zgs5ifehXM5t0SFE8Oi7H
         qjnEffPyLYFbb5+1esjlFWScYEvF0TvOfQhRUkuAFtByu0fF6s6OyxnviCKQlyGmGDyg
         w3ZNjxaVlTiKUZL7t7l5C3alt95WvCedpHaGf8sadF03BKjW26Iz1KHM3Yxfk2xfKReS
         t+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684153610; x=1686745610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frVvBnuP2+i1aJfoXn+uOQ4Dz2/3JLy5AwDGkoiWkAA=;
        b=dbxZrrzATJUqdqO2a3Tfx0n9NmM/mbKYXB59SqbCQJm2sl9XN00IGKauH81vpL23gG
         5a8S6vLvD77PTlTXJIsBX89T26R6007ca+wu4mmDGqGrQ1v7YKJ8ITWeI9g9aZIkX4oG
         AuXVdBnCmgfOu1DTTjpqyk/fmXHRsE639LC77cqMODJzSmyKEEnUPOJOgMQhKY8eCEBU
         kMfgCN9g++JZ7lRhIvgPXDdCkh3Hys99N8weHqpB4iIOCCUFZDComaIBpO0rfFR61QYW
         FwA0ayIbaTAmhmCstAx70dkm7Do7a5SkIHD7/bvrgrmG1AEfGcTzRmgsJc7GrzXIs19E
         qejg==
X-Gm-Message-State: AC+VfDyFn3OCatwQow1z/EpmnFgI7d30x6mEOUnQlS9fQYJhrD3+2T9t
        +PEzm6oKhKA0L7Bx6lcppXE=
X-Google-Smtp-Source: ACHHUZ6UVQqt/Q5Q7FdQgoJCVn2vJlZj9ekfWfTM2bVhtPYCZhqh96pfA590HhUR4eBOOfm4HFeeHQ==
X-Received: by 2002:a05:622a:414:b0:3f3:895b:6161 with SMTP id n20-20020a05622a041400b003f3895b6161mr44618826qtx.65.1684153610369;
        Mon, 15 May 2023 05:26:50 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id m24-20020aed27d8000000b003f364778b2bsm5395733qtg.4.2023.05.15.05.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:26:49 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     hare@suse.de
Cc:     axboe@kernel.dk, horms@kernel.org, linux-block@vger.kernel.org,
        lkp@intel.com, llvm@lists.linux.dev, ming.lei@redhat.com,
        oe-kbuild-all@lists.linux.dev, tian.lan@twosigma.com,
        tilan7663@gmail.com
Subject: [PATCH] blk-mq: fix blk_mq_hw_ctx active request accounting
Date:   Mon, 15 May 2023 08:26:43 -0400
Message-Id: <20230515122643.597546-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1c9fc9df-817c-e6cb-1375-2013c0c5a9bb@suse.de>
References: <1c9fc9df-817c-e6cb-1375-2013c0c5a9bb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tian Lan <tian.lan@twosigma.com>

The nr_active counter continues to increase over time which causes the
blk_mq_get_tag to hang until the thread is rescheduled to a different
core despite there are still tags available.

kernel-stack

  INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
  Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:inboundIORe state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
    Call Trace:
    <TASK>
    __schedule+0x351/0xa20
    scheduler+0x5d/0xe0
    io_schedule+0x42/0x70
    blk_mq_get_tag+0x11a/0x2a0
    ? dequeue_task_stop+0x70/0x70
    __blk_mq_alloc_requests+0x191/0x2e0

kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
__blk_mq_free_request being called.

  320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0
         b'__blk_mq_free_request+0x1 [kernel]'
         b'bt_iter+0x50 [kernel]'
         b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
         b'blk_mq_timeout_work+0x7c [kernel]'
         b'process_one_work+0x1c4 [kernel]'
         b'worker_thread+0x4d [kernel]'
         b'kthread+0xe6 [kernel]'
         b'ret_from_fork+0x1f [kernel]'

The issue is caused by the difference between blk_mq_free_request() and
blk_mq_end_request_batch() wrt. when to call __blk_mq_dec_active_requests().
The former does it before calling req_ref_put_and_test(), and the latter
decreases the active request after req_ref_put_and_test().

- Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")

Signed-off-by: Tian Lan <tian.lan@twosigma.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2f..850bfb844ed2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -683,6 +683,10 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
+
+	if (rq->rq_flags & RQF_MQ_INFLIGHT)
+		__blk_mq_dec_active_requests(hctx);
+
 	if (rq->tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
 	if (sched_tag != BLK_MQ_NO_TAG)
@@ -694,15 +698,11 @@ static void __blk_mq_free_request(struct request *rq)
 void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	if ((rq->rq_flags & RQF_ELVPRIV) &&
 	    q->elevator->type->ops.finish_request)
 		q->elevator->type->ops.finish_request(rq);
 
-	if (rq->rq_flags & RQF_MQ_INFLIGHT)
-		__blk_mq_dec_active_requests(hctx);
-
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->disk->bdi);
 
-- 
2.25.1

