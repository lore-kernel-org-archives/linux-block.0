Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B52CCA47A
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 09:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbiFNJJ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbiFNJJv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 05:09:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12174131E
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=i1KmEgZjd7O4n2CLA071LE1/HSTT0i2IDw5Sobh6pao=; b=DD3kNhr7zAp1AXn3LMRh/S74dh
        nkZtXHWJr6ntnbc5SxfdEIxL4DnzpCHtjbO1H8xa8MXxih0Xx/Z81bXRWY17DNE4htlM6KMVqwTgH
        Keljj9PjpXe+rKBCecjqQBcjiB5+gzAqPtvdj4y9sSFilIcJtteq9cXKMRpBrfyTDFfT5I/hvlD/C
        i1lZQ1pgdfJ490NEVU88mk+amNzIiBLV633MfIyVnFQVxzmighD2t49mHoeLTQrKOpyXUPTiGtqfY
        FxKPbqX9LvxrlHrrJE1JBZuI4N7R1yjP+UJTyK4LJNz92ylimQ8VyIH1MpMusYW9JZpLEuNXwzr12
        FkJLB+2g==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12YS-008Zea-QX; Tue, 14 Jun 2022 09:09:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 2/6] dm: open code blk_max_size_offset in max_io_len
Date:   Tue, 14 Jun 2022 11:09:30 +0200
Message-Id: <20220614090934.570632-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614090934.570632-1-hch@lst.de>
References: <20220614090934.570632-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

max_io_len always passes an explicitly non-zero chunk_sectors into
blk_max_size_offset.  That means much of blk_max_size_offset is not
needed and can be open coded to simplify the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d8f16183bf27c..0514358a1f8e5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1079,23 +1079,18 @@ static sector_t max_io_len(struct dm_target *ti, sector_t sector)
 {
 	sector_t target_offset = dm_target_offset(ti, sector);
 	sector_t len = max_io_len_target_boundary(ti, target_offset);
-	sector_t max_len;
 
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
+	return min_t(sector_t, len,
+		min(queue_max_sectors(ti->table->md->queue),
+		    blk_chunk_sectors_left(target_offset, ti->max_io_len)));
 }
 
 int dm_set_target_max_io_len(struct dm_target *ti, sector_t len)
-- 
2.30.2

