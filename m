Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA646C433E7
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 12:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9885A20767
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 12:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgIAMGI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:06:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728064AbgIAMAw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 08:00:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8217CE36630B98D27A37;
        Tue,  1 Sep 2020 20:00:42 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 20:00:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>, <ebiggers@google.com>, <satyat@google.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] block: Fix potential NULL pointer dereference in __bio_crypt_clone()
Date:   Tue, 1 Sep 2020 07:59:21 -0400
Message-ID: <20200901115921.8926-1-linmiaohe@huawei.com>
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

mempool_alloc() may return NULL if __GFP_DIRECT_RECLAIM is not set in
gfp_mask under memory pressure. So we should check the return value of
mempool_alloc() against NULL before dereference.

Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/blk-crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 2d5e60023b08..046aff85cfa3 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -98,7 +98,8 @@ void __bio_crypt_free_ctx(struct bio *bio)
 void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
 {
 	dst->bi_crypt_context = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
-	*dst->bi_crypt_context = *src->bi_crypt_context;
+	if (likely(dst->bi_crypt_context))
+		*dst->bi_crypt_context = *src->bi_crypt_context;
 }
 EXPORT_SYMBOL_GPL(__bio_crypt_clone);
 
-- 
2.19.1

