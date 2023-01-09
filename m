Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9086C54EBD
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbjAIX2K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbjAIX1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:27:48 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1163A140F9
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:27:48 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id c9so7424578pfj.5
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOlCWcSLEYoc+DC54TwVl5DO3M0BRFT5LbwS4adE59w=;
        b=laNnJU9WToG2LLlAWI+Env9wpSm7Pf/qNzCQSZe+F6Az4uHeNGBt7yhmLFt5yW4Ol0
         SjbtyKafehq+379qBkTc2maxPekppU5yWcNiqgvBSHc0q1x82si1i1UR8TkAFLmrneIr
         3y5iR8sHnwcQSBWphy69P1VAORHBqFl1lOwGxWoPOW4F0wk3C2K0j99b/q4LIGKm0dSz
         IdXZeLbab5gR2q5mdgzQezMDGMsbl+uptPl/nOm6wRojiXDs/A1mZARUihjJn1Y0AmPe
         q5yJ/IwA4V4oWRzMf9Ytf9yU37fQk/iWq66ktdmrzgfQJ6iszZJpCf0J3B8D9+d95RXa
         PS8A==
X-Gm-Message-State: AFqh2kpjfYkfbQXnQ6L81EG8oobtlWU1ma5Sxb7rbvoHbIV+oOOxOZA2
        FnzukCsi8ImCzJTpHuJRieI=
X-Google-Smtp-Source: AMrXdXv5nV9jFTli4ksUbS0rt+NPMu18SNEYFKsvpQk2saFobpxLncRV7viwuqa6OCmQ9BY8ZlaYNQ==
X-Received: by 2002:aa7:86ce:0:b0:582:f129:7b93 with SMTP id h14-20020aa786ce000000b00582f1297b93mr19843476pfo.33.1673306867500;
        Mon, 09 Jan 2023 15:27:47 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm5032244pfb.155.2023.01.09.15.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:27:46 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH 1/8] block: Document blk_queue_zone_is_seq() and blk_rq_zone_is_seq()
Date:   Mon,  9 Jan 2023 15:27:31 -0800
Message-Id: <20230109232738.169886-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109232738.169886-1-bvanassche@acm.org>
References: <20230109232738.169886-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since it is nontrivial to figure out how disk_zone_is_seq() and
blk_rq_zone_is_seq() handle sequential write preferred zones, document
this.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-mq.h | 7 +++++++
 include/linux/blkdev.h | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 779fba613bd0..6735db1ad24d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1155,6 +1155,13 @@ static inline unsigned int blk_rq_zone_no(struct request *rq)
 	return disk_zone_no(rq->q->disk, blk_rq_pos(rq));
 }
 
+/**
+ * blk_rq_zone_is_seq() - Whether a request is for a sequential zone.
+ * @rq: Request pointer.
+ *
+ * Return: true if and only if blk_rq_pos(@rq) refers either to a sequential
+ * write required or to a sequential write preferred zone.
+ */
 static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 {
 	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b87ed829ab94..ef93e848b1fd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -672,6 +672,15 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 	return sector >> ilog2(disk->queue->limits.chunk_sectors);
 }
 
+/**
+ * disk_zone_is_seq() - Whether a logical block is in a sequential zone.
+ * @disk: Disk pointer.
+ * @sector: Offset from start of block device in 512 byte units.
+ *
+ * Return: true if and only if @disk refers to a zoned block device and
+ * @sector refers either to a sequential write required or a sequential
+ * write preferred zone.
+ */
 static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
 {
 	if (!blk_queue_is_zoned(disk->queue))
