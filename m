Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2178C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 23:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiF0Xnv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242257AbiF0Xnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 19:43:50 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020313D5C
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:50 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id d129so10507867pgc.9
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sidm+YmX4odLJBDsgWhSml1wP+jSGmGPOzF6NSRNmeI=;
        b=xScNvigY6syhadqW67hjeJDZu8d3itN0lNBoSaqUAkhyLCpqyLlxv/PPQD6HsoNTdn
         3uVRZWQoTkPTKXdGtXHCCfVKJvcM9vz+OszXpNxnaXTxtxBsY7IZ3Zh52oUkBKJf+XPu
         sc+C4XVWLqfDJRbdSomFWCdeLObRwaPdy64EfwAaMHtcojNuTqkVjbXMChcHFlF7YPfu
         FchpNdsnI7nHZJ3DhCgAagUMnIH1zZptjd6rL98eAW1COHjSrvc1LiPCULEAQN+mKTMh
         eE1uK7i5vW9OfPEZmB1JUru65/HyPuuuJ1N8EbGuikzuVk4dy4r+9kxTrgNtC7U2r+O+
         MAQw==
X-Gm-Message-State: AJIora9YhmyNt9oBhFZPF2ooCI4bap+y4TUqRqO/obSVFz5BSf9r2l74
        2rb72ZTJQybed7G33LB/9k4=
X-Google-Smtp-Source: AGRyM1uAPZkeaU9+QdHtXkBi+IhjgYqqJ7iU8Liq++XGo7rx5Xoa+zpK5NZieh67sXr33y2YNN/PvQ==
X-Received: by 2002:a63:1e49:0:b0:3fd:cf48:3694 with SMTP id p9-20020a631e49000000b003fdcf483694mr15020725pgm.275.1656373429587;
        Mon, 27 Jun 2022 16:43:49 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3879:b18f:db0d:205])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm7907456pjb.47.2022.06.27.16.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:43:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v3 1/8] block: Document blk_queue_zone_is_seq() and blk_rq_zone_is_seq()
Date:   Mon, 27 Jun 2022 16:43:28 -0700
Message-Id: <20220627234335.1714393-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627234335.1714393-1-bvanassche@acm.org>
References: <20220627234335.1714393-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since it is nontrivial to figure out how blk_queue_zone_is_seq() and
blk_rq_zone_is_seq() handle sequential write preferred zones, document
this.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-mq.h | 7 +++++++
 include/linux/blkdev.h | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e2d9daf7e8dd..909d47e34b7c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1124,6 +1124,13 @@ static inline unsigned int blk_rq_zone_no(struct request *rq)
 	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));
 }
 
+/**
+ * blk_rq_zone_is_seq() - Whether a request is for a sequential zone.
+ * @rq: Request pointer.
+ *
+ * Return: true if and only if blk_rq_pos(@rq) refers either to a sequential
+ * write required or a sequential write preferred zone.
+ */
 static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 {
 	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b2d42201bd5d..6491250ba286 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -687,6 +687,15 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 	return sector >> ilog2(q->limits.chunk_sectors);
 }
 
+/**
+ * blk_queue_zone_is_seq() - Whether a logical block is in a sequential zone.
+ * @q: Request queue pointer.
+ * @sector: Offset from start of block device in 512 byte units.
+ *
+ * Return: true if and only if @q is associated with a zoned block device and
+ * @sector refers either to a sequential write required or a sequential write
+ * preferred zone.
+ */
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
 					 sector_t sector)
 {
