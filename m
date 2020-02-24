Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A206C38C00
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3803D22525
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgBXVlB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:41:01 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgBXVk5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 16:40:57 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO5Dh008698;
        Mon, 24 Feb 2020 22:24:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 07/10] floppy: cleanup: expand macro DRS
Date:   Mon, 24 Feb 2020 22:23:49 +0100
Message-Id: <20200224212352.8640-8-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200224212352.8640-1-w@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This macro doesn't bring much value and only slightly obfuscates the
code by silently using global variable "current_drive", let's expand it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 115 ++++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 54 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 7744e42..6d4a2e1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -306,7 +306,6 @@ static bool initialized;
 	/* reverse mapping from unit and fdc to drive */
 #define REVDRIVE(fdc, unit) ((unit) + ((fdc) << 2))
 
-#define DRS	(&drive_state[current_drive])
 #define DRWE	(&write_errors[current_drive])
 
 #define PH_HEAD(floppy, head) (((((floppy)->stretch & 2) >> 1) ^ head) << 2)
@@ -827,7 +826,7 @@ static void twaddle(void)
 		return;
 	fd_outb(fdc_state[fdc].dor & ~(0x10 << UNIT(current_drive)), FD_DOR);
 	fd_outb(fdc_state[fdc].dor, FD_DOR);
-	DRS->select_date = jiffies;
+	drive_state[current_drive].select_date = jiffies;
 }
 
 /*
@@ -1427,11 +1426,13 @@ static int interpret_errors(void)
 		bad = 1;
 		if (ST1 & ST1_WP) {
 			DPRINT("Drive is write protected\n");
-			clear_bit(FD_DISK_WRITABLE_BIT, &DRS->flags);
+			clear_bit(FD_DISK_WRITABLE_BIT,
+				  &drive_state[current_drive].flags);
 			cont->done(0);
 			bad = 2;
 		} else if (ST1 & ST1_ND) {
-			set_bit(FD_NEED_TWADDLE_BIT, &DRS->flags);
+			set_bit(FD_NEED_TWADDLE_BIT,
+				&drive_state[current_drive].flags);
 		} else if (ST1 & ST1_OR) {
 			if (drive_params[current_drive].flags & FTD_MSG)
 				DPRINT("Over/Underrun - retrying\n");
@@ -1441,7 +1442,7 @@ static int interpret_errors(void)
 		}
 		if (ST2 & ST2_WC || ST2 & ST2_BC)
 			/* wrong cylinder => recal */
-			DRS->track = NEED_2_RECAL;
+			drive_state[current_drive].track = NEED_2_RECAL;
 		return bad;
 	case 0x80:		/* invalid command given */
 		DPRINT("Invalid FDC command given!\n");
@@ -1474,7 +1475,7 @@ static void setup_rw_floppy(void)
 		flags |= FD_RAW_INTR;
 
 	if ((flags & FD_RAW_SPIN) && !(flags & FD_RAW_NO_MOTOR)) {
-		ready_date = DRS->spinup_date + drive_params[current_drive].spinup;
+		ready_date = drive_state[current_drive].spinup_date + drive_params[current_drive].spinup;
 		/* If spinup will take a long time, rerun scandrives
 		 * again just before spinup completion. Beware that
 		 * after scandrives, we must again wait for selection.
@@ -1525,27 +1526,28 @@ static void seek_interrupt(void)
 	debugt(__func__, "");
 	if (inr != 2 || (ST0 & 0xF8) != 0x20) {
 		DPRINT("seek failed\n");
-		DRS->track = NEED_2_RECAL;
+		drive_state[current_drive].track = NEED_2_RECAL;
 		cont->error();
 		cont->redo();
 		return;
 	}
-	if (DRS->track >= 0 && DRS->track != ST1 && !blind_seek) {
+	if (drive_state[current_drive].track >= 0 && drive_state[current_drive].track != ST1 && !blind_seek) {
 		debug_dcl(drive_params[current_drive].flags,
 			  "clearing NEWCHANGE flag because of effective seek\n");
 		debug_dcl(drive_params[current_drive].flags, "jiffies=%lu\n",
 			  jiffies);
-		clear_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags);
+		clear_bit(FD_DISK_NEWCHANGE_BIT,
+			  &drive_state[current_drive].flags);
 					/* effective seek */
-		DRS->select_date = jiffies;
+		drive_state[current_drive].select_date = jiffies;
 	}
