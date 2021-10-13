Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0942C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C529E610F9
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhJMRSB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237932AbhJMRSA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:18:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B6AC061746
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GTAoVH+ub0V8DPqlArZQ0wXb4nmSsMsv+ZPFs7jdHU8=; b=fnNVzOrqMJ4KMHB8ILyLqyyQyj
        TVcNGBtlOp5Xaurzhw1zGf565YwvV4OecTs1TeAA9/qJf+hBE8K8UAMCWEh/+z2XveDCM660GL+kZ
        e6Y2BR4SKjoG6XhRD5gMIA0L83HmKqDzlNbkUzyOEK63G863Fp+6ykPWYJI9jRe1uAGggzzAmEhNY
        3Zqw//VOZdkafvG8qyFW2+0Ebh1H7zmUpxH/Mq7pCK8zwF+HsOAbgE59nM2E89Kilr+iKnKE12BUb
        NK3eBs2PhkM1tUjpJT7Myv9qiXWUEZZFW4PmyHai5Lv27+xT5XbkOcMXajeMSsS92PJs2f2F+iL8I
        JmZ7tqJQ==;
Received: from [2001:4bb8:199:73c5:265:8549:750e:c7f7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mahpk-007eUb-2S; Wed, 13 Oct 2021 17:14:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 2/6] dm: open code blk_max_size_offset in max_io_len
Date:   Wed, 13 Oct 2021 19:12:11 +0200
Message-Id: <20211013171215.1177671-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013171215.1177671-1-hch@lst.de>
References: <20211013171215.1177671-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

max_io_len always passed in an explicit, non-zero chunk_sectors into
blk_max_size_offset.  That means much of blk_max_size_offset is not needed
and open coding it simplifies the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a011d09cb0fac..825ed9d84c9c0 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -944,24 +944,18 @@ static inline sector_t max_io_len_target_boundary(struct dm_target *ti,
 static sector_t max_io_len(struct dm_target *ti, sector_t sector)
 {
 	sector_t target_offset = dm_target_offset(ti, sector);
-	sector_t len = max_io_len_target_boundary(ti, target_offset);
-	sector_t max_len;
+	unsigned int len = max_io_len_target_boundary(ti, target_offset);
 
 	/*
 	 * Does the target need to split IO even further?
 	 * - varied (per target) IO splitting is a tenet of DM; this
 	 *   explains why stacked chunk_sectors based splitting via
-	 *   blk_max_size_offset() isn't possible here. So pass in
-	 *   ti->max_io_len to override stacked chunk_sectors.
+	 *   blk_queue_split() isn't possible here.
 	 */
-	if (ti->max_io_len) {
-		max_len = blk_max_size_offset(ti->table->md->queue,
-					      target_offset, ti->max_io_len);
-		if (len > max_len)
-			len = max_len;
-	}
-
-	return len;
+	if (!ti->max_io_len)
+		return len;
+	return min3(len, ti->table->md->queue->limits.max_sectors,
+		    blk_chunk_sectors_left(target_offset, ti->max_io_len));
 }
 
 int dm_set_target_max_io_len(struct dm_target *ti, sector_t len)
-- 
2.30.2

