Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D6FC3F2D1
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 19:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779F5246C0
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 19:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgCAT5M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 14:57:12 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32087 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgCAT5M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Mar 2020 14:57:12 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 021Ju5ds011206;
        Sun, 1 Mar 2020 20:56:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 6/6] floppy: rename the global "fdc" variable to "current_fdc"
Date:   Sun,  1 Mar 2020 20:55:55 +0100
Message-Id: <20200301195555.11154-7-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200301195555.11154-1-w@1wt.eu>
References: <20200301195555.11154-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is done in order to remove the confusion that arises at some places
in the code where local variables or arguments shadow the global variable.
It is already visible that some places are a bit awkward and iterate over
the global variable, for the sole reason that they used to rely on it being
named "fdc" in order to get the correct address when using FD_DOR. These
ones are easy to spot by searching for "for (current_fdc...".

Some more cleanup is definitely possible. For example
"fdc_state[current_fdc].somefield" is used all over the code and would
probably be better with "fdc_state->somefield" with fdc_state being set
when current_fdc is assigned. This would require to pass the pointer to
the current state instead of the current_fdc to the I/O functions.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 267 +++++++++++++++++++++++++------------------------
 1 file changed, 137 insertions(+), 130 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 4e43a7e..c3daa64 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -582,7 +582,7 @@ static int buffer_max = -1;
 
 /* fdc related variables, should end up in a struct */
 static struct floppy_fdc_state fdc_state[N_FDC];
-static int fdc;			/* current fdc */
+static int current_fdc;			/* current fdc */
 
 static struct workqueue_struct *floppy_wq;
 
@@ -831,8 +831,9 @@ static void twaddle(void)
 {
 	if (drive_params[current_drive].select_delay)
 		return;
-	fdc_outb(fdc_state[fdc].dor & ~(0x10 << UNIT(current_drive)), fdc, FD_DOR);
-	fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
+	fdc_outb(fdc_state[current_fdc].dor & ~(0x10 << UNIT(current_drive)),
+		 current_fdc, FD_DOR);
+	fdc_outb(fdc_state[current_fdc].dor, current_fdc, FD_DOR);
 	drive_state[current_drive].select_date = jiffies;
 }
 
@@ -844,19 +845,20 @@ static void reset_fdc_info(int mode)
 {
 	int drive;
 
-	fdc_state[fdc].spec1 = fdc_state[fdc].spec2 = -1;
-	fdc_state[fdc].need_configure = 1;
-	fdc_state[fdc].perp_mode = 1;
-	fdc_state[fdc].rawcmd = 0;
+	fdc_state[current_fdc].spec1 = fdc_state[current_fdc].spec2 = -1;
+	fdc_state[current_fdc].need_configure = 1;
+	fdc_state[current_fdc].perp_mode = 1;
+	fdc_state[current_fdc].rawcmd = 0;
 	for (drive = 0; drive < N_DRIVE; drive++)
-		if (FDC(drive) == fdc && (mode || drive_state[drive].track != NEED_1_RECAL))
+		if (FDC(drive) == current_fdc &&
+		    (mode || drive_state[drive].track != NEED_1_RECAL))
 			drive_state[drive].track = NEED_2_RECAL;
 }
 
 /* selects the fdc and drive, and enables the fdc's input/dma. */
 static void set_fdc(int drive)
 {
-	unsigned int new_fdc = fdc;
+	unsigned int new_fdc = current_fdc;
 
 	if (drive >= 0 && drive < N_DRIVE) {
 		new_fdc = FDC(drive);
@@ -866,15 +868,15 @@ static void set_fdc(int drive)
 		pr_info("bad fdc value\n");
 		return;
 	}
-	fdc = new_fdc;
-	set_dor(fdc, ~0, 8);
+	current_fdc = new_fdc;
+	set_dor(current_fdc, ~0, 8);
 #if N_FDC > 1
-	set_dor(1 - fdc, ~8, 0);
+	set_dor(1 - current_fdc, ~8, 0);
 #endif
-	if (fdc_state[fdc].rawcmd == 2)
+	if (fdc_state[current_fdc].rawcmd == 2)
 		reset_fdc_info(1);
-	if (fdc_inb(fdc, FD_STATUS) != STATUS_READY)
-		fdc_state[fdc].reset = 1;
+	if (fdc_inb(current_fdc, FD_STATUS) != STATUS_READY)
+		fdc_state[current_fdc].reset = 1;
 }
 
 /* locks the driver */
