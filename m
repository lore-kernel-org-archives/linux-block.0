Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C9DC41513
	for <linux-block@archiver.kernel.org>; Sun, 13 Aug 2023 18:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjHMS0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Aug 2023 14:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjHMS0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Aug 2023 14:26:44 -0400
Received: from out-99.mta0.migadu.com (out-99.mta0.migadu.com [91.218.175.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EF01707
        for <linux-block@vger.kernel.org>; Sun, 13 Aug 2023 11:26:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691951205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8R8a1McseA9yHEzYOxyXGPVlvlW3Oa2+9zEDFiMSek=;
        b=F1iv7o3mfAJ/lx9mGer0a7rWZ9/JVBVL1z9zqJi7whLLVhox4bPxuqQxBxnC99UIfW2UlG
        ZBKU/hkfefnNBvH6KxiJQ+wmMFbYOXa4rcqQ5U3woeEEKzg8mLb2PEO8dFVegERyng5ghw
        PkMSQN64rn8tOTAYwUCtBY0YU6sq0Mk=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 2/3] block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
Date:   Sun, 13 Aug 2023 14:26:35 -0400
Message-Id: <20230813182636.2966159-3-kent.overstreet@linux.dev>
In-Reply-To: <20230813182636.2966159-1-kent.overstreet@linux.dev>
References: <20230813182636.2966159-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_iov_iter_get_pages() trims the IO based on the block size of the
block device the IO will be issued to.

However, bcachefs is a multi device filesystem; when we're creating the
bio we don't yet know which block device the bio will be submitted to -
we have to handle the alignment checks elsewhere.

Thus this is needed to avoid a null ptr deref.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/bio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1e75840d17..e74a04ea14 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1245,7 +1245,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct page **pages = (struct page **)bv;
 	ssize_t size, left;
 	unsigned len, i = 0;
-	size_t offset, trim;
+	size_t offset;
 	int ret = 0;
 
 	/*
@@ -1274,10 +1274,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 
-	trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
-	iov_iter_revert(iter, trim);
+	if (bio->bi_bdev) {
+		size_t trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
+		iov_iter_revert(iter, trim);
+		size -= trim;
+	}
 
-	size -= trim;
 	if (unlikely(!size)) {
 		ret = -EFAULT;
 		goto out;
-- 
2.40.1

