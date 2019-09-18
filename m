Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73726C4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5389A21897
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 09:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfIRJk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:40:27 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:57446 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfIRJk1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 05:40:27 -0400
X-QQ-mid: bizesmtp25t1568798767te597jk1
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Wed, 18 Sep 2019 17:26:06 +0800 (CST)
X-QQ-SSF: 01400000002000R0YS90000A0000000
X-QQ-FEAT: lRUSrEWtKQBsPf+gZWWAMTXFZ1Ou7uUhg9K6bSHiotI+AmRpXYpCKyxKmO84T
        7kOiXbJF+W/C9FqzgAOxAyE2tkB0GlJkbqxdaKk1x52DG6Kl06vlvWGEBkDIuhn1CAAqMwf
        8ReS0nzXHmYYIK/1+k1roOo7mF54WXBAXdyIH+bDc/yc/sTNYu9nao6mVPoOYSMsmxjOWvY
        KSPkHpa1ZJiCLW0sZELTtduKat1Fu9Gh2ENiOliYzKubJycgMYmgph6D3evHtkEDMjdUGJM
        zQoCXQYnPz+31fvA+gP5k1UHLizDVT2/ZjFuKaoQdOp+B/JKwsNsjX+g+x52mVxoqIJPal+
        D3iBtv176dirENWUruZicVNOgjTqmjNw2vEZgXj
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH] io_uring: fix potential crash issue due to io_get_req failure
Date:   Wed, 18 Sep 2019 17:25:52 +0800
Message-Id: <1568798752-214257-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sometimes io_get_req will return a NUL, then we need to do the
correct error handling, otherwise it will cause the kernel null
pointer exception.

Fixes: 4fe2c963154c ("io_uring: add support for link with drain")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1621243..efc3c05 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2364,12 +2364,15 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 		if (link && (sqes[i].sqe->flags & IOSQE_IO_DRAIN)) {
 			if (!shadow_req) {
 				shadow_req = io_get_req(ctx, NULL);
+				if (unlikely(!shadow_req))
+					goto out;
 				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
 				refcount_dec(&shadow_req->refs);
 			}
 			shadow_req->sequence = sqes[i].sequence;
 		}
 
+out:
 		if (unlikely(mm_fault)) {
 			io_cqring_add_event(ctx, sqes[i].sqe->user_data,
 						-EFAULT);
@@ -2551,12 +2554,15 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
 			if (!shadow_req) {
 				shadow_req = io_get_req(ctx, NULL);
+				if (unlikely(!shadow_req))
+					goto out;
 				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
 				refcount_dec(&shadow_req->refs);
 			}
 			shadow_req->sequence = s.sequence;
 		}
 
+out:
 		s.has_user = true;
 		s.needs_lock = false;
 		s.needs_fixed_file = false;
-- 
2.7.4



