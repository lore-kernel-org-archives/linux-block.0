Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F0BC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6711420B1F
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgCaJmb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:42:31 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34158 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbgCaJmb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:42:31 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f4CG024508;
        Tue, 31 Mar 2020 11:41:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Matt Turner <mattst88@gmail.com>, Ian Molton <spyro@f2s.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>, x86@kernel.org
Subject: [PATCH 01/23] floppy: split the base port from the register in I/O accesses
Date:   Tue, 31 Mar 2020 11:40:32 +0200
Message-Id: <20200331094054.24441-2-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we have architecture-specific fd_inb() and fd_outb() functions
or macros, taking just a port which is in fact made of a base address and
a register. The base address is FDC-specific and derived from the local or
global "fdc" variable through the FD_IOPORT macro used in the base address
calculation.

This change splits this by explicitly passing the FDC's base address and
the register separately to fd_outb() and fd_inb(). It affects the
following archs:
  - x86, alpha, mips, powerpc, parisc, arm, m68k:
    simple remap of port -> base+reg

  - sparc32: use of reg only, since the base address was already masked
    out and the FDC controller is known from a static struct.

  - sparc64: like x86 for PCI, like sparc32 for 82077

Some archs use inline functions and others macros. This was not
unified in order to minimize the number of changes to review. For the
same reason checkpatch still spews a few warnings about things that
were already there before.

The parisc still uses hard-coded register values and could be cleaned up
by taking the register definitions.

The sparc per-controller inb/outb functions could further be refined
to explicitly take an FDC register instead of a port in argument but it
was not needed yet and may be cleaned later.

Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Ian Molton <spyro@f2s.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: x86@kernel.org
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/alpha/include/asm/floppy.h             |  4 ++--
 arch/arm/include/asm/floppy.h               |  8 ++++----
 arch/m68k/include/asm/floppy.h              | 12 ++++++------
 arch/mips/include/asm/mach-generic/floppy.h |  8 ++++----
 arch/mips/include/asm/mach-jazz/floppy.h    |  8 ++++----
 arch/parisc/include/asm/floppy.h            | 12 ++++++------
 arch/powerpc/include/asm/floppy.h           |  4 ++--
 arch/sparc/include/asm/floppy_32.h          |  4 ++--
 arch/sparc/include/asm/floppy_64.h          |  4 ++--
 arch/x86/include/asm/floppy.h               |  4 ++--
 drivers/block/floppy.c                      |  4 ++--
 11 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/alpha/include/asm/floppy.h b/arch/alpha/include/asm/floppy.h
index 942924756cf2..8dfdb3aa1d96 100644
--- a/arch/alpha/include/asm/floppy.h
+++ b/arch/alpha/include/asm/floppy.h
@@ -11,8 +11,8 @@
 #define __ASM_ALPHA_FLOPPY_H
 
 
-#define fd_inb(port)			inb_p(port)
-#define fd_outb(value,port)		outb_p(value,port)
+#define fd_inb(base, reg)		inb_p((base) + (reg))
+#define fd_outb(value, base, reg)	outb_p(value, (base) + (reg))
 
 #define fd_enable_dma()         enable_dma(FLOPPY_DMA)
 #define fd_disable_dma()        disable_dma(FLOPPY_DMA)
diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
index 79fa327238e8..e1cb04ed5008 100644
--- a/arch/arm/include/asm/floppy.h
+++ b/arch/arm/include/asm/floppy.h
@@ -9,20 +9,20 @@
 #ifndef __ASM_ARM_FLOPPY_H
 #define __ASM_ARM_FLOPPY_H
 
-#define fd_outb(val,port)						\
+#define fd_outb(val, base, reg)						\
 	do {								\
 		int new_val = (val);					\
-		if (((port) & 7) == FD_DOR) {				\
+		if ((reg) == FD_DOR) {					\
 			if (new_val & 0xf0)				\
 				new_val = (new_val & 0x0c) |		\
 					  floppy_selects[new_val & 3];	\
 			else						\
 				new_val &= 0x0c;			\
 		}							\
-		outb(new_val, (port));					\
+		outb(new_val, (base) + (reg));				\
 	} while(0)
 
-#define fd_inb(port)		inb((port))
+#define fd_inb(base, reg)	inb((base) + (reg))
 #define fd_request_irq()	request_irq(IRQ_FLOPPYDISK,floppy_interrupt,\
 					    0,"floppy",NULL)
 #define fd_free_irq()		free_irq(IRQ_FLOPPYDISK,NULL)
