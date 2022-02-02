Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A080EC433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 16:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbiBBQBZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345630AbiBBQBY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 11:01:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E6C06173B
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2zDeJV7L2pJAwrBW2BoaWb0iAmlSixUiIC+xO6VsI9s=; b=HynGE8TD9m6HLFarZX5vNdsvyE
        IoxmI0Dxy5doQdGvR/a3Ot3TJAwRwwe82ufa7zuoWpqLgcOUmKbcbiwgEgfediuOzGYxYbRj5jC82
        IferQLr2R7RhDTFul+jZP+SKAws+9t5Zqm1wUG0bXF/6cil+pLb60/3Pa2W1X2pmNetyZOISqfXqU
        KFF4hTLmF3/AODcwsKBeJ7eKxxS2lDTaTtdql5wHcOps3YS/bebU77Ast4dR5V+QgpZVw5YU9LLCi
        gNb8yi3B1KhozI0O3JjyBzHMFYPc8xqCnlwzRQhnApezX1a83xmYsp32ScJVxLylyPmhnuPQ3KlIN
        enW2xelg==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFI4N-00G7yw-LV; Wed, 02 Feb 2022 16:01:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 03/13] dm: fold clone_bio into __clone_and_map_data_bio
Date:   Wed,  2 Feb 2022 17:00:59 +0100
Message-Id: <20220202160109.108149-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold clone_bio into its only caller to prepare for refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5543e18f3c3bc..9384d250a3e4e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1190,17 +1190,22 @@ static void bio_setup_sector(struct bio *bio, sector_t sector, unsigned len)
 /*
  * Creates a bio that consists of range of complete bvecs.
  */
-static int clone_bio(struct dm_target_io *tio, struct bio *bio,
-		     sector_t sector, unsigned len)
+static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
+				    sector_t sector, unsigned *len)
 {
-	struct bio *clone = &tio->clone;
+	struct bio *bio = ci->bio, *clone;
+	struct dm_target_io *tio;
 	int r;
 
+	tio = alloc_tio(ci, ti, 0, GFP_NOIO);
+	tio->len_ptr = len;
+
+	clone = &tio->clone;
 	__bio_clone_fast(clone, bio);
 
 	r = bio_crypt_clone(clone, bio, GFP_NOIO);
 	if (r < 0)
-		return r;
+		goto free_tio;
 
 	if (bio_integrity(bio)) {
 		if (unlikely(!dm_target_has_integrity(tio->ti->type) &&
@@ -1208,21 +1213,26 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 			DMWARN("%s: the target %s doesn't support integrity data.",
 				dm_device_name(tio->io->md),
 				tio->ti->type->name);
-			return -EIO;
+			r = -EIO;
+			goto free_tio;
 		}
 
 		r = bio_integrity_clone(clone, bio, GFP_NOIO);
 		if (r < 0)
-			return r;
+			goto free_tio;
 	}
 
 	bio_advance(clone, to_bytes(sector - clone->bi_iter.bi_sector));
-	clone->bi_iter.bi_size = to_bytes(len);
+	clone->bi_iter.bi_size = to_bytes(*len);
 
 	if (bio_integrity(bio))
 		bio_integrity_trim(clone);
 
+	__map_bio(tio);
 	return 0;
+free_tio:
+	free_tio(tio);
+	return r;
 }
 
 static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
@@ -1313,25 +1323,6 @@ static int __send_empty_flush(struct clone_info *ci)
 	return 0;
 }
 
-static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
-				    sector_t sector, unsigned *len)
-{
-	struct bio *bio = ci->bio;
-	struct dm_target_io *tio;
-	int r;
-
-	tio = alloc_tio(ci, ti, 0, GFP_NOIO);
-	tio->len_ptr = len;
-	r = clone_bio(tio, bio, sector, *len);
-	if (r < 0) {
-		free_tio(tio);
-		return r;
-	}
-	__map_bio(tio);
-
-	return 0;
-}
-
 static int __send_changing_extent_only(struct clone_info *ci, struct dm_target *ti,
 				       unsigned num_bios)
 {
-- 
2.30.2

