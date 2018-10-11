Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38389 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbeJLCth (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Oct 2018 22:49:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id f29-v6so4899407pff.5
        for <linux-block@vger.kernel.org>; Thu, 11 Oct 2018 12:21:02 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, kernel-team@fb.com
Subject: [PATCH v2 05/11] amiflop: fold headers into C file
Date: Thu, 11 Oct 2018 12:20:45 -0700
Message-Id: <ec3301bfbf5ff683ec8e8fece0699848e0b00b81.1539284959.git.osandov@fb.com>
In-Reply-To: <cover.1539284959.git.osandov@fb.com>
References: <cover.1539284959.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

amifd.h and amifdreg.h are only used from amiflop.c, and they're pretty
small, so move the contents to amiflop.c and get rid of the .h files.
This is preparation for adding a struct blk_mq_tag_set to struct
amiga_floppy_struct.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/amiflop.c  | 123 ++++++++++++++++++++++++++++++++++++++-
 include/linux/amifd.h    |  63 --------------------
 include/linux/amifdreg.h |  82 --------------------------
 3 files changed, 120 insertions(+), 148 deletions(-)
 delete mode 100644 include/linux/amifd.h
 delete mode 100644 include/linux/amifdreg.h

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 3aaf6af3ec23..a7d6e6a9b12f 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -61,10 +61,8 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
-#include <linux/amifdreg.h>
-#include <linux/amifd.h>
 #include <linux/fs.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/elevator.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -86,6 +84,125 @@
  *  Defines
  */
 
+/*
+ * CIAAPRA bits (read only)
+ */
+
+#define DSKRDY      (0x1<<5)        /* disk ready when low */
+#define DSKTRACK0   (0x1<<4)        /* head at track zero when low */
+#define DSKPROT     (0x1<<3)        /* disk protected when low */
+#define DSKCHANGE   (0x1<<2)        /* low when disk removed */
+
+/*
+ * CIAAPRB bits (read/write)
+ */
+
+#define DSKMOTOR    (0x1<<7)        /* motor on when low */
+#define DSKSEL3     (0x1<<6)        /* select drive 3 when low */
+#define DSKSEL2     (0x1<<5)        /* select drive 2 when low */
+#define DSKSEL1     (0x1<<4)        /* select drive 1 when low */
+#define DSKSEL0     (0x1<<3)        /* select drive 0 when low */
+#define DSKSIDE     (0x1<<2)        /* side selection: 0 = upper, 1 = lower */
+#define DSKDIREC    (0x1<<1)        /* step direction: 0=in, 1=out (to trk 0) */
+#define DSKSTEP     (0x1)           /* pulse low to step head 1 track */
+
+/*
+ * DSKBYTR bits (read only)
+ */
+
+#define DSKBYT      (1<<15)         /* register contains valid byte when set */
+#define DMAON       (1<<14)         /* disk DMA enabled */
+#define DISKWRITE   (1<<13)         /* disk write bit in DSKLEN enabled */
+#define WORDEQUAL   (1<<12)         /* DSKSYNC register match when true */
+/* bits 7-0 are data */
+
+/*
+ * ADKCON/ADKCONR bits
+ */
+
+#ifndef SETCLR
+#define ADK_SETCLR      (1<<15)     /* control bit */
+#endif
+#define ADK_PRECOMP1    (1<<14)     /* precompensation selection */
+#define ADK_PRECOMP0    (1<<13)     /* 00=none, 01=140ns, 10=280ns, 11=500ns */
+#define ADK_MFMPREC     (1<<12)     /* 0=GCR precomp., 1=MFM precomp. */
+#define ADK_WORDSYNC    (1<<10)     /* enable DSKSYNC auto DMA */
+#define ADK_MSBSYNC     (1<<9)      /* when 1, enable sync on MSbit (for GCR) */
+#define ADK_FAST        (1<<8)      /* bit cell: 0=2us (GCR), 1=1us (MFM) */
+
+/*
+ * DSKLEN bits
+ */
+
+#define DSKLEN_DMAEN    (1<<15)
+#define DSKLEN_WRITE    (1<<14)
+
+/*
+ * INTENA/INTREQ bits
+ */
+
+#define DSKINDEX    (0x1<<4)        /* DSKINDEX bit */
+
+/*
+ * Misc
+ */
+
+#define MFM_SYNC    0x4489          /* standard MFM sync value */
+
+/* Values for FD_COMMAND */
+#define FD_RECALIBRATE		0x07	/* move to track 0 */
+#define FD_SEEK			0x0F	/* seek track */
+#define FD_READ			0xE6	/* read with MT, MFM, SKip deleted */
+#define FD_WRITE		0xC5	/* write with MT, MFM */
+#define FD_SENSEI		0x08	/* Sense Interrupt Status */
+#define FD_SPECIFY		0x03	/* specify HUT etc */
+#define FD_FORMAT		0x4D	/* format one track */
+#define FD_VERSION		0x10	/* get version code */
+#define FD_CONFIGURE		0x13	/* configure FIFO operation */
+#define FD_PERPENDICULAR	0x12	/* perpendicular r/w mode */
+
+#define FD_MAX_UNITS    4	/* Max. Number of drives */
+#define FLOPPY_MAX_SECTORS	22	/* Max. Number of sectors per track */
+
+struct fd_data_type {
+	char *name;		/* description of data type */
+	int sects;		/* sectors per track */
+	int (*read_fkt)(int);	/* read whole track */
+	void (*write_fkt)(int);	/* write whole track */
+};
+
+struct fd_drive_type {
+	unsigned long code;		/* code returned from drive */
+	char *name;			/* description of drive */
+	unsigned int tracks;	/* number of tracks */
+	unsigned int heads;		/* number of heads */
+	unsigned int read_size;	/* raw read size for one track */
+	unsigned int write_size;	/* raw write size for one track */
+	unsigned int sect_mult;	/* sectors and gap multiplier (HD = 2) */
+	unsigned int precomp1;	/* start track for precomp 1 */
+	unsigned int precomp2;	/* start track for precomp 2 */
+	unsigned int step_delay;	/* time (in ms) for delay after step */
+	unsigned int settle_time;	/* time to settle after dir change */
+	unsigned int side_time;	/* time needed to change sides */
+};
+
+struct amiga_floppy_struct {
+	struct fd_drive_type *type;	/* type of floppy for this unit */
+	struct fd_data_type *dtype;	/* type of floppy for this unit */
+	int track;			/* current track (-1 == unknown) */
+	unsigned char *trackbuf;	/* current track (kmaloc()'d */
+
+	int blocks;			/* total # blocks on disk */
+
+	int changed;			/* true when not known */
+	int disk;			/* disk in drive (-1 == unknown) */
+	int motor;			/* true when motor is at speed */
+	int busy;			/* true when drive is active */
+	int dirty;			/* true when trackbuf is not on disk */
+	int status;			/* current error code for unit */
+	struct gendisk *gendisk;
+};
+
 /*
  *  Error codes
  */
diff --git a/include/linux/amifd.h b/include/linux/amifd.h
deleted file mode 100644
index 202a77dbe46d..000000000000
--- a/include/linux/amifd.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _AMIFD_H
-#define _AMIFD_H
-
-/* Definitions for the Amiga floppy driver */
-
-#include <linux/fd.h>
-
-#define FD_MAX_UNITS    4	/* Max. Number of drives */
-#define FLOPPY_MAX_SECTORS	22	/* Max. Number of sectors per track */
-
-#ifndef ASSEMBLER
-
-struct fd_data_type {
-    char *name;			/* description of data type */
-    int sects;			/* sectors per track */
-#ifdef __STDC__
-    int (*read_fkt)(int);
-    void (*write_fkt)(int);
-#else
-    int (*read_fkt)();		/* read whole track */
-    void (*write_fkt)();		/* write whole track */
-#endif
-};
-
-/*
-** Floppy type descriptions
-*/
-
-struct fd_drive_type {
-    unsigned long code;		/* code returned from drive */
-    char *name;			/* description of drive */
-    unsigned int tracks;	/* number of tracks */
-    unsigned int heads;		/* number of heads */
-    unsigned int read_size;	/* raw read size for one track */
-    unsigned int write_size;	/* raw write size for one track */
-    unsigned int sect_mult;	/* sectors and gap multiplier (HD = 2) */
-    unsigned int precomp1;	/* start track for precomp 1 */
-    unsigned int precomp2;	/* start track for precomp 2 */
-    unsigned int step_delay;	/* time (in ms) for delay after step */
-    unsigned int settle_time;	/* time to settle after dir change */
-    unsigned int side_time;	/* time needed to change sides */
-};
-
-struct amiga_floppy_struct {
-    struct fd_drive_type *type;	/* type of floppy for this unit */
-    struct fd_data_type *dtype;	/* type of floppy for this unit */
-    int track;			/* current track (-1 == unknown) */
-    unsigned char *trackbuf;    /* current track (kmaloc()'d */
-
-    int blocks;			/* total # blocks on disk */
-
-    int changed;		/* true when not known */
-    int disk;			/* disk in drive (-1 == unknown) */
-    int motor;			/* true when motor is at speed */
-    int busy;			/* true when drive is active */
-    int dirty;			/* true when trackbuf is not on disk */
-    int status;			/* current error code for unit */
-    struct gendisk *gendisk;
-};
-#endif
-
-#endif
diff --git a/include/linux/amifdreg.h b/include/linux/amifdreg.h
deleted file mode 100644
index 9b514d05ec70..000000000000
--- a/include/linux/amifdreg.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_AMIFDREG_H
-#define _LINUX_AMIFDREG_H
-
-/*
-** CIAAPRA bits (read only)
-*/
-
-#define DSKRDY      (0x1<<5)        /* disk ready when low */
-#define DSKTRACK0   (0x1<<4)        /* head at track zero when low */
-#define DSKPROT     (0x1<<3)        /* disk protected when low */
-#define DSKCHANGE   (0x1<<2)        /* low when disk removed */
-
-/*
-** CIAAPRB bits (read/write)
-*/
-
-#define DSKMOTOR    (0x1<<7)        /* motor on when low */
-#define DSKSEL3     (0x1<<6)        /* select drive 3 when low */
-#define DSKSEL2     (0x1<<5)        /* select drive 2 when low */
-#define DSKSEL1     (0x1<<4)        /* select drive 1 when low */
-#define DSKSEL0     (0x1<<3)        /* select drive 0 when low */
-#define DSKSIDE     (0x1<<2)        /* side selection: 0 = upper, 1 = lower */
-#define DSKDIREC    (0x1<<1)        /* step direction: 0=in, 1=out (to trk 0) */
-#define DSKSTEP     (0x1)           /* pulse low to step head 1 track */
-
-/*
-** DSKBYTR bits (read only)
-*/
-
-#define DSKBYT      (1<<15)         /* register contains valid byte when set */
-#define DMAON       (1<<14)         /* disk DMA enabled */
-#define DISKWRITE   (1<<13)         /* disk write bit in DSKLEN enabled */
-#define WORDEQUAL   (1<<12)         /* DSKSYNC register match when true */
-/* bits 7-0 are data */
-
-/*
-** ADKCON/ADKCONR bits
-*/
-
-#ifndef SETCLR
-#define ADK_SETCLR      (1<<15)     /* control bit */
-#endif
-#define ADK_PRECOMP1    (1<<14)     /* precompensation selection */
-#define ADK_PRECOMP0    (1<<13)     /* 00=none, 01=140ns, 10=280ns, 11=500ns */
-#define ADK_MFMPREC     (1<<12)     /* 0=GCR precomp., 1=MFM precomp. */
-#define ADK_WORDSYNC    (1<<10)     /* enable DSKSYNC auto DMA */
-#define ADK_MSBSYNC     (1<<9)      /* when 1, enable sync on MSbit (for GCR) */
-#define ADK_FAST        (1<<8)      /* bit cell: 0=2us (GCR), 1=1us (MFM) */
- 
-/*
-** DSKLEN bits
-*/
-
-#define DSKLEN_DMAEN    (1<<15)
-#define DSKLEN_WRITE    (1<<14)
-
-/*
-** INTENA/INTREQ bits
-*/
-
-#define DSKINDEX    (0x1<<4)        /* DSKINDEX bit */
-
-/*
-** Misc
-*/
- 
-#define MFM_SYNC    0x4489          /* standard MFM sync value */
-
-/* Values for FD_COMMAND */
-#define FD_RECALIBRATE		0x07	/* move to track 0 */
-#define FD_SEEK			0x0F	/* seek track */
-#define FD_READ			0xE6	/* read with MT, MFM, SKip deleted */
-#define FD_WRITE		0xC5	/* write with MT, MFM */
-#define FD_SENSEI		0x08	/* Sense Interrupt Status */
-#define FD_SPECIFY		0x03	/* specify HUT etc */
-#define FD_FORMAT		0x4D	/* format one track */
-#define FD_VERSION		0x10	/* get version code */
-#define FD_CONFIGURE		0x13	/* configure FIFO operation */
-#define FD_PERPENDICULAR	0x12	/* perpendicular r/w mode */
-
-#endif /* _LINUX_AMIFDREG_H */
-- 
2.19.1
