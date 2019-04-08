Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40758C10F14
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07633213F2
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fRj+WHLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfDHKrK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:47:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfDHKrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 06:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ujE7HFWYEnqRuLkTpNeVkbaF5H7bpbdcoBBNUgC69Zg=; b=fRj+WHLSIvPWSc1dcMLmssONy3
        DvSOagbFjFzyzPM/D6OB0ixyxKArcUABEoO/3+1zeBbQVEal3+dKsxTrLZj3MloqlT2NuN56DzbBP
        mnRJRsGZGZeXCK1+5JkptsG4hZHE44CZ6YCsxh9iEyZArKUldjWAK5IS5kVTjUwug0qSEmAoNSZa+
        kN1xDAFTDTDczm3Bw6EIZMo3h4EZ2RAgv2CVWfH7exHGGrB+nseQ3v6CdrMfRmqO81q944x3jsJNP
        6iohgXmLQ9KPEzmtexgZYPxxRKTiWsLvXEvHxEosw445WmfZY3W6Zy7N2gQHTPflKWVQNsIxltJSE
        YNhcPj9Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDRnw-0000ID-1w; Mon, 08 Apr 2019 10:47:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 2/5] block: refactor __bio_iov_bvec_add_pages
Date:   Mon,  8 Apr 2019 12:46:38 +0200
Message-Id: <20190408104641.4905-3-hch@lst.de>
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

Return early on error, and add an unlikely annotation for that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c2592c5d70b9..ad346082a971 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -873,20 +873,19 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 	len = min_t(size_t, bv->bv_len - iter->iov_offset, iter->count);
 	size = bio_add_page(bio, bv->bv_page, len,
 				bv->bv_offset + iter->iov_offset);
-	if (size == len) {
-		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
-			struct page *page;
-			int i;
+	if (unlikely(size != len))
+		return -EINVAL;
 
-			mp_bvec_for_each_page(page, bv, i)
-				get_page(page);
-		}
+	if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
+		struct page *page;
+		int i;
 
-		iov_iter_advance(iter, size);
-		return 0;
+		mp_bvec_for_each_page(page, bv, i)
+			get_page(page);
 	}
 
-	return -EINVAL;
+	iov_iter_advance(iter, size);
+	return 0;
 }
 
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
-- 
2.20.1

