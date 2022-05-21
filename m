Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4589EC433EF
	for <linux-block@archiver.kernel.org>; Sat, 21 May 2022 11:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354813AbiEULMj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 May 2022 07:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiEULMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 May 2022 07:12:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFCC2B240;
        Sat, 21 May 2022 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z+UdviyqVJKaussspFyvgPoTQANAMyQBNyEo6pguiAk=;
  b=qboyWFjr2xXNmXsYGdh4lH1WCHL+5IgD1dPdAPDxvLJ7Iz/qwlQsUqyp
   w2e2+daaHuMKGt7lBtnNYIvOrLf3zyh0RfeF20482fRw85l7ihgDfDtxv
   vjpsCwHfp3TyyOnpMG9tSsTb0ow52dm6W5Z4TlYF700TmkSjWWqAcexoq
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727923"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:57 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtip32xx: fix typo in comment
Date:   Sat, 21 May 2022 13:10:38 +0200
Message-Id: <20220521111145.81697-28-Julia.Lawall@inria.fr>
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
 drivers/block/mtip32xx/mtip32xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 4fbaf0b4958b..27386a572ba4 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2729,7 +2729,7 @@ static int mtip_dma_alloc(struct driver_data *dd)
 {
 	struct mtip_port *port = dd->port;
 
-	/* Allocate dma memory for RX Fis, Identify, and Sector Bufffer */
+	/* Allocate dma memory for RX Fis, Identify, and Sector Buffer */
 	port->block1 =
 		dma_alloc_coherent(&dd->pdev->dev, BLOCK_DMA_ALLOC_SZ,
 					&port->block1_dma, GFP_KERNEL);

