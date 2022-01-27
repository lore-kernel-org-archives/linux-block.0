Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B3BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 06:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiA0GgI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 01:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbiA0GgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 01:36:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4314C061714
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 22:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Lg6DP9QwtBcbVbUOOxv7EiJkSX7497L9xYmr8ySpJaE=; b=gKSTejCmB2FQLay7CoIYt/Vmvv
        H5owakRqQ3179EA+gWq3NJLbwrES+2ZZaoyTkKViU0uH1L603L+S7pxqxk5Oh1fRL5rwg6khfB6Lt
        9DPDZUXVEvZ9YqzXenwfPb3O7cFz0lB4fmamUl6tvDOa+IIq7m8Pnmwmw62SDQqPraqLr+vLCXl9e
        tNGHuyVrj309daJ08g8ILi33wkiCzTMknQWXaifQqY1RzrGOEIzNrZ1Wru4xJVyNz0HgcXphKigUf
        pPtDMnd/VVSN1zv+ZqFj0O349Bn5n6uRcSVllkq+6EO4wOADfuQA/9FGlDv6xJtIhFGndVplr9G0z
        UsD/5KUg==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyO5-00EY66-Bj; Thu, 27 Jan 2022 06:36:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 04/14] dm: fold __send_duplicate_bios into __clone_and_map_simple_bio
Date:   Thu, 27 Jan 2022 07:35:36 +0100
Message-Id: <20220127063546.1314111-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold __send_duplicate_bios into its only caller to prepare for
refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e1356a4ce0393..b3b60918206b5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1273,29 +1273,24 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 	}
 }
 
-static void __clone_and_map_simple_bio(struct clone_info *ci,
-					   struct dm_target_io *tio, unsigned *len)
-{
-	struct bio *clone = &tio->clone;
-
-	tio->len_ptr = len;
-
-	__bio_clone_fast(clone, ci->bio);
-	if (len)
-		bio_setup_sector(clone, ci->sector, *len);
-	__map_bio(tio);
-}
-
 static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 				  unsigned num_bios, unsigned *len)
 {
 	struct bio_list blist = BIO_EMPTY_LIST;
-	struct bio *bio;
+	struct bio *clone;
 
 	alloc_multiple_bios(&blist, ci, ti, num_bios);
 
-	while ((bio = bio_list_pop(&blist)))
-		__clone_and_map_simple_bio(ci, clone_to_tio(bio), len);
+	while ((clone = bio_list_pop(&blist))) {
+		struct dm_target_io *tio = clone_to_tio(clone);
+
+		tio->len_ptr = len;
+
+		__bio_clone_fast(clone, ci->bio);
+		if (len)
+			bio_setup_sector(clone, ci->sector, *len);
+		__map_bio(tio);
+	}
 }
 
 static int __send_empty_flush(struct clone_info *ci)
-- 
2.30.2

