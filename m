Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF94BCCA47F
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 09:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350773AbiFNJJ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352435AbiFNJJ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 05:09:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2041634
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bRDG3OpzxUtRd6qdhwMYYetySjE4uBzMs6kJjEayCEM=; b=fVypyQmSxqQNaxtnADD/b+qujm
        wkam6jpKXOrd9FRPCzysAvQTb8bE+A4fsz/29WaAwGcqNWZclZBI5cJ8i0tmZq716D3tZTDM4QQRR
        DDPXZ/mr8ylTfVBkDYlFFlJLnW7ja06KMGNxr2YjlnDlFJqQ44eBh2BhQ6HKaBJRBf0SzPxDMZ+O+
        b3GGKTMcgroQKoWWiDz7zVPg1kLW7nPQKFNSlVaa/yPUdvnjeDiwv/gRV9+7NXEA0nXfXOW2Xjon/
        cvIkka8I+a/oEUkNjcy2z9ZsqSL0bbXcFb8EAz+toKFQeZWTG31Un9hOweJF5yDT/gUh9wvG/ApiA
        aw9ZZiyg==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12YY-008Zh3-7F; Tue, 14 Jun 2022 09:09:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 4/6] block: cleanup variable naming in get_max_io_size
Date:   Tue, 14 Jun 2022 11:09:32 +0200
Message-Id: <20220614090934.570632-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614090934.570632-1-hch@lst.de>
References: <20220614090934.570632-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

get_max_io_size has a very odd choice of variables names and
initialization patterns.  Switch to more descriptive names and more
clear initialization of them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index df003ecfbd474..4da981efddeed 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -164,18 +164,16 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 static inline unsigned get_max_io_size(struct request_queue *q,
 				       struct bio *bio)
 {
-	unsigned sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector, 0);
-	unsigned max_sectors = sectors;
 	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
 	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
-	unsigned start_offset = bio->bi_iter.bi_sector & (pbs - 1);
-
-	max_sectors += start_offset;
-	max_sectors &= ~(pbs - 1);
-	if (max_sectors > start_offset)
-		return max_sectors - start_offset;
-
-	return sectors & ~(lbs - 1);
+	unsigned max_sectors, start, end;
+
+	max_sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector, 0);
+	start = bio->bi_iter.bi_sector & (pbs - 1);
+	end = (start + max_sectors) & ~(pbs - 1);
+	if (end > start)
+		return end - start;
+	return max_sectors & ~(lbs - 1);
 }
 
 static inline unsigned get_max_segment_size(const struct request_queue *q,
-- 
2.30.2

