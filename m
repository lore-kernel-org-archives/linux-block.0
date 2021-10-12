Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E44C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EC960E54
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhJLQlV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhJLQlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:41:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38599C061745
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Nc+d/q0J4PGimwNTxkQAUU06JTt//M9VzazvluZE4TY=; b=Izm26lpnS3FADXKXjNFcLP5yfu
        kpZhQUR2TKq4WDc/suUlaUEFRL0kIokBS6DHdzTGSuuccPTqegu9MKb4n3iGk6zyfhuLzNckFWw7g
        uChNhDKAVRqK9Oj49LQFnoKIV0BgwPx14bUT6elITk71uvLrz0lBWOsUpZo6ONKJf1asyV9pGviYH
        trukAr0NG7HfZzUm9j9apHTw8RyXumN6UxfM0uccsJDBckdp+vACcnxCDro4lWKmyQDNc4NZAEQ06
        dkSx8Bag+LWnsa22pTG5pBvFdccKehDz+s/iA5H6Cx9HcU3nES0ZIMwp5qS0GTWy/qmrwir2v3gaI
        jTkf/c5g==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKmL-006em5-6V; Tue, 12 Oct 2021 16:37:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 1/5] block: factor out a chunk_size_left helper
Date:   Tue, 12 Oct 2021 18:36:09 +0200
Message-Id: <20211012163613.994933-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012163613.994933-1-hch@lst.de>
References: <20211012163613.994933-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out a helper from blk_max_size_offset so that it can be reused
independently.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17705c970d7e1..0b020bb45a3e7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -622,6 +622,18 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	return q->limits.max_sectors;
 }
 
+/*
+ * Return how much of the chunk sectors is left to be used for an I/O at the
+ * given offset.
+ */
+static inline unsigned int chunk_size_left(sector_t offset,
+		unsigned int chunk_sectors)
+{
+	if (unlikely(!is_power_of_2(chunk_sectors)))
+		return chunk_sectors - sector_div(offset, chunk_sectors);
+	return chunk_sectors - (offset & (chunk_sectors - 1));
+}
+
 /*
  * Return maximum size of a request at given offset. Only valid for
  * file system requests.
@@ -637,12 +649,8 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
 			return q->limits.max_sectors;
 	}
 
-	if (likely(is_power_of_2(chunk_sectors)))
-		chunk_sectors -= offset & (chunk_sectors - 1);
-	else
-		chunk_sectors -= sector_div(offset, chunk_sectors);
-
-	return min(q->limits.max_sectors, chunk_sectors);
+	return min(q->limits.max_sectors,
+			chunk_size_left(offset, chunk_sectors));
 }
 
 /*
-- 
2.30.2

