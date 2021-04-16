Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A82CC433ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 08:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA54C611AB
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 08:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhDPIf6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:35:58 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]:35354 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbhDPIf6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 04:35:58 -0400
Received: by mail-qv1-f41.google.com with SMTP id x27so13077345qvd.2;
        Fri, 16 Apr 2021 01:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=remU4wRFvBJsWsuq7KZfs4sBz1FR2GIMrE8lrIkidqs=;
        b=E/H+GfncvwYFFZCbjteo+fpkN54UMXcuYt9VIL4sxP6NgGTgKlJZN/VhPhW9zZpWiR
         k5SPmWlB0SlBtUeKvfmlSiIO+EPRDxsNqWmYfXngSk8rxBfV0ujKRzpYLGfO6XxjGLR4
         JTvYcmGinzPrYBbdrFCUy5Z762b1vlGus1uMQjYNJvN4zxZnJDVFnel8mjPVj9+rXPb1
         PvP4vSdCDDkvdwjXVUY9hJY/PrOdHn8SjqL4iN7q8SC7b6eowL+Y5FYRj11NGnEi5wkX
         s4LLINB3KIfP7G5NrJpvih7JMEifvOqkmvTv1lKRPUV7uwWuG2ls+96I+53LETgORfeU
         /mmA==
X-Gm-Message-State: AOAM533H1943FMQbo2eao7z9q+MHO0nHekNVhRuZarUv5R4CHNizKJPU
        YrDApAV4LeEZKhFzChygkyAv+KtDcCeYpg==
X-Google-Smtp-Source: ABdhPJxApfwUbxH5p8Jfz6ceyi9z6xn1U5csu89vGB2EVKYsSe/j2ReIwdkV85/tC04boxzwZgdlvw==
X-Received: by 2002:a0c:e842:: with SMTP id l2mr7188459qvo.21.1618562133541;
        Fri, 16 Apr 2021 01:35:33 -0700 (PDT)
