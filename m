Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B679C04AA9
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25D6206DF
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QlA2Rnso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfEBXeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 19:34:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBXeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 19:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uVNhOIlK09t3Ea6YCgQ/BfrqRSesaWH1U5p5r8s7+6I=; b=QlA2RnsogloJMoRKCZRZhGLEC7
        6spkpfcAv4rvgv98j45DWANFL59EBjnHF3Z6IEKRdFhFcVFwVtsc2UUwAIhTb5n/KphbFzl5ALGDW
        FrODE6mZDIXaQMHbgOXT8BuKKOTT8erKB0x5uQOBOyUjaqUb6RK1p44TDnKfCrnL/DIpcf08gl49H
        9gbHmdXSynWTDTwBI7sU3E/ijJT823/Gf+YC8rGIZn1Gjjl7A7E7IGbxBZ27gSGvaSLC7QbXWQ6Qo
        SmYQBFUHNR09kSDzCGh0RrACpHP2WGLgX7i58ax5yfq+840GUr07QBCrpKymfJ6GJkl4zyLAN8aK2
        94eyAPEA==;
Received: from [12.246.51.142] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMLDX-0002mo-La; Thu, 02 May 2019 23:34:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 7/8] direct-io: use bio_release_pages in dio_bio_complete
Date:   Thu,  2 May 2019 19:33:31 -0400
Message-Id: <20190502233332.28720-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502233332.28720-1-hch@lst.de>
References: <20190502233332.28720-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use bio_release_pages and bio_set_pages_dirty instead of open coding
them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/direct-io.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index fbe885d68035..62d0594a4622 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -537,7 +537,6 @@ static struct bio *dio_await_one(struct dio *dio)
  */
 static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 {
-	struct bio_vec *bvec;
 	blk_status_t err = bio->bi_status;
 
 	if (err) {
@@ -550,17 +549,9 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {
 		bio_check_pages_dirty(bio);	/* transfers ownership */
 	} else {
-		struct bvec_iter_all iter_all;
-
-		bio_for_each_segment_all(bvec, bio, iter_all) {
-			struct page *page = bvec->bv_page;
-
-			if (dio->op == REQ_OP_READ && !PageCompound(page) &&
-					dio->should_dirty)
-				set_page_dirty_lock(page);
-			put_page(page);
-		}
-		bio_put(bio);
+		if (dio->op == REQ_OP_READ && dio->should_dirty)
+			bio_set_pages_dirty(bio);
+		bio_release_pages(bio);
 	}
 	return err;
 }
-- 
2.20.1

