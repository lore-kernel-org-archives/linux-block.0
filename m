Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EE8C433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 12:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F246207EA
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 12:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgIAMEK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:04:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728036AbgIAMBp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 08:01:45 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8EF14AABD7F2EA51D1C1;
        Tue,  1 Sep 2020 20:01:27 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 20:01:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] block: Fix potential page reference leak in __bio_iov_iter_get_pages()
Date:   Tue, 1 Sep 2020 08:00:06 -0400
Message-ID: <20200901120006.9545-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When bio is full, __bio_iov_iter_get_pages() would return error directly
while left page reference still held in pages. Release these references.
Also advance the iov_iter according to what we have done successfully.

Fixes: 576ed9135489 ("block: use bio_add_page in bio_iov_iter_get_pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/bio.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index a9931f23d933..e113073958cb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1023,7 +1023,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 				put_page(page);
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len)))
-                                return -EINVAL;
+				goto put_pages;
 			__bio_add_page(bio, page, len, offset);
 		}
 		offset = 0;
@@ -1031,6 +1031,19 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	iov_iter_advance(iter, size);
 	return 0;
+
+put_pages:
+	/* Advance iov_iter to what we have done yet. */
+	iov_iter_advance(iter, size - left);
+	/* Put the page references still held by pages. */
+	for (; left > 0; left -= len, i++) {
+		struct page *page = pages[i];
+
+		len = min_t(size_t, PAGE_SIZE - offset, left);
+		put_page(page);
+		offset = 0;
+	}
+	return -EINVAL;
 }
 
 static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
-- 
2.19.1

