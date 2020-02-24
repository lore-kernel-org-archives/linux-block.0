Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB9CC38BFA
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC17F2176D
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgBXVlH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:41:07 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbgBXVlG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 16:41:06 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO4eq008692;
        Mon, 24 Feb 2020 22:24:04 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 01/10] floppy: cleanup: expand macro FDCS
Date:   Mon, 24 Feb 2020 22:23:43 +0100
Message-Id: <20200224212352.8640-2-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200224212352.8640-1-w@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Macro FDCS silently uses identifier "fdc" which may be either the
global one or a local one. Let's expand the macro to make this more
obvious.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 183 ++++++++++++++++++++++++-------------------------
 1 file changed, 91 insertions(+), 92 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 8ef65c0..93e0840 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -309,7 +309,6 @@ static bool initialized;
 #define DP	(&drive_params[current_drive])
 #define DRS	(&drive_state[current_drive])
 #define DRWE	(&write_errors[current_drive])
-#define FDCS	(&fdc_state[fdc])
 
 #define UDP	(&drive_params[drive])
 #define UDRS	(&drive_state[drive])
@@ -742,11 +741,11 @@ static int disk_change(int drive)
 
 	if (time_before(jiffies, UDRS->select_date + UDP->select_delay))
 		DPRINT("WARNING disk change called early\n");
-	if (!(FDCS->dor & (0x10 << UNIT(drive))) ||
-	    (FDCS->dor & 3) != UNIT(drive) || fdc != FDC(drive)) {
+	if (!(fdc_state[fdc].dor & (0x10 << UNIT(drive))) ||
+	    (fdc_state[fdc].dor & 3) != UNIT(drive) || fdc != FDC(drive)) {
 		DPRINT("probing disk change on unselected drive\n");
 		DPRINT("drive=%d fdc=%d dor=%x\n", drive, FDC(drive),
-		       (unsigned int)FDCS->dor);
+		       (unsigned int)fdc_state[fdc].dor);
 	}
 
 	debug_dcl(UDP->flags,
@@ -799,10 +798,10 @@ static int set_dor(int fdc, char mask, char data)
 	unsigned char newdor;
 	unsigned char olddor;
 
-	if (FDCS->address == -1)
+	if (fdc_state[fdc].address == -1)
 		return -1;
 
-	olddor = FDCS->dor;
+	olddor = fdc_state[fdc].dor;
 	newdor = (olddor & mask) | data;
 	if (newdor != olddor) {
 		unit = olddor & 0x3;
@@ -812,7 +811,7 @@ static int set_dor(int fdc, char mask, char data)
 				  "calling disk change from set_dor\n");
 			disk_change(drive);
 		}
-		FDCS->dor = newdor;
+		fdc_state[fdc].dor = newdor;
 		fd_outb(newdor, FD_DOR);
 
 		unit = newdor & 0x3;
@@ -828,8 +827,8 @@ static void twaddle(void)
 {
 	if (DP->select_delay)
 		return;
-	fd_outb(FDCS->dor & ~(0x10 << UNIT(current_drive)), FD_DOR);
-	fd_outb(FDCS->dor, FD_DOR);
+	fd_outb(fdc_state[fdc].dor & ~(0x10 << UNIT(current_drive)), FD_DOR);
+	fd_outb(fdc_state[fdc].dor, FD_DOR);
 	DRS->select_date = jiffies;
 }
 
@@ -841,10 +840,10 @@ static void reset_fdc_info(int mode)
 {
 	int drive;
 
-	FDCS->spec1 = FDCS->spec2 = -1;
-	FDCS->need_configure = 1;
-	FDCS->perp_mode = 1;
-	FDCS->rawcmd = 0;
+	fdc_state[fdc].spec1 = fdc_state[fdc].spec2 = -1;
+	fdc_state[fdc].need_configure = 1;
+	fdc_state[fdc].perp_mode = 1;
+	fdc_state[fdc].rawcmd = 0;
 	for (drive = 0; drive < N_DRIVE; drive++)
 		if (FDC(drive) == fdc && (mode || UDRS->track != NEED_1_RECAL))
 			UDRS->track = NEED_2_RECAL;
@@ -868,10 +867,10 @@ static void set_fdc(int drive)
 #if N_FDC > 1
 	set_dor(1 - fdc, ~8, 0);
 #endif
-	if (FDCS->rawcmd == 2)
+	if (fdc_state[fdc].rawcmd == 2)
 		reset_fdc_info(1);
 	if (fd_inb(FD_STATUS) != STATUS_READY)
-		FDCS->reset = 1;
+		fdc_state[fdc].reset = 1;
 }
 
 /* locks the driver */
