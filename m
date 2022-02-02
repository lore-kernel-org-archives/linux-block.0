Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C29DC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 16:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbiBBQBh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345642AbiBBQBf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 11:01:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17ADC06173D
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6nB4XCyNV0lLp4O7TLKt17coILi7UbFBfUYhwbdKt70=; b=DBLAljdEvNjT1ULi0WBmTfAend
        BUZVo07tqMGN+j/ue6vbsm0P0gfzIQR7DYDkjlUH0KrHTPp5PBPtgQ0+jGocgtMDJtwyTI3r5kccv
        18Bx6laYf60iQxFUPOKAbwLyBsLpiUcvxnr0NiiXDav2qSauvr1eF703KEvINVlUThORtbBDQDB/t
        Aq2pOrVaymC1bs65nNw03OXxhwHmaNx5SqopgmTUlKV21cQovhVEWunDuD2qM6MBayrs3P1shOY0N
        M+dXqqhxnH3KNC+CrEbtHK9CV1e8mzw0sp4MTw+AHo22JxeQglaUZ17YG1yrHbk+Z2Xv/D8Qymwax
        MK/0outg==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFI4a-00G85F-Ue; Wed, 02 Feb 2022 16:01:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 08/13] dm: simplify the single bio fast path in __send_duplicate_bios
Date:   Wed,  2 Feb 2022 17:01:04 +0100
Message-Id: <20220202160109.108149-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
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
index c05b6ff1bb957..78df75f57288b 100644
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