@@ -964,11 +966,11 @@ static void scandrives(void)
 		if (drive_state[drive].fd_ref == 0 || drive_params[drive].select_delay != 0)
 			continue;	/* skip closed drives */
 		set_fdc(drive);
-		if (!(set_dor(fdc, ~3, UNIT(drive) | (0x10 << UNIT(drive))) &
+		if (!(set_dor(current_fdc, ~3, UNIT(drive) | (0x10 << UNIT(drive))) &
 		      (0x10 << UNIT(drive))))
 			/* switch the motor off again, if it was off to
 			 * begin with */
-			set_dor(fdc, ~(0x10 << UNIT(drive)), 0);
+			set_dor(current_fdc, ~(0x10 << UNIT(drive)), 0);
 	}
 	set_fdc(saved_drive);
 }
@@ -1039,7 +1041,7 @@ static void main_command_interrupt(void)
 static int fd_wait_for_completion(unsigned long expires,
 				  void (*function)(void))
 {
-	if (fdc_state[fdc].reset) {
+	if (fdc_state[current_fdc].reset) {
 		reset_fdc();	/* do the reset during sleep to win time
 				 * if we don't need to sleep, it's a good
 				 * occasion anyways */
@@ -1067,13 +1069,13 @@ static void setup_DMA(void)
 			pr_cont("%x,", raw_cmd->cmd[i]);
 		pr_cont("\n");
 		cont->done(0);
-		fdc_state[fdc].reset = 1;
+		fdc_state[current_fdc].reset = 1;
 		return;
 	}
 	if (((unsigned long)raw_cmd->kernel_data) % 512) {
 		pr_info("non aligned address: %p\n", raw_cmd->kernel_data);
 		cont->done(0);
-		fdc_state[fdc].reset = 1;
+		fdc_state[current_fdc].reset = 1;
 		return;
 	}
 	f = claim_dma_lock();
@@ -1081,10 +1083,11 @@ static void setup_DMA(void)
 #ifdef fd_dma_setup
 	if (fd_dma_setup(raw_cmd->kernel_data, raw_cmd->length,
 			 (raw_cmd->flags & FD_RAW_READ) ?
-			 DMA_MODE_READ : DMA_MODE_WRITE, fdc_state[fdc].address) < 0) {
+			 DMA_MODE_READ : DMA_MODE_WRITE,
+			 fdc_state[current_fdc].address) < 0) {
 		release_dma_lock(f);
 		cont->done(0);
-		fdc_state[fdc].reset = 1;
+		fdc_state[current_fdc].reset = 1;
 		return;
 	}
 	release_dma_lock(f);
@@ -1095,7 +1098,7 @@ static void setup_DMA(void)
 			DMA_MODE_READ : DMA_MODE_WRITE);
 	fd_set_dma_addr(raw_cmd->kernel_data);
 	fd_set_dma_count(raw_cmd->length);
-	virtual_dma_port = fdc_state[fdc].address;
+	virtual_dma_port = fdc_state[current_fdc].address;
 	fd_enable_dma();
 	release_dma_lock(f);
 #endif
@@ -1109,18 +1112,18 @@ static int wait_til_ready(void)
 	int status;
 	int counter;
 
-	if (fdc_state[fdc].reset)
+	if (fdc_state[current_fdc].reset)
 		return -1;
 	for (counter = 0; counter < 10000; counter++) {
-		status = fdc_inb(fdc, FD_STATUS);
+		status = fdc_inb(current_fdc, FD_STATUS);
 		if (status & STATUS_READY)
 			return status;
 	}
 	if (initialized) {
-		DPRINT("Getstatus times out (%x) on fdc %d\n", status, fdc);
+		DPRINT("Getstatus times out (%x) on fdc %d\n", status, current_fdc);
 		show_floppy();
 	}
-	fdc_state[fdc].reset = 1;
+	fdc_state[current_fdc].reset = 1;
 	return -1;
 }
 
@@ -1133,17 +1136,17 @@ static int output_byte(char byte)
 		return -1;
 
 	if (is_ready_state(status)) {
-		fdc_outb(byte, fdc, FD_DATA);
+		fdc_outb(byte, current_fdc, FD_DATA);
 		output_log[output_log_pos].data = byte;
 		output_log[output_log_pos].status = status;
 		output_log[output_log_pos].jiffies = jiffies;
 		output_log_pos = (output_log_pos + 1) % OLOGSIZE;
 		return 0;
 	}
