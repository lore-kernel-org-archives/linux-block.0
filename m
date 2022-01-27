Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E6C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 06:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiA0GgV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 01:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiA0GgU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 01:36:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5129C061714
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 22:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0vH1FUnfMx5FpP0X0Nrsss1nthAfDDjqNlEhQ3JqQzs=; b=L/rTsNs4ktkshLuN4h1OOx/vjC
        eUttYjHxGMNdPTcLbfLIuq6YxLRVdpnTNudIVODg63CbHBSoWb3Q6AT6L5adEZH/tdiFWQkyqDaVq
        2m8KCWxHUBo4lEZLQkHXPPDnN/G8LDGAu/kdHY43RunpdMkJWLxZgobgt7E/1huMy7bn6BNUHsfkD
        fD6CK3j71iXomsRcuwCwBwEwbGxqeMSTN3EUkmIV7zdv/QXFmcc8nfv9QTMR9jDnSlxhEq8KpVtTL
        bH4w5c9RaWg/QmhDSTDrYCteHD8EbH4ipgk+IfoBbn7s7Bg27dblgmGPC0c0/DOioyDS0N65Caydk
        EU0c7FkA==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyOI-00EYAI-C2; Thu, 27 Jan 2022 06:36:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 08/14] dm: simplify the single bio fast path in __send_duplicate_bios
Date:   Thu, 27 Jan 2022 07:35:40 +0100
Message-Id: <20220127063546.1314111-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most targets just need a single flush bio.  Open code that case in
__send_duplicate_bios without the need to add the bio to a list.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 030270b770eb0..ee2d92ec7c9fc 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1241,15 +1241,6 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 	struct bio *bio;
 	int try;
 
-	if (!num_bios)
-		return;
-
-	if (num_bios == 1) {
-		bio = alloc_tio(ci, ti, 0, len, GFP_NOIO);
-		bio_list_add(blist, bio);
-		return;
-	}
-
 	for (try = 0; try < 2; try++) {
 		int bio_nr;
 
@@ -1279,12 +1270,23 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 	struct bio_list blist = BIO_EMPTY_LIST;
 	struct bio *clone;
 
-	alloc_multiple_bios(&blist, ci, ti, num_bios, len);
-
-	while ((clone = bio_list_pop(&blist))) {
+	switch (num_bios) {
+	case 0:
+		break;
+	case 1:
+		clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
 		if (len)
 			bio_setup_sector(clone, ci->sector, *len);
 		__map_bio(clone);
+		break;
+	default:
+		alloc_multiple_bios(&blist, ci, ti, num_bios, len);
+		while ((clone = bio_list_pop(&blist))) {
+			if (len)
+				bio_setup_sector(clone, ci->sector, *len);
+			__map_bio(clone);
+		}
+		break;
 	}
 }
 
-- 
2.30.2

