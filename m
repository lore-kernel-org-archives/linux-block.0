Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A8ECAAA1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 12:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiH3MkA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiH3Mj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 08:39:58 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E1F12F555
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 05:39:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661863172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ol9Yn3rS0Ef5GAu+q877yCKMkEWCXTaYE03ZGnPBQU=;
        b=EoGwa4ZvVCvDVoiqQR/PRITzM5ovorBryauYpvJcPQrQObCtyP8JJSMFKKz+702V2TF1MS
        bshLVGjUY+Q1DywEORA7yxLstbCwVm6Y6gDmSX5xFtqjaa17dNcMlDNJQ5njYCJb+3wJGa
        sUvGPDTm0oGJ3dodmrBvsZ+OXjTZXhw=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/3] rnbd-srv: fix the return value of rnbd_srv_rdma_ev
Date:   Tue, 30 Aug 2022 20:39:02 +0800
Message-Id: <20220830123904.26671-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220830123904.26671-1-guoqing.jiang@linux.dev>
References: <20220830123904.26671-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since process_msg_open could fail, we should return 'ret'
instead of '0' at the end of function.

Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 3f6c268e04ef..9182d45cb9be 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -403,7 +403,7 @@ static int rnbd_srv_rdma_ev(void *priv,
 	}
 
 	rtrs_srv_resp_rdma(id, ret);
-	return 0;
+	return ret;
 }
 
 static struct rnbd_srv_sess_dev
-- 
2.34.1

