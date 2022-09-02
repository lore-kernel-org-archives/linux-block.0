Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF720C38145
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 10:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiIBKBT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 06:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbiIBKBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 06:01:14 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EBF84EDC
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 03:01:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662112862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PO0NJ0PKN2qkoAxuNz+8dWRIPeHYEd9j9osUc4jNSy0=;
        b=SikqhacHlzdL/2tsUmQ8w4SvFp84KHVP+KunNOSDPFUbg5Mrl8Y2r38YJ5Vr65xeISRJfv
        EB+hhp872m2JOIFZhhEmklcMp2j84TCvCjmlOy46+FskLeISObsFLtpniQngSz4Cbj0fR9
        vYp5/VmpEkMSpXDHtLyxBSJvjxOL5/Q=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2 1/3] rnbd-srv: add comment in rnbd_srv_rdma_ev
Date:   Fri,  2 Sep 2022 18:00:53 +0800
Message-Id: <20220902100055.25724-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220902100055.25724-1-guoqing.jiang@linux.dev>
References: <20220902100055.25724-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let's add some explanations here given the err handling is not obvious.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 3f6c268e04ef..a229dd87c322 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -402,6 +402,11 @@ static int rnbd_srv_rdma_ev(void *priv,
 		return -EINVAL;
 	}
 
+	/*
+	 * Since ret is passed to rtrs to handle the failure case, we
+	 * just return 0 at the end otherwise callers in rtrs would call
+	 * send_io_resp_imm again to print redundant err message.
+	 */
 	rtrs_srv_resp_rdma(id, ret);
 	return 0;
 }
-- 
2.31.1

