Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52064C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 09:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352916AbiFNJJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351222AbiFNJJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 05:09:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF3140A16
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VftBlw+J8XHGFIkvNwP8l9M1/vCc+WKDE/iuHGrQuQ0=; b=hBDkYP19ChP9eFYczwXoRW7hLf
        tPSCzeS8uChKCeghEknFU2HmTulBrE/iKt36M9kMDSvDzIgS459RjjpuYWecixvZtC54iYh2s11mq
        E1R2j49hP1MHGzUOE4eu4LBj0b772x0YsXIuX/cA3P5Y8E27fi//8mOBjlcb7gl2QLAA24kA4CQFc
        y2wYHM4+z06f8YrHAnJ1sLDpPTu6ZN7vkShONZHtjL8RY3Wfk1lbB+pQ6sHgcN6/ItTKYVb7AfJt4
        7VXZDmB8OA/BXMwLIhF1/DjkxqClMd2xBlH7vBiU7FeLpiBE6jOR5o+zecYtMpRLtt9ojKYUOLDP5
        YPnDpBfg==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12YP-008ZdX-Tp; Tue, 14 Jun 2022 09:09:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 1/6] block: factor out a chunk_size_left helper
Date:   Tue, 14 Jun 2022 11:09:29 +0200
Message-Id: <20220614090934.570632-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614090934.570632-1-hch@lst.de>
References: <20220614090934.570632-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out a helper from blk_max_size_offset so that it can be reused
independently.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 914c613d81da7..e66ad451274ec 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -933,6 +933,17 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	return q->limits.max_sectors;
 }
 
+/*
+ * Return how much of the chunk is left to be used for I/O at a given offset.
+ */
+static inline unsigned int blk_chunk_sectors_left(sector_t offset,
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
@@ -948,12 +959,8 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
 			return q->limits.max_sectors;
 	}
 
-	if (likely(is_power_of_2(chunk_sectors)))
-		chunk_sectors -= offset & (chunk_sectors - 1);
-	else
-		chunk_sectors -= sector_div(offset, chunk_sectors);
-
-	return min(q->limits.max_sectors, chunk_sectors);
+	return min(q->limits.max_sectors,
+			blk_chunk_sectors_left(offset, chunk_sectors));
 }
 
 /*
-- 
2.30.2

