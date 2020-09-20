Return-Path: <SRS0=iZfY=C5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E4C43469
	for <linux-block@archiver.kernel.org>; Sun, 20 Sep 2020 12:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDC820EDD
	for <linux-block@archiver.kernel.org>; Sun, 20 Sep 2020 12:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgITMQ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Sep 2020 08:16:26 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:33994 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbgITMQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Sep 2020 08:16:24 -0400
X-IronPort-AV: E=Sophos;i="5.77,282,1596492000"; 
   d="scan'208";a="468612192"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 20 Sep 2020 14:08:58 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] block: drop double zeroing
Date:   Sun, 20 Sep 2020 13:26:18 +0200
Message-Id: <1600601186-7420-7-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sg_init_table zeroes its first argument, so the allocation of that argument
doesn't have to.

the semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
@@

x =
- kzalloc
+ kmalloc
 (...)
...
sg_init_table(x,...)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 block/bsg-lib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/block/bsg-lib.c b/block/bsg-lib.c
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -207,7 +207,7 @@ static int bsg_map_buffer(struct bsg_buf
 
 	BUG_ON(!req->nr_phys_segments);
 
-	buf->sg_list = kzalloc(sz, GFP_KERNEL);
+	buf->sg_list = kmalloc(sz, GFP_KERNEL);
 	if (!buf->sg_list)
 		return -ENOMEM;
 	sg_init_table(buf->sg_list, req->nr_phys_segments);

