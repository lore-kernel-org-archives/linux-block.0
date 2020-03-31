Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9B6C2D0E8
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197D72137B
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgCaJm0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:42:26 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34157 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbgCaJm0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:42:26 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f56P024514;
        Tue, 31 Mar 2020 11:41:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 07/23] floppy: use symbolic register names in the sparc64 port
Date:   Tue, 31 Mar 2020 11:40:38 +0200
Message-Id: <20200331094054.24441-8-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now by splitting the base address from the register index we can
use the symbolic register names instead of the hard-coded numeric
values.

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/sparc/include/asm/floppy_64.h | 59 ++++++++++++++++--------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index c0cf157e5b15..bd7847f2c64a 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -47,8 +47,9 @@ unsigned long fdc_status;
 static struct platform_device *floppy_op = NULL;
 
 struct sun_floppy_ops {
-	unsigned char	(*fd_inb) (unsigned long port);
-	void		(*fd_outb) (unsigned char value, unsigned long port);
+	unsigned char	(*fd_inb) (unsigned long port, unsigned int reg);
+	void		(*fd_outb) (unsigned char value, unsigned long base,
+				    unsigned int reg);
 	void		(*fd_enable_dma) (void);
 	void		(*fd_disable_dma) (void);
 	void		(*fd_set_dma_mode) (int);
@@ -62,8 +63,8 @@ struct sun_floppy_ops {
 
 static struct sun_floppy_ops sun_fdops;
 
-#define fd_inb(base, reg)         sun_fdops.fd_inb((base) + (reg))
-#define fd_outb(value, base, reg) sun_fdops.fd_outb(value, (base) + (reg))
+#define fd_inb(base, reg)         sun_fdops.fd_inb(base, reg)
+#define fd_outb(value, base, reg) sun_fdops.fd_outb(value, base, reg)
 #define fd_enable_dma()           sun_fdops.fd_enable_dma()
 #define fd_disable_dma()          sun_fdops.fd_disable_dma()
 #define fd_request_dma()          (0) /* nothing... */
@@ -97,42 +98,43 @@ static int sun_floppy_types[2] = { 0, 0 };
 /* No 64k boundary crossing problems on the Sparc. */
 #define CROSS_64KB(a,s) (0)
 
-static unsigned char sun_82077_fd_inb(unsigned long port)
+static unsigned char sun_82077_fd_inb(unsigned long base, unsigned int reg)
 {
 	udelay(5);
-	switch(port & 7) {
+	switch (reg) {
 	default:
-		printk("floppy: Asked to read unknown port %lx\n", port);
+		printk("floppy: Asked to read unknown port %lx\n", reg);
 		panic("floppy: Port bolixed.");
-	case 4: /* FD_STATUS */
+	case FD_STATUS:
 		return sbus_readb(&sun_fdc->status_82077) & ~STATUS_DMA;
-	case 5: /* FD_DATA */
+	case FD_DATA:
 		return sbus_readb(&sun_fdc->data_82077);
-	case 7: /* FD_DIR */
+	case FD_DIR:
 		/* XXX: Is DCL on 0x80 in sun4m? */
 		return sbus_readb(&sun_fdc->dir_82077);
 	}
 	panic("sun_82072_fd_inb: How did I get here?");
 }
 
-static void sun_82077_fd_outb(unsigned char value, unsigned long port)
+static void sun_82077_fd_outb(unsigned char value, unsigned long base,
+			      unsigned int reg)
 {
 	udelay(5);
-	switch(port & 7) {
+	switch (reg) {
 	default:
-		printk("floppy: Asked to write to unknown port %lx\n", port);
+		printk("floppy: Asked to write to unknown port %lx\n", reg);
 		panic("floppy: Port bolixed.");
-	case 2: /* FD_DOR */
+	case FD_DOR:
 		/* Happily, the 82077 has a real DOR register. */
 		sbus_writeb(value, &sun_fdc->dor_82077);
 		break;
-	case 5: /* FD_DATA */
+	case FD_DATA:
 		sbus_writeb(value, &sun_fdc->data_82077);
 		break;
-	case 7: /* FD_DCR */
+	case FD_DCR:
 		sbus_writeb(value, &sun_fdc->dcr_82077);
 		break;
-	case 4: /* FD_STATUS */
+	case FD_DSR:
 		sbus_writeb(value, &sun_fdc->status_82077);
 		break;
 	}
@@ -298,19 +300,21 @@ static struct sun_pci_dma_op sun_pci_dma_pending = { -1U, 0, 0, NULL};
 
 irqreturn_t floppy_interrupt(int irq, void *dev_id);
 
-static unsigned char sun_pci_fd_inb(unsigned long port)
+static unsigned char sun_pci_fd_inb(unsigned long base, unsigned int reg)
 {
 	udelay(5);
-	return inb(port);
+	return inb(base + reg);
 }
 
-static void sun_pci_fd_outb(unsigned char val, unsigned long port)
+static void sun_pci_fd_outb(unsigned char val, unsigned long base,
+			    unsigned int reg)
 {
 	udelay(5);
-	outb(val, port);
+	outb(val, base + reg);
 }
 
-static void sun_pci_fd_broken_outb(unsigned char val, unsigned long port)
+static void sun_pci_fd_broken_outb(unsigned char val, unsigned long base,
+				   unsigned int reg)
 {
 	udelay(5);
 	/*
@@ -320,16 +324,17 @@ static void sun_pci_fd_broken_outb(unsigned char val, unsigned long port)
 	 *      this does not hurt correct hardware like the AXmp.
 	 *      (Eddie, Sep 12 1998).
 	 */
-	if (port == ((unsigned long)sun_fdc) + 2) {
+	if (reg == FD_DOR) {
 		if (((val & 0x03) == sun_pci_broken_drive) && (val & 0x20)) {
 			val |= 0x10;
 		}
 	}
-	outb(val, port);
+	outb(val, base + reg);
 }
 
 #ifdef PCI_FDC_SWAP_DRIVES
-static void sun_pci_fd_lde_broken_outb(unsigned char val, unsigned long port)
+static void sun_pci_fd_lde_broken_outb(unsigned char val, unsigned long base,
+				       unsigned int reg)
 {
 	udelay(5);
 	/*
@@ -339,13 +344,13 @@ static void sun_pci_fd_lde_broken_outb(unsigned char val, unsigned long port)
 	 *      this does not hurt correct hardware like the AXmp.
 	 *      (Eddie, Sep 12 1998).
 	 */
-	if (port == ((unsigned long)sun_fdc) + 2) {
+	if (reg == FD_DOR) {
 		if (((val & 0x03) == sun_pci_broken_drive) && (val & 0x10)) {
 			val &= ~(0x03);
 			val |= 0x21;
 		}
 	}
-	outb(val, port);
+	outb(val, base + reg);
 }
 #endif /* PCI_FDC_SWAP_DRIVES */
 
-- 
2.20.1