diff --git a/arch/m68k/include/asm/floppy.h b/arch/m68k/include/asm/floppy.h
index c3b9ad6732fc..2a6ce29b92aa 100644
--- a/arch/m68k/include/asm/floppy.h
+++ b/arch/m68k/include/asm/floppy.h
@@ -63,21 +63,21 @@ static __inline__ void release_dma_lock(unsigned long flags)
 }
 
 
-static __inline__ unsigned char fd_inb(int port)
+static __inline__ unsigned char fd_inb(int base, int reg)
 {
 	if(MACH_IS_Q40)
-		return inb_p(port);
+		return inb_p(base + reg);
 	else if(MACH_IS_SUN3X)
-		return sun3x_82072_fd_inb(port);
+		return sun3x_82072_fd_inb(base + reg);
 	return 0;
 }
 
-static __inline__ void fd_outb(unsigned char value, int port)
+static __inline__ void fd_outb(unsigned char value, int base, int reg)
 {
 	if(MACH_IS_Q40)
-		outb_p(value, port);
+		outb_p(value, base + reg);
 	else if(MACH_IS_SUN3X)
-		sun3x_82072_fd_outb(value, port);
+		sun3x_82072_fd_outb(value, base + reg);
 }
 
 
diff --git a/arch/mips/include/asm/mach-generic/floppy.h b/arch/mips/include/asm/mach-generic/floppy.h
index 9ec2f6a5200b..e3f446d54827 100644
--- a/arch/mips/include/asm/mach-generic/floppy.h
+++ b/arch/mips/include/asm/mach-generic/floppy.h
@@ -26,14 +26,14 @@
 /*
  * How to access the FDC's registers.
  */
-static inline unsigned char fd_inb(unsigned int port)
+static inline unsigned char fd_inb(unsigned int base, unsigned int reg)
 {
-	return inb_p(port);
+	return inb_p(base + reg);
 }
 
-static inline void fd_outb(unsigned char value, unsigned int port)
+static inline void fd_outb(unsigned char value, unsigned int base, unsigned int reg)
 {
-	outb_p(value, port);
+	outb_p(value, base + reg);
 }
 
 /*
diff --git a/arch/mips/include/asm/mach-jazz/floppy.h b/arch/mips/include/asm/mach-jazz/floppy.h
index 4b86c88a03b7..095000c290e5 100644
--- a/arch/mips/include/asm/mach-jazz/floppy.h
+++ b/arch/mips/include/asm/mach-jazz/floppy.h
@@ -17,19 +17,19 @@
 #include <asm/jazzdma.h>
 #include <asm/pgtable.h>
 
-static inline unsigned char fd_inb(unsigned int port)
+static inline unsigned char fd_inb(unsigned int base, unsigned int reg)
 {
 	unsigned char c;
 
-	c = *(volatile unsigned char *) port;
+	c = *(volatile unsigned char *) (base + reg);
 	udelay(1);
 
 	return c;
 }
 
-static inline void fd_outb(unsigned char value, unsigned int port)
+static inline void fd_outb(unsigned char value, unsigned int base, unsigned int reg)
 {
-	*(volatile unsigned char *) port = value;
+	*(volatile unsigned char *) (base + reg) = value;
 }
 
 /*
diff --git a/arch/parisc/include/asm/floppy.h b/arch/parisc/include/asm/floppy.h
index 09b6f4c1687e..1aebc23b7744 100644
--- a/arch/parisc/include/asm/floppy.h
+++ b/arch/parisc/include/asm/floppy.h
@@ -29,8 +29,8 @@
 #define CSW fd_routine[can_use_virtual_dma & 1]
 
 
-#define fd_inb(port)			readb(port)
-#define fd_outb(value, port)		writeb(value, port)
+#define fd_inb(base, reg)		readb((base) + (reg))
+#define fd_outb(value, base, reg)	writeb(value, (base) + (reg))
 
 #define fd_request_dma()        CSW._request_dma(FLOPPY_DMA,"floppy")
 #define fd_free_dma()           CSW._free_dma(FLOPPY_DMA)
@@ -75,19 +75,19 @@ static void floppy_hardint(int irq, void *dev_id, struct pt_regs * regs)
 		register char *lptr = virtual_dma_addr;
 
 		for (lcount = virtual_dma_count; lcount; lcount--) {
-			st = fd_inb(virtual_dma_port+4) & 0xa0 ;
+			st = fd_inb(virtual_dma_port, 4) & 0xa0;
 			if (st != 0xa0) 
 				break;
 			if (virtual_dma_mode) {
-				fd_outb(*lptr, virtual_dma_port+5);
+				fd_outb(*lptr, virtual_dma_port, 5);
 			} else {
-				*lptr = fd_inb(virtual_dma_port+5);
+				*lptr = fd_inb(virtual_dma_port, 5);
 			}
 			lptr++;
 		}
 		virtual_dma_count = lcount;
 		virtual_dma_addr = lptr;
-		st = fd_inb(virtual_dma_port+4);
+		st = fd_inb(virtual_dma_port, 4);
 	}
 
 #ifdef TRACE_FLPY_INT
diff --git a/arch/powerpc/include/asm/floppy.h b/arch/powerpc/include/asm/floppy.h
index 167c44b58848..ed467eb0c4c8 100644
--- a/arch/powerpc/include/asm/floppy.h
+++ b/arch/powerpc/include/asm/floppy.h
@@ -13,8 +13,8 @@
 
 #include <asm/machdep.h>
 
-#define fd_inb(port)		inb_p(port)
-#define fd_outb(value,port)	outb_p(value,port)
+#define fd_inb(base, reg)		inb_p((base) + (reg))
+#define fd_outb(value, base, reg)	outb_p(value, (base) + (reg))
 
 #define fd_enable_dma()         enable_dma(FLOPPY_DMA)
 #define fd_disable_dma()	 fd_ops->_disable_dma(FLOPPY_DMA)
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index b519acf4383d..4d08df4f4deb 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -59,8 +59,8 @@ struct sun_floppy_ops {
 
 static struct sun_floppy_ops sun_fdops;
 
-#define fd_inb(port)              sun_fdops.fd_inb(port)
-#define fd_outb(value,port)       sun_fdops.fd_outb(value,port)
+#define fd_inb(base, reg)         sun_fdops.fd_inb(reg)
+#define fd_outb(value, base, reg) sun_fdops.fd_outb(value, reg)
 #define fd_enable_dma()           sun_fd_enable_dma()
 #define fd_disable_dma()          sun_fd_disable_dma()
 #define fd_request_dma()          (0) /* nothing... */
diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index 3729fc35ba83..c0cf157e5b15 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -62,8 +62,8 @@ struct sun_floppy_ops {
 
 static struct sun_floppy_ops sun_fdops;
 
-#define fd_inb(port)              sun_fdops.fd_inb(port)
-#define fd_outb(value,port)       sun_fdops.fd_outb(value,port)
+#define fd_inb(base, reg)         sun_fdops.fd_inb((base) + (reg))
+#define fd_outb(value, base, reg) sun_fdops.fd_outb(value, (base) + (reg))
 #define fd_enable_dma()           sun_fdops.fd_enable_dma()
 #define fd_disable_dma()          sun_fdops.fd_disable_dma()
 #define fd_request_dma()          (0) /* nothing... */
diff --git a/arch/x86/include/asm/floppy.h b/arch/x86/include/asm/floppy.h
index 7ec59edde154..20088cb08f5e 100644
--- a/arch/x86/include/asm/floppy.h
+++ b/arch/x86/include/asm/floppy.h
@@ -31,8 +31,8 @@
 #define CSW fd_routine[can_use_virtual_dma & 1]
 
 
-#define fd_inb(port)		inb_p(port)
-#define fd_outb(value, port)	outb_p(value, port)
+#define fd_inb(base, reg)		inb_p((base) + (reg))
+#define fd_outb(value, base, reg)	outb_p(value, (base) + (reg))
 
 #define fd_request_dma()	CSW._request_dma(FLOPPY_DMA, "floppy")
 #define fd_free_dma()		CSW._free_dma(FLOPPY_DMA)
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c3daa64cb52c..1cda39098b07 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -595,12 +595,12 @@ static unsigned char in_sector_offset;	/* offset within physical sector,
 
 static inline unsigned char fdc_inb(int fdc, int reg)
 {
-	return fd_inb(fdc_state[fdc].address + reg);
+	return fd_inb(fdc_state[fdc].address, reg);
 }
 
 static inline void fdc_outb(unsigned char value, int fdc, int reg)
 {
-	fd_outb(value, fdc_state[fdc].address + reg);
+	fd_outb(value, fdc_state[fdc].address, reg);
 }
 
 static inline bool drive_no_geom(int drive)
-- 
2.20.1

