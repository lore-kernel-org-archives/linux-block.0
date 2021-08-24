Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C38C432BE
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 17:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FD461BB1
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 17:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhHXRID (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 13:08:03 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:33692 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbhHXRGM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 13:06:12 -0400
Received: by mail-pf1-f172.google.com with SMTP id w68so18926985pfd.0
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 10:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOHZr9sjQWL47aREJziCWByq5yNZI7U5chRYYhpFbmk=;
        b=FTkwIveIYJIykSUAF8h9SxJb1Dt1uZOA1HJ4flVZCpvBoay9m/aMl9yvY+ebSqzYIw
         bHg+MZyCHfgmx8rCzgnAFzBNd52lVr+Lz906Er9A62wUHdUvVafvPZajgfvvo0tuPJ+c
         Z/cqRq9a4VEsTu4HBuAtspnBNyGMlnjQQK2TQKYDEBGTzRAKqkwi+qasW0Lo/PR03uCa
         6BSbpiBZHqluRAPXESLWzDQat/N7jQ3wjsFRbRbNIdk0UkQHwbRUI+dMF1PQwDeUrLwM
         u2CbWU31kggmaWLgHFu+curu5AOWsjZGvCP3HT/V2Eo68NucAXCJL8BEnA4sSIrGJhqs
         2CoQ==
X-Gm-Message-State: AOAM531eNtOTI+/jp5DJrUVbogtF/2+J39D+NBwJKiAPevUpRaiE8VqF
        GbTHppbQNWO63FcUU2rCEeI=
X-Google-Smtp-Source: ABdhPJwzXcmpRmOn96XZymyngQheRQGASv7KtEXrW24aZWmL+QADM35pRiDK/es5atzOFB8sZaUmJA==
X-Received: by 2002:a65:664f:: with SMTP id z15mr34991106pgv.252.1629824727641;
        Tue, 24 Aug 2021 10:05:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3f6e:b7f7:7ad7:acb7])
        by smtp.gmail.com with ESMTPSA id gl12sm2950097pjb.40.2021.08.24.10.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 10:05:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH] mq-deadline: Fix request accounting
Date:   Tue, 24 Aug 2021 10:05:20 -0700
Message-Id: <20210824170520.1659173-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer may call the I/O scheduler .finish_request() callback
without having called the .insert_requests() callback. Make sure that the
mq-deadline I/O statistics are correct if the block layer inserts an I/O
request that bypasses the I/O scheduler. This patch prevents that lower
priority I/O is delayed longer than necessary for mixed I/O priority
workloads.

Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Fixes: 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index dbd74bae9f11..28f2e7655a5f 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -713,6 +713,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	prio = ioprio_class_to_prio[ioprio_class];
 	dd_count(dd, inserted, prio);
+	rq->elv.priv[0] = (void *)(uintptr_t)1;
 
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		blk_mq_free_requests(&free);
@@ -761,12 +762,10 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 	spin_unlock(&dd->lock);
 }
 
-/*
- * Nothing to do here. This is defined only to ensure that .finish_request
- * method is called upon request completion.
- */
+/* Callback from inside blk_mq_rq_ctx_init(). */
 static void dd_prepare_request(struct request *rq)
 {
+	rq->elv.priv[0] = NULL;
 }
 
 /*
@@ -793,7 +792,14 @@ static void dd_finish_request(struct request *rq)
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
-	dd_count(dd, completed, prio);
+	/*
+	 * The block layer core may call dd_finish_request() without having
+	 * called dd_insert_requests(). Hence only update statistics for
+	 * requests for which dd_insert_requests() has been called. See also
+	 * blk_mq_request_bypass_insert().
+	 */
+	if (rq->elv.priv[0])
+		dd_count(dd, completed, prio);
 
 	if (blk_queue_is_zoned(q)) {
 		unsigned long flags;
