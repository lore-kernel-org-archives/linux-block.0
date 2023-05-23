Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684B3C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjEWHzk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjEWHyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:54:35 -0400
Received: from out-55.mta0.migadu.com (out-55.mta0.migadu.com [IPv6:2001:41d0:1004:224b::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652EAE53
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:54:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684828419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d05xTiCU7Yz3Xd2o5GXv1m3iGY5f2vOzDgpL9GlrTVI=;
        b=bQqSoRF+6KUcelHTNsIzTpfNiHGtHfP+dlKuMYNs+dEwmA5CEHevZqVHhlrdosJplrbzbc
        orxhf1CdArAbVAsMFzCdATDpdbBaZIUYaFPXig7ihG2VSJAOr+PGoPVkNnSPpPraFnonby
        cO0djGYQdiqiUwI4WX6BaRSgAM0pCVs=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 01/10] block/rnbd: kill rnbd_flags_supported
Date:   Tue, 23 May 2023 15:53:22 +0800
Message-Id: <20230523075331.32250-2-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-1-guoqing.jiang@linux.dev>
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This routine is not called since added. Then the two flags
(RNBD_OP_LAST and RNBD_F_ALL) can be removed too after kill
rnbd_flags_supported.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-proto.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index da1d0542d7e2..84fd69844b7d 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -185,7 +185,6 @@ struct rnbd_msg_io {
 enum rnbd_io_flags {
 
 	/* Operations */
-
 	RNBD_OP_READ		= 0,
 	RNBD_OP_WRITE		= 1,
 	RNBD_OP_FLUSH		= 2,
@@ -193,15 +192,9 @@ enum rnbd_io_flags {
 	RNBD_OP_SECURE_ERASE	= 4,
 	RNBD_OP_WRITE_SAME	= 5,
 
-	RNBD_OP_LAST,
-
 	/* Flags */
-
 	RNBD_F_SYNC  = 1<<(RNBD_OP_BITS + 0),
 	RNBD_F_FUA   = 1<<(RNBD_OP_BITS + 1),
-
-	RNBD_F_ALL   = (RNBD_F_SYNC | RNBD_F_FUA)
-
 };
 
 static inline u32 rnbd_op(u32 flags)
@@ -214,21 +207,6 @@ static inline u32 rnbd_flags(u32 flags)
 	return flags & ~RNBD_OP_MASK;
 }
 
-static inline bool rnbd_flags_supported(u32 flags)
-{
-	u32 op;
-
-	op = rnbd_op(flags);
-	flags = rnbd_flags(flags);
-
-	if (op >= RNBD_OP_LAST)
-		return false;
-	if (flags & ~RNBD_F_ALL)
-		return false;
-
-	return true;
-}
-
 static inline blk_opf_t rnbd_to_bio_flags(u32 rnbd_opf)
 {
 	blk_opf_t bio_opf;
-- 
2.35.3

