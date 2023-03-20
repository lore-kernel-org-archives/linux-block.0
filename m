Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D3FC6FD1C
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 23:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCTXvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 19:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCTXvC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 19:51:02 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED7531E1D
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:50:27 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so3336673pjb.4
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679356176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fo1Le/AT02JY1skfmKl6BFKi8BdgJ1W5SuOdeJnrrs=;
        b=h6aWQGraSjZjf+/08m6s/GWtcBOO7edcX1PGywhFyIChv+07+ZLWQNZfpP95Yqvbee
         A4BELWOAl898eAtyWRcwOh+xI+ICiVN7a4SvvmSod+Ka6bzI2p0WzPsal8COZeepeTmG
         2n4l582CVRt9OG8JmAqfrWjoD2i9V6KPE+/KmJKK87ze6Dlst0pSFf1gfMiDcza0hBeh
         YjV7C16M0K0OhhFVlLtL3p3+olB2creZnhpg789ruVAdlmO2Z4AfF80nSumdEpH86Lot
         kplxFwuYDbeK88/NfP3OIVf0xBsyPRCCYD+mr4AO6RuVtKFsy+RNinpUpALd6fakNp7J
         vIxQ==
X-Gm-Message-State: AO0yUKVkxKFJPI75r0VcF7scsL6/6+7ZaFzf0uDYCR4uQr0Lg4w3Epjo
        YUF69NpZo1WFgjAMNEjH0h8=
X-Google-Smtp-Source: AK7set/OEra0Sl9hUP9ff7gWhJg8ihmQ3ZKaWFK/sq+7TDjcmCnD4Hx798mDE8QHl3YIKEPohUx1rQ==
X-Received: by 2002:a05:6a20:bb21:b0:cc:50de:a2be with SMTP id fc33-20020a056a20bb2100b000cc50dea2bemr1139623pzb.14.1679356175889;
        Mon, 20 Mar 2023 16:49:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78dd7000000b0058bf2ae9694sm6915907pfr.156.2023.03.20.16.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:49:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/3] block: Preserve LBA order when requeuing
Date:   Mon, 20 Mar 2023 16:49:05 -0700
Message-Id: <20230320234905.3832131-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230320234905.3832131-1-bvanassche@acm.org>
References: <20230320234905.3832131-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When requeuing a request to a zoned block device, preserve the LBA order
per zone.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cc32ad0cd548..2ec7d6140114 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1495,6 +1495,44 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	blk_mq_run_hw_queues(q, false);
 }
 
+static void blk_mq_insert_rq(struct request *rq, struct list_head *list,
+			     bool at_head)
+{
+	bool zone_in_list = false;
+	struct request *rq2;
+
+	/*
+	 * For request queues associated with a zoned block device, check
+	 * whether another request for the same zone has already been queued.
+	 */
+	if (blk_queue_is_zoned(rq->q)) {
+		const unsigned int zno = blk_rq_zone_no(rq);
+
+		list_for_each_entry(rq2, list, queuelist) {
+			if (blk_rq_zone_no(rq2) == zno) {
+				zone_in_list = true;
+				if (blk_rq_pos(rq) < blk_rq_pos(rq2))
+					break;
+			}
+		}
+	}
+	if (!zone_in_list) {
+		if (at_head) {
+			rq->rq_flags |= RQF_SOFTBARRIER;
+			list_add(&rq->queuelist, list);
+		} else {
+			list_add_tail(&rq->queuelist, list);
+		}
+	} else {
+		/*
+		 * Insert the request in the list before another request for
+		 * the same zone and with a higher LBA. If there is no such
+		 * request, insert the request at the end of the list.
+		 */
+		list_add_tail(&rq->queuelist, &rq2->queuelist);
+	}
+}
+
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list)
 {
@@ -1508,12 +1546,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 	BUG_ON(rq->rq_flags & RQF_SOFTBARRIER);
 
 	spin_lock_irqsave(&q->requeue_lock, flags);
-	if (at_head) {
-		rq->rq_flags |= RQF_SOFTBARRIER;
-		list_add(&rq->queuelist, &q->requeue_list);
-	} else {
-		list_add_tail(&rq->queuelist, &q->requeue_list);
-	}
+	blk_mq_insert_rq(rq, &q->requeue_list, at_head);
 	spin_unlock_irqrestore(&q->requeue_lock, flags);
 
 	if (kick_requeue_list)
