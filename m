Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A16C6FA8B
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 01:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiITBwX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiITBwV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 21:52:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A55564C4
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 18:52:19 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MWkvw3J1xz14QgZ;
        Tue, 20 Sep 2022 09:48:12 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:52:17 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
        <christoph.boehmwalder@linbit.com>, <axboe@kernel.dk>,
        <cuigaosheng1@huawei.com>
CC:     <drbd-dev@lists.linbit.com>, <linux-block@vger.kernel.org>
Subject: [PATCH 1/2] drbd: remove orphan _req_may_be_done() declaration
Date:   Tue, 20 Sep 2022 09:52:15 +0800
Message-ID: <20220920015216.782190-2-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920015216.782190-1-cuigaosheng1@huawei.com>
References: <20220920015216.782190-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The _req_may_be_done() has been removed by
commit 6870ca6d463e ("drbd: factor out master_bio completion
and drbd_request destruction paths"), so remove the orphan
declaration.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/block/drbd/drbd_req.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 511f39a08de4..6237fa1dcb0e 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -266,8 +266,6 @@ struct bio_and_error {
 
 extern void start_new_tl_epoch(struct drbd_connection *connection);
 extern void drbd_req_destroy(struct kref *kref);
-extern void _req_may_be_done(struct drbd_request *req,
-		struct bio_and_error *m);
 extern int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		struct bio_and_error *m);
 extern void complete_master_bio(struct drbd_device *device,
-- 
2.25.1

