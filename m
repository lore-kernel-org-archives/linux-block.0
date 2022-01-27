Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C885CC433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 06:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiA0Ggt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 01:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiA0Gge (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 01:36:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73271C061753
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 22:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=StJRsse+37Wokpa/jUXP89uDvoTX9kPzqnz3I3KaGyU=; b=yRNodCYDrUwGNfU5xGzvygidGL
        0qM0DMASwCq3VIwq1bxRk9QWXvfGciN0mypolVJcxvm9xMMnB3B/oHp5lI257hsXgNPVzDPtWcsUS
        /b+wlj0+srrD1B9mPu5ML+g1Yji6gK1JhJV66ggvR4c92NH6+GnHQml5Qphul9dIMJWSzVmEdaBw9
        IuxdCWBJj6KHub1GGmpyGsAU4CZ5UiZT7yplolqo85fITBEtD0tKR1pCs/qqKnbKkYds5vZrsiycD
        nqr92QDH6NcB7CLxG4HqzILV8lC4QH74YwYEEQwrKIYl+t2KhWqaEDQLoQAct9p6gkGqtAg9vakEl
        9jkbblWA==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyOV-00EYFd-Ng; Thu, 27 Jan 2022 06:36:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 12/14] dm: use bio_clone_fast in alloc_tio
Date:   Thu, 27 Jan 2022 07:35:44 +0100
Message-Id: <20220127063546.1314111-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace an open coded bio_clone_fast with the actual helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5978cb87e9372..984ccafb11ea8 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -558,17 +558,13 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 			return NULL;
 		}
 	} else {
-		struct bio *clone = bio_alloc_bioset(NULL, 0, 0, gfp_mask,
-						     &ci->io->md->bs);
+		struct bio *clone = bio_clone_fast(ci->bio, gfp_mask,
+						   &ci->io->md->bs);
 		if (!clone)
 			return NULL;
 
 		tio = clone_to_tio(clone);
 		tio->inside_dm_io = false;
-		if (__bio_clone_fast(&tio->clone, ci->bio, gfp_mask) < 0) {
-			bio_put(clone);
-			return NULL;
-		}
 	}
 
 	tio->magic = DM_TIO_MAGIC;
-- 
2.30.2