-	fdc_state[fdc].reset = 1;
+	fdc_state[current_fdc].reset = 1;
 	if (initialized) {
 		DPRINT("Unable to send byte %x to FDC. Fdc=%x Status=%x\n",
-		       byte, fdc, status);
+		       byte, current_fdc, status);
 		show_floppy();
 	}
 	return -1;
@@ -1166,16 +1169,16 @@ static int result(void)
 			return i;
 		}
 		if (status == (STATUS_DIR | STATUS_READY | STATUS_BUSY))
-			reply_buffer[i] = fdc_inb(fdc, FD_DATA);
+			reply_buffer[i] = fdc_inb(current_fdc, FD_DATA);
 		else
 			break;
 	}
 	if (initialized) {
 		DPRINT("get result error. Fdc=%d Last status=%x Read bytes=%d\n",
-		       fdc, status, i);
+		       current_fdc, status, i);
 		show_floppy();
 	}
-	fdc_state[fdc].reset = 1;
+	fdc_state[current_fdc].reset = 1;
 	return -1;
 }
 
@@ -1212,7 +1215,7 @@ static void perpendicular_mode(void)
 		default:
 			DPRINT("Invalid data rate for perpendicular mode!\n");
 			cont->done(0);
-			fdc_state[fdc].reset = 1;
+			fdc_state[current_fdc].reset = 1;
 					/*
 					 * convenient way to return to
 					 * redo without too much hassle
@@ -1223,12 +1226,12 @@ static void perpendicular_mode(void)
 	} else
 		perp_mode = 0;
 
-	if (fdc_state[fdc].perp_mode == perp_mode)
+	if (fdc_state[current_fdc].perp_mode == perp_mode)
 		return;
-	if (fdc_state[fdc].version >= FDC_82077_ORIG) {
+	if (fdc_state[current_fdc].version >= FDC_82077_ORIG) {
 		output_byte(FD_PERPENDICULAR);
 		output_byte(perp_mode);
-		fdc_state[fdc].perp_mode = perp_mode;
+		fdc_state[current_fdc].perp_mode = perp_mode;
 	} else if (perp_mode) {
 		DPRINT("perpendicular mode not supported by this FDC.\n");
 	}
@@ -1283,9 +1286,10 @@ static void fdc_specify(void)
 	int hlt_max_code = 0x7f;
 	int hut_max_code = 0xf;
 
-	if (fdc_state[fdc].need_configure && fdc_state[fdc].version >= FDC_82072A) {
+	if (fdc_state[current_fdc].need_configure &&
+	    fdc_state[current_fdc].version >= FDC_82072A) {
 		fdc_configure();
-		fdc_state[fdc].need_configure = 0;
+		fdc_state[current_fdc].need_configure = 0;
 	}
 
 	switch (raw_cmd->rate & 0x03) {
@@ -1294,7 +1298,7 @@ static void fdc_specify(void)
 		break;
 	case 1:
 		dtr = 300;
-		if (fdc_state[fdc].version >= FDC_82078) {
+		if (fdc_state[current_fdc].version >= FDC_82078) {
 			/* chose the default rate table, not the one
 			 * where 1 = 2 Mbps */
 			output_byte(FD_DRIVESPEC);
@@ -1309,7 +1313,7 @@ static void fdc_specify(void)
 		break;
 	}
 
