Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F73C4740A
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 01:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5D12171F
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 01:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbfIJBXZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 21:23:25 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:43633 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfIJBXZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 21:23:25 -0400
X-QQ-mid: bizesmtp26t1568078577t9p2vmvv
Received: from Macbook.pro (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Tue, 10 Sep 2019 09:22:56 +0800 (CST)
X-QQ-SSF: 01400000002000R0YS90000A0000000
X-QQ-FEAT: s8YYpWqVDdfG4FZT2mnP+CUK/tdnVZ6TGAA3jx3YtwQ0w0jpnb49o2HSjuoy5
        XgP+MMJnbcpKo9xgpSWw3N8t0h+QWDqWsT8qhPOVZV5ak5L9Ku4bd0sGugbXCd2SdMAhyJs
        gOfnPDawPDNkA0Feq7xozF+qDxKgqKUUxkHyqg5xmyNk5awVtaWF0DTnjdgFJ4UqT+ExCgS
        NqvXP2UPPPLLq3qvV6MvhesM38PIFMag0Dn33gK2nmV25hIcdGX0r1FZ7/iATVIA7dWEhy3
        /WGzhvDpEmfPw6xJN6LzSNT5du9QZwRLPeyQWpdMJd8OcnB9lxGjk8gtxo5wfWE3BTaDPMb
        M+TmabAOX2CNtwt6aQ=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] io_uring: fix use-after-free of shadow_req
Date:   Tue, 10 Sep 2019 09:22:47 +0800
Message-Id: <20190910012247.9987-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a potential dangling pointer problem. we never clean
shadow_req, if there are multiple link lists in this series of
sqes, then the shadow_req will not reallocate, and continue to
use the last one. but in the previous, his memory has been
released, thus forming a dangling pointer. let's clean up him
and make sure that every new link list can reapply for a new
shadow_req.

Fixes: 4fe2c96315 ("io_uring: add support for link with drain")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b03630ced9ae..45ed66d17a64 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2341,6 +2341,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 		if (!prev_was_link && link) {
 			io_queue_link_head(ctx, link, &link->submit, shadow_req);
 			link = NULL;
+			shadow_req = NULL;
 		}
 		prev_was_link = (sqes[i].sqe->flags & IOSQE_IO_LINK) != 0;
 
@@ -2524,6 +2525,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		if (!prev_was_link && link) {
 			io_queue_link_head(ctx, link, &link->submit, shadow_req);
 			link = NULL;
+			shadow_req = NULL;
 		}
 		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
 
-- 
2.23.0



