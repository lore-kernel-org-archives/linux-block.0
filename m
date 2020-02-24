Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A8C38BFA
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5745E21D7E
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgBXVlE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:41:04 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgBXVlC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 16:41:02 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO5tW008695;
        Mon, 24 Feb 2020 22:24:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 04/10] floppy: cleanup: expand macro UDRS
Date:   Mon, 24 Feb 2020 22:23:46 +0100
Message-Id: <20200224212352.8640-5-w@1wt.eu>
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
 drivers/block/floppy.c | 162 +++++++++++++++++++++++++------------------------
 1 file changed, 83 insertions(+), 79 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 8fcedb2..522fbcc 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -310,7 +310,6 @@ static bool initialized;
 #define DRS	(&drive_state[current_drive])
 #define DRWE	(&write_errors[current_drive])
 
-#define UDRS	(&drive_state[drive])
 #define UDRWE	(&write_errors[drive])
 
 #define PH_HEAD(floppy, head) (((((floppy)->stretch & 2) >> 1) ^ head) << 2)
@@ -603,7 +602,7 @@ static unsigned char in_sector_offset;	/* offset within physical sector,
 
 static inline bool drive_no_geom(int drive)
 {
-	return !current_type[drive] && !ITYPE(UDRS->fd_device);
+	return !current_type[drive] && !ITYPE(drive_state[drive].fd_device);
 }
 
 #ifndef fd_eject
@@ -737,7 +736,7 @@ static int disk_change(int drive)
 {
 	int fdc = FDC(drive);
 
-	if (time_before(jiffies, UDRS->select_date + drive_params[drive].select_delay))
+	if (time_before(jiffies, drive_state[drive].select_date + drive_params[drive].select_delay))
 		DPRINT("WARNING disk change called early\n");
 	if (!(fdc_state[fdc].dor & (0x10 << UNIT(drive))) ||
 	    (fdc_state[fdc].dor & 3) != UNIT(drive) || fdc != FDC(drive)) {
@@ -751,19 +750,22 @@ static int disk_change(int drive)
 	debug_dcl(drive_params[drive].flags, "jiffies=%lu\n", jiffies);
 	debug_dcl(drive_params[drive].flags, "disk change line=%x\n",
 		  fd_inb(FD_DIR) & 0x80);
-	debug_dcl(drive_params[drive].flags, "flags=%lx\n", UDRS->flags);
+	debug_dcl(drive_params[drive].flags, "flags=%lx\n",
+		  drive_state[drive].flags);
 
 	if (drive_params[drive].flags & FD_BROKEN_DCL)
-		return test_bit(FD_DISK_CHANGED_BIT, &UDRS->flags);
+		return test_bit(FD_DISK_CHANGED_BIT,
+				&drive_state[drive].flags);
 	if ((fd_inb(FD_DIR) ^ drive_params[drive].flags) & 0x80) {
-		set_bit(FD_VERIFY_BIT, &UDRS->flags);
+		set_bit(FD_VERIFY_BIT, &drive_state[drive].flags);
 					/* verify write protection */
 
-		if (UDRS->maxblock)	/* mark it changed */
-			set_bit(FD_DISK_CHANGED_BIT, &UDRS->flags);
+		if (drive_state[drive].maxblock)	/* mark it changed */
+			set_bit(FD_DISK_CHANGED_BIT,
+				&drive_state[drive].flags);
 
 		/* invalidate its geometry */
-		if (UDRS->keep_data >= 0) {
+		if (drive_state[drive].keep_data >= 0) {
 			if ((drive_params[drive].flags & FTD_MSG) &&
 			    current_type[drive] != NULL)
 				DPRINT("Disk type is undefined after disk change\n");
@@ -773,8 +775,8 @@ static int disk_change(int drive)
 
 		return 1;
 	} else {
-		UDRS->last_checked = jiffies;
-		clear_bit(FD_DISK_NEWCHANGE_BIT, &UDRS->flags);
+		drive_state[drive].last_checked = jiffies;
+		clear_bit(FD_DISK_NEWCHANGE_BIT, &drive_state[drive].flags);
 	}
 	return 0;
 }