-	DRS->track = ST1;
+	drive_state[current_drive].track = ST1;
 	floppy_ready();
 }
 
 static void check_wp(void)
 {
-	if (test_bit(FD_VERIFY_BIT, &DRS->flags)) {
+	if (test_bit(FD_VERIFY_BIT, &drive_state[current_drive].flags)) {
 					/* check write protection */
 		output_byte(FD_GETSTATUS);
 		output_byte(UNIT(current_drive));
@@ -1553,16 +1555,19 @@ static void check_wp(void)
 			fdc_state[fdc].reset = 1;
 			return;
 		}
-		clear_bit(FD_VERIFY_BIT, &DRS->flags);
-		clear_bit(FD_NEED_TWADDLE_BIT, &DRS->flags);
+		clear_bit(FD_VERIFY_BIT, &drive_state[current_drive].flags);
+		clear_bit(FD_NEED_TWADDLE_BIT,
+			  &drive_state[current_drive].flags);
 		debug_dcl(drive_params[current_drive].flags,
 			  "checking whether disk is write protected\n");
 		debug_dcl(drive_params[current_drive].flags, "wp=%x\n",
 			  ST3 & 0x40);
 		if (!(ST3 & 0x40))
-			set_bit(FD_DISK_WRITABLE_BIT, &DRS->flags);
+			set_bit(FD_DISK_WRITABLE_BIT,
+				&drive_state[current_drive].flags);
 		else
-			clear_bit(FD_DISK_WRITABLE_BIT, &DRS->flags);
+			clear_bit(FD_DISK_WRITABLE_BIT,
+				  &drive_state[current_drive].flags);
 	}
 }
 
@@ -1575,23 +1580,24 @@ static void seek_floppy(void)
 	debug_dcl(drive_params[current_drive].flags,
 		  "calling disk change from %s\n", __func__);
 
-	if (!test_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags) &&
+	if (!test_bit(FD_DISK_NEWCHANGE_BIT, &drive_state[current_drive].flags) &&
 	    disk_change(current_drive) && (raw_cmd->flags & FD_RAW_NEED_DISK)) {
 		/* the media changed flag should be cleared after the seek.
 		 * If it isn't, this means that there is really no disk in
 		 * the drive.
 		 */
-		set_bit(FD_DISK_CHANGED_BIT, &DRS->flags);
+		set_bit(FD_DISK_CHANGED_BIT,
+			&drive_state[current_drive].flags);
 		cont->done(0);
 		cont->redo();
 		return;
 	}
-	if (DRS->track <= NEED_1_RECAL) {
+	if (drive_state[current_drive].track <= NEED_1_RECAL) {
 		recalibrate_floppy();
 		return;
-	} else if (test_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags) &&
+	} else if (test_bit(FD_DISK_NEWCHANGE_BIT, &drive_state[current_drive].flags) &&
 		   (raw_cmd->flags & FD_RAW_NEED_DISK) &&
-		   (DRS->track <= NO_TRACK || DRS->track == raw_cmd->track)) {
+		   (drive_state[current_drive].track <= NO_TRACK || drive_state[current_drive].track == raw_cmd->track)) {
 		/* we seek to clear the media-changed condition. Does anybody
 		 * know a more elegant way, which works on all drives? */
 		if (raw_cmd->track)
@@ -1606,7 +1612,7 @@ static void seek_floppy(void)
 		}
 	} else {
 		check_wp();
-		if (raw_cmd->track != DRS->track &&
+		if (raw_cmd->track != drive_state[current_drive].track &&
 		    (raw_cmd->flags & FD_RAW_NEED_SEEK))
 			track = raw_cmd->track;
 		else {
@@ -1631,7 +1637,7 @@ static void recal_interrupt(void)
 	if (inr != 2)
 		fdc_state[fdc].reset = 1;
 	else if (ST0 & ST0_ECE) {
-		switch (DRS->track) {
+		switch (drive_state[current_drive].track) {
 		case NEED_1_RECAL:
 			debugt(__func__, "need 1 recal");
 			/* after a second recalibrate, we still haven't
@@ -1652,8 +1658,9 @@ static void recal_interrupt(void)
 			debug_dcl(drive_params[current_drive].flags,
 				  "clearing NEWCHANGE flag because of second recalibrate\n");
 
-			clear_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags);
-			DRS->select_date = jiffies;
+			clear_bit(FD_DISK_NEWCHANGE_BIT,
+				  &drive_state[current_drive].flags);
+			drive_state[current_drive].select_date = jiffies;
 			/* fall through */
 		default:
 			debugt(__func__, "default");
@@ -1663,11 +1670,11 @@ static void recal_interrupt(void)
 			 * track 0, this might mean that we
 			 * started beyond track 80.  Try
 			 * again.  */
-			DRS->track = NEED_1_RECAL;
+			drive_state[current_drive].track = NEED_1_RECAL;
 			break;
 		}
 	} else
-		DRS->track = ST1;
+		drive_state[current_drive].track = ST1;
 	floppy_ready();
 }
 
@@ -1877,9 +1884,9 @@ static int start_motor(void (*function)(void))
 		if (!(fdc_state[fdc].dor & (0x10 << UNIT(current_drive)))) {
 			set_debugt();
 			/* no read since this drive is running */
-			DRS->first_read_date = 0;
+			drive_state[current_drive].first_read_date = 0;
 			/* note motor start time if motor is not yet running */
-			DRS->spinup_date = jiffies;
+			drive_state[current_drive].spinup_date = jiffies;
 			data |= (0x10 << UNIT(current_drive));
 		}
 	} else if (fdc_state[fdc].dor & (0x10 << UNIT(current_drive)))
@@ -1890,7 +1897,7 @@ static int start_motor(void (*function)(void))
 	set_dor(fdc, mask, data);
 
 	/* wait_for_completion also schedules reset if needed. */
-	return fd_wait_for_completion(DRS->select_date + drive_params[current_drive].select_delay,
+	return fd_wait_for_completion(drive_state[current_drive].select_date + drive_params[current_drive].select_delay,
 				      function);
 }
 
@@ -1939,7 +1946,7 @@ static void floppy_start(void)
 	scandrives();
 	debug_dcl(drive_params[current_drive].flags,
 		  "setting NEWCHANGE in floppy_start\n");
-	set_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags);
+	set_bit(FD_DISK_NEWCHANGE_BIT, &drive_state[current_drive].flags);
 	floppy_ready();
 }
 
