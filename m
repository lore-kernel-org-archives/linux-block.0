Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597AAC31E40
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 09:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C6121855
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 09:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfHOJiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:38:11 -0400
Received: from smtpbg202.qq.com ([184.105.206.29]:59588 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOJiL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 05:38:11 -0400
X-QQ-mid: bizesmtp22t1565861886t6rnd0y0
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 15 Aug 2019 17:38:06 +0800 (CST)
X-QQ-SSF: 01400000002000R0XR80000A0000000
X-QQ-FEAT: 7jvh91anbK89ZSXB/9AXPwVGcst7t7FiAOXJI0eYzGRTg6YQrCNZLxde+5QOz
        D2LaiwUZkbf6rgHPLIZH1fUq3oKkNQGhB6EmVy9dwhkBtZiEpDU+O7dQU9UrsEJLnFb/cE8
        uz8yrwXNcHsMFK3ZXrJ+EvhPF/HR8QU0NjYciqsu3NTCqk9rD/ZrhcZSSdYA5L4w/yOeiE5
        spWH/+5odXFF10DQiZ+iE0G97ekfrj4kC+7y/jrU7Yjh6TxJfflH44DfQ8di4Fcl+R9/uIM
        u9IGcHm7q+oR1K182VXNNSYR6tobcQd2Yw+ag2T7BhkW9A5lp6ZGNNjo9D9nz0HcWEHCO2c
        SIXklOWJdmlMxeBaxcKUJBVEdBdyw==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] io_uring: use kmemdup instead of kmalloc and memcpy
Date:   Thu, 15 Aug 2019 17:38:00 +0800
Message-Id: <1565861880-67516-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just clean up the code, no function changes.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d542f1c..e5d9f3d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2029,13 +2029,11 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
 		struct io_uring_sqe *sqe_copy;
 
-		sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
+		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (sqe_copy) {
 			struct async_list *list;
 
-			memcpy(sqe_copy, s->sqe, sizeof(*sqe_copy));
 			s->sqe = sqe_copy;
-
 			memcpy(&req->submit, s, sizeof(*s));
 			list = io_async_list_from_sqe(ctx, s->sqe);
 			if (!io_add_to_prev_work(list, req)) {
-- 
2.7.4



