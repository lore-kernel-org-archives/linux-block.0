Return-Path: <SRS0=xoF3=VK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A138C742D7
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 03:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137E6217D8
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 03:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfGMD7A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jul 2019 23:59:00 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:42774 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfGMD7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 23:59:00 -0400
X-QQ-mid: bizesmtp21t1562990329twuqv0la
Received: from localhost.localdomain (unknown [113.240.168.78])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 13 Jul 2019 11:58:43 +0800 (CST)
X-QQ-SSF: 01400000002000H0ZG31B00A0000000
X-QQ-FEAT: F6eslHfxP6otbQDg1Ha2cTCgOTwLjTi0TR1A/EDVDYE6I7JyO1NLqxvOxWPog
        6sdKvZStQTmC0UVBMl2GoG5fDjrTcYh0IQ+a07mOOYui6IzVcZAhiXzjKxaCVnUcHR+5/fG
        gN+PwjrypHb2vt2LXKWK+tzjwiVsEFdWa7tBo2Tj4lR0Ug/Di7+5+esTkdnK4saz7dpmOYU
        fYih7bGvJmEiLO1Zzq2s3QDkCPDjEGpdHsWV1nvO9b8+5jSwssZloJf9YzJcPlShHKPkfYC
        nUz/XghAWiH9Hpjv5+bPez5UyuiXVpkZOfUg/Rj/XnoM+YfIEELFgBajCTO/lHooaLloiOI
        KNpoEfF
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Subject: [PATCH 1/2] io_uring: make req from defer and link list not touch async list
Date:   Sat, 13 Jul 2019 11:58:25 +0800
Message-Id: <20190713035826.2987-1-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We would queue a work for each req in defer and link list without
increasing async->cnt, so we shouldn't decrease it while exiting
from workqueue as well as shouldn't process the req in async list.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 fs/io_uring.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7e932c572f26..3e48fd7cd08f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -333,7 +333,8 @@ struct io_kiocb {
 #define REQ_F_IO_DRAIN		16	/* drain existing IO first */
 #define REQ_F_IO_DRAINED	32	/* drain done */
 #define REQ_F_LINK		64	/* linked sqes */
-#define REQ_F_FAIL_LINK		128	/* fail rest of links */
+#define REQ_F_LINKED		128	/* linked sqes done */
+#define REQ_F_FAIL_LINK		256	/* fail rest of links */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -630,6 +631,7 @@ static void io_req_link_next(struct io_kiocb *req)
 			nxt->flags |= REQ_F_LINK;
 		}
 
+		nxt->flags |= REQ_F_LINKED;
 		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
 		queue_work(req->ctx->sqo_wq, &nxt->work);
 	}
@@ -1845,6 +1847,10 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		/* async context always use a copy of the sqe */
 		kfree(sqe);
 
+		/* req from defer and link list needn't dec async_list->cnt */
+		if (req->flags & (REQ_F_IO_DRAINED | REQ_F_LINKED))
+			goto out;
+
 		if (!async_list)
 			break;
 		if (!list_empty(&req_list)) {
@@ -1892,6 +1898,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		}
 	}
 
+out:
 	if (cur_mm) {
 		set_fs(old_fs);
 		unuse_mm(cur_mm);
-- 
2.19.1



