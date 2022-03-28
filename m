Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0CDC433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 02:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiC1Czy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Mar 2022 22:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiC1Czx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Mar 2022 22:55:53 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11C34C780;
        Sun, 27 Mar 2022 19:54:12 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 28 Mar
 2022 10:54:12 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 28 Mar
 2022 10:54:10 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
        <axboe@kernel.dk>
CC:     <drbd-dev@lists.linbit.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] drbd: Return true/false (not 1/0) from bool functions
Date:   Mon, 28 Mar 2022 10:54:09 +0800
Message-ID: <1648436049-4335-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return boolean values ("true" or "false") instead of 1 or 0 from bool
functions.  This fixes the following warnings from coccicheck:

./drivers/block/drbd/drbd_req.c:912:9-10: WARNING: return of 0/1 in
function 'remote_due_to_read_balancing' with return type bool

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index c043945..171905a 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -909,7 +909,7 @@ static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t se
 
 	switch (rbm) {
 	case RB_CONGESTED_REMOTE:
-		return 0;
+		return false;
 	case RB_LEAST_PENDING:
 		return atomic_read(&device->local_cnt) >
 			atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
-- 
2.7.4

