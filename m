Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD18BC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 21:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A63D2082F
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 21:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A63D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeLJVfY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:35:24 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:57165 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeLJVfY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 16:35:24 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M5xDJ-1gYN9a39XH-007Skp; Mon, 10 Dec 2018 22:35:01 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtip32xx: avoid using semaphores
Date:   Mon, 10 Dec 2018 22:34:39 +0100
Message-Id: <20181210213459.1147671-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bAKGUqjSdfxw9cELQaqHA8DxRoZriOdQDSeLBEhTssFMoerCf3M
 O1FyQRHjoR+2gzIarvKFEikMF1jbKGKKknlQYmiaIxnUyhdYwiQQ8fIGeDBIN2ktGu+vM/W
 B0AV1PxsTWK3P41iPsG7vhMPwnUEOtcOJ/wuWNuMRSaybrAKj140+YQ7lYwo/Wo0+79jO6V
 7f4MxYWUHsS75CC1JAs+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tseO4L7P49I=:QblY4sSgrUoSAFVm+Djb/H
 THmKDHvccHngbjXF/5W3cpkCftKWWhg4CZeVIS4GmfwGd4fGMLq6pnWxN3dH6nz0KTRZ8O+QB
 tuNUdVCNbPfTaRjmOuvh2B8SM7zkajmudRq3Edt/jlMeSUx1ow4dG4KNGBojhFfhqe6d4W/NU
 U9VFtsQNFw7giezr15hgxcefP0E67yOMf1xGfFC/JB2WGwpWnvn5wujvSbASdArzUeYxqbmlm
 FVAYgVjc2o7oEG+LqVCVbwuGlKacN/Csvp/QwE/K5SMElPZPtm/gz7tFO/708nAf/GrrVxMeQ
 OyKDNdX9aAC2o7x1KyfVMoxWr2WyUL62LlI5Brjf3EWB94NKrWuiuPQ/DeyENeqokFRfcevjq
 bkCpwYNSgXuTs2aUnPgtfxBRvXC4v/xQ5FMXU/x/Dg90mtp+cwy2UuwolIBIMNH17dU0lsACn
 WshZeONdseUmfo7ynfiDAkLZrRUfVQOHVd72dI6vS+zQ/sd6tqNoPXTUZSL01TW650xcGWHbr
 xZ8bVJg0LU90iobRHYUpPKMpVUEAhpWEWIvTCMHTgjG+EORKiNIreFfbtvsofWOAcrtRY8Fad
 Co93/KDqx/X3j8IP0vmoOBRf011fC2HM2f1gFowIhEEe7Jch0rTv+6lQ7SeBsjmAu6a7PEIra
 tYW+td5AMt8Db7Cfa4omZP9yKuNZ28H3rnru0I5+x0vlW1Mhvhwf/iIcJGFIaKcJ6fy6x6vlo
 j+s4AjbWkjNrkTFc9YYWcjZMkHX3KK6Y0UVulA==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The "cmd_slot_unal" semaphore is never used in a blocking way
but only as an atomic counter. Change the code to using
atomic_dec_if_positive() as a better API.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 6 +++---
 drivers/block/mtip32xx/mtip32xx.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 2b0ac9d01e51..d7dc307d0cc8 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2680,7 +2680,7 @@ static void mtip_softirq_done_fn(struct request *rq)
 							cmd->direction);
 
 	if (unlikely(cmd->unaligned))
-		up(&dd->port->cmd_slot_unal);
+		atomic_inc(&dd->port->cmd_slot_unal);
 
 	blk_mq_end_request(rq, cmd->status);
 }
@@ -2990,7 +2990,7 @@ static int mtip_hw_init(struct driver_data *dd)
 	else
 		dd->unal_qdepth = 0;
 
-	sema_init(&dd->port->cmd_slot_unal, dd->unal_qdepth);
+	atomic_set(&dd->port->cmd_slot_unal, dd->unal_qdepth);
 
 	/* Spinlock to prevent concurrent issue */
 	for (i = 0; i < MTIP_MAX_SLOT_GROUPS; i++)
@@ -3533,7 +3533,7 @@ static bool mtip_check_unal_depth(struct blk_mq_hw_ctx *hctx,
 			cmd->unaligned = 1;
 	}
 
-	if (cmd->unaligned && down_trylock(&dd->port->cmd_slot_unal))
+	if (cmd->unaligned && atomic_dec_if_positive(&dd->port->cmd_slot_unal) >= 0)
 		return true;
 
 	return false;
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index c33f8c3d9fb4..abce25f27f57 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -433,8 +433,8 @@ struct mtip_port {
 	 */
 	unsigned long ic_pause_timer;
 
-	/* Semaphore to control queue depth of unaligned IOs */
-	struct semaphore cmd_slot_unal;
+	/* Counter to control queue depth of unaligned IOs */
+	atomic_t cmd_slot_unal;
 
 	/* Spinlock for working around command-issue bug. */
 	spinlock_t cmd_issue_lock[MTIP_MAX_SLOT_GROUPS];
-- 
2.20.0