@@ -816,7 +818,7 @@ static int set_dor(int fdc, char mask, char data)
 		unit = newdor & 0x3;
 		if (!is_selected(olddor, unit) && is_selected(newdor, unit)) {
 			drive = REVDRIVE(fdc, unit);
-			UDRS->select_date = jiffies;
+			drive_state[drive].select_date = jiffies;
 		}
 	}
 	return olddor;
@@ -844,8 +846,8 @@ static void reset_fdc_info(int mode)
 	fdc_state[fdc].perp_mode = 1;
 	fdc_state[fdc].rawcmd = 0;
 	for (drive = 0; drive < N_DRIVE; drive++)
-		if (FDC(drive) == fdc && (mode || UDRS->track != NEED_1_RECAL))
-			UDRS->track = NEED_2_RECAL;
+		if (FDC(drive) == fdc && (mode || drive_state[drive].track != NEED_1_RECAL))
+			drive_state[drive].track = NEED_2_RECAL;
 }
 
 /* selects the fdc and drive, and enables the fdc's input/dma. */
@@ -930,7 +932,7 @@ static void floppy_off(unsigned int drive)
 	/* make spindle stop in a position which minimizes spinup time
 	 * next time */
 	if (drive_params[drive].rps) {
-		delta = jiffies - UDRS->first_read_date + HZ -
+		delta = jiffies - drive_state[drive].first_read_date + HZ -
 		    drive_params[drive].spindown_offset;
 		delta = ((delta * drive_params[drive].rps) % HZ) / drive_params[drive].rps;
 		motor_off_timer[drive].expires =
@@ -956,7 +958,7 @@ static void scandrives(void)
 	saved_drive = current_drive;
 	for (i = 0; i < N_DRIVE; i++) {
 		drive = (saved_drive + i + 1) % N_DRIVE;
-		if (UDRS->fd_ref == 0 || drive_params[drive].select_delay != 0)
+		if (drive_state[drive].fd_ref == 0 || drive_params[drive].select_delay != 0)
 			continue;	/* skip closed drives */
 		set_fdc(drive);
 		if (!(set_dor(fdc, ~3, UNIT(drive) | (0x10 << UNIT(drive))) &
@@ -2065,7 +2067,7 @@ static void bad_flp_intr(void)
 
 static void set_floppy(int drive)
 {
-	int type = ITYPE(UDRS->fd_device);
+	int type = ITYPE(drive_state[drive].fd_device);
 
 	if (type)
 		_floppy = floppy_type + type;
@@ -3183,11 +3185,11 @@ static int raw_cmd_ioctl(int cmd, void __user *param)
 		if (FDC(drive) != fdc)
 			continue;
 		if (drive == current_drive) {
-			if (UDRS->fd_ref > 1) {
+			if (drive_state[drive].fd_ref > 1) {
 				fdc_state[fdc].rawcmd = 2;
 				break;
 			}
-		} else if (UDRS->fd_ref) {
+		} else if (drive_state[drive].fd_ref) {
 			fdc_state[fdc].rawcmd = 2;
 			break;
 		}
@@ -3405,7 +3407,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 		    unsigned long param)
 {
 	int drive = (long)bdev->bd_disk->private_data;
-	int type = ITYPE(UDRS->fd_device);
+	int type = ITYPE(drive_state[drive].fd_device);
 	int i;
 	int ret;
 	int size;
@@ -3453,7 +3455,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 
 	switch (cmd) {
 	case FDEJECT:
-		if (UDRS->fd_ref != 1)
+		if (drive_state[drive].fd_ref != 1)
 			/* somebody else has this drive open */
 			return -EBUSY;
 		if (lock_fdc(drive))
@@ -3463,8 +3465,8 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 		 * non-Sparc architectures */
 		ret = fd_eject(UNIT(drive));
 
-		set_bit(FD_DISK_CHANGED_BIT, &UDRS->flags);
-		set_bit(FD_VERIFY_BIT, &UDRS->flags);
+		set_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags);
+		set_bit(FD_VERIFY_BIT, &drive_state[drive].flags);
 		process_fd_request();
 		return ret;
 	case FDCLRPRM:
@@ -3472,7 +3474,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 			return -EINTR;
 		current_type[drive] = NULL;
 		floppy_sizes[drive] = MAX_DISK_SIZE << 1;
-		UDRS->keep_data = 0;
+		drive_state[drive].keep_data = 0;
 		return invalidate_drive(bdev);
 	case FDSETPRM:
 	case FDDEFPRM:
@@ -3497,7 +3499,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 			return -EINTR;
 		if (poll_drive(true, FD_RAW_NEED_DISK) == -EINTR)
 			return -EINTR;
-		ret = UDRS->flags;
+		ret = drive_state[drive].flags;
 		process_fd_request();
 		if (ret & FD_VERIFY)
 			return -ENODEV;
@@ -3505,7 +3507,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 			return -EROFS;
 		return 0;
 	case FDFMTTRK:
-		if (UDRS->fd_ref != 1)
+		if (drive_state[drive].fd_ref != 1)
 			return -EBUSY;
 		return do_format(drive, &inparam.f);
 	case FDFMTEND:
@@ -3543,7 +3545,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 		process_fd_request();
 		/* fall through */
 	case FDGETDRVSTAT:
-		outparam = UDRS;
+		outparam = &drive_state[drive];
 		break;
 	case FDRESET:
 		return user_reset_fdc(drive, (int)param, true);
@@ -3690,7 +3692,7 @@ static int compat_set_geometry(struct block_device *bdev, fmode_t mode, unsigned
 
 	mutex_lock(&floppy_mutex);
 	drive = (long)bdev->bd_disk->private_data;
-	type = ITYPE(UDRS->fd_device);
+	type = ITYPE(drive_state[drive].fd_device);
 	err = set_geometry(cmd == FDSETPRM32 ? FDSETPRM : FDDEFPRM,
 			&v, drive, type, bdev);
 	mutex_unlock(&floppy_mutex);
@@ -3706,7 +3708,8 @@ static int compat_get_prm(int drive,
 
 	memset(&v, 0, sizeof(v));
 	mutex_lock(&floppy_mutex);
-	err = get_floppy_geometry(drive, ITYPE(UDRS->fd_device), &p);
+	err = get_floppy_geometry(drive, ITYPE(drive_state[drive].fd_device),
+				  &p);
 	if (err) {
 		mutex_unlock(&floppy_mutex);
 		return err;
@@ -3803,20 +3806,20 @@ static int compat_getdrvstat(int drive, bool poll,
 			goto Eintr;
 		process_fd_request();
 	}
-	v.spinup_date = UDRS->spinup_date;
-	v.select_date = UDRS->select_date;
-	v.first_read_date = UDRS->first_read_date;
-	v.probed_format = UDRS->probed_format;
-	v.track = UDRS->track;
-	v.maxblock = UDRS->maxblock;
-	v.maxtrack = UDRS->maxtrack;
-	v.generation = UDRS->generation;
-	v.keep_data = UDRS->keep_data;
-	v.fd_ref = UDRS->fd_ref;
-	v.fd_device = UDRS->fd_device;
-	v.last_checked = UDRS->last_checked;
-	v.dmabuf = (uintptr_t)UDRS->dmabuf;
-	v.bufblocks = UDRS->bufblocks;
+	v.spinup_date = drive_state[drive].spinup_date;
+	v.select_date = drive_state[drive].select_date;
+	v.first_read_date = drive_state[drive].first_read_date;
+	v.probed_format = drive_state[drive].probed_format;
+	v.track = drive_state[drive].track;
+	v.maxblock = drive_state[drive].maxblock;
+	v.maxtrack = drive_state[drive].maxtrack;
+	v.generation = drive_state[drive].generation;
+	v.keep_data = drive_state[drive].keep_data;
+	v.fd_ref = drive_state[drive].fd_ref;
+	v.fd_device = drive_state[drive].fd_device;
+	v.last_checked = drive_state[drive].last_checked;
+	v.dmabuf = (uintptr_t) drive_state[drive].dmabuf;
+	v.bufblocks = drive_state[drive].bufblocks;
 	mutex_unlock(&floppy_mutex);
 
 	if (copy_to_user(arg, &v, sizeof(struct compat_floppy_drive_struct)))
@@ -3985,11 +3988,11 @@ static void floppy_release(struct gendisk *disk, fmode_t mode)
 
 	mutex_lock(&floppy_mutex);
 	mutex_lock(&open_lock);
-	if (!UDRS->fd_ref--) {
+	if (!drive_state[drive].fd_ref--) {
 		DPRINT("floppy_release with fd_ref == 0");
-		UDRS->fd_ref = 0;
+		drive_state[drive].fd_ref = 0;
 	}
-	if (!UDRS->fd_ref)
+	if (!drive_state[drive].fd_ref)
 		opened_bdev[drive] = NULL;
 	mutex_unlock(&open_lock);
 	mutex_unlock(&floppy_mutex);
@@ -4010,16 +4013,16 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 
 	mutex_lock(&floppy_mutex);
 	mutex_lock(&open_lock);
-	old_dev = UDRS->fd_device;
+	old_dev = drive_state[drive].fd_device;
 	if (opened_bdev[drive] && opened_bdev[drive] != bdev)
 		goto out2;
 
-	if (!UDRS->fd_ref && (drive_params[drive].flags & FD_BROKEN_DCL)) {
-		set_bit(FD_DISK_CHANGED_BIT, &UDRS->flags);
-		set_bit(FD_VERIFY_BIT, &UDRS->flags);
+	if (!drive_state[drive].fd_ref && (drive_params[drive].flags & FD_BROKEN_DCL)) {
+		set_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags);
+		set_bit(FD_VERIFY_BIT, &drive_state[drive].flags);
 	}
 
-	UDRS->fd_ref++;
+	drive_state[drive].fd_ref++;
 
 	opened_bdev[drive] = bdev;
 
@@ -4056,7 +4059,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	}
 
 	new_dev = MINOR(bdev->bd_dev);
-	UDRS->fd_device = new_dev;
+	drive_state[drive].fd_device = new_dev;
 	set_capacity(disks[drive], floppy_sizes[new_dev]);
 	if (old_dev != -1 && old_dev != new_dev) {
 		if (buffer_drive == drive)
@@ -4068,26 +4071,27 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 
 	if (!(mode & FMODE_NDELAY)) {
 		if (mode & (FMODE_READ|FMODE_WRITE)) {
-			UDRS->last_checked = 0;
-			clear_bit(FD_OPEN_SHOULD_FAIL_BIT, &UDRS->flags);
+			drive_state[drive].last_checked = 0;
+			clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
+				  &drive_state[drive].flags);
 			check_disk_change(bdev);
-			if (test_bit(FD_DISK_CHANGED_BIT, &UDRS->flags))
+			if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags))
 				goto out;
-			if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &UDRS->flags))
+			if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags))
 				goto out;
 		}
 		res = -EROFS;
 		if ((mode & FMODE_WRITE) &&
-		    !test_bit(FD_DISK_WRITABLE_BIT, &UDRS->flags))
+		    !test_bit(FD_DISK_WRITABLE_BIT, &drive_state[drive].flags))
 			goto out;
 	}
 	mutex_unlock(&open_lock);
 	mutex_unlock(&floppy_mutex);
 	return 0;
 out:
-	UDRS->fd_ref--;
+	drive_state[drive].fd_ref--;
 
-	if (!UDRS->fd_ref)
+	if (!drive_state[drive].fd_ref)
 		opened_bdev[drive] = NULL;
 out2:
 	mutex_unlock(&open_lock);
@@ -4103,19 +4107,19 @@ static unsigned int floppy_check_events(struct gendisk *disk,
 {
 	int drive = (long)disk->private_data;
 
-	if (test_bit(FD_DISK_CHANGED_BIT, &UDRS->flags) ||
-	    test_bit(FD_VERIFY_BIT, &UDRS->flags))
+	if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags) ||
+	    test_bit(FD_VERIFY_BIT, &drive_state[drive].flags))
 		return DISK_EVENT_MEDIA_CHANGE;
 
-	if (time_after(jiffies, UDRS->last_checked + drive_params[drive].checkfreq)) {
+	if (time_after(jiffies, drive_state[drive].last_checked + drive_params[drive].checkfreq)) {
 		if (lock_fdc(drive))
 			return 0;
 		poll_drive(false, 0);
 		process_fd_request();
 	}
 
-	if (test_bit(FD_DISK_CHANGED_BIT, &UDRS->flags) ||
-	    test_bit(FD_VERIFY_BIT, &UDRS->flags) ||
+	if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags) ||
+	    test_bit(FD_VERIFY_BIT, &drive_state[drive].flags) ||
 	    test_bit(drive, &fake_change) ||
 	    drive_no_geom(drive))
 		return DISK_EVENT_MEDIA_CHANGE;
@@ -4141,7 +4145,7 @@ static void floppy_rb0_cb(struct bio *bio)
 	if (bio->bi_status) {
 		pr_info("floppy: error %d while reading block 0\n",
 			bio->bi_status);
-		set_bit(FD_OPEN_SHOULD_FAIL_BIT, &UDRS->flags);
+		set_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags);
 	}
 	complete(&cbdata->complete);
 }
