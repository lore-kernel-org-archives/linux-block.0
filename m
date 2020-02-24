Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80674C38BFA
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5D02176D
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgBXVkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:40:55 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgBXVkz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 16:40:55 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO4La008694;
        Mon, 24 Feb 2020 22:24:04 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 03/10] floppy: cleanup: expand macro UDP
Date:   Mon, 24 Feb 2020 22:23:45 +0100
Message-Id: <20200224212352.8640-4-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200224212352.8640-1-w@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This macro doesn't bring much value and only slightly obfuscates the
code by silently using local variable "drive", let's expand it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 152 +++++++++++++++++++++++++------------------------
 1 file changed, 77 insertions(+), 75 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 182148a..8fcedb2 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -310,7 +310,6 @@ static bool initialized;
 #define DRS	(&drive_state[current_drive])
 #define DRWE	(&write_errors[current_drive])
 
-#define UDP	(&drive_params[drive])
 #define UDRS	(&drive_state[drive])
 #define UDRWE	(&write_errors[drive])
 
@@ -681,10 +680,10 @@ static void __reschedule_timeout(int drive, const char *message)
 		delay = 20UL * HZ;
 		drive = 0;
 	} else
-		delay = UDP->timeout;
+		delay = drive_params[drive].timeout;
 
 	mod_delayed_work(floppy_wq, &fd_timeout, delay);
-	if (UDP->flags & FD_DEBUG)
+	if (drive_params[drive].flags & FD_DEBUG)
 		DPRINT("reschedule timeout %s\n", message);
 	timeout_message = message;
 }
@@ -738,7 +737,7 @@ static int disk_change(int drive)
 {
 	int fdc = FDC(drive);
 
-	if (time_before(jiffies, UDRS->select_date + UDP->select_delay))
+	if (time_before(jiffies, UDRS->select_date + drive_params[drive].select_delay))
 		DPRINT("WARNING disk change called early\n");
 	if (!(fdc_state[fdc].dor & (0x10 << UNIT(drive))) ||
 	    (fdc_state[fdc].dor & 3) != UNIT(drive) || fdc != FDC(drive)) {
@@ -747,15 +746,16 @@ static int disk_change(int drive)
 		       (unsigned int)fdc_state[fdc].dor);
 	}
 
