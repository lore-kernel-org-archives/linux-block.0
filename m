Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35035 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604AbcGGHyf (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id a66so3512872wme.2
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:35 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: Wenwei Tao <ww.tao0320@gmail.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 01/17] lightnvm: break the loop when rqd is not null
Date: Thu,  7 Jul 2016 09:54:07 +0200
Message-Id: <1467878063-22919-2-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Wenwei Tao <ww.tao0320@gmail.com>

Break the loop when rqd is not null to reduce
an unnecessary schedule.

Signed-off-by: Wenwei Tao <ww.tao0320@gmail.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/rrpc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index de86d72..736e669 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -96,10 +96,13 @@ static void rrpc_discard(struct rrpc *rrpc, struct bio *bio)
 	sector_t len = bio->bi_iter.bi_size / RRPC_EXPOSED_PAGE_SIZE;
 	struct nvm_rq *rqd;
 
-	do {
+	while (1) {
 		rqd = rrpc_inflight_laddr_acquire(rrpc, slba, len);
+		if (rqd)
+			break;
+
 		schedule();
-	} while (!rqd);
+	}
 
 	if (IS_ERR(rqd)) {
 		pr_err("rrpc: unable to acquire inflight IO\n");
-- 
2.1.4

