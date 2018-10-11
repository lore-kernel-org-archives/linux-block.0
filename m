Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com
Subject: [PATCH v2 08/11] ataflop: fold headers into C file
Date: Thu, 11 Oct 2018 12:20:48 -0700
Message-Id: <11626464bab0d9607d9916c7a4dd729e4204b9aa.1539284959.git.osandov@fb.com>
In-Reply-To: <cover.1539284959.git.osandov@fb.com>
References: <cover.1539284959.git.osandov@fb.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

atafd.h and atafdreg.h are only used from ataflop.c, so merge them in
there.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 arch/m68k/include/asm/atafd.h    | 13 -----
 arch/m68k/include/asm/atafdreg.h | 80 ------------------------------
 drivers/block/ataflop.c          | 83 +++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 95 deletions(-)
 delete mode 100644 arch/m68k/include/asm/atafd.h
 delete mode 100644 arch/m68k/include/asm/atafdreg.h

diff --git a/arch/m68k/include/asm/atafd.h b/arch/m68k/include/asm/atafd.h
deleted file mode 100644
index ad7014cad633..000000000000
--- a/arch/m68k/include/asm/atafd.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_M68K_FD_H
-#define _ASM_M68K_FD_H
-
-/* Definitions for the Atari Floppy driver */
-
-struct atari_format_descr {
-    int track;			/* to be formatted */
-    int head;			/*   ""     ""     */
-    int sect_offset;		/* offset of first sector */
-};
-
-#endif
diff --git a/arch/m68k/include/asm/atafdreg.h b/arch/m68k/include/asm/atafdreg.h
deleted file mode 100644
index c31b4919ed2d..000000000000
--- a/arch/m68k/include/asm/atafdreg.h
+++ /dev/null
@@ -1,80 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_FDREG_H
-#define _LINUX_FDREG_H
-
-/*
-** WD1772 stuff
- */
-
-/* register codes */
-
-#define FDCSELREG_STP   (0x80)   /* command/status register */
-#define FDCSELREG_TRA   (0x82)   /* track register */
-#define FDCSELREG_SEC   (0x84)   /* sector register */
-#define FDCSELREG_DTA   (0x86)   /* data register */
-
-/* register names for FDC_READ/WRITE macros */
-
-#define FDCREG_CMD		0
-#define FDCREG_STATUS	0
-#define FDCREG_TRACK	2
-#define FDCREG_SECTOR	4
-#define FDCREG_DATA		6
-
-/* command opcodes */
-
-#define FDCCMD_RESTORE  (0x00)   /*  -                   */
-#define FDCCMD_SEEK     (0x10)   /*   |                  */
-#define FDCCMD_STEP     (0x20)   /*   |  TYP 1 Commands  */
-#define FDCCMD_STIN     (0x40)   /*   |                  */
-#define FDCCMD_STOT     (0x60)   /*  -                   */
-#define FDCCMD_RDSEC    (0x80)   /*  -   TYP 2 Commands  */
-#define FDCCMD_WRSEC    (0xa0)   /*  -          "        */
-#define FDCCMD_RDADR    (0xc0)   /*  -                   */
-#define FDCCMD_RDTRA    (0xe0)   /*   |  TYP 3 Commands  */
-#define FDCCMD_WRTRA    (0xf0)   /*  -                   */
-#define FDCCMD_FORCI    (0xd0)   /*  -   TYP 4 Command   */
-
-/* command modifier bits */
-
-#define FDCCMDADD_SR6   (0x00)   /* step rate settings */
-#define FDCCMDADD_SR12  (0x01)
-#define FDCCMDADD_SR2   (0x02)
-#define FDCCMDADD_SR3   (0x03)
-#define FDCCMDADD_V     (0x04)   /* verify */
-#define FDCCMDADD_H     (0x08)   /* wait for spin-up */
-#define FDCCMDADD_U     (0x10)   /* update track register */
-#define FDCCMDADD_M     (0x10)   /* multiple sector access */
-#define FDCCMDADD_E     (0x04)   /* head settling flag */
-#define FDCCMDADD_P     (0x02)   /* precompensation off */
-#define FDCCMDADD_A0    (0x01)   /* DAM flag */
-
-/* status register bits */
-
-#define	FDCSTAT_MOTORON	(0x80)   /* motor on */
-#define	FDCSTAT_WPROT	(0x40)   /* write protected (FDCCMD_WR*) */
-#define	FDCSTAT_SPINUP	(0x20)   /* motor speed stable (Type I) */
-#define	FDCSTAT_DELDAM	(0x20)   /* sector has deleted DAM (Type II+III) */
-#define	FDCSTAT_RECNF	(0x10)   /* record not found */
-#define	FDCSTAT_CRC		(0x08)   /* CRC error */
-#define	FDCSTAT_TR00	(0x04)   /* Track 00 flag (Type I) */
-#define	FDCSTAT_LOST	(0x04)   /* Lost Data (Type II+III) */
-#define	FDCSTAT_IDX		(0x02)   /* Index status (Type I) */
-#define	FDCSTAT_DRQ		(0x02)   /* DRQ status (Type II+III) */
-#define	FDCSTAT_BUSY	(0x01)   /* FDC is busy */
-
-
-/* PSG Port A Bit Nr 0 .. Side Sel .. 0 -> Side 1  1 -> Side 2 */
-#define DSKSIDE     (0x01)
-
-#define DSKDRVNONE  (0x06)
-#define DSKDRV0     (0x02)
-#define DSKDRV1     (0x04)
-
-/* step rates */
-#define	FDCSTEP_6	0x00
-#define	FDCSTEP_12	0x01
-#define	FDCSTEP_2	0x02
-#define	FDCSTEP_3	0x03
-
-#endif
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index dfb2c2622e5a..17df631c5d85 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -71,8 +71,6 @@
 #include <linux/completion.h>
 #include <linux/wait.h>
 
