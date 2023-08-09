Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3B9EB64DD
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 13:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjHINIy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 09:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHINIy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 09:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E793B10FB
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 06:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6181C63A25
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 13:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982CEC433C7;
        Wed,  9 Aug 2023 13:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691586532;
        bh=MScpwcjBz5TxXEBq166PZBm+5zcEUeryQRCV+AaqDcw=;
        h=Subject:From:To:Cc:Date:From;
        b=BLGfKZYPLqZX9WMbRJBNTmiOnPDQWTj+ee/MPvLKMvrsllXdb8paLJ/Jy7ppiaE8d
         G4NvUbkG/Kgb1WhbHkr1w9rBB2gZRiHkWoBTqztnXhuinq0Wgrpol8Pt2uRbsPxx10
         XB00YPGK3Kf3i9NbeG+qsiX3dkH4kDSjpEz8zEViZqKtdYT5BP8aBH30TbOHMRozuK
         +iN7cTvIiF7DdWJWeF/8W5IHoEuxlk3JEQP54w6IS1SclmULTGMGvCa96ej6QFYwz8
         wvHgHA5sTH395Q+XhQDlrKoUXYnevYCFh2DtSZJFLLqaNk3ZT7sGSbq9OzIhwiyRXD
         YawRVW2s+eI9A==
Subject: [PATCH RFC] block: Revert 615939a2ae73
From:   Chuck Lever <cel@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 09 Aug 2023 09:08:51 -0400
Message-ID: <169158653156.2034.8363987273532378512.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Even after commit 9f87fc4d72f5 ("block: queue data commands from the
flush state machine at the head"), I'm still seeing hangs on NFS
exports that reside on SATA devices.

Bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
submission path for post-flush requests"). I've tested reverting
that commit on several kernels from 0aa69d53ac7c ("Merge tag
'for-6.5/io_uring-2023-06-23' of git://git.kernel.dk/linux") to
v6.5-rc5, and it seems to address the problem.

I also confirmed that commit 9f87fc4d72f5 ("block: queue data
commands from the flush state machine at the head") is still
necessary.

There is still no root cause.

Fixes: 615939a2ae73 ("blk-mq: defer to the normal submission path for post-flush requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 block/blk-flush.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 8220517c2d67..e4d12f2c344c 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -437,17 +437,6 @@ bool blk_insert_flush(struct request *rq)
 		 * Queue for normal execution.
 		 */
 		return false;
-	case REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH:
-		/*
-		 * Initialize the flush fields and completion handler to trigger
-		 * the post flush, and then just pass the command on.
-		 */
-		blk_rq_init_flush(rq);
-		rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
-		spin_lock_irq(&fq->mq_flush_lock);
-		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
-		spin_unlock_irq(&fq->mq_flush_lock);
-		return false;
 	default:
 		/*
 		 * Mark the request as part of a flush sequence and submit it


