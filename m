Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2723C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjDRWk0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjDRWkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:23 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3509014
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:11 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id x8-20020a17090a6b4800b002474c5d3367so202490pjl.2
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857610; x=1684449610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2A9uSLQqM4lhpLKSZo2fi+4H/cRk9MYZu3vr8t9nn4=;
        b=dqGRXDJiFTSBEtk5x7dATPpcrRdTS6TRfS8vP/JcOYT7L9TqYn2VVthb4/48HdLHr6
         VTMWaIgu7eXNxZh7VKbEPOw4Gc0Bh7drrAgd48V/au2cK953cV/xsjijVICKlwQIcTU2
         W4coOopt5pcCvNdAs+85DRajjO+Z3nVgkMbRT4hRZDwDYPK/9sDKDmkXZuCfTod4XMht
         N1zYyFJRTcn7m01raeOuFSlQnT64O9p6gLR6aCTA/py+TPsyY7X49Y5zXWMjDRwDk1+i
         EskVpePa4/tfaV3n6stGI52u053XB4dozIaLtvbGZxy6GASBc0vMW0MP6dJdsnFX/d28
         +srQ==
X-Gm-Message-State: AAQBX9fSofo78hZRj3UiaJYX2Q8vdRmTH1+7H66dXRnKhksM1VoVvvx+
        t3Mo/tMudVoII+Rbl9r+FcI=
X-Google-Smtp-Source: AKy350a1hGWZPF79H5Af1pSM45uASq0l/1vSfM+O40GkLB5Ba4heC4JlZ24k+XAlMzCYkagvKuyGkw==
X-Received: by 2002:a05:6a20:12d0:b0:eb:c48b:d11d with SMTP id v16-20020a056a2012d000b000ebc48bd11dmr1213719pzg.30.1681857610430;
        Tue, 18 Apr 2023 15:40:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 02/11] block: Micro-optimize blk_req_needs_zone_write_lock()
Date:   Tue, 18 Apr 2023 15:39:53 -0700
Message-ID: <20230418224002.1195163-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of using the following expression to translate a request pointer
into a request queue pointer: rq->q->disk->part0->bd_queue, use the
following expression: rq->q.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.h         | 2 +-
 block/blk-zoned.c      | 2 +-
 include/linux/blkdev.h | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index e876584d3516..6b5bc0b8d7b8 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -368,7 +368,7 @@ static inline struct blk_plug *blk_mq_plug( struct bio *bio)
 {
 	/* Zoned block device write operation case: do not plug the BIO */
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
+	    queue_op_is_zoned_write(bdev_get_queue(bio->bi_bdev), bio_op(bio)))
 		return NULL;
 
 	/*
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 835d9e937d4d..c93a26ce4670 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -60,7 +60,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 	if (!rq->q->disk->seq_zones_wlock)
 		return false;
 
-	if (bdev_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
+	if (queue_op_is_zoned_write(rq->q, req_op(rq)))
 		return blk_rq_zone_is_seq(rq);
 
 	return false;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e3242e67a8e3..261538319bbf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1284,10 +1284,10 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
 	return disk_zone_no(bdev->bd_disk, sec);
 }
 
-static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
-					  blk_opf_t op)
+static inline bool queue_op_is_zoned_write(struct request_queue *q,
+					   enum req_op op)
 {
-	if (!bdev_is_zoned(bdev))
+	if (!blk_queue_is_zoned(q))
 		return false;
 
 	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
