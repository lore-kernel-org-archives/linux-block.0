Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D4DC48BD3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68E621670
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K3cY0zSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFZNtn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:49:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZNtn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0coxyap5vSTMPkOQ5B15LU//PdYWspWjTnwssiK0QB8=; b=K3cY0zSfaHq7CVE7udmlghcAaX
        8WwTnJX+vjp1mF4vXPCioQiiukGMW42ZkMg/qDME7fHrkqmQRad0ooCF4f9TPb8M4JVpJGwCE2cH7
        DO2NIeMDRJWIaDrDUUsIKJ/T+3F8KpTykfZhfg2wHftpU4TnlcYlXgbXz4/VtnhHuhXaX/MOz8LXl
        7fCyAhSzzHr83CAPor+ItgzS5oBR1KimSi4U2BdEDESSYkkhYg3VLMkWD48xX+rIgFgnwIBViV2s4
        rdjPs5p6xv1T61QJpmB4lqH/XREMjrDYWVQ5FPhGNQFhMGI7tp/o+5zUyEXi0wpVuNPx5+HnCUf6O
        uW3z/Fdw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8Iw-0003Cj-HV; Wed, 26 Jun 2019 13:49:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5/9] iomap: use bio_release_pages in iomap_dio_bio_end_io
Date:   Wed, 26 Jun 2019 15:49:24 +0200
Message-Id: <20190626134928.7988-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626134928.7988-1-hch@lst.de>
References: <20190626134928.7988-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use bio_release_pages instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 23ef63fd1669..3798eaf789d7 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1595,13 +1595,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
-		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
-			struct bvec_iter_all iter_all;
-			struct bio_vec *bvec;
-
-			bio_for_each_segment_all(bvec, bio, iter_all)
-				put_page(bvec->bv_page);
-		}
+		bio_release_pages(bio, false);
 		bio_put(bio);
 	}
 }
-- 
2.20.1

