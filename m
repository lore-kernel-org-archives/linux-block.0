Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1998BC56201
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 06:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C786520872
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 06:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgKYG6T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 01:58:19 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35727 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbgKYG6T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 01:58:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UGTpWZU_1606287497;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UGTpWZU_1606287497)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Nov 2020 14:58:18 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: [PATCH] block: remove unused BIO_SPLIT_ENTRIES
Date:   Wed, 25 Nov 2020 14:58:17 +0800
Message-Id: <20201125065817.34148-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 4b1faf931650 ("block: Kill bio_pair_split()"), there's
no user of BIO_SPLIT_ENTRIES anymore.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/linux/bio.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..ecf67108f091 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -711,12 +711,6 @@ static inline bool bioset_initialized(struct bio_set *bs)
 	return bs->bio_slab != NULL;
 }
 
-/*
- * a small number of entries is fine, not going to be performance critical.
- * basically we just need to survive
- */
-#define BIO_SPLIT_ENTRIES 2
-
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 
 #define bip_for_each_vec(bvl, bip, iter)				\
-- 
2.27.0

