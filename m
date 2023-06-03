Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0533C77B7A
	for <linux-block@archiver.kernel.org>; Sat,  3 Jun 2023 22:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFCWjV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Jun 2023 18:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFCWjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Jun 2023 18:39:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B13CED;
        Sat,  3 Jun 2023 15:39:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75afa109e60so317138085a.2;
        Sat, 03 Jun 2023 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685831958; x=1688423958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMF+jXCPQw0LKYviejsLmEDSnGWZk4ESqZbZb2scmOM=;
        b=N2g9yTJW4EpuLzTsO8Sw7FCKBYr3vKlUfybb28EdfE4+nJQSZjrvczkp5Qxj3PdndZ
         Qh4jhMoHda6pE3jbBzKqmiJVo7Mpf30Y7pyOGv52WwxNT1KpjsPAB61l2Nx5jPZv0IUe
         8NiVf++QeUwLNkT2J7jh+9I2cdPnlgAPaTfD2TBQeBI0lcMFukdtNhQkHEs3NUM3KBKG
         4fXoRlvzSZ+4FNCLBBy7A+r3SgdDimL5QB3wHVy4qdjb6I5SxFw8GQB47rdi2mPD8pAG
         JEfbrBOq5ci2dlxKmtI7LPzT3CiECqjCAs5HN/l/F3FiimlwzuIU0yXyBJxl1FZ02B5t
         kv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685831958; x=1688423958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMF+jXCPQw0LKYviejsLmEDSnGWZk4ESqZbZb2scmOM=;
        b=eeG6Ey6azUpvMyRFDs6mzXQnmg9X4mQanpc/VhFO0vw02tHZgJwamQE0yoV2Sb7nvu
         evB/Lo/POLzzf3QvTfix0abZHglfjZAZYo+zq1gXMyX19+rj649F3+gpS7uddVeia5jQ
         TMRygv0UcHIOhFiVefPzOK1Yr9CVVZGC2r2DPiLnGZ2Oi0zJ34c0LeBohgxl9wQP9SUW
         h5bYlyceODr7WCEtBvvnLLyeMpMpFy8qp5V1QjBHMBtnWBIdzF9wlaZ78TOI2gy5x2mp
         ReMTinRa1B0QePp1zHV6MorMbp6iSCOwpIFQuuj1QJZAKAr49dNs2a2d8ettwVUjd8B2
         C+iQ==
X-Gm-Message-State: AC+VfDzLmGbU0wLObCP1P50l+hIg+tJorsFCUS1i/12kSFe+WtEp9NM/
        isK1qH3riVvhdsDsYQ2dpY0=
X-Google-Smtp-Source: ACHHUZ7GMrl810w4H/hJZ5jaYjmaCzLABh0nLnuzVTcicYQLuQBcKZ4dQkihUCTLNult04ZMseYd9w==
X-Received: by 2002:a37:a88:0:b0:75d:52f9:f812 with SMTP id 130-20020a370a88000000b0075d52f9f812mr685812qkk.20.1685831958213;
        Sat, 03 Jun 2023 15:39:18 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id k9-20020a05620a142900b0075b06ea03aasm2282727qkj.80.2023.06.03.15.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 15:39:17 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     axboe@kernel.dk
Cc:     horms@kernel.org, linux-block@vger.kernel.org, lkp@intel.com,
        llvm@lists.linux.dev, ming.lei@redhat.com,
        oe-kbuild-all@lists.linux.dev, tian.lan@twosigma.com,
        tilan7663@gmail.com, Hannes Reinecke <hare@suse.de>,
        stable@vger.kernel.org
Subject: [PATCH] blk-mq: fix blk_mq_hw_ctx active request accounting
Date:   Sat,  3 Jun 2023 18:39:12 -0400
Message-Id: <20230603223912.827913-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <da0ae57e-71c2-9ad5-1134-c12309032402@kernel.dk>
References: <da0ae57e-71c2-9ad5-1134-c12309032402@kernel.dk>
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

This issue arises when both bt_iter() and blk_mq_end_request_batch()
are iterating on the same request. The leak happens when
blk_mq_find_and_get_req() is executed(from bt_iter) before
req_ref_put_and_test() gets called by blk_mq_end_request_batch().
And because non-flush request freed by blk_mq_put_rq_ref() bypasses the
active request tracking, the counter would slowly leak overtime.

Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter")

Signed-off-by: Tian Lan <tian.lan@twosigma.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: stable@vger.kernel.org
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