@@ -2038,14 +2045,14 @@ static int next_valid_format(void)
 {
 	int probed_format;
 
-	probed_format = DRS->probed_format;
+	probed_format = drive_state[current_drive].probed_format;
 	while (1) {
 		if (probed_format >= 8 || !drive_params[current_drive].autodetect[probed_format]) {
-			DRS->probed_format = 0;
+			drive_state[current_drive].probed_format = 0;
 			return 1;
 		}
 		if (floppy_type[drive_params[current_drive].autodetect[probed_format]].sect) {
-			DRS->probed_format = probed_format;
+			drive_state[current_drive].probed_format = probed_format;
 			return 0;
 		}
 		probed_format++;
@@ -2057,7 +2064,7 @@ static void bad_flp_intr(void)
 	int err_count;
 
 	if (probing) {
-		DRS->probed_format++;
+		drive_state[current_drive].probed_format++;
 		if (!next_valid_format())
 			return;
 	}
@@ -2068,7 +2075,7 @@ static void bad_flp_intr(void)
 	if (err_count > drive_params[current_drive].max_errors.reset)
 		fdc_state[fdc].reset = 1;
 	else if (err_count > drive_params[current_drive].max_errors.recal)
-		DRS->track = NEED_2_RECAL;
+		drive_state[current_drive].track = NEED_2_RECAL;
 }
 
 static void set_floppy(int drive)
@@ -2259,9 +2266,9 @@ static void request_done(int uptodate)
 		/* maintain values for invalidation on geometry
 		 * change */
 		block = current_count_sectors + blk_rq_pos(req);
-		INFBOUND(DRS->maxblock, block);
+		INFBOUND(drive_state[current_drive].maxblock, block);
 		if (block > _floppy->sect)
-			DRS->maxtrack = 1;
+			drive_state[current_drive].maxtrack = 1;
 
 		floppy_end_request(req, 0);
 	} else {
@@ -2270,10 +2277,10 @@ static void request_done(int uptodate)
 			DRWE->write_errors++;
 			if (DRWE->write_errors == 1) {
 				DRWE->first_error_sector = blk_rq_pos(req);
-				DRWE->first_error_generation = DRS->generation;
+				DRWE->first_error_generation = drive_state[current_drive].generation;
 			}
 			DRWE->last_error_sector = blk_rq_pos(req);
-			DRWE->last_error_generation = DRS->generation;
+			DRWE->last_error_generation = drive_state[current_drive].generation;
 		}
 		floppy_end_request(req, BLK_STS_IOERR);
 	}
@@ -2294,8 +2301,8 @@ static void rw_interrupt(void)
 		return;
 	}
 
-	if (!DRS->first_read_date)
-		DRS->first_read_date = jiffies;
+	if (!drive_state[current_drive].first_read_date)
+		drive_state[current_drive].first_read_date = jiffies;
 
 	nr_sectors = 0;
 	ssize = DIV_ROUND_UP(1 << SIZECODE, 4);
