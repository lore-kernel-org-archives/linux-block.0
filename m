Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3A4C73C7C
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 08:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3286120665
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 08:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfGJIgZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:36:25 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:43930 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJIgZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 04:36:25 -0400
X-QQ-mid: bizesmtp21t1562747767tfppgxhm
Received: from Macbook.pro (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 10 Jul 2019 16:36:06 +0800 (CST)
X-QQ-SSF: 01400000002000Q0WO70000A0000000
X-QQ-FEAT: +YOBnTLWDrEM+TuZuFNL7MSqbG6In9MqYWrKZ4FHLoMHKpJwB18abY+cf0nVk
        wqRYOporxOD8WYzF+hZ2Dn09ncTlviw5nNdOmwhCsf50ZuogaiVkUOxt1TZ0an5zipBqZ5Z
        Z1Ah51/CCJ+Y09JaLPbXdeXATWpo4zLjR9Cj6hM/RHTiLX+KKNy9NxxX2j2+7D2pvLR/DSN
        dSxEM0h7U/Qc1lhDap3wEfMgslcmAaoHe1GFbfpF2MhG0j6S9VHP5PZ1bHe6c1hEm2k5Oc/
        XzhG+yWpcKWvwl6Lb+pCK9U/gpbYJrWPkp67fLZdCXpTV3gYmUclnDYeM+UE2124eHhVDef
        lkDM06hxTdqQv1Q3ZQ=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     Jackie Liu <liuyun01@kylinos.cn>, linux-block@vger.kernel.org
Subject: [PATCH] io_uring: fix stuck problem caused by potential memory alloc failure
Date:   Wed, 10 Jul 2019 16:35:58 +0800
Message-Id: <20190710083558.5940-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

when io_req_defer alloc memory failed, it will be return -EAGAIN.
But io_submit_sqe cannot be returned immediately because the reference
count for req is still hold. we should be clean it.

Fixes: de0617e46717 ("io_uring: add support for marking commands as draining")
Cc: linux-block@vger.kernel.org
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4ef62a45045d..1c388533cdc8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1843,8 +1843,8 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	ret = io_req_defer(ctx, req, s->sqe);
 	if (ret) {
 		if (ret == -EIOCBQUEUED)
-			ret = 0;
-		return ret;
+			return 0;
+		goto out;
 	}
 
 	ret = __io_submit_sqe(ctx, req, s, true);
-- 
2.22.0



