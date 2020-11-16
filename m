Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8BEC63798
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 21:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA0122240
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 21:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MFSucmkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgKPVUc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 16:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgKPVUc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 16:20:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F192C0613CF
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 13:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=x6ThtvQgvwHIscZfOUELeo3Uy7svW74ISAsOiTBJTd8=; b=MFSucmkHVCjF+4G00MDVKfOE7M
        BHZOOO99Uk3U4UiXmreqy5l49PtfcX/diVYdhl4mmzPa8dSjy/9l8keq8TEe46UBekbR2QEb5Qm8I
        xWo3hVunlDyBzsjoPPx0zFadTbBf6RTB47gi+OXO/QU0h6de1LIH6EAU0NJPAvShrq1hWFuKLt+XQ
        16BcbFzLN3GiemdGPHPRcILvJ18F8ER4U6yjfI3n21pAZ/pCV/sxi2EEkL4xAtJQazLHPFSkcZcrg
        xCrUajYreFTXpfWiLV0h5+MYo/kYh6NODwtYYWXrFn19IP3EUiftrll4BTt8NCBnv4MP+QCkFhKC5
        QTOIOIcA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kelvH-0007PB-QY; Mon, 16 Nov 2020 21:20:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 5/6] dm: simplify flush_bio initialization in __send_empty_flush
Date:   Mon, 16 Nov 2020 22:20:19 +0100
Message-Id: <20201116212020.1099154-6-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116212020.1099154-1-hch@lst.de>
References: <20201116212020.1099154-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't really need the struct block_device to initialize a bio.  So
switch from using bio_set_dev to manually setting up bi_disk (bi_partno
will always be zero and has been cleared by bio_init already).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 54739f1b579bc8..6d7eb72d41f9ea 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1422,18 +1422,12 @@ static int __send_empty_flush(struct clone_info *ci)
 	 */
 	bio_init(&flush_bio, NULL, 0);
 	flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
+	flush_bio.bi_disk = ci->io->md->disk;
+	bio_associate_blkg(&flush_bio);
+
 	ci->bio = &flush_bio;
 	ci->sector_count = 0;
 
-	/*
-	 * Empty flush uses a statically initialized bio, as the base for
-	 * cloning.  However, blkg association requires that a bdev is
-	 * associated with a gendisk, which doesn't happen until the bdev is
-	 * opened.  So, blkg association is done at issue time of the flush
-	 * rather than when the device is created in alloc_dev().
-	 */
-	bio_set_dev(ci->bio, ci->io->md->bdev);
-
 	BUG_ON(bio_has_data(ci->bio));
 	while ((ti = dm_table_get_target(ci->map, target_nr++)))
 		__send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
-- 
2.29.2

