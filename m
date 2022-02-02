Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C169C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 16:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiBBQB1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345633AbiBBQBZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 11:01:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC62C061714
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 08:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tDHwNd2dRB8Z2K6EiRpcY2F0+iUbIwe96VxPtXRuAkw=; b=4lIVZRrhfvopQBZZO2SIoK7rn9
        f/J3VzjxAr2p9T7TWpoJv7q7ci9MlRhZbkq1Oh+SPs8SKQzZM3anNuhYv8sXPIGalVwdM4HP1GQN+
        ig6e2nloYWHU3+dDTRrv+zALLTZis5uV5dbfpdhBYzrXyODrkz3UAe4+HGRXvb7k7phqhIU8Jt3Y2
        7t4SxSzLWI07Z5/NAogpWBGizq1rR2Z5cYSdCh8pPOjP759w8Snlc/AE8OzyU24xE4hogUZo+ZFDu
        IIuanz8H+fOJUzsAswEEchkmep6TnoiAOUvrzExBGNwcYwCiIcaM3mhqHSXMITqdLv8i0y0FJTgti
        0Uj7taXg==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFI4Q-00G80Z-AJ; Wed, 02 Feb 2022 16:01:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 04/13] dm: fold __send_duplicate_bios into __clone_and_map_simple_bio
Date:   Wed,  2 Feb 2022 17:01:00 +0100
Message-Id: <20220202160109.108149-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
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
index 9384d250a3e4e..2527b287ead0f 100644
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

