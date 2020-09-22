Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3064EC4346E
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AA52193E
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTJJWSxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgIVCdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 22:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgIVCdA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 22:33:00 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF59C061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:32:59 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id n10so14419902qtv.3
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FPyxJTEfNz4t6PoD6vTT7hbbizqhBOkxQ4lCpIxAUdw=;
        b=qTJJWSxlwxSXXROpFetAkvGXbASVGP8SEQb5QZGJkQNzZToy8R+w5DayRqqH4OkP7m
         yLcUtq6po8GjUb55FlYNuxp1msA5K4YwIaKuqM8LuqSGbi4ZCWNnt/MFpVj65LzlHbMp
         ukI6xEX4CVCB9DjLfUsrCBnKhwi76mxQYDxGm3jBdpDs00SIdslQYnwnGKE1/uGhXdwF
         GaZH8x4sVM7sTbgagfXdv1SOTxSacfwn3nszp3ndARzaqvzkWL1LFxxMgPDZ/va+eedw
         92HHKYhBPoKbLsy/xDTuf8aRUOVH/YH1t1Metw6vWj2Xeibl9YXBaT14QrdhwrNWCB+R
         4TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=FPyxJTEfNz4t6PoD6vTT7hbbizqhBOkxQ4lCpIxAUdw=;
        b=S8a829DYRxgPoxucArxEK8H9I3Airh1i95aN90Z8e8jyDqxL7Bf70/YjHjmY/mfuRi
         DajCPNmxlPsbBXJ7FIhsACeQuFd2uFSvU2xNxdAzd3oPhz8zdNUek1VCqYwipkreEqXl
         Gw07QENqKAoDLzD+DU9lYUvPPOzvXPKK2+bFDScXcazxSG0nJ+vpiD+DzJotCXwwhfON
         54+5rCoeQZ7cr74+Y3esjl/S4LoD7atjKvQgBHuo5w28tpzmSJt7B54i59qLqNBHG6/D
         JBh58XNKYBHbhzPR5cj5QuM/BFyXBW9H8FWU20j78qitrcAGjMsgxZbOvQDad+14g2cn
         sSfA==
X-Gm-Message-State: AOAM533fwzSqB//OP2dNK6EtI2mIRmdrA/zt10TMHXQ8qv7ddhq0E587
        AZQbuUGpKR8xzo0B3TtIp6I=
X-Google-Smtp-Source: ABdhPJwA7XzwPgQjajmIKJUINJYBRbVON+qScRpOurSH9hVDi4qKTD8l6xVe/lcnpeUv0u/RnRLQfA==
X-Received: by 2002:ac8:3fdd:: with SMTP id v29mr2599290qtk.383.1600741979177;
        Mon, 21 Sep 2020 19:32:59 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r24sm11240605qtm.70.2020.09.21.19.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 19:32:58 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 4/6] block: allow 'chunk_sectors' to be non-power-of-2
Date:   Mon, 21 Sep 2020 22:32:49 -0400
Message-Id: <20200922023251.47712-5-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200922023251.47712-1-snitzer@redhat.com>
References: <20200922023251.47712-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is possible, albeit more unlikely, for a block device to have a non
power-of-2 for chunk_sectors (e.g. 10+2 RAID6 with 128K chunk_sectors,
which results in a full-stripe size of 1280K. This causes the RAID6's
io_opt to be advertised as 1280K, and a stacked device _could_ then be
made to use a blocksize, aka chunk_sectors, that matches non power-of-2
io_opt of underlying RAID6 -- resulting in stacked device's
chunk_sectors being a non power-of-2).

Update blk_queue_chunk_sectors() and blk_max_size_offset() to
accommodate drivers that need a non power-of-2 chunk_sectors.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-settings.c   | 10 ++++------
 include/linux/blkdev.h | 12 +++++++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b2e1a929a6db..5ea3de48afba 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -172,15 +172,13 @@ EXPORT_SYMBOL(blk_queue_max_hw_sectors);
  *
  * Description:
  *    If a driver doesn't want IOs to cross a given chunk size, it can set
- *    this limit and prevent merging across chunks. Note that the chunk size
- *    must currently be a power-of-2 in sectors. Also note that the block
- *    layer must accept a page worth of data at any offset. So if the
- *    crossing of chunks is a hard limitation in the driver, it must still be
- *    prepared to split single page bios.
+ *    this limit and prevent merging across chunks. Note that the block layer
+ *    must accept a page worth of data at any offset. So if the crossing of
+ *    chunks is a hard limitation in the driver, it must still be prepared
+ *    to split single page bios.
  **/
 void blk_queue_chunk_sectors(struct request_queue *q, unsigned int chunk_sectors)
 {
-	BUG_ON(!is_power_of_2(chunk_sectors));
 	q->limits.chunk_sectors = chunk_sectors;
 }
 EXPORT_SYMBOL(blk_queue_chunk_sectors);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5636cc17b9..51d98a595943 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1059,11 +1059,17 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 static inline unsigned int blk_max_size_offset(struct request_queue *q,
 					       sector_t offset)
 {
-	if (!q->limits.chunk_sectors)
+	unsigned int chunk_sectors = q->limits.chunk_sectors;
+
+	if (!chunk_sectors)
 		return q->limits.max_sectors;
 
-	return min(q->limits.max_sectors, (unsigned int)(q->limits.chunk_sectors -
-			(offset & (q->limits.chunk_sectors - 1))));
+	if (likely(is_power_of_2(chunk_sectors)))
+		chunk_sectors -= offset & (chunk_sectors - 1);
+	else
+		chunk_sectors -= sector_div(offset, chunk_sectors);
+
+	return min(q->limits.max_sectors, chunk_sectors);
 }
 
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
-- 
2.15.0

