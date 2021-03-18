Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D217C433DB
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 12:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D124C64F57
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 12:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCRMUN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 08:20:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14375 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhCRMUC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 08:20:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F1Qz21HKkz90yS;
        Thu, 18 Mar 2021 20:18:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Mar 2021
 20:19:51 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <hch@lst.de>,
        <keescook@chromium.org>, <linux-block@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] block: do not copy data to user when bi_status is error
Date:   Thu, 18 Mar 2021 20:26:21 +0800
Message-ID: <20210318122621.330010-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the user submitted a request with unaligned buffer, we will
allocate a new page and try to copy data to or from the new page.
If it is a reading request, we always copy back the data to user's
buffer, whether the result is good or error. So if the driver or
hardware returns an error, garbage data is copied to the user space.
This is a potential security issue which makes kernel info leaks.

So do not copy the uninitalized data to user's buffer if the
bio->bi_status is not BLK_STS_OK in bio_copy_kern_endio_read().

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 block/blk-map.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 1ffef782fcf2..c2e2162d54d9 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -439,9 +439,11 @@ static void bio_copy_kern_endio_read(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
-		p += bvec->bv_len;
+	if (!bio->bi_status) {
+		bio_for_each_segment_all(bvec, bio, iter_all) {
+			memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
+			p += bvec->bv_len;
+		}
 	}
 
 	bio_copy_kern_endio(bio);
-- 
2.25.4

