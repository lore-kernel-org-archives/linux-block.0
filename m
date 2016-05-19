Return-Path: <linux-block-owner@vger.kernel.org>
Received: from m50-138.163.com ([123.125.50.138]:44370 "EHLO m50-138.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848AbcESGhW (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 19 May 2016 02:37:22 -0400
From: Wenwei Tao <wwtao0320@163.com>
To: mb@lightnvm.io
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	ww.tao0320@gmail.com
Subject: [PATCH 1/2] lightnvm: break the loop when rqd is not null
Date: Thu, 19 May 2016 14:38:40 +0800
Message-Id: <1463639921-1824-1-git-send-email-wwtao0320@163.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Wenwei Tao <ww.tao0320@gmail.com>

Break the loop when rqd is not null to reduce
unnecessary schedule.

Signed-off-by: Wenwei Tao <ww.tao0320@gmail.com>
---
 drivers/lightnvm/rrpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 2103e97..2915e39 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -98,6 +98,9 @@ static void rrpc_discard(struct rrpc *rrpc, struct bio *bio)
 
 	do {
 		rqd = rrpc_inflight_laddr_acquire(rrpc, slba, len);
+		if (rqd)
+			break;
+
 		schedule();
 	} while (!rqd);
 
-- 
1.8.3.1