@@ -924,7 +923,7 @@ static void floppy_off(unsigned int drive)
 	unsigned long volatile delta;
 	int fdc = FDC(drive);
 
-	if (!(FDCS->dor & (0x10 << UNIT(drive))))
+	if (!(fdc_state[fdc].dor & (0x10 << UNIT(drive))))
 		return;
 
 	del_timer(motor_off_timer + drive);
@@ -1035,7 +1034,7 @@ static void main_command_interrupt(void)
 static int fd_wait_for_completion(unsigned long expires,
 				  void (*function)(void))
 {
-	if (FDCS->reset) {
+	if (fdc_state[fdc].reset) {
 		reset_fdc();	/* do the reset during sleep to win time
 				 * if we don't need to sleep, it's a good
 				 * occasion anyways */
@@ -1063,13 +1062,13 @@ static void setup_DMA(void)
 			pr_cont("%x,", raw_cmd->cmd[i]);
 		pr_cont("\n");
 		cont->done(0);
-		FDCS->reset = 1;
+		fdc_state[fdc].reset = 1;
 		return;
 	}
 	if (((unsigned long)raw_cmd->kernel_data) % 512) {
 		pr_info("non aligned address: %p\n", raw_cmd->kernel_data);
 		cont->done(0);
-		FDCS->reset = 1;
+		fdc_state[fdc].reset = 1;
 		return;
 	}
 	f = claim_dma_lock();
@@ -1077,10 +1076,10 @@ static void setup_DMA(void)
 #ifdef fd_dma_setup
 	if (fd_dma_setup(raw_cmd->kernel_data, raw_cmd->length,
 			 (raw_cmd->flags & FD_RAW_READ) ?
-			 DMA_MODE_READ : DMA_MODE_WRITE, FDCS->address) < 0) {
+			 DMA_MODE_READ : DMA_MODE_WRITE, fdc_state[fdc].address) < 0) {
 		release_dma_lock(f);
 		cont->done(0);
-		FDCS->reset = 1;
+		fdc_state[fdc].reset = 1;
 		return;
 	}
 	release_dma_lock(f);
@@ -1091,7 +1090,7 @@ static void setup_DMA(void)
 			DMA_MODE_READ : DMA_MODE_WRITE);
 	fd_set_dma_addr(raw_cmd->kernel_data);
 	fd_set_dma_count(raw_cmd->length);
-	virtual_dma_port = FDCS->address;
+	virtual_dma_port = fdc_state[fdc].address;
 	fd_enable_dma();
 	release_dma_lock(f);
 #endif
@@ -1105,7 +1104,7 @@ static int wait_til_ready(void)
 	int status;
 	int counter;
 
-	if (FDCS->reset)
+	if (fdc_state[fdc].reset)
 		return -1;
 	for (counter = 0; counter < 10000; counter++) {
 		status = fd_inb(FD_STATUS);
@@ -1116,7 +1115,7 @@ static int wait_til_ready(void)
 		DPRINT("Getstatus times out (%x) on fdc %d\n", status, fdc);
 		show_floppy();
 	}
-	FDCS->reset = 1;
+	fdc_state[fdc].reset = 1;
 	return -1;
 }
 
@@ -1136,7 +1135,7 @@ static int output_byte(char byte)
 		output_log_pos = (output_log_pos + 1) % OLOGSIZE;
 		return 0;
 	}
-	FDCS->reset = 1;
+	fdc_state[fdc].reset = 1;
 	if (initialized) {
 		DPRINT("Unable to send byte %x to FDC. Fdc=%x Status=%x\n",
 		       byte, fdc, status);
@@ -1171,7 +1170,7 @@ static int result(void)
 		       fdc, status, i);
 		show_floppy();
 	}
-	FDCS->reset = 1;
+	fdc_state[fdc].reset = 1;
 	return -1;
 }
 
@@ -1208,7 +1207,7 @@ static void perpendicular_mode(void)
 		default:
 			DPRINT("Invalid data rate for perpendicular mode!\n");
 			cont->done(0);