@@ -2568,7 +2575,7 @@ static int make_raw_rw_request(void)
 	HEAD = fsector_t / _floppy->sect;
 
 	if (((_floppy->stretch & (FD_SWAPSIDES | FD_SECTBASEMASK)) ||
-	     test_bit(FD_NEED_TWADDLE_BIT, &DRS->flags)) &&
+	     test_bit(FD_NEED_TWADDLE_BIT, &drive_state[current_drive].flags)) &&
 	    fsector_t < _floppy->sect)
 		max_sector = _floppy->sect;
 
@@ -2685,7 +2692,7 @@ static int make_raw_rw_request(void)
 		    (indirect * 2 > direct * 3 &&
 		     *errors < drive_params[current_drive].max_errors.read_track &&
 		     ((!probing ||
-		       (drive_params[current_drive].read_track & (1 << DRS->probed_format)))))) {
+		       (drive_params[current_drive].read_track & (1 << drive_state[current_drive].probed_format)))))) {
 			max_size = blk_rq_sectors(current_req);
 		} else {
 			raw_cmd->kernel_data = bio_data(current_req->bio);
@@ -2847,14 +2854,14 @@ static void redo_fd_request(void)
 
 	disk_change(current_drive);
 	if (test_bit(current_drive, &fake_change) ||
-	    test_bit(FD_DISK_CHANGED_BIT, &DRS->flags)) {
+	    test_bit(FD_DISK_CHANGED_BIT, &drive_state[current_drive].flags)) {
 		DPRINT("disk absent or changed during operation\n");
 		request_done(0);
 		goto do_request;
 	}
 	if (!_floppy) {	/* Autodetection */
 		if (!probing) {
-			DRS->probed_format = 0;
+			drive_state[current_drive].probed_format = 0;
 			if (next_valid_format()) {
 				DPRINT("no autodetectable formats\n");
 				_floppy = NULL;
@@ -2863,7 +2870,7 @@ static void redo_fd_request(void)
 			}
 		}
 		probing = 1;
-		_floppy = floppy_type + drive_params[current_drive].autodetect[DRS->probed_format];
+		_floppy = floppy_type + drive_params[current_drive].autodetect[drive_state[current_drive].probed_format];
 	} else
 		probing = 0;
 	errors = &(current_req->error_count);
@@ -2873,7 +2880,7 @@ static void redo_fd_request(void)
 		goto do_request;
 	}
 
-	if (test_bit(FD_NEED_TWADDLE_BIT, &DRS->flags))
+	if (test_bit(FD_NEED_TWADDLE_BIT, &drive_state[current_drive].flags))
 		twaddle();
 	schedule_bh(floppy_start);
 	debugt(__func__, "queue fd request");
@@ -2944,7 +2951,7 @@ static int poll_drive(bool interruptible, int flag)
 	cont = &poll_cont;
 	debug_dcl(drive_params[current_drive].flags,
 		  "setting NEWCHANGE in poll_drive\n");
-	set_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags);
+	set_bit(FD_DISK_NEWCHANGE_BIT, &drive_state[current_drive].flags);
 
 	return wait_til_done(floppy_ready, interruptible);
 }
@@ -3220,7 +3227,7 @@ static int raw_cmd_ioctl(int cmd, void __user *param)
 	if (ret != -EINTR && fdc_state[fdc].reset)
 		ret = -EIO;
 
-	DRS->track = NO_TRACK;
+	drive_state[current_drive].track = NO_TRACK;
 
 	ret2 = raw_cmd_copyout(cmd, param, my_raw_cmd);
 	if (!ret)
@@ -3293,16 +3300,16 @@ static int set_geometry(unsigned int cmd, struct floppy_struct *g,
 		current_type[drive] = &user_params[drive];
 		floppy_sizes[drive] = user_params[drive].size;
 		if (cmd == FDDEFPRM)
-			DRS->keep_data = -1;
+			drive_state[current_drive].keep_data = -1;
 		else
-			DRS->keep_data = 1;
+			drive_state[current_drive].keep_data = 1;
 		/* invalidation. Invalidate only when needed, i.e.
 		 * when there are already sectors in the buffer cache
 		 * whose number will change. This is useful, because
 		 * mtools often changes the geometry of the disk after
 		 * looking at the boot block */
-		if (DRS->maxblock > user_params[drive].sect ||
-		    DRS->maxtrack ||
+		if (drive_state[current_drive].maxblock > user_params[drive].sect ||
+		    drive_state[current_drive].maxtrack ||
 		    ((user_params[drive].sect ^ oldStretch) &
 		     (FD_SWAPSIDES | FD_SECTBASEMASK)))
 			invalidate_drive(bdev);
-- 
2.9.0

