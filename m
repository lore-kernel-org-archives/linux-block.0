Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA486C433FF
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 03:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F5D20657
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 03:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfHFDiG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:38:06 -0400
Received: from smtpbg202.qq.com ([184.105.206.29]:51693 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfHFDiG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Aug 2019 23:38:06 -0400
X-QQ-mid: bizesmtp11t1565062658tbzka1ji
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 06 Aug 2019 11:37:37 +0800 (CST)
X-QQ-SSF: 01400000002000R0XQ80000A0000000
X-QQ-FEAT: mAJfWfDYrJPS00QQubGsDYnALKFh7jUNCIAoZOWheXFnrCyvMNu6jDpox3icJ
        Z+VFjqeMl2n4d3ACgbhbRjhdXUmT1yKrPaYtPSDOk6LAnxEpzv+oj7h3QUuVi6cRdESt3KZ
        KZLNT4ZHTiX3E35W+Oumse4oEnnxZT3Bcy6P2ZjKtESVVgIkq2NnDEa7aNSc/vekw8Uz3fS
        ++ZsIOEs7viJuxleBit+bCyWc7S1jMhx85NejpHJYXhHNmboTlnuMKqZj7mjLxWV2erf1Qb
        RZ3HMoP3xj6jc9DstaP4AK0OdsyoPBGpAl/IObcRCDHlTNFMFq27NI09ty1PTN/d5lsVbeW
        uSffd25NfT9AhGRQefiDd4YaafxZQ==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] io_uring: remove duplicate judgments when put_user_pages
Date:   Tue,  6 Aug 2019 11:37:32 +0800
Message-Id: <1565062652-12596-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When pret is less than or equal to 0, put_user_pages can be
processed correctly.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8a1de5a..be1e010 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2959,8 +2959,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			 * if we did partial map, or found file backed vmas,
 			 * release any pages we did get
 			 */
-			if (pret > 0)
-				put_user_pages(pages, pret);
+			put_user_pages(pages, pret);
 			if (ctx->account_mem)
 				io_unaccount_mem(ctx->user, nr_pages);
 			kvfree(imu->bvec);
-- 
2.7.4



