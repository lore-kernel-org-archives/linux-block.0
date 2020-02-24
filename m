Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB1C38BFA
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A4A21D7E
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgBXVkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:40:53 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgBXVkv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 16:40:51 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO5v6008697;
        Mon, 24 Feb 2020 22:24:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 06/10] floppy: cleanup: expand macro DP
Date:   Mon, 24 Feb 2020 22:23:48 +0100
Message-Id: <20200224212352.8640-7-w@1wt.eu>
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
 drivers/block/floppy.c | 84 ++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index a76a9bb..7744e42 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -306,7 +306,6 @@ static bool initialized;
 	/* reverse mapping from unit and fdc to drive */
 #define REVDRIVE(fdc, unit) ((unit) + ((fdc) << 2))
 
-#define DP	(&drive_params[current_drive])
 #define DRS	(&drive_state[current_drive])
 #define DRWE	(&write_errors[current_drive])
 
@@ -624,7 +623,7 @@ static inline void set_debugt(void)
 
 static inline void debugt(const char *func, const char *msg)
 {
-	if (DP->flags & DEBUGT)
+	if (drive_params[current_drive].flags & DEBUGT)
 		pr_info("%s:%s dtime=%lu\n", func, msg, jiffies - debugtimer);
 }
 #else
@@ -824,7 +823,7 @@ static int set_dor(int fdc, char mask, char data)
 
 static void twaddle(void)
 {
-	if (DP->select_delay)
+	if (drive_params[current_drive].select_delay)
 		return;
 	fd_outb(fdc_state[fdc].dor & ~(0x10 << UNIT(current_drive)), FD_DOR);
 	fd_outb(fdc_state[fdc].dor, FD_DOR);
@@ -950,7 +949,7 @@ static void scandrives(void)
 	int drive;
 	int saved_drive;
 
-	if (DP->select_delay)
+	if (drive_params[current_drive].select_delay)
 		return;
 
 	saved_drive = current_drive;
@@ -1009,7 +1008,8 @@ static void cancel_activity(void)
  * transfer */
 static void fd_watchdog(void)
 {
-	debug_dcl(DP->flags, "calling disk change from watchdog\n");
+	debug_dcl(drive_params[current_drive].flags,
+		  "calling disk change from watchdog\n");
 
 	if (disk_change(current_drive)) {
 		DPRINT("disk removed during i/o\n");
@@ -1310,20 +1310,23 @@ static void fdc_specify(void)
 	}
 
 	/* Convert step rate from microseconds to milliseconds and 4 bits */
-	srt = 16 - DIV_ROUND_UP(DP->srt * scale_dtr / 1000, NOMINAL_DTR);
+	srt = 16 - DIV_ROUND_UP(drive_params[current_drive].srt * scale_dtr / 1000,
+				NOMINAL_DTR);
 	if (slow_floppy)
 		srt = srt / 4;
 
 	SUPBOUND(srt, 0xf);
 	INFBOUND(srt, 0);
 
-	hlt = DIV_ROUND_UP(DP->hlt * scale_dtr / 2, NOMINAL_DTR);
+	hlt = DIV_ROUND_UP(drive_params[current_drive].hlt * scale_dtr / 2,
+			   NOMINAL_DTR);
 	if (hlt < 0x01)
 		hlt = 0x01;
 	else if (hlt > 0x7f)
 		hlt = hlt_max_code;
 
-	hut = DIV_ROUND_UP(DP->hut * scale_dtr / 16, NOMINAL_DTR);
+	hut = DIV_ROUND_UP(drive_params[current_drive].hut * scale_dtr / 16,
+			   NOMINAL_DTR);
 	if (hut < 0x1)
 		hut = 0x1;
 	else if (hut > 0xf)
@@ -1430,10 +1433,10 @@ static int interpret_errors(void)
 		} else if (ST1 & ST1_ND) {
 			set_bit(FD_NEED_TWADDLE_BIT, &DRS->flags);
 		} else if (ST1 & ST1_OR) {
-			if (DP->flags & FTD_MSG)
+			if (drive_params[current_drive].flags & FTD_MSG)
 				DPRINT("Over/Underrun - retrying\n");
 			bad = 0;
-		} else if (*errors >= DP->max_errors.reporting) {
+		} else if (*errors >= drive_params[current_drive].max_errors.reporting) {
 			print_errors();
 		}
 		if (ST2 & ST2_WC || ST2 & ST2_BC)
@@ -1471,13 +1474,13 @@ static void setup_rw_floppy(void)
 		flags |= FD_RAW_INTR;
 
 	if ((flags & FD_RAW_SPIN) && !(flags & FD_RAW_NO_MOTOR)) {
-		ready_date = DRS->spinup_date + DP->spinup;
+		ready_date = DRS->spinup_date + drive_params[current_drive].spinup;
 		/* If spinup will take a long time, rerun scandrives
 		 * again just before spinup completion. Beware that
 		 * after scandrives, we must again wait for selection.
 		 */
-		if (time_after(ready_date, jiffies + DP->select_delay)) {
-			ready_date -= DP->select_delay;
+		if (time_after(ready_date, jiffies + drive_params[current_drive].select_delay)) {
+			ready_date -= drive_params[current_drive].select_delay;
 			function = floppy_start;
 		} else
 			function = setup_rw_floppy;
@@ -1528,9 +1531,10 @@ static void seek_interrupt(void)
 		return;
 	}
 	if (DRS->track >= 0 && DRS->track != ST1 && !blind_seek) {
-		debug_dcl(DP->flags,
+		debug_dcl(drive_params[current_drive].flags,
 			  "clearing NEWCHANGE flag because of effective seek\n");
-		debug_dcl(DP->flags, "jiffies=%lu\n", jiffies);
+		debug_dcl(drive_params[current_drive].flags, "jiffies=%lu\n",
+			  jiffies);
 		clear_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags);
 					/* effective seek */
 		DRS->select_date = jiffies;
@@ -1551,9 +1555,10 @@ static void check_wp(void)
 		}
 		clear_bit(FD_VERIFY_BIT, &DRS->flags);
 		clear_bit(FD_NEED_TWADDLE_BIT, &DRS->flags);
-		debug_dcl(DP->flags,
+		debug_dcl(drive_params[current_drive].flags,
 			  "checking whether disk is write protected\n");
-		debug_dcl(DP->flags, "wp=%x\n", ST3 & 0x40);
+		debug_dcl(drive_params[current_drive].flags, "wp=%x\n",
+			  ST3 & 0x40);
 		if (!(ST3 & 0x40))
 			set_bit(FD_DISK_WRITABLE_BIT, &DRS->flags);
 		else
@@ -1567,7 +1572,8 @@ static void seek_floppy(void)
 
 	blind_seek = 0;
 
-	debug_dcl(DP->flags, "calling disk change from %s\n", __func__);
+	debug_dcl(drive_params[current_drive].flags,
+		  "calling disk change from %s\n", __func__);
 
 	if (!test_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags) &&
 	    disk_change(current_drive) && (raw_cmd->flags & FD_RAW_NEED_DISK)) {
@@ -1591,7 +1597,7 @@ static void seek_floppy(void)
 		if (raw_cmd->track)
 			track = raw_cmd->track - 1;
 		else {
-			if (DP->flags & FD_SILENT_DCL_CLEAR) {
+			if (drive_params[current_drive].flags & FD_SILENT_DCL_CLEAR) {
 				set_dor(fdc, ~(0x10 << UNIT(current_drive)), 0);
 				blind_seek = 1;
 				raw_cmd->flags |= FD_RAW_NEED_SEEK;
@@ -1643,7 +1649,7 @@ static void recal_interrupt(void)
 			 * not to move at recalibration is to
 			 * be already at track 0.) Clear the
 			 * new change flag */
-			debug_dcl(DP->flags,
+			debug_dcl(drive_params[current_drive].flags,
 				  "clearing NEWCHANGE flag because of second recalibrate\n");
 
 			clear_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags);
@@ -1884,7 +1890,7 @@ static int start_motor(void (*function)(void))
 	set_dor(fdc, mask, data);
 
 	/* wait_for_completion also schedules reset if needed. */
-	return fd_wait_for_completion(DRS->select_date + DP->select_delay,
+	return fd_wait_for_completion(DRS->select_date + drive_params[current_drive].select_delay,
 				      function);
 }
 
@@ -1899,9 +1905,10 @@ static void floppy_ready(void)
 	if (fdc_dtr())
 		return;
 
-	debug_dcl(DP->flags, "calling disk change from floppy_ready\n");
+	debug_dcl(drive_params[current_drive].flags,
+		  "calling disk change from floppy_ready\n");
 	if (!(raw_cmd->flags & FD_RAW_NO_MOTOR) &&
-	    disk_change(current_drive) && !DP->select_delay)
+	    disk_change(current_drive) && !drive_params[current_drive].select_delay)
 		twaddle();	/* this clears the dcl on certain
 				 * drive/controller combinations */
 
@@ -1930,7 +1937,8 @@ static void floppy_start(void)
 	reschedule_timeout(current_reqD, "floppy start");
 
 	scandrives();
-	debug_dcl(DP->flags, "setting NEWCHANGE in floppy_start\n");
+	debug_dcl(drive_params[current_drive].flags,
+		  "setting NEWCHANGE in floppy_start\n");
 	set_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags);
 	floppy_ready();
 }
@@ -2032,11 +2040,11 @@ static int next_valid_format(void)
 
 	probed_format = DRS->probed_format;
 	while (1) {
-		if (probed_format >= 8 || !DP->autodetect[probed_format]) {
+		if (probed_format >= 8 || !drive_params[current_drive].autodetect[probed_format]) {
 			DRS->probed_format = 0;
 			return 1;
 		}
-		if (floppy_type[DP->autodetect[probed_format]].sect) {
+		if (floppy_type[drive_params[current_drive].autodetect[probed_format]].sect) {
 			DRS->probed_format = probed_format;
 			return 0;
 		}
@@ -2055,11 +2063,11 @@ static void bad_flp_intr(void)
 	}
 	err_count = ++(*errors);
 	INFBOUND(DRWE->badness, err_count);
-	if (err_count > DP->max_errors.abort)
+	if (err_count > drive_params[current_drive].max_errors.abort)
 		cont->done(0);
-	if (err_count > DP->max_errors.reset)
+	if (err_count > drive_params[current_drive].max_errors.reset)
 		fdc_state[fdc].reset = 1;
-	else if (err_count > DP->max_errors.recal)
+	else if (err_count > drive_params[current_drive].max_errors.recal)
 		DRS->track = NEED_2_RECAL;
 }
 
@@ -2189,7 +2197,7 @@ static int do_format(int drive, struct format_descr *tmp_format_req)
 
 	set_floppy(drive);
 	if (!_floppy ||
-	    _floppy->track > DP->tracks ||
+	    _floppy->track > drive_params[current_drive].tracks ||
 	    tmp_format_req->track >= _floppy->track ||
 	    tmp_format_req->head >= _floppy->head ||
 	    (_floppy->sect << 2) % (1 << FD_SIZECODE(_floppy)) ||
@@ -2345,7 +2353,7 @@ static void rw_interrupt(void)
 	}
 
 	if (probing) {
-		if (DP->flags & FTD_MSG)
+		if (drive_params[current_drive].flags & FTD_MSG)
 			DPRINT("Auto-detected floppy type %s in fd%d\n",
 			       _floppy->name, current_drive);
 		current_type[current_drive] = _floppy;
@@ -2675,9 +2683,9 @@ static int make_raw_rw_request(void)
 		 */
 		if (!direct ||
 		    (indirect * 2 > direct * 3 &&
-		     *errors < DP->max_errors.read_track &&
+		     *errors < drive_params[current_drive].max_errors.read_track &&
 		     ((!probing ||
-		       (DP->read_track & (1 << DRS->probed_format)))))) {
+		       (drive_params[current_drive].read_track & (1 << DRS->probed_format)))))) {
 			max_size = blk_rq_sectors(current_req);
 		} else {
 			raw_cmd->kernel_data = bio_data(current_req->bio);
@@ -2855,7 +2863,7 @@ static void redo_fd_request(void)
 			}
 		}
 		probing = 1;
