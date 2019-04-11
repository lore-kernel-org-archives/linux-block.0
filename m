Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F320AC10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 06:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5165204EC
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 06:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="crU2uJzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDKGYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:24:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKGYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 02:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZZdcaHVKSdPa2d1fmW63mDhm+/bobM8WeHtepT86N5E=; b=crU2uJzA1GrAnhUD1Ovk5O8Lil
        loAV/2XJ83Vj2/s4D51gaMOQ/4dlcN2s++W3l8w9Hf4vNcjAY+7wzEtKjlX0Kr+ohp3AUmrHOunSf
        ddk0iGfuPVVX7xmxq/QWWkHcHFdzN7TMITKLgwVK+k54mamaKn+aF5NflvWWc3c7mWQb1APNT83TR
        BqY1lXRKJq9sZqiiyURucJsMzbB9zKLxv1fJT5+PWYYobyY+nPSixCCertP345Rdu8J+drXnlxH9O
        IvmFOZZxaLczdneh0cXPtH5R4aZNdj0sc1pPLBpw/ZTAIiGyAg1Co/PbUf0ihXW+O6rEmTfw91r/6
        NmaQx0Cw==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hET7z-0005Mk-PG; Thu, 11 Apr 2019 06:24:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/5] block: don't allow multiple bio_iov_iter_get_pages calls per bio
Date:   Thu, 11 Apr 2019 08:23:29 +0200
Message-Id: <20190411062331.27800-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411062331.27800-1-hch@lst.de>
References: <20190411062331.27800-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No caller uses bio_iov_iter_get_pages multiple times on a given bio,
and that funtionality isn't all that useful.  Removing it will make
some future changes a little easier and also simplifies the function
a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/bio.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ad346082a971..c2a389b1509a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -958,7 +958,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	const bool is_bvec = iov_iter_is_bvec(iter);
-	unsigned short orig_vcnt = bio->bi_vcnt;
+	int ret;
+
+	if (WARN_ON_ONCE(bio->bi_vcnt))
+		return -EINVAL;
 
 	/*
 	 * If this is a BVEC iter, then the pages are kernel pages. Don't
@@ -968,19 +971,13 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
 
 	do {
-		int ret;
-
 		if (is_bvec)
 			ret = __bio_iov_bvec_add_pages(bio, iter);
 		else
 			ret = __bio_iov_iter_get_pages(bio, iter);
+	} while (!ret && iov_iter_count(iter) && !bio_full(bio));
 
-		if (unlikely(ret))
-			return bio->bi_vcnt > orig_vcnt ? 0 : ret;
-
-	} while (iov_iter_count(iter) && !bio_full(bio));
-
-	return 0;
+	return bio->bi_vcnt ? 0 : ret;
 }
 
 static void submit_bio_wait_endio(struct bio *bio)
-- 
2.20.1

