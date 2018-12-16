Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B24BC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 09:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BFD217FB
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 09:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbeLPJfe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 04:35:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:45021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbeLPJfe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 04:35:34 -0500
Received: from localhost.localdomain ([113.87.89.150]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MTwYX-1gzF0l2kyn-00Qh2z; Sun, 16 Dec 2018 10:35:31 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: loop: check error using IS_ERR instead of IS_ERR_OR_NULL in loop_add()
Date:   Sun, 16 Dec 2018 17:35:00 +0800
Message-Id: <20181216093500.25023-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:hzJx1Kv9nzQ/oDGnskYeLLrdijeHG6DTk3x/rvKqfJu0nogiehO
 G5HeS/xZ184Txi5UZTb+bYFIFyQZepSkejeSh4wI8zC4hwIeKzjFY9TJSapkftvkXTNj08I
 6wj/epcMLgrDEX3xEl1wPE7oxZl7paJ79me94VYIsNowzzGEm+OeedIl9/I5UN+FJaMVjCS
 lmrUejPWcZMGlk2eVZHwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HWZQH5K48hU=:nLkSNvuygCmqqZktOTnZm5
 XRM6BsBeyicSqktEIQHHlaJVGlRFk7Tuc2Kp+ORpTLCHck1dso/foawqaZJVaVLSjdtI31oWe
 yTnZ4431Qi0miTvr+malUQ/ICnDrIT6Yq4+WEKhHiJZqGm9FasdkZddWVe+Az/gvem1QPivTs
 eo12i5jv9rJI/OvzTUsM4SoPpgh61B0arm1aodzNDUaV/hOLehOPkJHCX1kNwESrt3DB6sNqk
 mAP9uiSl8JtBT5FackapdksLZiekiv6fx8Ka3+gOVFuwYrKdrAnGsU1iaVo8Izi3Y7cRCy8Wz
 Sf5joJRlX25RzfS3eNZBVSXOzYg4XnNusL3v/FY0x1SZdWHoK3onxYFcYItUq5HhbXXrjJFvL
 zz+F4Z0vD9G867ggCVXJn/fF7YHHfqUX0+rY7xrDgQJjSG9k940noQF2VkR33s6MDhLLzlHbK
 Dw+1DjAibZdr76RcH6V+kpFOQ5WDeiJfsUj5U26rglsYj0P9P2HGduNMbkJKrLhCY71Dkg1ml
 oh9q4VaTPXx5U2ccUVvnB/dr/JkCYvtVYhna4ipyS8bqbQDlSJ75KRafkYb5atHz692Tp6314
 gpiaY77Yz0kkfyirQYK9KWDInLOUEkUyTWI79wGojuDSGh3LjdE7tlR+rh9JqTG2Xe9ruVnVC
 2bJHlAN8VbonLNDmHugGunAs/FxY4Qfm3wYvqMH8sO/4Nto9sPJlmehbzS/LpDWrR47d8Yzez
 FZ96HkBxiXGEoNVZyzVyaHw8yqicWQwhYZ0odT9DD+QgeQ8xRDTKJAmeAjK6MiEUcazim18ZK
 UdpCrEaTpiLmr3gGBzrNneY+L3N8ilVqFQ2TPZlhgKqT3NWr0addOYDuqqNlo0lpaDx2queN+
 oamghU4BoCnikQ50CsO+LJHVhFD1SWkTeRN4BjbtQ=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_init_queue() will not return NULL pointer to its caller,
so it's better to replace IS_ERR_OR_NULL using IS_ERR in loop_add().

If in the future things change to check NULL pointer inside loop_add(),
we should return -ENOMEM as return code instead of PTR_ERR(NULL).

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb0cc8685076..849a48120cca 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1853,7 +1853,7 @@ static int loop_add(struct loop_device **l, int i)
 		goto out_free_idr;
 
 	lo->lo_queue = blk_mq_init_queue(&lo->tag_set);
-	if (IS_ERR_OR_NULL(lo->lo_queue)) {
+	if (IS_ERR(lo->lo_queue)) {
 		err = PTR_ERR(lo->lo_queue);
 		goto out_cleanup_tags;
 	}
-- 
2.17.2

