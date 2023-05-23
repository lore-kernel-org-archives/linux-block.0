Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1CDC7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbjEWHyN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbjEWHyG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:54:06 -0400
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146EE10C3
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:53:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684828429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSfuOMbEetSWAFwj114W63TvaftzVxqbMqn97S3AAjw=;
        b=Mf+LOFSB7lKHhMjNQozHGPguG8VTmKm9l5u1ILcMy0WmkVq8R3XApnsHIM4KifVUACEDXx
        yUzGDA1OO09kevcZxnyUUaGHbu8b344UzMlQXTOcqqS8ValZ1Dntkhla+OX+n43PYil60K
        mkijEqAbND0WsSTZYhLSOREXFieI/7Q=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 08/10] block/rnbd-srv: init err earlier in rnbd_srv_init_module
Date:   Tue, 23 May 2023 15:53:29 +0800
Message-Id: <20230523075331.32250-9-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-1-guoqing.jiang@linux.dev>
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With this, we can remove several lines of code.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 102831c302fc..1fdf3366135a 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -803,7 +803,7 @@ static struct rtrs_srv_ctx *rtrs_ctx;
 static struct rtrs_srv_ops rtrs_ops;
 static int __init rnbd_srv_init_module(void)
 {
-	int err;
+	int err = 0;
 
 	BUILD_BUG_ON(sizeof(struct rnbd_msg_hdr) != 4);
 	BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info) != 36);
@@ -817,19 +817,17 @@ static int __init rnbd_srv_init_module(void)
 	};
 	rtrs_ctx = rtrs_srv_open(&rtrs_ops, port_nr);
 	if (IS_ERR(rtrs_ctx)) {
-		err = PTR_ERR(rtrs_ctx);
 		pr_err("rtrs_srv_open(), err: %d\n", err);
-		return err;
+		return PTR_ERR(rtrs_ctx);
 	}
 
 	err = rnbd_srv_create_sysfs_files();
 	if (err) {
 		pr_err("rnbd_srv_create_sysfs_files(), err: %d\n", err);
 		rtrs_srv_close(rtrs_ctx);
-		return err;
 	}
 
-	return 0;
+	return err;
 }
 
 static void __exit rnbd_srv_cleanup_module(void)
-- 
2.35.3

