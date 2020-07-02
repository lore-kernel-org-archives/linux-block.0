Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CD3C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 19:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D65A21D82
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 19:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4u1u9XM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgGBTVf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBTVf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 15:21:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC608C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=C6dgvPjqvecR+HEjROFzfsPjBs85rEQmC100LnFGlIk=; b=d4u1u9XMDDtdb50V56j9kFyruM
        L7//DIHPepr1fzt+PPvLhqe14Ok1ki0iNPh5N7sfJmiRQbMrNkxju+JF6OqSmfT8WJ0KKlu4hwQ24
        yC6IOEub+l0ZpR8+jvCoPfosrwyUSoO/8u9mgIu5jSZum8RK8HwjJesD3I8D0019P8wA2mMUYJ00d
        14HFu4f+iJN0Kkkg0Dvhhfw0ycTq/X8XprbW+PsJuuP3/JD3byWd2OgdLXW2WrhoDSIG+RNEZh00z
        HHe4QzkLa3UPZ8rJzraovArX61Ejac4TIO18NbB4XJFWmS2EiS/fW+hwCdrjMjrO9aEINRB1vJoBp
        ngULYu3A==;
Received: from [81.201.200.59] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr4m3-00011J-R9; Thu, 02 Jul 2020 19:21:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] block: initialize current->bio_list[1] in __submit_bio_noacct_mq
Date:   Thu,  2 Jul 2020 21:21:25 +0200
Message-Id: <20200702192125.3754607-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_alloc_bioset references current->bio_list[1], so we need to
initialize it for the blk-mq submission path as well.

Fixes: ff93ea0ce763 ("block: shortcut __submit_bio_noacct for blk-mq drivers")
Reported-by: Qian Cai <cai@lca.pw>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 block/blk-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bf882b8d84450c..9f1bf8658b611a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1155,11 +1155,10 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_disk;
-	struct bio_list bio_list;
+	struct bio_list bio_list[2] = { };
 	blk_qc_t ret = BLK_QC_T_NONE;
 
-	bio_list_init(&bio_list);
-	current->bio_list = &bio_list;
+	current->bio_list = bio_list;
 
 	do {
 		WARN_ON_ONCE(bio->bi_disk != disk);
@@ -1174,7 +1173,7 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 		}
 
 		ret = blk_mq_submit_bio(bio);
-	} while ((bio = bio_list_pop(&bio_list)));
+	} while ((bio = bio_list_pop(&bio_list[0])));
 
 	current->bio_list = NULL;
 	return ret;
-- 
2.26.2

