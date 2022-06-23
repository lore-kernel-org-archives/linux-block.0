Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C162C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 23:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiFWX0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWX0M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 19:26:12 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940845639F
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:11 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id l6so549072plg.11
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3Do2YgRAaAJn11Nkv2QWkHfv2RmvzTULT5W6oBZVa4=;
        b=Xoss4MgM/c16p/W0LIHjw74p/ZlW6IY2F0S8g6ScPWVlir+z0hXkaXwzk0mS2LCdW2
         QLKROVGvNj6WdeskE5TBa2dpEZc8bDi2u7azPgj1CuF3gLchHUU6kTV7ARjPc3d4L+te
         kJyBM9AtAgahWhtgtW3BQCZl0/n/X0yCWtoKC8xcHfbX+GX7A4Ybr1qM/xEH+kShzWuT
         BXOHnxmXww+UnWkzETM4qnGbn6w1KX9svAFxAMhxvhP2apteIGg0ugbr3xLnFrnS+n7b
         bz+wqCxWllwrNaxslR9wsUMvQr3gLTOYMdvLUoR5fSySAKMmbGJAV7MzDlq8L+mTQTs2
         zreA==
X-Gm-Message-State: AJIora8aNO6XLJXHHlZ4xD7PKuR/hQ3mfSpLIm4KVkvXJAyjjagp2NHH
        nzRT0+Ilw3MdJ3WZEpvW32Y=
X-Google-Smtp-Source: AGRyM1vEf8xKS+r3ak60YknJMZH83vDOIBr0pCsn27xK77sJIr5m4Utsyw+0jPQ6aI0y1rbfEAWFxw==
X-Received: by 2002:a17:902:ec8e:b0:16a:2d25:aa5b with SMTP id x14-20020a170902ec8e00b0016a2d25aa5bmr19414926plg.69.1656026770948;
        Thu, 23 Jun 2022 16:26:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id f11-20020a62380b000000b0051829b1595dsm184709pfa.130.2022.06.23.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:26:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v2 1/6] block: Document blk_queue_zone_is_seq() and blk_rq_zone_is_seq()
Date:   Thu, 23 Jun 2022 16:25:58 -0700
Message-Id: <20220623232603.3751912-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623232603.3751912-1-bvanassche@acm.org>
References: <20220623232603.3751912-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since it is nontrivial to figure out how blk_queue_zone_is_seq() and
blk_rq_zone_is_seq() handle sequential write preferred zones, document
this.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
index 92b3bffad328..2904100d2485 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -688,6 +688,15 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
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