-		_floppy = floppy_type + DP->autodetect[DRS->probed_format];
+		_floppy = floppy_type + drive_params[current_drive].autodetect[DRS->probed_format];
 	} else
 		probing = 0;
 	errors = &(current_req->error_count);
@@ -2934,7 +2942,8 @@ static int poll_drive(bool interruptible, int flag)
 	raw_cmd->track = 0;
 	raw_cmd->cmd_count = 0;
 	cont = &poll_cont;
-	debug_dcl(DP->flags, "setting NEWCHANGE in poll_drive\n");
+	debug_dcl(drive_params[current_drive].flags,
+		  "setting NEWCHANGE in poll_drive\n");
 	set_bit(FD_DISK_NEWCHANGE_BIT, &DRS->flags);
 
 	return wait_til_done(floppy_ready, interruptible);
@@ -3205,7 +3214,8 @@ static int raw_cmd_ioctl(int cmd, void __user *param)
 	raw_cmd = my_raw_cmd;
 	cont = &raw_cmd_cont;
 	ret = wait_til_done(floppy_start, true);
-	debug_dcl(DP->flags, "calling disk change from raw_cmd ioctl\n");
+	debug_dcl(drive_params[current_drive].flags,
+		  "calling disk change from raw_cmd ioctl\n");
 
 	if (ret != -EINTR && fdc_state[fdc].reset)
 		ret = -EIO;
@@ -4386,7 +4396,7 @@ static void __init set_cmos(int *ints, int dummy, int dummy2)
 	if (current_drive >= 4 && !FDC2)
 		FDC2 = 0x370;
 #endif
-	DP->cmos = ints[2];
+	drive_params[current_drive].cmos = ints[2];
 	DPRINT("setting CMOS code to %d\n", ints[2]);
 }
 
-- 
2.9.0

