Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364CAC433E1
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 01:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A22A20748
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 01:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653554;
	bh=PSzzfbTuoUNF3dRKfP49WxHtPiD1fc3IO882Ix6zJLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mZJjJteJAa9aJh3/qf+YD+2nUsy26eOwsIyDHkCYX56N26KQHl69rfbMcRPyXrcTz
	 OhA4x4C/pq5NTKxgsY0xH9dgyumnhybI4Jck4dwml06nUERfs//TxNbDqhQE5qWTLn
	 GyOfyGEDPDsgvNDUybvx/MAgsmmw1ThcCHOLKLfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgGBB0K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgGBB0K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 21:26:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAFC120B80;
        Thu,  2 Jul 2020 01:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653169;
        bh=PSzzfbTuoUNF3dRKfP49WxHtPiD1fc3IO882Ix6zJLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dd+JmM3qbLK+efRttCUN+1oxjrSDLVNLj5yQXEMfmIq5J4EmwBuyAQaXoZJvXqJbS
         QQ9gY46SHOg1D2LrtnaRntY/dj4c6aQWMgjw55MwRRWiAeCkBJVs+kszZHUNhniXNS
         NX7PvDHpJHkFu/Cc7zIcY7jAfGm9kFXoXi9x5g0k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 36/40] block: release bip in a right way in error path
Date:   Wed,  1 Jul 2020 21:23:57 -0400
Message-Id: <20200702012402.2701121-36-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012402.2701121-1-sashal@kernel.org>
References: <20200702012402.2701121-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengguang Xu <cgxu519@mykernel.net>

[ Upstream commit 0b8eb629a700c0ef15a437758db8255f8444e76c ]

Release bip using kfree() in error path when that was allocated
by kmalloc().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio-integrity.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25cde8f4..1d173feb38831 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -24,6 +24,18 @@ void blk_flush_integrity(void)
 	flush_workqueue(kintegrityd_wq);
 }
 
+void __bio_integrity_free(struct bio_set *bs, struct bio_integrity_payload *bip)
+{
+	if (bs && mempool_initialized(&bs->bio_integrity_pool)) {
+		if (bip->bip_vec)
+			bvec_free(&bs->bvec_integrity_pool, bip->bip_vec,
+				  bip->bip_slab);
+		mempool_free(bip, &bs->bio_integrity_pool);
+	} else {
+		kfree(bip);
+	}
+}
+
 /**
  * bio_integrity_alloc - Allocate integrity payload and attach it to bio
  * @bio:	bio to attach integrity metadata to
@@ -75,7 +87,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 
 	return bip;
 err:
-	mempool_free(bip, &bs->bio_integrity_pool);
+	__bio_integrity_free(bs, bip);
 	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
@@ -96,14 +108,7 @@ void bio_integrity_free(struct bio *bio)
 		kfree(page_address(bip->bip_vec->bv_page) +
 		      bip->bip_vec->bv_offset);
 
-	if (bs && mempool_initialized(&bs->bio_integrity_pool)) {
-		bvec_free(&bs->bvec_integrity_pool, bip->bip_vec, bip->bip_slab);
-
-		mempool_free(bip, &bs->bio_integrity_pool);
-	} else {
-		kfree(bip);
-	}
-
+	__bio_integrity_free(bs, bip);
 	bio->bi_integrity = NULL;
 	bio->bi_opf &= ~REQ_INTEGRITY;
 }
-- 
2.25.1