-	if (fdc_state[fdc].version >= FDC_82072) {
+	if (fdc_state[current_fdc].version >= FDC_82072) {
 		scale_dtr = dtr;
 		hlt_max_code = 0x00;	/* 0==256msec*dtr0/dtr (not linear!) */
 		hut_max_code = 0x0;	/* 0==256msec*dtr0/dtr (not linear!) */
@@ -1342,11 +1346,12 @@ static void fdc_specify(void)
 	spec2 = (hlt << 1) | (use_virtual_dma & 1);
 
 	/* If these parameters did not change, just return with success */
-	if (fdc_state[fdc].spec1 != spec1 || fdc_state[fdc].spec2 != spec2) {
+	if (fdc_state[current_fdc].spec1 != spec1 ||
+	    fdc_state[current_fdc].spec2 != spec2) {
 		/* Go ahead and set spec1 and spec2 */
 		output_byte(FD_SPECIFY);
-		output_byte(fdc_state[fdc].spec1 = spec1);
-		output_byte(fdc_state[fdc].spec2 = spec2);
+		output_byte(fdc_state[current_fdc].spec1 = spec1);
+		output_byte(fdc_state[current_fdc].spec2 = spec2);
 	}
 }				/* fdc_specify */
 
@@ -1357,18 +1362,18 @@ static void fdc_specify(void)
 static int fdc_dtr(void)
 {
 	/* If data rate not already set to desired value, set it. */
-	if ((raw_cmd->rate & 3) == fdc_state[fdc].dtr)
+	if ((raw_cmd->rate & 3) == fdc_state[current_fdc].dtr)
 		return 0;
 
 	/* Set dtr */
-	fdc_outb(raw_cmd->rate & 3, fdc, FD_DCR);
+	fdc_outb(raw_cmd->rate & 3, current_fdc, FD_DCR);
 
 	/* TODO: some FDC/drive combinations (C&T 82C711 with TEAC 1.2MB)
 	 * need a stabilization period of several milliseconds to be
 	 * enforced after data rate changes before R/W operations.
 	 * Pause 5 msec to avoid trouble. (Needs to be 2 jiffies)
 	 */
-	fdc_state[fdc].dtr = raw_cmd->rate & 3;
+	fdc_state[current_fdc].dtr = raw_cmd->rate & 3;
 	return fd_wait_for_completion(jiffies + 2UL * HZ / 100, floppy_ready);
 }				/* fdc_dtr */
 
@@ -1424,7 +1429,7 @@ static int interpret_errors(void)
 
 	if (inr != 7) {
 		DPRINT("-- FDC reply error\n");
-		fdc_state[fdc].reset = 1;
+		fdc_state[current_fdc].reset = 1;
 		return 1;
 	}
 
@@ -1564,7 +1569,7 @@ static void check_wp(void)
 		output_byte(FD_GETSTATUS);
 		output_byte(UNIT(current_drive));
 		if (result() != 1) {
-			fdc_state[fdc].reset = 1;
+			fdc_state[current_fdc].reset = 1;
 			return;
 		}
 		clear_bit(FD_VERIFY_BIT, &drive_state[current_drive].flags);
@@ -1616,7 +1621,7 @@ static void seek_floppy(void)
 			track = raw_cmd->track - 1;
 		else {
 			if (drive_params[current_drive].flags & FD_SILENT_DCL_CLEAR) {
-				set_dor(fdc, ~(0x10 << UNIT(current_drive)), 0);
+				set_dor(current_fdc, ~(0x10 << UNIT(current_drive)), 0);
 				blind_seek = 1;
 				raw_cmd->flags |= FD_RAW_NEED_SEEK;
 			}
@@ -1647,7 +1652,7 @@ static void recal_interrupt(void)
 {
 	debugt(__func__, "");
 	if (inr != 2)
-		fdc_state[fdc].reset = 1;
+		fdc_state[current_fdc].reset = 1;
 	else if (reply_buffer[ST0] & ST0_ECE) {
 		switch (drive_state[current_drive].track) {
 		case NEED_1_RECAL:
@@ -1716,16 +1721,16 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 	release_dma_lock(f);
 
 	do_floppy = NULL;
-	if (fdc >= N_FDC || fdc_state[fdc].address == -1) {
+	if (current_fdc >= N_FDC || fdc_state[current_fdc].address == -1) {
 		/* we don't even know which FDC is the culprit */
 		pr_info("DOR0=%x\n", fdc_state[0].dor);
-		pr_info("floppy interrupt on bizarre fdc %d\n", fdc);
+		pr_info("floppy interrupt on bizarre fdc %d\n", current_fdc);
 		pr_info("handler=%ps\n", handler);
 		is_alive(__func__, "bizarre fdc");
 		return IRQ_NONE;
 	}
 
-	fdc_state[fdc].reset = 0;
+	fdc_state[current_fdc].reset = 0;
 	/* We have to clear the reset flag here, because apparently on boxes
 	 * with level triggered interrupts (PS/2, Sparc, ...), it is needed to
 	 * emit SENSEI's to clear the interrupt line. And fdc_state[fdc].reset
@@ -1752,7 +1757,7 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 			 inr == 2 && max_sensei);
 	}
 	if (!handler) {
-		fdc_state[fdc].reset = 1;
+		fdc_state[current_fdc].reset = 1;
 		return IRQ_NONE;
 	}
 	schedule_bh(handler);
@@ -1778,7 +1783,7 @@ static void reset_interrupt(void)
 {
 	debugt(__func__, "");
 	result();		/* get the status ready for set_fdc */
-	if (fdc_state[fdc].reset) {
+	if (fdc_state[current_fdc].reset) {
 		pr_info("reset set in interrupt, calling %ps\n", cont->error);
 		cont->error();	/* a reset just after a reset. BAD! */
 	}
@@ -1794,7 +1799,7 @@ static void reset_fdc(void)
 	unsigned long flags;
 
 	do_floppy = reset_interrupt;
-	fdc_state[fdc].reset = 0;
+	fdc_state[current_fdc].reset = 0;
 	reset_fdc_info(0);
 
 	/* Pseudo-DMA may intercept 'reset finished' interrupt.  */
@@ -1804,12 +1809,13 @@ static void reset_fdc(void)
 	fd_disable_dma();
 	release_dma_lock(flags);
 
-	if (fdc_state[fdc].version >= FDC_82072A)
-		fdc_outb(0x80 | (fdc_state[fdc].dtr & 3), fdc, FD_STATUS);
+	if (fdc_state[current_fdc].version >= FDC_82072A)
+		fdc_outb(0x80 | (fdc_state[current_fdc].dtr & 3),
+			 current_fdc, FD_STATUS);
 	else {
-		fdc_outb(fdc_state[fdc].dor & ~0x04, fdc, FD_DOR);
+		fdc_outb(fdc_state[current_fdc].dor & ~0x04, current_fdc, FD_DOR);
 		udelay(FD_RESET_DELAY);
-		fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
+		fdc_outb(fdc_state[current_fdc].dor, current_fdc, FD_DOR);
 	}
 }
 
@@ -1836,7 +1842,7 @@ static void show_floppy(void)
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1,
 		       reply_buffer, resultsize, true);
 
-	pr_info("status=%x\n", fdc_inb(fdc, FD_STATUS));
+	pr_info("status=%x\n", fdc_inb(current_fdc, FD_STATUS));
 	pr_info("fdc_busy=%lu\n", fdc_busy);
 	if (do_floppy)
 		pr_info("do_floppy=%ps\n", do_floppy);
@@ -1873,7 +1879,7 @@ static void floppy_shutdown(struct work_struct *arg)
 
 	if (initialized)
 		DPRINT("floppy timeout called\n");
-	fdc_state[fdc].reset = 1;
+	fdc_state[current_fdc].reset = 1;
 	if (cont) {
 		cont->done(0);
 		cont->redo();	/* this will recall reset when needed */
@@ -1893,7 +1899,7 @@ static int start_motor(void (*function)(void))
 	mask = 0xfc;
 	data = UNIT(current_drive);
 	if (!(raw_cmd->flags & FD_RAW_NO_MOTOR)) {
-		if (!(fdc_state[fdc].dor & (0x10 << UNIT(current_drive)))) {
+		if (!(fdc_state[current_fdc].dor & (0x10 << UNIT(current_drive)))) {
 			set_debugt();
 			/* no read since this drive is running */
 			drive_state[current_drive].first_read_date = 0;
@@ -1901,12 +1907,12 @@ static int start_motor(void (*function)(void))
 			drive_state[current_drive].spinup_date = jiffies;
 			data |= (0x10 << UNIT(current_drive));
 		}
-	} else if (fdc_state[fdc].dor & (0x10 << UNIT(current_drive)))
+	} else if (fdc_state[current_fdc].dor & (0x10 << UNIT(current_drive)))
 		mask &= ~(0x10 << UNIT(current_drive));
 
 	/* starts motor and selects floppy */
 	del_timer(motor_off_timer + current_drive);
-	set_dor(fdc, mask, data);
+	set_dor(current_fdc, mask, data);
 
 	/* wait_for_completion also schedules reset if needed. */
 	return fd_wait_for_completion(drive_state[current_drive].select_date + drive_params[current_drive].select_delay,
@@ -1915,7 +1921,7 @@ static int start_motor(void (*function)(void))
 
 static void floppy_ready(void)
 {
-	if (fdc_state[fdc].reset) {
+	if (fdc_state[current_fdc].reset) {
 		reset_fdc();
 		return;
 	}
@@ -2016,7 +2022,7 @@ static int wait_til_done(void (*handler)(void), bool interruptible)
 		return -EINTR;
 	}
 
-	if (fdc_state[fdc].reset)
+	if (fdc_state[current_fdc].reset)
 		command_status = FD_COMMAND_ERROR;
 	if (command_status == FD_COMMAND_OKAY)
 		ret = 0;
@@ -2085,7 +2091,7 @@ static void bad_flp_intr(void)
 	if (err_count > drive_params[current_drive].max_errors.abort)
 		cont->done(0);
 	if (err_count > drive_params[current_drive].max_errors.reset)
-		fdc_state[fdc].reset = 1;
+		fdc_state[current_fdc].reset = 1;
 	else if (err_count > drive_params[current_drive].max_errors.recal)
 		drive_state[current_drive].track = NEED_2_RECAL;
 }
@@ -2998,8 +3004,8 @@ static int user_reset_fdc(int drive, int arg, bool interruptible)
 		return -EINTR;
 
 	if (arg == FD_RESET_ALWAYS)
-		fdc_state[fdc].reset = 1;
-	if (fdc_state[fdc].reset) {
+		fdc_state[current_fdc].reset = 1;
+	if (fdc_state[current_fdc].reset) {
 		cont = &reset_cont;
 		ret = wait_til_done(reset_fdc, interruptible);
 		if (ret == -EINTR)
@@ -3210,23 +3216,23 @@ static int raw_cmd_ioctl(int cmd, void __user *param)
 	int ret2;
 	int ret;
 
-	if (fdc_state[fdc].rawcmd <= 1)
-		fdc_state[fdc].rawcmd = 1;
+	if (fdc_state[current_fdc].rawcmd <= 1)
+		fdc_state[current_fdc].rawcmd = 1;
 	for (drive = 0; drive < N_DRIVE; drive++) {
-		if (FDC(drive) != fdc)
+		if (FDC(drive) != current_fdc)
 			continue;
 		if (drive == current_drive) {
 			if (drive_state[drive].fd_ref > 1) {
-				fdc_state[fdc].rawcmd = 2;
+				fdc_state[current_fdc].rawcmd = 2;
 				break;
 			}
 		} else if (drive_state[drive].fd_ref) {
-			fdc_state[fdc].rawcmd = 2;
+			fdc_state[current_fdc].rawcmd = 2;
 			break;
 		}
 	}
 
-	if (fdc_state[fdc].reset)
+	if (fdc_state[current_fdc].reset)
 		return -EIO;
 
 	ret = raw_cmd_copyin(cmd, param, &my_raw_cmd);
@@ -3241,7 +3247,7 @@ static int raw_cmd_ioctl(int cmd, void __user *param)
 	debug_dcl(drive_params[current_drive].flags,
 		  "calling disk change from raw_cmd ioctl\n");
 
-	if (ret != -EINTR && fdc_state[fdc].reset)
+	if (ret != -EINTR && fdc_state[current_fdc].reset)
 		ret = -EIO;
 
 	drive_state[current_drive].track = NO_TRACK;
@@ -4297,23 +4303,23 @@ static char __init get_fdc_version(void)
 	int r;
 
 	output_byte(FD_DUMPREGS);	/* 82072 and better know DUMPREGS */
-	if (fdc_state[fdc].reset)
+	if (fdc_state[current_fdc].reset)
 		return FDC_NONE;
 	r = result();
 	if (r <= 0x00)
 		return FDC_NONE;	/* No FDC present ??? */
 	if ((r == 1) && (reply_buffer[0] == 0x80)) {
-		pr_info("FDC %d is an 8272A\n", fdc);
+		pr_info("FDC %d is an 8272A\n", current_fdc);
 		return FDC_8272A;	/* 8272a/765 don't know DUMPREGS */
 	}
 	if (r != 10) {
 		pr_info("FDC %d init: DUMPREGS: unexpected return of %d bytes.\n",
-			fdc, r);
+			current_fdc, r);
 		return FDC_UNKNOWN;
 	}
 
 	if (!fdc_configure()) {
-		pr_info("FDC %d is an 82072\n", fdc);
+		pr_info("FDC %d is an 82072\n", current_fdc);
 		return FDC_82072;	/* 82072 doesn't know CONFIGURE */
 	}
 
@@ -4321,50 +4327,50 @@ static char __init get_fdc_version(void)
 	if (need_more_output() == MORE_OUTPUT) {
 		output_byte(0);
 	} else {
-		pr_info("FDC %d is an 82072A\n", fdc);
+		pr_info("FDC %d is an 82072A\n", current_fdc);
 		return FDC_82072A;	/* 82072A as found on Sparcs. */
 	}
 
 	output_byte(FD_UNLOCK);
 	r = result();
 	if ((r == 1) && (reply_buffer[0] == 0x80)) {
-		pr_info("FDC %d is a pre-1991 82077\n", fdc);
+		pr_info("FDC %d is a pre-1991 82077\n", current_fdc);
 		return FDC_82077_ORIG;	/* Pre-1991 82077, doesn't know
 					 * LOCK/UNLOCK */
 	}
 	if ((r != 1) || (reply_buffer[0] != 0x00)) {
 		pr_info("FDC %d init: UNLOCK: unexpected return of %d bytes.\n",
-			fdc, r);
+			current_fdc, r);
 		return FDC_UNKNOWN;
 	}
 	output_byte(FD_PARTID);
 	r = result();
 	if (r != 1) {
 		pr_info("FDC %d init: PARTID: unexpected return of %d bytes.\n",
-			fdc, r);
+			current_fdc, r);
 		return FDC_UNKNOWN;
 	}
 	if (reply_buffer[0] == 0x80) {
-		pr_info("FDC %d is a post-1991 82077\n", fdc);
+		pr_info("FDC %d is a post-1991 82077\n", current_fdc);
 		return FDC_82077;	/* Revised 82077AA passes all the tests */
 	}
 	switch (reply_buffer[0] >> 5) {
 	case 0x0:
 		/* Either a 82078-1 or a 82078SL running at 5Volt */
-		pr_info("FDC %d is an 82078.\n", fdc);
+		pr_info("FDC %d is an 82078.\n", current_fdc);
 		return FDC_82078;
 	case 0x1:
-		pr_info("FDC %d is a 44pin 82078\n", fdc);
+		pr_info("FDC %d is a 44pin 82078\n", current_fdc);
 		return FDC_82078;
 	case 0x2:
-		pr_info("FDC %d is a S82078B\n", fdc);
+		pr_info("FDC %d is a S82078B\n", current_fdc);
 		return FDC_S82078B;
 	case 0x3:
-		pr_info("FDC %d is a National Semiconductor PC87306\n", fdc);
+		pr_info("FDC %d is a National Semiconductor PC87306\n", current_fdc);
 		return FDC_87306;
 	default:
 		pr_info("FDC %d init: 82078 variant with unknown PARTID=%d.\n",
-			fdc, reply_buffer[0] >> 5);
+			current_fdc, reply_buffer[0] >> 5);
 		return FDC_82078_UNKN;
 	}
 }				/* get_fdc_version */
@@ -4640,16 +4646,16 @@ static int __init do_floppy_init(void)
 	config_types();
 
 	for (i = 0; i < N_FDC; i++) {
-		fdc = i;
-		memset(&fdc_state[fdc], 0, sizeof(*fdc_state));
-		fdc_state[fdc].dtr = -1;
-		fdc_state[fdc].dor = 0x4;
+		current_fdc = i;
+		memset(&fdc_state[current_fdc], 0, sizeof(*fdc_state));
+		fdc_state[current_fdc].dtr = -1;
+		fdc_state[current_fdc].dor = 0x4;
 #if defined(__sparc__) || defined(__mc68000__)
 	/*sparcs/sun3x don't have a DOR reset which we can fall back on to */
 #ifdef __mc68000__
 		if (MACH_IS_SUN3X)
 #endif
-			fdc_state[fdc].version = FDC_82072A;
+			fdc_state[current_fdc].version = FDC_82072A;
 #endif
 	}
 
@@ -4664,7 +4670,7 @@ static int __init do_floppy_init(void)
 	fdc_state[1].address = FDC2;
 #endif
 
-	fdc = 0;		/* reset fdc in case of unexpected interrupt */
+	current_fdc = 0;	/* reset fdc in case of unexpected interrupt */
 	err = floppy_grab_irq_and_dma();
 	if (err) {
 		cancel_delayed_work(&fd_timeout);
@@ -4691,29 +4697,30 @@ static int __init do_floppy_init(void)
 	msleep(10);
 
 	for (i = 0; i < N_FDC; i++) {
-		fdc = i;
-		fdc_state[fdc].driver_version = FD_DRIVER_VERSION;
+		current_fdc = i;
+		fdc_state[current_fdc].driver_version = FD_DRIVER_VERSION;
 		for (unit = 0; unit < 4; unit++)
-			fdc_state[fdc].track[unit] = 0;
-		if (fdc_state[fdc].address == -1)
+			fdc_state[current_fdc].track[unit] = 0;
+		if (fdc_state[current_fdc].address == -1)
 			continue;
-		fdc_state[fdc].rawcmd = 2;
+		fdc_state[current_fdc].rawcmd = 2;
 		if (user_reset_fdc(-1, FD_RESET_ALWAYS, false)) {
 			/* free ioports reserved by floppy_grab_irq_and_dma() */
-			floppy_release_regions(fdc);
-			fdc_state[fdc].address = -1;
-			fdc_state[fdc].version = FDC_NONE;
+			floppy_release_regions(current_fdc);
+			fdc_state[current_fdc].address = -1;
+			fdc_state[current_fdc].version = FDC_NONE;
 			continue;
 		}
 		/* Try to determine the floppy controller type */
-		fdc_state[fdc].version = get_fdc_version();
-		if (fdc_state[fdc].version == FDC_NONE) {
+		fdc_state[current_fdc].version = get_fdc_version();
+		if (fdc_state[current_fdc].version == FDC_NONE) {
 			/* free ioports reserved by floppy_grab_irq_and_dma() */
-			floppy_release_regions(fdc);
-			fdc_state[fdc].address = -1;
+			floppy_release_regions(current_fdc);
+			fdc_state[current_fdc].address = -1;
 			continue;
 		}
-		if (can_use_virtual_dma == 2 && fdc_state[fdc].version < FDC_82072A)
+		if (can_use_virtual_dma == 2 &&
+		    fdc_state[current_fdc].version < FDC_82072A)
 			can_use_virtual_dma = 0;
 
 		have_no_fdc = 0;
@@ -4723,7 +4730,7 @@ static int __init do_floppy_init(void)
 		 */
 		user_reset_fdc(-1, FD_RESET_ALWAYS, false);
 	}
-	fdc = 0;
+	current_fdc = 0;
 	cancel_delayed_work(&fd_timeout);
 	current_drive = 0;
 	initialized = true;
@@ -4875,36 +4882,36 @@ static int floppy_grab_irq_and_dma(void)
 		}
 	}
 
-	for (fdc = 0; fdc < N_FDC; fdc++) {
-		if (fdc_state[fdc].address != -1) {
-			if (floppy_request_regions(fdc))
+	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++) {
+		if (fdc_state[current_fdc].address != -1) {
+			if (floppy_request_regions(current_fdc))
 				goto cleanup;
 		}
 	}
-	for (fdc = 0; fdc < N_FDC; fdc++) {
-		if (fdc_state[fdc].address != -1) {
+	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++) {
+		if (fdc_state[current_fdc].address != -1) {
 			reset_fdc_info(1);
-			fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
+			fdc_outb(fdc_state[current_fdc].dor, current_fdc, FD_DOR);
 		}
 	}
-	fdc = 0;
+	current_fdc = 0;
 	set_dor(0, ~0, 8);	/* avoid immediate interrupt */
 
-	for (fdc = 0; fdc < N_FDC; fdc++)
-		if (fdc_state[fdc].address != -1)
-			fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
+	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++)
+		if (fdc_state[current_fdc].address != -1)
+			fdc_outb(fdc_state[current_fdc].dor, current_fdc, FD_DOR);
 	/*
 	 * The driver will try and free resources and relies on us
 	 * to know if they were allocated or not.
 	 */
-	fdc = 0;
+	current_fdc = 0;
 	irqdma_allocated = 1;
 	return 0;
 cleanup:
 	fd_free_irq();
 	fd_free_dma();
-	while (--fdc >= 0)
-		floppy_release_regions(fdc);
+	while (--current_fdc >= 0)
+		floppy_release_regions(current_fdc);
 	atomic_dec(&usage_count);
 	return -1;
 }
@@ -4952,11 +4959,11 @@ static void floppy_release_irq_and_dma(void)
 		pr_info("auxiliary floppy timer still active\n");
 	if (work_pending(&floppy_work))
 		pr_info("work still pending\n");
-	old_fdc = fdc;
-	for (fdc = 0; fdc < N_FDC; fdc++)
-		if (fdc_state[fdc].address != -1)
-			floppy_release_regions(fdc);
-	fdc = old_fdc;
+	old_fdc = current_fdc;
+	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++)
+		if (fdc_state[current_fdc].address != -1)
+			floppy_release_regions(current_fdc);
+	current_fdc = old_fdc;
 }
 
 #ifdef MODULE
-- 
2.9.0

