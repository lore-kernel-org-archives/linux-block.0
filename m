Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F158CC77B6C
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjDGX7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDGX7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:59:02 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C4CA1C
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:56 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id w11so56665pjh.5
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911936; x=1683503936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IHmovrm22qDdnBZvKTzWyMHmpC60E1KaJrCMmtQeVc=;
        b=fmiTUNu9yzIqXHUmncYXHeBNx8XSaupDVXJ85wq3aDW2lDop4pV11nQSBtci4YUITT
         Oe4ale9qPKOUzo7r58PTzBbob9ugWZd4hm+4Qph+Vbfr6HThCmTxQ8HMkm/e4G4G/IZ+
         42m2tFgd3g60TfBZAey6HsqjtM6g3KXpNBYPquw8XXArATXe2knp9h3Xkl6Y+VIhWI9G
         DV4leIy7ZsnoA4ekDdMTiSs1nVKjkeZw3q/9StgVuYVoIkViLE1SQNrFNE2pV+WYonv5
         RvD2YvhcJOqCwfO01kWwlrZrQ42HboyxvPKkaswQH1DvMpZn7BO1Z+zqCxYn0HB9tw31
         DYgA==
X-Gm-Message-State: AAQBX9dBJNfI/JZHh5IK2Mt6Vws1l4E98JYNl6cQgFjwrRZwIQV/d3Ja
        fr2l169n7WQA7P6Ckhfomtw=
X-Google-Smtp-Source: AKy350aeWuR2Sz8EOAGg5jnmScPJm+Dt67sKDPQQNMWvcspMIzwNCFGQRoon7L+jj9y+xCaro6ZOiQ==
X-Received: by 2002:a05:6a20:4c98:b0:d3:84ca:11b with SMTP id fq24-20020a056a204c9800b000d384ca011bmr3486018pzb.40.1680911935876;
        Fri, 07 Apr 2023 16:58:55 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 12/12] block: mq-deadline: Handle requeued requests correctly
Date:   Fri,  7 Apr 2023 16:58:22 -0700
Message-Id: <20230407235822.1672286-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a zoned write is requeued with an LBA that is lower than already
inserted zoned writes, make sure that it is submitted first.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index d49e20d3011d..c536b499a60f 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -162,8 +162,19 @@ static void
 deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
 {
 	struct rb_root *root = deadline_rb_root(per_prio, rq);
+	struct request **next_rq = &per_prio->next_rq[rq_data_dir(rq)];
 
 	elv_rb_add(root, rq);
+	if (*next_rq == NULL || !blk_queue_is_zoned(rq->q))
+		return;
+	/*
+	 * If a request got requeued or requests have been submitted out of
+	 * order, make sure that per zone the request with the lowest LBA is
+	 * submitted first.
+	 */
+	if (blk_rq_pos(rq) < blk_rq_pos(*next_rq) &&
+	    blk_rq_zone_no(rq) == blk_rq_zone_no(*next_rq))
+		*next_rq = rq;
 }
 
 static inline void
@@ -822,6 +833,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
+		struct list_head *insert_before;
+
 		deadline_add_rq_rb(per_prio, rq);
 
 		if (rq_mergeable(rq)) {
@@ -834,7 +847,18 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		 * set expire time and add to fifo list
 		 */
 		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
-		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
+		insert_before = &per_prio->fifo_list[data_dir];
+		if (blk_rq_is_seq_zoned_write(rq)) {
+			const unsigned int zno = blk_rq_zone_no(rq);
+			struct request *rq2 = rq;
+
+			while ((rq2 = deadline_earlier_request(rq2)) &&
+			       blk_rq_zone_no(rq2) == zno &&
+			       blk_rq_pos(rq2) > blk_rq_pos(rq)) {
+				insert_before = &rq2->queuelist;
+			}
+		}
+		list_add_tail(&rq->queuelist, insert_before);
 	}
 }
 
