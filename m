Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39687C2D0E8
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CCF208FE
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgCaJly (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:41:54 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34106 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730375AbgCaJlx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:53 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f4NZ024510;
        Tue, 31 Mar 2020 11:41:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 03/23] floppy: use symbolic register names in the m68k port
Date:   Tue, 31 Mar 2020 11:40:34 +0200
Message-Id: <20200331094054.24441-4-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we can use FD_STATUS and FD_DATA instead of 4 or 5, let's do
this, and also use STATUS_DMA and STATUS_READY for the status bits.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/m68k/include/asm/floppy.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/include/asm/floppy.h b/arch/m68k/include/asm/floppy.h
index 2a6ce29b92aa..a4d0fea47c6b 100644
--- a/arch/m68k/include/asm/floppy.h
+++ b/arch/m68k/include/asm/floppy.h
@@ -211,26 +211,27 @@ asmlinkage irqreturn_t floppy_hardint(int irq, void *dev_id)
 		st=1;
 		for(lcount=virtual_dma_count, lptr=virtual_dma_addr;
 		    lcount; lcount--, lptr++) {
-			st=inb(virtual_dma_port+4) & 0xa0 ;
-			if(st != 0xa0)
+			st = inb(virtual_dma_port + FD_STATUS);
+			st &= STATUS_DMA | STATUS_READY;
+			if (st != (STATUS_DMA | STATUS_READY))
 				break;
 			if(virtual_dma_mode)
-				outb_p(*lptr, virtual_dma_port+5);
+				outb_p(*lptr, virtual_dma_port + FD_DATA);
 			else
-				*lptr = inb_p(virtual_dma_port+5);
+				*lptr = inb_p(virtual_dma_port + FD_DATA);
 		}
 
 		virtual_dma_count = lcount;
 		virtual_dma_addr = lptr;
-		st = inb(virtual_dma_port+4);
+		st = inb(virtual_dma_port + FD_STATUS);
 	}
 
 #ifdef TRACE_FLPY_INT
 	calls++;
 #endif
-	if(st == 0x20)
+	if (st == STATUS_DMA)
 		return IRQ_HANDLED;
-	if(!(st & 0x20)) {
+	if (!(st & STATUS_DMA)) {
 		virtual_dma_residue += virtual_dma_count;
 		virtual_dma_count=0;
 #ifdef TRACE_FLPY_INT
-- 
2.20.1

