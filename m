Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3563C433F5
	for <linux-block@archiver.kernel.org>; Sat, 21 May 2022 11:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbiEULMj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 May 2022 07:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242810AbiEULML (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 May 2022 07:12:11 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C22B2B26F;
        Sat, 21 May 2022 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8kYNFUV9Zcxq+xozkt4bW19kyeKPdHmTSaJ76s0D2PY=;
  b=rBnQigwpigXvemnKVHRMnppReKpXFazeFf/5iX9yAfpVBPclg5jRlHRr
   WFW5ZPV27eLCogs7SoZZv3mGlrGQZnY65EM0jit46xwR13WNcgT60XFjs
   WyB+dW77pjMeJ5ajTnp6Uqhp0DI6e0TOVUkSk2hDkBFUQTqyqtB6aAqLv
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727924"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:57 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: fix typo in comment
Date:   Sat, 21 May 2022 13:10:39 +0200
Message-Id: <20220521111145.81697-29-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 block/blk-mq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ed1869a305c4..ae116b755648 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1083,7 +1083,7 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
-	 * For a polled request, always complete locallly, it's pointless
+	 * For a polled request, always complete locally, it's pointless
 	 * to redirect the completion.
 	 */
 	if (rq->cmd_flags & REQ_POLLED)

