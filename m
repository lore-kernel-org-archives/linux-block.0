Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AF9C433F5
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 14:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbiEXOjY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 10:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiEXOjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 10:39:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1FF8FF90
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fqfRmBPDePeAQ/5ed4zX6XQlXizUd7fklGIsWzQ68Ao=; b=kq2+H/SaIvAyxrsB2sRUhXgck8
        q8XVbveBLz+qWaK7BBDCZU2CYKl7VnaDJ7C33XBiOHbhGOn20KGGAcuEBoyh48UgZmH9PwK85bWnd
        QBGGVRoe2YICqN2vEgcJK7rbT6FstCZf340Jbs2LvsOqySi0FszpyWxwof3diEMtv89NYIMvyHGfE
        dw/PgBqH5MKpGV/WahgzYYyquj4vvVqlB/WmQjvCpI/J9wgUmmQQLl9H2dif6L9ITjXCE0y8/dI1L
        s0ZkKrzNcti+ud8VMPJVSvBiBM5bWQNgwXa4dldExNKxBHLLHLGinmxnbNPqM5DkPWhPQvKKxXeSj
        kS6xZgHQ==;
Received: from [2001:4bb8:18c:7298:91b6:63de:2998:b8b2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntVgv-008Hdn-GU; Tue, 24 May 2022 14:39:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: take destination bvec offsets into account in bio_copy_data_iter
Date:   Tue, 24 May 2022 16:39:19 +0200
Message-Id: <20220524143919.1155501-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Appartly bcache can copy into bios that do not just contain fresh
pages but can have offsets into the bio_vecs.  Restore support for tht
in bio_copy_data_iter.

Fixes: 8b679a070c53 ("block: rewrite bio_copy_data_iter to use bvec_kmap_local and memcpy_to_bvec")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a3893d80dccc9..8a1b3d650a7f7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1366,10 +1366,12 @@ void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 		struct bio_vec src_bv = bio_iter_iovec(src, *src_iter);
 		struct bio_vec dst_bv = bio_iter_iovec(dst, *dst_iter);
 		unsigned int bytes = min(src_bv.bv_len, dst_bv.bv_len);
-		void *src_buf;
+		void *src_buf = bvec_kmap_local(&src_bv);
+		void *dst_buf = bvec_kmap_local(&dst_bv);
 
-		src_buf = bvec_kmap_local(&src_bv);
-		memcpy_to_bvec(&dst_bv, src_buf);
+		memcpy(dst_buf, src_buf, bytes);
+
+		kunmap_local(dst_buf);
 		kunmap_local(src_buf);
 
 		bio_advance_iter_single(src, src_iter, bytes);
-- 
2.30.2

