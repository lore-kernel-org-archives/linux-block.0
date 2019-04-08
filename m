Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE187C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7469020883
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nT30lN5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfDHKrN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:47:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHKrM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 06:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S1pVJ2+xZSpEMyLPvjUzxxbCmkkVwdxyV3H/fb2TEcI=; b=nT30lN5Dq0VHdY485iSq28g6Vs
        fsZ/gXBJYRmF6Bk7lrD7JyxN5Qvd5nJw+nyncGZZSJaNuctwYynums5EWyabX4e+wQPNlO3XBA0K4
        cUYYOxcGgyomHWnQjFAB/MT/v9BIMOk6NYSq8cndUGz21B1vCp6C5ZSgEya3v5KP3bKEXZQ9PVccx
        kMmAY/1wHwSOYVc32UOmex6hh+UZfeEe3SF6/P3lIAWd+T/m3D2AwxZU0AgNffSqSUh3OPyO3eQ/z
        GX0nClqizsAJ5RSGKkoKhoM+/3qhIsMvCCsTJK/fhm8hoLe5+pHaWSsGxSS4uRl3rK2FORo1I0ZI1
        p0L4Cp1A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDRny-0000Lq-I2; Mon, 08 Apr 2019 10:47:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 3/5] block: don't allow multiple bio_iov_iter_get_pages calls per bio
Date:   Mon,  8 Apr 2019 12:46:39 +0200
Message-Id: <20190408104641.4905-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408104641.4905-1-hch@lst.de>
References: <20190408104641.4905-1-hch@lst.de>
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
---
 block/bio.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ad346082a971..2fa624db21c7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -958,7 +958,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	const bool is_bvec = iov_iter_is_bvec(iter);
-	unsigned short orig_vcnt = bio->bi_vcnt;
+	int ret = -EFAULT;
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

