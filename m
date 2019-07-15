Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD6C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 15:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E762054F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563203455;
	bh=GRdJJ4B83AfJF8aHUll+amuq345dPXlfxOAT4/iRX60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AoQj/OU9PMaivv+5mWFcldQDuai+iuxmU/R2k/KGfbsm+5cubwRM7qr8K9gUANpd+
	 z8odGVx6H+WocqkBlEtoAAWbOJ9IiVWhgIlExci1NI1J4tcqISG69w04ilGnqEcRnY
	 IJ7dR15vJvN/DYGHJcMf16kjfgn1P8iD8tFWaFt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbfGOPKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732715AbfGONzH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 09:55:07 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF15C20C01;
        Mon, 15 Jul 2019 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198906;
        bh=GRdJJ4B83AfJF8aHUll+amuq345dPXlfxOAT4/iRX60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKQbFPdjofCCAD84I8BeaIPMSqJi3CEKmXRNBSfHuGe250SgBESR+YiHWhZH+8pEj
         u1AGFXzM96tscL+UftosX5azDumXYUF30gMK6vJVBEjfQwwWLShb70iBfZr56+ww/C
         VZLq92FVnMgL+NBpsWjmnWjvSGOZ6mhHu9Y8gkCE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 137/249] lightnvm: pblk: fix freeing of merged pages
Date:   Mon, 15 Jul 2019 09:45:02 -0400
Message-Id: <20190715134655.4076-137-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Heiner Litz <hlitz@ucsc.edu>

[ Upstream commit 510fd8ea98fcb586c01aef93d87c060a159ac30a ]

bio_add_pc_page() may merge pages when a bio is padded due to a flush.
Fix iteration over the bio to free the correct pages in case of a merge.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/pblk-core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 773537804319..f546e6f28b8a 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -323,14 +323,16 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
 			 int nr_pages)
 {
-	struct bio_vec bv;
-	int i;
-
-	WARN_ON(off + nr_pages != bio->bi_vcnt);
-
-	for (i = off; i < nr_pages + off; i++) {
-		bv = bio->bi_io_vec[i];
-		mempool_free(bv.bv_page, &pblk->page_bio_pool);
+	struct bio_vec *bv;
+	struct page *page;
+	int i, e, nbv = 0;
+
+	for (i = 0; i < bio->bi_vcnt; i++) {
+		bv = &bio->bi_io_vec[i];
+		page = bv->bv_page;
+		for (e = 0; e < bv->bv_len; e += PBLK_EXPOSED_PAGE_SIZE, nbv++)
+			if (nbv >= off)
+				mempool_free(page++, &pblk->page_bio_pool);
 	}
 }
 
-- 
2.20.1

