Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45F3C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 03:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjE3DdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 May 2023 23:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE3DdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 May 2023 23:33:22 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF93C9;
        Mon, 29 May 2023 20:33:12 -0700 (PDT)
X-QQ-mid: bizesmtp84t1685417562t8wq2x3p
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 11:32:41 +0800 (CST)
X-QQ-SSF: 01400000000000C0G000000A0001000
X-QQ-FEAT: uGhnJwy6xZIa4gIS+jDjc06YMsYLdchXgk3LHYba6K8g4kaZI58NW9IZ70lCx
        5cr5DUrlSQBm9FHK8DnL0Rq6y/n89ytPLY9sK45p60ngxh7kJB52jYPlxRVeQZ1m2vB+A7h
        OKyPJBubLG8o9n44Us/9Hb59W1ezLWkzCwgkWTY7ljCo0DvXh9PG6Uewiqo9ajlvlvgVKQ9
        /dmdj3tPvLOpepy1AEeadSptbdrRzP8N4s+n+6dR9EG6b4mbhKtfpU94sjMILIIkexiPYZ3
        ueDO4nkAJz5MPRVIfd7m5Uw+Xx9sxkoz/MvkgJBwIuDMJ0iwAHDBAwkprYz8nItvn7MjCqK
        ebBWuCUlertEnRVyc+rWw6yGg0me0P7N7L01pUXyMtojmuuz6pXCVGIDEf4hhtNaHDvlUnx
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 171752197749127171
From:   gouhao@uniontech.com
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/buffer: using __bio_add_page in submit_bh_wbc()
Date:   Tue, 30 May 2023 11:32:39 +0800
Message-Id: <20230530033239.17534-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gou Hao <gouhao@uniontech.com>

In submit_bh_wbc(), bio is newly allocated, so it
does not need any merging logic.

And using bio_add_page here will execute 'bio_flagged(
bio, BIO_CLONED)' and 'bio_full' twice, which is unnecessary.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a7fc561758b1..5abc26d8399d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2760,7 +2760,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 
-	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
+	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
 
 	bio->bi_end_io = end_bio_bh_io_sync;
-- 
2.20.1

