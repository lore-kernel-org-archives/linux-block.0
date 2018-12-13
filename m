Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B29C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0557C2086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JD6icGd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0557C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeLMUcY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:32:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeLMUcY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x7N9wkWVrhL7eD+tlMZmcYB5T4RvJ7h8O5ZuEHDcnBU=; b=JD6icGd/DMmmfERw9+L6OgCVF0
        Ljuu6dIDXCwuCdxNypLt4JCmHDIr3o9mvJsJHQ+GAKe9MhdBSrlakhC+2NpTpANm9OV4Ox9HKrdIQ
        wrANo/kZc7GviSSbSMtMCOGv3jmBYleAplnipAAFNcgm8upteFbiSecRyl5pu92q7A4E/0y+nvGDW
        NNgl71KpFpGV+KRrSdARHxEtMnWyJKeywdfi3fO2bzGCWcdYkIsJgRT5ypykdN0HPhdYsmOOxK3It
        oNsa7KjdlWUPcE6YgAYERIZpLqOpTgbLv1zyU5ofVB3YcM77Ov0RxU+YJvTB3NTWNW/v+Do8oIWfM
        PBDklRfA==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXXeh-0005sT-OF; Thu, 13 Dec 2018 20:32:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/7] block: remove the bio_phys_segments export
Date:   Thu, 13 Dec 2018 21:32:09 +0100
Message-Id: <20181213203214.10650-3-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213203214.10650-1-hch@lst.de>
References: <20181213203214.10650-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c       | 3 +--
 block/blk-merge.c | 6 +++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 036e3f0cc736..fa1ea2ac66a8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -571,14 +571,13 @@ void bio_put(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_put);
 
-inline int bio_phys_segments(struct request_queue *q, struct bio *bio)
+int bio_phys_segments(struct request_queue *q, struct bio *bio)
 {
 	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
 		blk_recount_segments(q, bio);
 
 	return bio->bi_phys_segments;
 }
-EXPORT_SYMBOL(bio_phys_segments);
 
 /**
  * 	__bio_clone_fast - clone a bio that shares the original bio's biovec
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 09591daf4993..62e97ec92034 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -264,7 +264,11 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
 	}
 
 	/* physical segments can be figured out during splitting */
-	res = split ? split : *bio;
+	if (split) {
+		res = split;
+	} else {
+		res = *bio;
+	}
 	res->bi_phys_segments = nsegs;
 	bio_set_flag(res, BIO_SEG_VALID);
 
-- 
2.19.2

