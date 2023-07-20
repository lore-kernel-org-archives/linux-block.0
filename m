Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9083EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 12:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjGTMQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 08:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGTMQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 08:16:03 -0400
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575532106
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 05:16:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689855359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1qUoKI3SbOAj4JugO0eFEKpo/XtZkaAZd4jHbDGRCXI=;
        b=UYRVGSJeMWgVT/Cmj35t2ZweiX0f74MUBaOSw4MLtDmMy3IiuQrHv8RU4qRm/+sTXZG3zj
        +eK1+VPGThdCpfSCGWbopKgw5Dw3dyzfnI+h4Dk0lnIiYvGH6rNedI6u3cchFohjzDfaRp
        UtcGfRKuKFeW1oGmtQWsxdDyRcpHit4=
From:   chengming.zhou@linux.dev
To:     tj@kernel.org, josef@toxicpanda.com
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH] blk-iocost: skip empty flush bio in iocost
Date:   Thu, 20 Jul 2023 20:14:41 +0800
Message-ID: <20230720121441.1408522-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The flush bio may have data, may have no data (empty flush), we couldn't
calculate cost for empty flush bio. So we'd better just skip it for now.

Another side effect is that empty flush bio's bio_end_sector() is 0, cause
iocg->cursor reset to 0, may break the cost calculation of other bios.

This isn't good enough, since flush bio still consume the device bandwidth,
but flush request is special, can be merged randomly in the flush state
machine, we don't know how to calculate cost for it for now.

Its completion time also has flaws, which may include the pre-flush or
post-flush completion time, but I don't know if we need to fix that and
how to fix it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6084a9519883..e735b3e9997c 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2516,6 +2516,10 @@ static void calc_vtime_cost_builtin(struct bio *bio, struct ioc_gq *iocg,
 	u64 seek_pages = 0;
 	u64 cost = 0;
 
+	/* Can't calculate cost for empty bio */
+	if (!bio->bi_iter.bi_size)
+		goto out;
+
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 		coef_seqio	= ioc->params.lcoefs[LCOEF_RSEQIO];
-- 
2.41.0

