Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592DFC433FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 06:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiA0Gg0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 01:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbiA0GgY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 01:36:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7DC061714
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 22:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J0izfstJSb8vQvi0Ea8HUHUJbIppOAU4XEVoB7P8WkI=; b=LbRjZZCjN9rTLJ9pYRBdrXdGzV
        2bYyGRkWsSWdR7fD9JQYzIBTlwiehszpdhDudZK1LN1nISK+tLwEL8vLqYLlvi5SArw1bWQ2sqWqz
        ZgRZfzXqzcX4k1HdD/U2m6AqJqnvktgmmI18S9abyOkA49wjm6C6cRXJqXvNanaL23btqyZIzE8UT
        VbtR+wb08M5AAXbo4nFQcUdxaG+58FOChzo6uEp6TEsqSwDLEPLuYgZDJV6yubnlD8fYYbcAFT2Jr
        wW7KR8mvKRAzcuAG3Oz5m6JUyo9QjkGxkdxTDYQ1i75TI9c7993UCttP+OBDHDPKA0GOn5tOQVrzP
        w38MUF/g==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyOM-00EYBP-08; Thu, 27 Jan 2022 06:36:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 09/14] dm: add a missing bio initialization to alloc_tio
Date:   Thu, 27 Jan 2022 07:35:41 +0100
Message-Id: <20220127063546.1314111-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bio in the tio embedded into the clone_info structure is never
initialized.  This is harmless as bio_init only zeroes the structure
and assigns the vectors, but add the initialization to prepare for
refactoring the bio cloning logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ee2d92ec7c9fc..57f44d3a4d747 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -552,6 +552,7 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 	if (!ci->io->tio.io) {
 		/* the dm_target_io embedded in ci->io is available */
 		tio = &ci->io->tio;
+		bio_init(&tio->clone, NULL, NULL, 0, 0);
 	} else {
 		struct bio *clone = bio_alloc_bioset(NULL, 0, 0, gfp_mask,
 						     &ci->io->md->bs);
-- 
2.30.2

