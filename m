Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9F6C74A21
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 15:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0942086D
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 15:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfGJPjf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:39:35 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:56137 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfGJPjf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 11:39:35 -0400
X-QQ-mid: bizesmtp17t1562773167tyqe66yy
Received: from Macbook.Pro.openvpn (unknown [175.10.88.112])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 10 Jul 2019 23:39:26 +0800 (CST)
X-QQ-SSF: 01400000002000Q0WO70000A0000000
X-QQ-FEAT: CPznDyfYuPezqzP1SsqcTPI7vZYFhX4sE4lpw35QoMQs/PxJBA6NGQryb2djc
        HtfXEtHWefTkfwuosdjOGjeM9eKkTPkWFpI2f3HBmowqi5VtBA/selaQz+f9YruOv8FsdOy
        o6eKs54iHTot5Nn98fKMqy+a7VKRCBpf1ty7d8vifwihvIj+3rG59TXbO8ffOJ8DWCVYSqV
        zntmaAcmwCiRZ7j+9zbW7ke8opQAi0gu962USQAOQSACbGVlDiBABcUan6h1xBJ9wmpKzIa
        kzS4yBKLxEVl5DuNFEihfCrZe3+9+YrqQvhW71fEsq4GVmbsiPLLuTuJ6Q01ISEq9gVNnwW
        Lqb5QuT7ljt/3B7joHQ2rPCcML1Fw==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     Jackie Liu <liuyun01@kylinos.cn>, linux-block@vger.kernel.org
Subject: [PATCH v2] io_uring: fix stuck problem caused by potential memory alloc failure
Date:   Wed, 10 Jul 2019 23:39:16 +0800
Message-Id: <20190710153916.1022-1-liuyun01@kylinos.cn>
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

When io_req_defer alloc memory fails, it will be -EAGAIN. But
io_submit_sqe cannot return immediately because the reference count for
req is still held. Ensure that we free it.

[axboe@kernel.dk: reword commit message]
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



