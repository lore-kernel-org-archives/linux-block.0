Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41875C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 01:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiITBwX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiITBwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 21:52:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C7558F6
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 18:52:20 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWkvw40RyzlW3x;
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
Subject: [PATCH 2/2] block/drbd: remove useless comments in receive_DataReply()
Date:   Tue, 20 Sep 2022 09:52:16 +0800
Message-ID: <20220920015216.782190-3-cuigaosheng1@huawei.com>
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

All implementations of req->collision, _req_may_be_done and
drbd_fail_pending_reads have been removed, so remove the comments
in receive_DataReply() that provide no useful information.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/block/drbd/drbd_receiver.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index af4c7d65490b..c897c4572036 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2113,9 +2113,6 @@ static int receive_DataReply(struct drbd_connection *connection, struct packet_i
 	if (unlikely(!req))
 		return -EIO;
 
-	/* hlist_del(&req->collision) is done in _req_may_be_done, to avoid
-	 * special casing it there for the various failure cases.
-	 * still no race with drbd_fail_pending_reads */
 	err = recv_dless_read(peer_device, req, sector, pi->size);
 	if (!err)
 		req_mod(req, DATA_RECEIVED);
-- 
2.25.1