-	debug_dcl(UDP->flags,
+	debug_dcl(drive_params[drive].flags,
 		  "checking disk change line for drive %d\n", drive);
-	debug_dcl(UDP->flags, "jiffies=%lu\n", jiffies);
-	debug_dcl(UDP->flags, "disk change line=%x\n", fd_inb(FD_DIR) & 0x80);
-	debug_dcl(UDP->flags, "flags=%lx\n", UDRS->flags);
+	debug_dcl(drive_params[drive].flags, "jiffies=%lu\n", jiffies);
+	debug_dcl(drive_params[drive].flags, "disk change line=%x\n",
+		  fd_inb(FD_DIR) & 0x80);
+	debug_dcl(drive_params[drive].flags, "flags=%lx\n", UDRS->flags);
 
-	if (UDP->flags & FD_BROKEN_DCL)
+	if (drive_params[drive].flags & FD_BROKEN_DCL)
 		return test_bit(FD_DISK_CHANGED_BIT, &UDRS->flags);
-	if ((fd_inb(FD_DIR) ^ UDP->flags) & 0x80) {
+	if ((fd_inb(FD_DIR) ^ drive_params[drive].flags) & 0x80) {
 		set_bit(FD_VERIFY_BIT, &UDRS->flags);
 					/* verify write protection */
 
@@ -764,7 +764,7 @@ static int disk_change(int drive)
 
 		/* invalidate its geometry */
 		if (UDRS->keep_data >= 0) {
-			if ((UDP->flags & FTD_MSG) &&
+			if ((drive_params[drive].flags & FTD_MSG) &&
 			    current_type[drive] != NULL)
 				DPRINT("Disk type is undefined after disk change\n");
 			current_type[drive] = NULL;
@@ -806,7 +806,7 @@ static int set_dor(int fdc, char mask, char data)
 		unit = olddor & 0x3;
 		if (is_selected(olddor, unit) && !is_selected(newdor, unit)) {
 			drive = REVDRIVE(fdc, unit);
-			debug_dcl(UDP->flags,
+			debug_dcl(drive_params[drive].flags,
 				  "calling disk change from set_dor\n");
 			disk_change(drive);
 		}
@@ -929,12 +929,12 @@ static void floppy_off(unsigned int drive)
 
 	/* make spindle stop in a position which minimizes spinup time
 	 * next time */
-	if (UDP->rps) {
+	if (drive_params[drive].rps) {
 		delta = jiffies - UDRS->first_read_date + HZ -
-		    UDP->spindown_offset;
-		delta = ((delta * UDP->rps) % HZ) / UDP->rps;
+		    drive_params[drive].spindown_offset;
+		delta = ((delta * drive_params[drive].rps) % HZ) / drive_params[drive].rps;
 		motor_off_timer[drive].expires =
-		    jiffies + UDP->spindown - delta;
+		    jiffies + drive_params[drive].spindown - delta;
 	}
 	add_timer(motor_off_timer + drive);
 }
@@ -956,7 +956,7 @@ static void scandrives(void)
 	saved_drive = current_drive;
 	for (i = 0; i < N_DRIVE; i++) {
 		drive = (saved_drive + i + 1) % N_DRIVE;
-		if (UDRS->fd_ref == 0 || UDP->select_delay != 0)
+		if (UDRS->fd_ref == 0 || drive_params[drive].select_delay != 0)
 			continue;	/* skip closed drives */
 		set_fdc(drive);
 		if (!(set_dor(fdc, ~3, UNIT(drive) | (0x10 << UNIT(drive))) &
@@ -2999,8 +2999,8 @@ static const char *drive_name(int type, int drive)
 	if (type)
 		floppy = floppy_type + type;
 	else {
-		if (UDP->native_format)
-			floppy = floppy_type + UDP->native_format;
+		if (drive_params[drive].native_format)
+			floppy = floppy_type + drive_params[drive].native_format;
 		else
 			return "(null)";
 	}
@@ -3240,7 +3240,7 @@ static int set_geometry(unsigned int cmd, struct floppy_struct *g,
 	    (int)(g->sect * g->head) <= 0 ||
 	    /* check for zero in F_SECT_PER_TRACK */
 	    (unsigned char)((g->sect << 2) >> FD_SIZECODE(g)) == 0 ||
-	    g->track <= 0 || g->track > UDP->tracks >> STRETCH(g) ||
+	    g->track <= 0 || g->track > drive_params[drive].tracks >> STRETCH(g) ||
 	    /* check if reserved bits are set */
 	    (g->stretch & ~(FD_STRETCH | FD_SWAPSIDES | FD_SECTBASEMASK)) != 0)
 		return -EINVAL;
@@ -3487,10 +3487,10 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 		outparam = &inparam.g;
 		break;
 	case FDMSGON:
-		UDP->flags |= FTD_MSG;
+		drive_params[drive].flags |= FTD_MSG;
 		return 0;
 	case FDMSGOFF:
-		UDP->flags &= ~FTD_MSG;
+		drive_params[drive].flags &= ~FTD_MSG;
 		return 0;
 	case FDFMTBEG:
 		if (lock_fdc(drive))
@@ -3514,13 +3514,13 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 			return -EINTR;
 		return invalidate_drive(bdev);
 	case FDSETEMSGTRESH:
-		UDP->max_errors.reporting = (unsigned short)(param & 0x0f);
+		drive_params[drive].max_errors.reporting = (unsigned short)(param & 0x0f);
 		return 0;
 	case FDGETMAXERRS:
-		outparam = &UDP->max_errors;
+		outparam = &drive_params[drive].max_errors;
 		break;
 	case FDSETMAXERRS:
-		UDP->max_errors = inparam.max_errors;
+		drive_params[drive].max_errors = inparam.max_errors;
 		break;
 	case FDGETDRVTYP:
 		outparam = drive_name(type, drive);
@@ -3530,10 +3530,10 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 		if (!valid_floppy_drive_params(inparam.dp.autodetect,
 				inparam.dp.native_format))
 			return -EINVAL;
-		*UDP = inparam.dp;
+		drive_params[drive] = inparam.dp;
 		break;
 	case FDGETDRVPRM:
-		outparam = UDP;
+		outparam = &drive_params[drive];
 		break;
 	case FDPOLLDRVSTAT:
 		if (lock_fdc(drive))
@@ -3730,25 +3730,26 @@ static int compat_setdrvprm(int drive,
 	if (!valid_floppy_drive_params(v.autodetect, v.native_format))
 		return -EINVAL;
 	mutex_lock(&floppy_mutex);
-	UDP->cmos = v.cmos;
-	UDP->max_dtr = v.max_dtr;
-	UDP->hlt = v.hlt;
-	UDP->hut = v.hut;
-	UDP->srt = v.srt;
-	UDP->spinup = v.spinup;
-	UDP->spindown = v.spindown;
-	UDP->spindown_offset = v.spindown_offset;
-	UDP->select_delay = v.select_delay;
-	UDP->rps = v.rps;
-	UDP->tracks = v.tracks;
-	UDP->timeout = v.timeout;
-	UDP->interleave_sect = v.interleave_sect;
-	UDP->max_errors = v.max_errors;
-	UDP->flags = v.flags;
-	UDP->read_track = v.read_track;
-	memcpy(UDP->autodetect, v.autodetect, sizeof(v.autodetect));
-	UDP->checkfreq = v.checkfreq;
-	UDP->native_format = v.native_format;
+	drive_params[drive].cmos = v.cmos;
+	drive_params[drive].max_dtr = v.max_dtr;
+	drive_params[drive].hlt = v.hlt;
+	drive_params[drive].hut = v.hut;
+	drive_params[drive].srt = v.srt;
+	drive_params[drive].spinup = v.spinup;
+	drive_params[drive].spindown = v.spindown;
+	drive_params[drive].spindown_offset = v.spindown_offset;
+	drive_params[drive].select_delay = v.select_delay;
+	drive_params[drive].rps = v.rps;
+	drive_params[drive].tracks = v.tracks;
+	drive_params[drive].timeout = v.timeout;
+	drive_params[drive].interleave_sect = v.interleave_sect;
+	drive_params[drive].max_errors = v.max_errors;
+	drive_params[drive].flags = v.flags;
+	drive_params[drive].read_track = v.read_track;
+	memcpy(drive_params[drive].autodetect, v.autodetect,
+	       sizeof(v.autodetect));
+	drive_params[drive].checkfreq = v.checkfreq;
+	drive_params[drive].native_format = v.native_format;
 	mutex_unlock(&floppy_mutex);
 	return 0;
 }
@@ -3760,25 +3761,26 @@ static int compat_getdrvprm(int drive,
 
 	memset(&v, 0, sizeof(struct compat_floppy_drive_params));
 	mutex_lock(&floppy_mutex);
-	v.cmos = UDP->cmos;
-	v.max_dtr = UDP->max_dtr;
-	v.hlt = UDP->hlt;
-	v.hut = UDP->hut;
-	v.srt = UDP->srt;
-	v.spinup = UDP->spinup;
-	v.spindown = UDP->spindown;
-	v.spindown_offset = UDP->spindown_offset;
-	v.select_delay = UDP->select_delay;
-	v.rps = UDP->rps;
-	v.tracks = UDP->tracks;
-	v.timeout = UDP->timeout;
-	v.interleave_sect = UDP->interleave_sect;
-	v.max_errors = UDP->max_errors;
-	v.flags = UDP->flags;
-	v.read_track = UDP->read_track;
-	memcpy(v.autodetect, UDP->autodetect, sizeof(v.autodetect));
-	v.checkfreq = UDP->checkfreq;
-	v.native_format = UDP->native_format;
+	v.cmos = drive_params[drive].cmos;
+	v.max_dtr = drive_params[drive].max_dtr;
+	v.hlt = drive_params[drive].hlt;
+	v.hut = drive_params[drive].hut;
+	v.srt = drive_params[drive].srt;
+	v.spinup = drive_params[drive].spinup;
+	v.spindown = drive_params[drive].spindown;
+	v.spindown_offset = drive_params[drive].spindown_offset;
+	v.select_delay = drive_params[drive].select_delay;
+	v.rps = drive_params[drive].rps;
+	v.tracks = drive_params[drive].tracks;
+	v.timeout = drive_params[drive].timeout;
+	v.interleave_sect = drive_params[drive].interleave_sect;
+	v.max_errors = drive_params[drive].max_errors;
+	v.flags = drive_params[drive].flags;
+	v.read_track = drive_params[drive].read_track;
+	memcpy(v.autodetect, drive_params[drive].autodetect,
+	       sizeof(v.autodetect));
+	v.checkfreq = drive_params[drive].checkfreq;
+	v.native_format = drive_params[drive].native_format;
 	mutex_unlock(&floppy_mutex);
 
 	if (copy_to_user(arg, &v, sizeof(struct compat_floppy_drive_params)))
@@ -3931,16 +3933,16 @@ static void __init config_types(void)
 
 	/* read drive info out of physical CMOS */
 	drive = 0;
-	if (!UDP->cmos)
-		UDP->cmos = FLOPPY0_TYPE;
+	if (!drive_params[drive].cmos)
+		drive_params[drive].cmos = FLOPPY0_TYPE;
 	drive = 1;
-	if (!UDP->cmos)
-		UDP->cmos = FLOPPY1_TYPE;
+	if (!drive_params[drive].cmos)
+		drive_params[drive].cmos = FLOPPY1_TYPE;
 
 	/* FIXME: additional physical CMOS drive detection should go here */
 
 	for (drive = 0; drive < N_DRIVE; drive++) {
-		unsigned int type = UDP->cmos;
+		unsigned int type = drive_params[drive].cmos;
 		struct floppy_drive_params *params;
 		const char *name = NULL;
 		char temparea[32];
@@ -3970,7 +3972,7 @@ static void __init config_types(void)
 
 			pr_cont("%s fd%d is %s", prepend, drive, name);
 		}
-		*UDP = *params;
+		drive_params[drive] = *params;
 	}
 
 	if (has_drive)
@@ -4012,7 +4014,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	if (opened_bdev[drive] && opened_bdev[drive] != bdev)
 		goto out2;
 
-	if (!UDRS->fd_ref && (UDP->flags & FD_BROKEN_DCL)) {
+	if (!UDRS->fd_ref && (drive_params[drive].flags & FD_BROKEN_DCL)) {
 		set_bit(FD_DISK_CHANGED_BIT, &UDRS->flags);
 		set_bit(FD_VERIFY_BIT, &UDRS->flags);
 	}
@@ -4026,7 +4028,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	if (!floppy_track_buffer) {
 		/* if opening an ED drive, reserve a big buffer,
 		 * else reserve a small one */
-		if ((UDP->cmos == 6) || (UDP->cmos == 5))
+		if ((drive_params[drive].cmos == 6) || (drive_params[drive].cmos == 5))
 			try = 64;	/* Only 48 actually useful */
 		else
 			try = 32;	/* Only 24 actually useful */
@@ -4105,7 +4107,7 @@ static unsigned int floppy_check_events(struct gendisk *disk,
 	    test_bit(FD_VERIFY_BIT, &UDRS->flags))
 		return DISK_EVENT_MEDIA_CHANGE;
 
-	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
+	if (time_after(jiffies, UDRS->last_checked + drive_params[drive].checkfreq)) {
 		if (lock_fdc(drive))
 			return 0;
 		poll_drive(false, 0);
@@ -4471,7 +4473,7 @@ static ssize_t floppy_cmos_show(struct device *dev,
 	int drive;
 
 	drive = p->id;
-	return sprintf(buf, "%X\n", UDP->cmos);
+	return sprintf(buf, "%X\n", drive_params[drive].cmos);
 }
 
 static DEVICE_ATTR(cmos, 0444, floppy_cmos_show, NULL);
-- 
2.9.0