@@ -4198,8 +4202,8 @@ static int floppy_revalidate(struct gendisk *disk)
 	int cf;
 	int res = 0;
 
-	if (test_bit(FD_DISK_CHANGED_BIT, &UDRS->flags) ||
-	    test_bit(FD_VERIFY_BIT, &UDRS->flags) ||
+	if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags) ||
+	    test_bit(FD_VERIFY_BIT, &drive_state[drive].flags) ||
 	    test_bit(drive, &fake_change) ||
 	    drive_no_geom(drive)) {
 		if (WARN(atomic_read(&usage_count) == 0,
@@ -4209,20 +4213,20 @@ static int floppy_revalidate(struct gendisk *disk)
 		res = lock_fdc(drive);
 		if (res)
 			return res;
-		cf = (test_bit(FD_DISK_CHANGED_BIT, &UDRS->flags) ||
-		      test_bit(FD_VERIFY_BIT, &UDRS->flags));
+		cf = (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags) ||
+		      test_bit(FD_VERIFY_BIT, &drive_state[drive].flags));
 		if (!(cf || test_bit(drive, &fake_change) || drive_no_geom(drive))) {
 			process_fd_request();	/*already done by another thread */
 			return 0;
 		}
-		UDRS->maxblock = 0;
-		UDRS->maxtrack = 0;
+		drive_state[drive].maxblock = 0;
+		drive_state[drive].maxtrack = 0;
 		if (buffer_drive == drive)
 			buffer_track = -1;
 		clear_bit(drive, &fake_change);
-		clear_bit(FD_DISK_CHANGED_BIT, &UDRS->flags);
+		clear_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags);
 		if (cf)
-			UDRS->generation++;
+			drive_state[drive].generation++;
 		if (drive_no_geom(drive)) {
 			/* auto-sensing */
 			res = __floppy_read_block_0(opened_bdev[drive], drive);
@@ -4232,7 +4236,7 @@ static int floppy_revalidate(struct gendisk *disk)
 			process_fd_request();
 		}
 	}
-	set_capacity(disk, floppy_sizes[UDRS->fd_device]);
+	set_capacity(disk, floppy_sizes[drive_state[drive].fd_device]);
 	return res;
 }
 
@@ -4638,12 +4642,12 @@ static int __init do_floppy_init(void)
 
 	/* initialise drive state */
 	for (drive = 0; drive < N_DRIVE; drive++) {
-		memset(UDRS, 0, sizeof(*UDRS));
+		memset(&drive_state[drive], 0, sizeof(drive_state[drive]));
 		memset(UDRWE, 0, sizeof(*UDRWE));
-		set_bit(FD_DISK_NEWCHANGE_BIT, &UDRS->flags);
-		set_bit(FD_DISK_CHANGED_BIT, &UDRS->flags);
-		set_bit(FD_VERIFY_BIT, &UDRS->flags);
-		UDRS->fd_device = -1;
+		set_bit(FD_DISK_NEWCHANGE_BIT, &drive_state[drive].flags);
+		set_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags);
+		set_bit(FD_VERIFY_BIT, &drive_state[drive].flags);
+		drive_state[drive].fd_device = -1;
 		floppy_track_buffer = NULL;
 		max_buffer_sectors = 0;
 	}
-- 
2.9.0

