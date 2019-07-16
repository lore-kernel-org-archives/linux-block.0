Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C313CC7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 15:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B44B21743
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 15:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfGPP0i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:26:38 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:45081 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbfGPP0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 11:26:37 -0400
X-QQ-mid: bizesmtp12t1563290792tc155f3n
Received: from localhost.localdomain (unknown [113.240.214.107])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 16 Jul 2019 23:26:15 +0800 (CST)
X-QQ-SSF: 01400000002000H0ZG31000A0000000
X-QQ-FEAT: Oo4T8aaKqtNjzxQ5PLb2cWvqte5ytmeO9woJLjEjoPjxO8liyo0yq0miwNLFX
        79614LhSSNATrRGue2HcRR7rOSgtXzGPKUXxbQP8LrZw1R9FX6e4dLdD8yipySpKNl2lyq/
        RbfxbPU24hnBWtwhBdbvsGiTpdaEmeRSeJ/cKT2aK5Fa8mPRwGPS1yu5C05GC5G/brTHNxE
        7LwxMDJeqft/QA/92l5EFivhv6vYhVmYslxqCNpHol/WWRcwPmkbVUA1B78NMJVIMQyDW9e
        nUBhJftIBMxk4/+SlJr9NV24NqFn8V1nkA/ogExi1IGTPROLJtGuyDmin5jXv81J0+i1aHB
        SIXYLI/miAZXIb/j3E=
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2] io_uring: fix the wrong counter in async_list
Date:   Tue, 16 Jul 2019 23:26:14 +0800
Message-Id: <20190716152614.15901-1-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We would queue a work for each req in defer and link list without
increasing async_list->cnt, so we shouldn't decrease it while exiting
from workqueue as well as shouldn't process the req in async list.

Thanks to Jens Axboe <axboe@kernel.dk> for his guidance.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 fs/io_uring.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7e932c572f26..e554091c713c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -333,7 +333,8 @@ struct io_kiocb {
 #define REQ_F_IO_DRAIN		16	/* drain existing IO first */
 #define REQ_F_IO_DRAINED	32	/* drain done */
 #define REQ_F_LINK		64	/* linked sqes */
-#define REQ_F_FAIL_LINK		128	/* fail rest of links */
+#define REQ_F_LINK_DONE		128	/* linked sqes done */
+#define REQ_F_FAIL_LINK		256	/* fail rest of links */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -630,6 +631,7 @@ static void io_req_link_next(struct io_kiocb *req)
 			nxt->flags |= REQ_F_LINK;
 		}
 
+		nxt->flags |= REQ_F_LINK_DONE;
 		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
 		queue_work(req->ctx->sqo_wq, &nxt->work);
 	}
@@ -1845,6 +1847,10 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		/* async context always use a copy of the sqe */
 		kfree(sqe);
 
+		/* req from defer and link list needn't decrease async cnt */
+		if (req->flags & (REQ_F_IO_DRAINED | REQ_F_LINK_DONE))
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



