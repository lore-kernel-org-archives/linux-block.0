Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8798EC43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F6721974
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG3o+qI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgIOSwS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgIORZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 13:25:14 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7084CC06178B
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 10:24:02 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id r8so3744726qtp.13
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZeX8V7Gb+jyRqRtlgs7NF1BRzrZm/6v3hKPdNUeahLM=;
        b=WG3o+qI8Cw3yk4Of2qOx3HWYkFQikC1L+LbatZwA9NEF0liTx0f12GzVIgjOIcRggk
         ybOBBsIu1DrocYotXMqBUrDPIsWOzbCeuDMvFKbDkN3syykn9SYx7aNT0zXq/s96qVvZ
         Os7uMIdaf4smKjNX0INspAjc+okNc/a8KjoJILplukcsNeYDIKK4tmJv8fw/RnZjj4Ht
         kGWpSjuWZaRtiHZK+xRo54Ks8Q/twluWB0SurSwyy27FURW1onuXd2c/NiYDKT6eVGw7
         a0GgHNeJAUiJKyZXLWiT6eorcokY4xHG6R84r1ELeiAbwtbNRrI822nynCEFhsVQjI7R
         /0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ZeX8V7Gb+jyRqRtlgs7NF1BRzrZm/6v3hKPdNUeahLM=;
        b=Ty7vwxtwvhMy8hIwPtNyBvU6n9HZj5ArB1eKiGl9H+aZG6yGQmcf57OYs8imiYzcNj
         2s4WUaRXN7fg7B/fC/e9D15fh1bxY1VS1EGDQvd4U2/XOCVEYHP37IoRjAa30fcX7eN7
         UiaMZQx7TIK58b6ytaJ0l/UaKocp7adZwe7OVZ9yx29XchnL+PgtS9TcGAaPg274a+Ia
         j56Wdw4NMyzk7yQRVRajt6JgUS+fldSvftOeDWPW6Uykcna2oqZYMXF6KTpBoyRngREV
         bBD7l2t53jxe0doL2M0nBvMVUdaxq9LaXrgicsm6KXnLXqoj2zYR1nxGoM4I0+e0WFzD
         5/tg==
X-Gm-Message-State: AOAM530UctYVE5wWXHKGzT3pLfe5ZZ3VkQZvelTJ8rM12zLWWWwOBqEV
        SfdczsMVDD4JFk3qxan9MaU=
X-Google-Smtp-Source: ABdhPJxrNthacXH+fyYZJ5rnayPOSYCU9MD/k5XzuTD8OsypSir6w5+0Cqu7Ydt5jXOHJtWRCM82aA==
X-Received: by 2002:ac8:3704:: with SMTP id o4mr17825222qtb.330.1600190641615;
        Tue, 15 Sep 2020 10:24:01 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id z2sm17349244qkg.40.2020.09.15.10.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:24:01 -0700 (PDT)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v2 2/4] block: allow 'chunk_sectors' to be non-power-of-2
Date:   Tue, 15 Sep 2020 13:23:55 -0400
Message-Id: <20200915172357.83215-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200915172357.83215-1-snitzer@redhat.com>
References: <20200915172357.83215-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is possible for a block device to use a non power-of-2 for chunk
size which results in a full-stripe size that is also a non
power-of-2.

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
index bb5636cc17b9..bbfbda33e993 100644
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
+	if (is_power_of_2(chunk_sectors))
+		chunk_sectors -= offset & (chunk_sectors - 1);
+	else
+		chunk_sectors -= sector_div(offset, chunk_sectors);
+
+	return min(q->limits.max_sectors, chunk_sectors);
 }
 
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
-- 
2.15.0

