Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1BCCA9EA0
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 01:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F007B207FC
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 01:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbfJWB5z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 21:57:55 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:54852 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfJWB5z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 21:57:55 -0400
X-QQ-mid: bizesmtp21t1571795868tq52w4qq
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 23 Oct 2019 09:57:47 +0800 (CST)
X-QQ-SSF: 01400000000000S0ZT90000A0000000
X-QQ-FEAT: RXPG1NRztPRumgqFAkwQUjmnSrYV7CrEgzSD8VKtwmupiRdPWhGi7L/uwtTxj
        F6/yMqmR0D++qql2wHnduvpA0QYrSAl+1Eo04PaQh4W8knZly9M2GH1T/VZl/hccGd2Bjho
        1GhhgEt1i9mE27FpuhM4mIdhz45QxNo6tHdbPiWOR1BA9OspjF+/lyAuSxtontLPhZQc8xr
        EQVBhEhjk1ka9SxM+LnWY0pTkwJon9nxtG9AWur9Ww8od8hY0h0w2ABGPaavg80VxG/V6Bz
        5gLheZu3urewZ0LIR90H/IQ4BbWFTrc60Mf4bT7+WwCM3AwxUXWHj0YN9hzNvG4VqrNlsoE
        CvOuLuUFToOlSfhKUM=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH] io_uring: ensure cq_entries is at least equal to or greater than sq_entries
Date:   Wed, 23 Oct 2019 09:57:44 +0800
Message-Id: <1571795864-56669-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If cq_entries is smaller than sq_entries, it will cause a lot of overflow
to appear. when customizing cq_entries, at least let him be no smaller than
sq_entries.

Fixes: 95d8765bd9f2 ("io_uring: allow application controlled CQ ring size")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b64cd2c..dfa9731 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3784,7 +3784,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 		 * to a power-of-two, if it isn't already. We do NOT impose
 		 * any cq vs sq ring sizing.
 		 */
-		if (!p->cq_entries || p->cq_entries > IORING_MAX_CQ_ENTRIES)
+		if (p->cq_entries < p->sq_entries || p->cq_entries > IORING_MAX_CQ_ENTRIES)
 			return -EINVAL;
 		p->cq_entries = roundup_pow_of_two(p->cq_entries);
 	} else {
-- 
2.7.4



