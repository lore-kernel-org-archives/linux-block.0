Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7979FC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7482072E
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgCaJl7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:41:59 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34116 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730375AbgCaJl7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:59 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f4dp024511;
        Tue, 31 Mar 2020 11:41:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 04/23] floppy: use symbolic register names in the parisc port
Date:   Tue, 31 Mar 2020 11:40:35 +0200
Message-Id: <20200331094054.24441-5-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we can use FD_STATUS and FD_DATA instead of 4 or 5, let's do
this, and also use STATUS_DMA and STATUS_READY for the status bits.

Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/parisc/include/asm/floppy.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/include/asm/floppy.h b/arch/parisc/include/asm/floppy.h
index 1aebc23b7744..762cfe7778c0 100644
--- a/arch/parisc/include/asm/floppy.h
+++ b/arch/parisc/include/asm/floppy.h
@@ -75,27 +75,28 @@ static void floppy_hardint(int irq, void *dev_id, struct pt_regs * regs)
 		register char *lptr = virtual_dma_addr;
 
 		for (lcount = virtual_dma_count; lcount; lcount--) {
-			st = fd_inb(virtual_dma_port, 4) & 0xa0;
-			if (st != 0xa0) 
+			st = fd_inb(virtual_dma_port, FD_STATUS);
+			st &= STATUS_DMA | STATUS_READY;
+			if (st != (STATUS_DMA | STATUS_READY))
 				break;
 			if (virtual_dma_mode) {
-				fd_outb(*lptr, virtual_dma_port, 5);
+				fd_outb(*lptr, virtual_dma_port, FD_DATA);
 			} else {
-				*lptr = fd_inb(virtual_dma_port, 5);
+				*lptr = fd_inb(virtual_dma_port, FD_DATA);
 			}
 			lptr++;
 		}
 		virtual_dma_count = lcount;
 		virtual_dma_addr = lptr;
-		st = fd_inb(virtual_dma_port, 4);
+		st = fd_inb(virtual_dma_port, FD_STATUS);
 	}
 
 #ifdef TRACE_FLPY_INT
 	calls++;
 #endif
-	if (st == 0x20)
+	if (st == STATUS_DMA)
 		return;
-	if (!(st & 0x20)) {
+	if (!(st & STATUS_DMA)) {
 		virtual_dma_residue += virtual_dma_count;
 		virtual_dma_count = 0;
 #ifdef TRACE_FLPY_INT
-- 
2.20.1