-#include <asm/atafd.h>
-#include <asm/atafdreg.h>
 #include <asm/atariints.h>
 #include <asm/atari_stdma.h>
 #include <asm/atari_stram.h>
@@ -85,6 +83,87 @@ static DEFINE_MUTEX(ataflop_mutex);
 static struct request *fd_request;
 static int fdc_queue;
 
+/*
+ * WD1772 stuff
+ */
+
+/* register codes */
+
+#define FDCSELREG_STP   (0x80)   /* command/status register */
+#define FDCSELREG_TRA   (0x82)   /* track register */
+#define FDCSELREG_SEC   (0x84)   /* sector register */
+#define FDCSELREG_DTA   (0x86)   /* data register */
+
+/* register names for FDC_READ/WRITE macros */
+
+#define FDCREG_CMD		0
+#define FDCREG_STATUS	0
+#define FDCREG_TRACK	2
+#define FDCREG_SECTOR	4
+#define FDCREG_DATA		6
+
+/* command opcodes */
+
+#define FDCCMD_RESTORE  (0x00)   /*  -                   */
+#define FDCCMD_SEEK     (0x10)   /*   |                  */
+#define FDCCMD_STEP     (0x20)   /*   |  TYP 1 Commands  */
+#define FDCCMD_STIN     (0x40)   /*   |                  */
+#define FDCCMD_STOT     (0x60)   /*  -                   */
+#define FDCCMD_RDSEC    (0x80)   /*  -   TYP 2 Commands  */
+#define FDCCMD_WRSEC    (0xa0)   /*  -          "        */
+#define FDCCMD_RDADR    (0xc0)   /*  -                   */
+#define FDCCMD_RDTRA    (0xe0)   /*   |  TYP 3 Commands  */
+#define FDCCMD_WRTRA    (0xf0)   /*  -                   */
+#define FDCCMD_FORCI    (0xd0)   /*  -   TYP 4 Command   */
+
+/* command modifier bits */
+
+#define FDCCMDADD_SR6   (0x00)   /* step rate settings */
+#define FDCCMDADD_SR12  (0x01)
+#define FDCCMDADD_SR2   (0x02)
+#define FDCCMDADD_SR3   (0x03)
+#define FDCCMDADD_V     (0x04)   /* verify */
+#define FDCCMDADD_H     (0x08)   /* wait for spin-up */
+#define FDCCMDADD_U     (0x10)   /* update track register */
+#define FDCCMDADD_M     (0x10)   /* multiple sector access */
+#define FDCCMDADD_E     (0x04)   /* head settling flag */
+#define FDCCMDADD_P     (0x02)   /* precompensation off */
+#define FDCCMDADD_A0    (0x01)   /* DAM flag */
+
+/* status register bits */
+
+#define	FDCSTAT_MOTORON	(0x80)   /* motor on */
+#define	FDCSTAT_WPROT	(0x40)   /* write protected (FDCCMD_WR*) */
+#define	FDCSTAT_SPINUP	(0x20)   /* motor speed stable (Type I) */
+#define	FDCSTAT_DELDAM	(0x20)   /* sector has deleted DAM (Type II+III) */
+#define	FDCSTAT_RECNF	(0x10)   /* record not found */
+#define	FDCSTAT_CRC		(0x08)   /* CRC error */
+#define	FDCSTAT_TR00	(0x04)   /* Track 00 flag (Type I) */
+#define	FDCSTAT_LOST	(0x04)   /* Lost Data (Type II+III) */
+#define	FDCSTAT_IDX		(0x02)   /* Index status (Type I) */
+#define	FDCSTAT_DRQ		(0x02)   /* DRQ status (Type II+III) */
+#define	FDCSTAT_BUSY	(0x01)   /* FDC is busy */
+
+
+/* PSG Port A Bit Nr 0 .. Side Sel .. 0 -> Side 1  1 -> Side 2 */
+#define DSKSIDE     (0x01)
+
+#define DSKDRVNONE  (0x06)
+#define DSKDRV0     (0x02)
+#define DSKDRV1     (0x04)
+
+/* step rates */
+#define	FDCSTEP_6	0x00
+#define	FDCSTEP_12	0x01
+#define	FDCSTEP_2	0x02
+#define	FDCSTEP_3	0x03
+
+struct atari_format_descr {
+	int track;		/* to be formatted */
+	int head;		/*   ""     ""     */
+	int sect_offset;	/* offset of first sector */
+};
+
 /* Disk types: DD, HD, ED */
 static struct atari_disk_type {
 	const char	*name;
-- 
2.19.1