-			FDCS->reset = 1;
+			fdc_state[fdc].reset = 1;
 					/*
 					 * convenient way to return to
 					 * redo without too much hassle
@@ -1219,12 +1218,12 @@ static void perpendicular_mode(void)
 	} else
 		perp_mode = 0;
 
-	if (FDCS->perp_mode == perp_mode)
+	if (fdc_state[fdc].perp_mode == perp_mode)
 		return;
-	if (FDCS->version >= FDC_82077_ORIG) {
+	if (fdc_state[fdc].version >= FDC_82077_ORIG) {
 		output_byte(FD_PERPENDICULAR);
 		output_byte(perp_mode);
-		FDCS->perp_mode = perp_mode;
+		fdc_state[fdc].perp_mode = perp_mode;
 	} else if (perp_mode) {
 		DPRINT("perpendicular mode not supported by this FDC.\n");
 	}
@@ -1279,9 +1278,9 @@ static void fdc_specify(void)
 	int hlt_max_code = 0x7f;
 	int hut_max_code = 0xf;
 
-	if (FDCS->need_configure && FDCS->version >= FDC_82072A) {
+	if (fdc_state[fdc].need_configure && fdc_state[fdc].version >= FDC_82072A) {
 		fdc_configure();
-		FDCS->need_configure = 0;
+		fdc_state[fdc].need_configure = 0;
 	}
 
 	switch (raw_cmd->rate & 0x03) {
@@ -1290,7 +1289,7 @@ static void fdc_specify(void)
 		break;
 	case 1:
 		dtr = 300;
-		if (FDCS->version >= FDC_82078) {
+		if (fdc_state[fdc].version >= FDC_82078) {
 			/* chose the default rate table, not the one
 			 * where 1 = 2 Mbps */
 			output_byte(FD_DRIVESPEC);
@@ -1305,7 +1304,7 @@ static void fdc_specify(void)
 		break;
 	}
 
