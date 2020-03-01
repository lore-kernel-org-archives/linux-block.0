Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF346C3F2D4
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 19:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2228246C0
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 19:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCAT5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 14:57:01 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32079 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgCAT5B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Mar 2020 14:57:01 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 021Ju5bo011205;
        Sun, 1 Mar 2020 20:56:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Ian Molton <spyro@f2s.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 5/6] floppy: separate the FDC's base address from its registers
Date:   Sun,  1 Mar 2020 20:55:54 +0100
Message-Id: <20200301195555.11154-6-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200301195555.11154-1-w@1wt.eu>
References: <20200301195555.11154-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FDC registers FD_STATUS, FD_DATA, FD_DOR, FD_DIR and FD_DCR used to be
defined relative to FD_IOPORT, which is the FDC's base address, itself
a macro depending on the "fdc" local or global variable.

This patch changes this so that the register macros above now only
reference the address offset, and that the FDC's address is explicitly
passed in each call to fd_inb() and fd_outb(), thus removing the macro.
With this change there is no more implicit usage of the local/global
"fdc" variable.

One place in the ARM code used to check if the port was equal to FD_DOR,
this was changed to testing the register by applying a mask to the port,
as was already done in the sparc code.

There are still occurrences of fd_inb() and fd_outb() in the PARISC
code and these ones remain unaffected since they already used to work
with a base address and a register offset.

The sparc, m68k and parisc code could now be slightly cleaned up to
benefit from the macro definitions above instead of the equivalent
hard-coded values.

Cc: Ian Molton <spyro@f2s.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm/include/asm/floppy.h |  2 +-
 drivers/block/floppy.c        |  9 ++++-----
 include/uapi/linux/fdreg.h    | 18 +++++-------------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
index 34ebd86..79fa327 100644
--- a/arch/arm/include/asm/floppy.h
+++ b/arch/arm/include/asm/floppy.h
@@ -12,7 +12,7 @@
 #define fd_outb(val,port)						\
 	do {								\
 		int new_val = (val);					\
-		if ((port) == (u32)FD_DOR) {				\
+		if (((port) & 7) == FD_DOR) {				\
 			if (new_val & 0xf0)				\
 				new_val = (new_val & 0x0c) |		\
 					  floppy_selects[new_val & 3];	\
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 250a451..4e43a7e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -171,7 +171,6 @@ static int print_unex = 1;
 #include <linux/kernel.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
-#define FDPATCHES
 #include <linux/fdreg.h>
 #include <linux/fd.h>
 #include <linux/hdreg.h>
@@ -594,14 +593,14 @@ static unsigned char fsector_t;	/* sector in track */
 static unsigned char in_sector_offset;	/* offset within physical sector,
 					 * expressed in units of 512 bytes */
 
-static inline unsigned char fdc_inb(int fdc, unsigned long addr)
+static inline unsigned char fdc_inb(int fdc, int reg)
 {
-	return fd_inb(addr);
+	return fd_inb(fdc_state[fdc].address + reg);
 }
 
-static inline void fdc_outb(unsigned char value, int fdc, unsigned long addr)
+static inline void fdc_outb(unsigned char value, int fdc, int reg)
 {
-	fd_outb(value, addr);
+	fd_outb(value, fdc_state[fdc].address + reg);
 }
 
 static inline bool drive_no_geom(int drive)
diff --git a/include/uapi/linux/fdreg.h b/include/uapi/linux/fdreg.h
index 5e2981d..1318881 100644
--- a/include/uapi/linux/fdreg.h
+++ b/include/uapi/linux/fdreg.h
@@ -7,26 +7,18 @@
  * Handbook", Sanches and Canton.
  */
 
-#ifdef FDPATCHES
-#define FD_IOPORT fdc_state[fdc].address
-#else
-/* It would be a lot saner just to force fdc_state[fdc].address to always
-   be set ! FIXME */
-#define FD_IOPORT 0x3f0
-#endif
-
 /* Fd controller regs. S&C, about page 340 */
-#define FD_STATUS	(4 + FD_IOPORT )
-#define FD_DATA		(5 + FD_IOPORT )
+#define FD_STATUS	4
+#define FD_DATA		5
 
 /* Digital Output Register */
-#define FD_DOR		(2 + FD_IOPORT )
+#define FD_DOR		2
 
 /* Digital Input Register (read) */
-#define FD_DIR		(7 + FD_IOPORT )
+#define FD_DIR		7
 
 /* Diskette Control Register (write)*/
-#define FD_DCR		(7 + FD_IOPORT )
+#define FD_DCR		7
 
 /* Bits of main status register */
 #define STATUS_BUSYMASK	0x0F		/* drive busy mask */
-- 
2.9.0