Received: from black.ru.oracle.com (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id k17sm3363778qtp.26.2021.04.16.01.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:35:33 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] floppy: cleanups: remove trailing whitespaces
Date:   Fri, 16 Apr 2021 11:34:45 +0300
Message-Id: <20210416083449.72700-2-efremov@linux.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416083449.72700-1-efremov@linux.com>
References: <20210416083449.72700-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cleanup trailing whitespaces as checkpatch.pl suggests.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 include/uapi/linux/fd.h | 46 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/uapi/linux/fd.h b/include/uapi/linux/fd.h
index 8b80c63b971c..7022e3413dbc 100644
--- a/include/uapi/linux/fd.h
+++ b/include/uapi/linux/fd.h
@@ -49,11 +49,11 @@ struct floppy_struct {
 #define FDCLRPRM _IO(2, 0x41)
 /* clear user-defined parameters */
 
-#define FDSETPRM _IOW(2, 0x42, struct floppy_struct) 
+#define FDSETPRM _IOW(2, 0x42, struct floppy_struct)
 #define FDSETMEDIAPRM FDSETPRM
 /* set user-defined parameters for current media */
 
-#define FDDEFPRM _IOW(2, 0x43, struct floppy_struct) 
+#define FDDEFPRM _IOW(2, 0x43, struct floppy_struct)
 #define FDGETPRM _IOR(2, 0x04, struct floppy_struct)
 #define FDDEFMEDIAPRM FDDEFPRM
 #define FDGETMEDIAPRM FDGETPRM
@@ -65,7 +65,7 @@ struct floppy_struct {
 /* issue/don't issue kernel messages on media type change */
 
 
-/* 
+/*
  * Formatting (obsolete)
  */
 #define FD_FILL_BYTE 0xF6 /* format fill byte. */
@@ -126,13 +126,13 @@ typedef char floppy_drive_name[16];
  */
 struct floppy_drive_params {
 	signed char cmos;		/* CMOS type */
-	
-	/* Spec2 is (HLD<<1 | ND), where HLD is head load time (1=2ms, 2=4 ms 
+
+	/* Spec2 is (HLD<<1 | ND), where HLD is head load time (1=2ms, 2=4 ms
 	 * etc) and ND is set means no DMA. Hardcoded to 6 (HLD=6ms, use DMA).
 	 */
 	unsigned long max_dtr;		/* Step rate, usec */
 	unsigned long hlt;     		/* Head load/settle time, msec */
-	unsigned long hut;     		/* Head unload time (remnant of 
+	unsigned long hut;     		/* Head unload time (remnant of
 					 * 8" drives) */
 	unsigned long srt;     		/* Step rate, usec */
 
@@ -145,12 +145,12 @@ struct floppy_drive_params {
 	unsigned char rps;		/* rotations per second */
 	unsigned char tracks;		/* maximum number of tracks */
 	unsigned long timeout;		/* timeout for interrupt requests */
-	
-	unsigned char interleave_sect;	/* if there are more sectors, use 
+
+	unsigned char interleave_sect;	/* if there are more sectors, use
 					 * interleave */
-	
+
 	struct floppy_max_errors max_errors;
-	
+
 	char flags;			/* various flags, including ftd_msg */
 /*
  * Announce successful media type detection and media information loss after
@@ -162,7 +162,7 @@ struct floppy_drive_params {
 #define FD_BROKEN_DCL 0x20
 #define FD_DEBUG 0x02
 #define FD_SILENT_DCL_CLEAR 0x4
-#define FD_INVERTED_DCL 0x80 /* must be 0x80, because of hardware 
+#define FD_INVERTED_DCL 0x80 /* must be 0x80, because of hardware
 				considerations */
 
 	char read_track;		/* use readtrack during probing? */
@@ -176,8 +176,8 @@ struct floppy_drive_params {
 #define FD_AUTODETECT_SIZE 8
 
 	short autodetect[FD_AUTODETECT_SIZE]; /* autodetected formats */
-	
-	int checkfreq; /* how often should the drive be checked for disk 
+
+	int checkfreq; /* how often should the drive be checked for disk
 			* changes */
 	int native_format; /* native format of this drive */
 };
@@ -225,13 +225,13 @@ struct floppy_drive_struct {
  * decremented after each probe.
  */
 	int keep_data;
-	
+
 	/* Prevent "aliased" accesses. */
 	int fd_ref;
 	int fd_device;
-	unsigned long last_checked; /* when was the drive last checked for a disk 
+	unsigned long last_checked; /* when was the drive last checked for a disk
 			   * change? */
-	
+
 	char *dmabuf;
 	int bufblocks;
 };
@@ -255,7 +255,7 @@ enum reset_mode {
 /*
  * FDC state
  */
-struct floppy_fdc_state {	
+struct floppy_fdc_state {
 	int spec1;		/* spec1 value last used */
 	int spec2;		/* spec2 value last used */
 	int dtr;
@@ -302,16 +302,16 @@ struct floppy_write_errors {
 	 * to the user process are not counted.
 	 */
 
-	unsigned int write_errors;  /* number of physical write errors 
+	unsigned int write_errors;  /* number of physical write errors
 				     * encountered */
-	
+
 	/* position of first and last write errors */
 	unsigned long first_error_sector;
 	int           first_error_generation;
 	unsigned long last_error_sector;
 	int           last_error_generation;
-	
-	unsigned int badness; /* highest retry count for a read or write 
+
+	unsigned int badness; /* highest retry count for a read or write
 			       * operation */
 };
 
@@ -335,7 +335,7 @@ struct floppy_raw_cmd {
 #define FD_RAW_DISK_CHANGE 4 /* out: disk change flag was set */
 #define FD_RAW_INTR 8    /* wait for an interrupt */
 #define FD_RAW_SPIN 0x10 /* spin up the disk for this command */
-#define FD_RAW_NO_MOTOR_AFTER 0x20 /* switch the motor off after command 
+#define FD_RAW_NO_MOTOR_AFTER 0x20 /* switch the motor off after command
 				    * completion */
 #define FD_RAW_NEED_DISK 0x40  /* this command needs a disk to be present */
 #define FD_RAW_NEED_SEEK 0x80  /* this command uses an implied seek (soft) */
@@ -353,7 +353,7 @@ struct floppy_raw_cmd {
 
 	void __user *data;
 	char *kernel_data; /* location of data buffer in the kernel */
-	struct floppy_raw_cmd *next; /* used for chaining of raw cmd's 
+	struct floppy_raw_cmd *next; /* used for chaining of raw cmd's
 				      * within the kernel */
 	long length; /* in: length of dma transfer. out: remaining bytes */
 	long phys_length; /* physical length, if different from dma length */
-- 
2.30.2