-	if (FDCS->version >= FDC_82072) {
+	if (fdc_state[fdc].version >= FDC_82072) {
 		scale_dtr = dtr;
 		hlt_max_code = 0x00;	/* 0==256msec*dtr0/dtr (not linear!) */
 		hut_max_code = 0x0;	/* 0==256msec*dtr0/dtr (not linear!) */
@@ -1335,11 +1334,11 @@ static void fdc_specify(void)
 	spec2 = (hlt << 1) | (use_virtual_dma & 1);
 
 	/* If these parameters did not change, just return with success */
-	if (FDCS->spec1 != spec1 || FDCS->spec2 != spec2) {
+	if (fdc_state[fdc].spec1 != spec1 || fdc_state[fdc].spec2 != spec2) {
 		/* Go ahead and set spec1 and spec2 */
 		output_byte(FD_SPECIFY);
-		output_byte(FDCS->spec1 = spec1);
-		output_byte(FDCS->spec2 = spec2);
+		output_byte(fdc_state[fdc].spec1 = spec1);
+		output_byte(fdc_state[fdc].spec2 = spec2);
 	}
 }				/* fdc_specify */
 
@@ -1350,7 +1349,7 @@ static void fdc_specify(void)
 static int fdc_dtr(void)
 {
 	/* If data rate not already set to desired value, set it. */
-	if ((raw_cmd->rate & 3) == FDCS->dtr)
+	if ((raw_cmd->rate & 3) == fdc_state[fdc].dtr)
 		return 0;
 
 	/* Set dtr */
@@ -1361,7 +1360,7 @@ static int fdc_dtr(void)
 	 * enforced after data rate changes before R/W operations.
 	 * Pause 5 msec to avoid trouble. (Needs to be 2 jiffies)
 	 */
-	FDCS->dtr = raw_cmd->rate & 3;
+	fdc_state[fdc].dtr = raw_cmd->rate & 3;
 	return fd_wait_for_completion(jiffies + 2UL * HZ / 100, floppy_ready);
 }				/* fdc_dtr */
 
@@ -1414,7 +1413,7 @@ static int interpret_errors(void)
 
 	if (inr != 7) {
 		DPRINT("-- FDC reply error\n");
-		FDCS->reset = 1;
+		fdc_state[fdc].reset = 1;
 		return 1;
 	}
 
@@ -1548,7 +1547,7 @@ static void check_wp(void)
 		output_byte(FD_GETSTATUS);
 		output_byte(UNIT(current_drive));
 		if (result() != 1) {
-			FDCS->reset = 1;
+			fdc_state[fdc].reset = 1;
 			return;
 		}
 		clear_bit(FD_VERIFY_BIT, &DRS->flags);
@@ -1625,7 +1624,7 @@ static void recal_interrupt(void)
 {
 	debugt(__func__, "");
 	if (inr != 2)
-		FDCS->reset = 1;
+		fdc_state[fdc].reset = 1;
 	else if (ST0 & ST0_ECE) {
 		switch (DRS->track) {
 		case NEED_1_RECAL:
@@ -1693,7 +1692,7 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 	release_dma_lock(f);
 
 	do_floppy = NULL;
-	if (fdc >= N_FDC || FDCS->address == -1) {
+	if (fdc >= N_FDC || fdc_state[fdc].address == -1) {
 		/* we don't even know which FDC is the culprit */
 		pr_info("DOR0=%x\n", fdc_state[0].dor);
 		pr_info("floppy interrupt on bizarre fdc %d\n", fdc);
@@ -1702,11 +1701,11 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	FDCS->reset = 0;
+	fdc_state[fdc].reset = 0;
 	/* We have to clear the reset flag here, because apparently on boxes
 	 * with level triggered interrupts (PS/2, Sparc, ...), it is needed to
-	 * emit SENSEI's to clear the interrupt line. And FDCS->reset blocks the
-	 * emission of the SENSEI's.
+	 * emit SENSEI's to clear the interrupt line. And fdc_state[fdc].reset
+	 * blocks the emission of the SENSEI's.
 	 * It is OK to emit floppy commands because we are in an interrupt
 	 * handler here, and thus we have to fear no interference of other
 	 * activity.
@@ -1729,7 +1728,7 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 			 inr == 2 && max_sensei);
 	}
 	if (!handler) {
-		FDCS->reset = 1;
+		fdc_state[fdc].reset = 1;
 		return IRQ_NONE;
 	}
 	schedule_bh(handler);
@@ -1755,7 +1754,7 @@ static void reset_interrupt(void)
 {
 	debugt(__func__, "");
 	result();		/* get the status ready for set_fdc */
-	if (FDCS->reset) {
+	if (fdc_state[fdc].reset) {
 		pr_info("reset set in interrupt, calling %ps\n", cont->error);
 		cont->error();	/* a reset just after a reset. BAD! */
 	}
@@ -1771,7 +1770,7 @@ static void reset_fdc(void)
 	unsigned long flags;
 
 	do_floppy = reset_interrupt;
-	FDCS->reset = 0;
+	fdc_state[fdc].reset = 0;
 	reset_fdc_info(0);
 
 	/* Pseudo-DMA may intercept 'reset finished' interrupt.  */
@@ -1781,12 +1780,12 @@ static void reset_fdc(void)
 	fd_disable_dma();
 	release_dma_lock(flags);
 
-	if (FDCS->version >= FDC_82072A)
-		fd_outb(0x80 | (FDCS->dtr & 3), FD_STATUS);
+	if (fdc_state[fdc].version >= FDC_82072A)
+		fd_outb(0x80 | (fdc_state[fdc].dtr & 3), FD_STATUS);
 	else {
-		fd_outb(FDCS->dor & ~0x04, FD_DOR);
+		fd_outb(fdc_state[fdc].dor & ~0x04, FD_DOR);
 		udelay(FD_RESET_DELAY);
-		fd_outb(FDCS->dor, FD_DOR);
+		fd_outb(fdc_state[fdc].dor, FD_DOR);
 	}
 }
 
@@ -1850,7 +1849,7 @@ static void floppy_shutdown(struct work_struct *arg)
 
 	if (initialized)
 		DPRINT("floppy timeout called\n");
-	FDCS->reset = 1;
+	fdc_state[fdc].reset = 1;
 	if (cont) {
 		cont->done(0);
 		cont->redo();	/* this will recall reset when needed */
@@ -1870,7 +1869,7 @@ static int start_motor(void (*function)(void))
 	mask = 0xfc;
 	data = UNIT(current_drive);
 	if (!(raw_cmd->flags & FD_RAW_NO_MOTOR)) {
-		if (!(FDCS->dor & (0x10 << UNIT(current_drive)))) {
+		if (!(fdc_state[fdc].dor & (0x10 << UNIT(current_drive)))) {
 			set_debugt();
 			/* no read since this drive is running */
 			DRS->first_read_date = 0;
@@ -1878,7 +1877,7 @@ static int start_motor(void (*function)(void))
 			DRS->spinup_date = jiffies;
 			data |= (0x10 << UNIT(current_drive));
 		}
-	} else if (FDCS->dor & (0x10 << UNIT(current_drive)))
+	} else if (fdc_state[fdc].dor & (0x10 << UNIT(current_drive)))
 		mask &= ~(0x10 << UNIT(current_drive));
 
 	/* starts motor and selects floppy */
@@ -1892,7 +1891,7 @@ static int start_motor(void (*function)(void))
 
 static void floppy_ready(void)
 {
-	if (FDCS->reset) {
+	if (fdc_state[fdc].reset) {
 		reset_fdc();
 		return;
 	}
@@ -1991,7 +1990,7 @@ static int wait_til_done(void (*handler)(void), bool interruptible)
 		return -EINTR;
 	}
 
-	if (FDCS->reset)
+	if (fdc_state[fdc].reset)
 		command_status = FD_COMMAND_ERROR;
 	if (command_status == FD_COMMAND_OKAY)
 		ret = 0;
@@ -2060,7 +2059,7 @@ static void bad_flp_intr(void)
 	if (err_count > DP->max_errors.abort)
 		cont->done(0);
 	if (err_count > DP->max_errors.reset)
-		FDCS->reset = 1;
+		fdc_state[fdc].reset = 1;
 	else if (err_count > DP->max_errors.recal)
 		DRS->track = NEED_2_RECAL;
 }
@@ -2967,8 +2966,8 @@ static int user_reset_fdc(int drive, int arg, bool interruptible)
 		return -EINTR;
 
 	if (arg == FD_RESET_ALWAYS)
-		FDCS->reset = 1;
-	if (FDCS->reset) {
+		fdc_state[fdc].reset = 1;
+	if (fdc_state[fdc].reset) {
 		cont = &reset_cont;
 		ret = wait_til_done(reset_fdc, interruptible);
 		if (ret == -EINTR)
@@ -3179,23 +3178,23 @@ static int raw_cmd_ioctl(int cmd, void __user *param)
 	int ret2;
 	int ret;
 
-	if (FDCS->rawcmd <= 1)
-		FDCS->rawcmd = 1;
+	if (fdc_state[fdc].rawcmd <= 1)
+		fdc_state[fdc].rawcmd = 1;
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		if (FDC(drive) != fdc)
 			continue;
 		if (drive == current_drive) {
 			if (UDRS->fd_ref > 1) {
-				FDCS->rawcmd = 2;
+				fdc_state[fdc].rawcmd = 2;
 				break;
 			}
 		} else if (UDRS->fd_ref) {
-			FDCS->rawcmd = 2;
+			fdc_state[fdc].rawcmd = 2;
 			break;
 		}
 	}
 
-	if (FDCS->reset)
+	if (fdc_state[fdc].reset)
 		return -EIO;
 
 	ret = raw_cmd_copyin(cmd, param, &my_raw_cmd);
@@ -3209,7 +3208,7 @@ static int raw_cmd_ioctl(int cmd, void __user *param)
 	ret = wait_til_done(floppy_start, true);
 	debug_dcl(DP->flags, "calling disk change from raw_cmd ioctl\n");
 
-	if (ret != -EINTR && FDCS->reset)
+	if (ret != -EINTR && fdc_state[fdc].reset)
 		ret = -EIO;
 
 	DRS->track = NO_TRACK;
@@ -4261,7 +4260,7 @@ static char __init get_fdc_version(void)
 	int r;
 
 	output_byte(FD_DUMPREGS);	/* 82072 and better know DUMPREGS */
-	if (FDCS->reset)
+	if (fdc_state[fdc].reset)
 		return FDC_NONE;
 	r = result();
 	if (r <= 0x00)
@@ -4494,7 +4493,7 @@ static int floppy_resume(struct device *dev)
 	int fdc;
 
 	for (fdc = 0; fdc < N_FDC; fdc++)
-		if (FDCS->address != -1)
+		if (fdc_state[fdc].address != -1)
 			user_reset_fdc(-1, FD_RESET_ALWAYS, false);
 
 	return 0;
@@ -4605,15 +4604,15 @@ static int __init do_floppy_init(void)
 
 	for (i = 0; i < N_FDC; i++) {
 		fdc = i;
-		memset(FDCS, 0, sizeof(*FDCS));
-		FDCS->dtr = -1;
-		FDCS->dor = 0x4;
+		memset(&fdc_state[fdc], 0, sizeof(*fdc_state));
+		fdc_state[fdc].dtr = -1;
+		fdc_state[fdc].dor = 0x4;
 #if defined(__sparc__) || defined(__mc68000__)
 	/*sparcs/sun3x don't have a DOR reset which we can fall back on to */
 #ifdef __mc68000__
 		if (MACH_IS_SUN3X)
 #endif
-			FDCS->version = FDC_82072A;
+			fdc_state[fdc].version = FDC_82072A;
 #endif
 	}
 
@@ -4656,28 +4655,28 @@ static int __init do_floppy_init(void)
 
 	for (i = 0; i < N_FDC; i++) {
 		fdc = i;
-		FDCS->driver_version = FD_DRIVER_VERSION;
+		fdc_state[fdc].driver_version = FD_DRIVER_VERSION;
 		for (unit = 0; unit < 4; unit++)
-			FDCS->track[unit] = 0;
-		if (FDCS->address == -1)
+			fdc_state[fdc].track[unit] = 0;
+		if (fdc_state[fdc].address == -1)
 			continue;
-		FDCS->rawcmd = 2;
+		fdc_state[fdc].rawcmd = 2;
 		if (user_reset_fdc(-1, FD_RESET_ALWAYS, false)) {
 			/* free ioports reserved by floppy_grab_irq_and_dma() */
 			floppy_release_regions(fdc);
-			FDCS->address = -1;
-			FDCS->version = FDC_NONE;
+			fdc_state[fdc].address = -1;
+			fdc_state[fdc].version = FDC_NONE;
 			continue;
 		}
 		/* Try to determine the floppy controller type */
-		FDCS->version = get_fdc_version();
-		if (FDCS->version == FDC_NONE) {
+		fdc_state[fdc].version = get_fdc_version();
+		if (fdc_state[fdc].version == FDC_NONE) {
 			/* free ioports reserved by floppy_grab_irq_and_dma() */
 			floppy_release_regions(fdc);
-			FDCS->address = -1;
+			fdc_state[fdc].address = -1;
 			continue;
 		}
-		if (can_use_virtual_dma == 2 && FDCS->version < FDC_82072A)
+		if (can_use_virtual_dma == 2 && fdc_state[fdc].version < FDC_82072A)
 			can_use_virtual_dma = 0;
 
 		have_no_fdc = 0;
@@ -4783,7 +4782,7 @@ static void floppy_release_allocated_regions(int fdc, const struct io_region *p)
 {
 	while (p != io_regions) {
 		p--;
-		release_region(FDCS->address + p->offset, p->size);
+		release_region(fdc_state[fdc].address + p->offset, p->size);
 	}
 }
 
@@ -4794,10 +4793,10 @@ static int floppy_request_regions(int fdc)
 	const struct io_region *p;
 
 	for (p = io_regions; p < ARRAY_END(io_regions); p++) {
-		if (!request_region(FDCS->address + p->offset,
+		if (!request_region(fdc_state[fdc].address + p->offset,
 				    p->size, "floppy")) {
 			DPRINT("Floppy io-port 0x%04lx in use\n",
-			       FDCS->address + p->offset);
+			       fdc_state[fdc].address + p->offset);
 			floppy_release_allocated_regions(fdc, p);
 			return -EBUSY;
 		}
@@ -4840,23 +4839,23 @@ static int floppy_grab_irq_and_dma(void)
 	}
 
 	for (fdc = 0; fdc < N_FDC; fdc++) {
-		if (FDCS->address != -1) {
+		if (fdc_state[fdc].address != -1) {
 			if (floppy_request_regions(fdc))
 				goto cleanup;
 		}
 	}
 	for (fdc = 0; fdc < N_FDC; fdc++) {
-		if (FDCS->address != -1) {
+		if (fdc_state[fdc].address != -1) {
 			reset_fdc_info(1);
-			fd_outb(FDCS->dor, FD_DOR);
+			fd_outb(fdc_state[fdc].dor, FD_DOR);
 		}
 	}
 	fdc = 0;
 	set_dor(0, ~0, 8);	/* avoid immediate interrupt */
 
 	for (fdc = 0; fdc < N_FDC; fdc++)
-		if (FDCS->address != -1)
-			fd_outb(FDCS->dor, FD_DOR);
+		if (fdc_state[fdc].address != -1)
+			fd_outb(fdc_state[fdc].dor, FD_DOR);
 	/*
 	 * The driver will try and free resources and relies on us
 	 * to know if they were allocated or not.
@@ -4918,7 +4917,7 @@ static void floppy_release_irq_and_dma(void)
 		pr_info("work still pending\n");
 	old_fdc = fdc;
 	for (fdc = 0; fdc < N_FDC; fdc++)
-		if (FDCS->address != -1)
+		if (fdc_state[fdc].address != -1)
 			floppy_release_regions(fdc);
 	fdc = old_fdc;
 }
-- 
2.9.0

