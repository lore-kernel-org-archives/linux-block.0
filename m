Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF37EC433FE
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 00:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B552A60ED5
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 00:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJXAWn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Oct 2021 20:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhJXAWm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Oct 2021 20:22:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013EEC061764;
        Sat, 23 Oct 2021 17:20:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d9so7071634pfl.6;
        Sat, 23 Oct 2021 17:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=CIzPEaFVjS2/ZHK11cNZ/i0vkhKsth8dpMOvQmaxtCs=;
        b=Rw3WeNQq76QFJ0Yp7DI+oQwxjExAaV6EAN1C9icdBOMZ4pLlCaIvLchnC7CbszE5Jr
         z+bQuOfSjEtwctQwQi48Th0kUhzClEW8i+4uAhrY0G3kmzmb33njVoiKcxxcIJXgdCVx
         jcaSQDEjDsOFMMIj4aaWGyFjrwuhgQyTBBy27z0FkcFC4gk3y7BvujgT9FQB2CDCAxSG
         OFzhVk6+GZhhyac9pgb+W8zPd7iyDeHkIq9GiwnRIYn9sqtbAaZ3ntNyonylFoVHLe/E
         o8tl70B5IU3N+HMvQhIvY+Qy76+cWpvqprXPKchGeTHdy7q8PUpEtECGl4cwlQlMgUUb
         s6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CIzPEaFVjS2/ZHK11cNZ/i0vkhKsth8dpMOvQmaxtCs=;
        b=fg341nUaK791fTwPw8QNaps+D6+aopl1mkewTITmaWFwq2XMeEDaUTv0EeEhZIiB+t
         e6gQ55YUTE4ysy7C+MawP/YuQLZw2n9ywp7c47qDNLfpDPixJgQAj56/RblzBqFVMLRw
         xBuVKmRyPFVWJOKrH+mFGOnrfuXLvQtmhYuQKf/3TxnF1GVuZD/ENtsLhHdVhlJrUW1x
         BOBbwkiEopyskio48De3HJhB77d8HN7zrGWxEC2ZryS0olroVuj8Bd4ZOmkpZbvKgW7w
         rhAYlZBb3MstFPgn544+eVQJrdX4IoryIzjn5UIQn7Pm75F/50oK3UNaByV8REdIVSYe
         VYVA==
X-Gm-Message-State: AOAM531P6VDVA4WvfejBO+11VqKAS+E7kVdbvLb0JBMCyairXM6+yCLc
        N/VfbF4F9DC0YsCT0v22mKY=
X-Google-Smtp-Source: ABdhPJz+kHAEG2/vRxUGo8kb9NH0ApR9wB1jjK0jdn4atfdl/St22oUokIjNpaRZN3Zt7dgjznnvRg==
X-Received: by 2002:a63:f84f:: with SMTP id v15mr6781392pgj.204.1635034822319;
        Sat, 23 Oct 2021 17:20:22 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id q15sm10902966pfk.16.2021.10.23.17.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 17:20:21 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id ED16236030C; Sun, 24 Oct 2021 13:20:17 +1300 (NZDT)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     axboe@kernel.dk, Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v1] block: ataflop: more blk-mq refactoring fixes
Date:   Sun, 24 Oct 2021 13:20:13 +1300
Message-Id: <20211024002013.9332-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As it turns out, my earlier patch in commit 86d46fdaa12a (block:
ataflop: fix breakage introduced at blk-mq refactoring) was
incomplete. This patch fixes any remaining issues found during
more testing and code review.

Requests exceeding 4 k are handled in 4k segments but
__blk_mq_end_request() is never called on these (still
sectors outstanding on the request). With redo_fd_request()
removed, there is no provision to kick off processing of the
next segment, causing requests exceeding 4k to hang. (By
setting /sys/block/fd0/queue/max_sectors_k <= 4 as workaround,
this behaviour can be avoided).

Instead of reintroducing redo_fd_request(), requeue the remainder
of the request by calling blk_mq_requeue_request() on incomplete
requests (i.e. when blk_update_request() still returns true), and
rely on the block layer to queue the residual as new request.

Both error handling and formatting needs to release the
ST-DMA lock, so call finish_fdc() on these (this was previously
handled by redo_fd_request()). finish_fdc() may be called
legitimately without the ST-DMA lock held - make sure we only
release the lock if we actually held it. In a similar way,
early exit due to errors in ataflop_queue_rq() must release
the lock.

After minor errors, fd_error sets up to recalibrate the drive
but never re-runs the current operation (another task handled by
redo_fd_request() before). Call do_fd_action() to get the next
steps (seek, retry read/write) underway.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Fixes: 6ec3938cff95f (ataflop: convert to blk-mq)
CC: linux-block@vger.kernel.org
---
 drivers/block/ataflop.c | 45 +++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 94f79fe120b3..d4499631d4d4 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -456,10 +456,20 @@ static DEFINE_TIMER(fd_timer, check_change);
 	
 static void fd_end_request_cur(blk_status_t err)
 {
+	DPRINT(("fd_end_request_cur(), bytes %d of %d\n",
+		blk_rq_cur_bytes(fd_request),
+		blk_rq_bytes(fd_request)));
+
 	if (!blk_update_request(fd_request, err,
 				blk_rq_cur_bytes(fd_request))) {
+		DPRINT(("calling __blk_mq_end_request()\n"));
 		__blk_mq_end_request(fd_request, err);
 		fd_request = NULL;
+	} else {
+		/* requeue rest of request */
+		DPRINT(("calling blk_mq_requeue_request()\n"));
+		blk_mq_requeue_request(fd_request, true);
+		fd_request = NULL;
 	}
 }
 
@@ -697,12 +707,21 @@ static void fd_error( void )
 	if (fd_request->error_count >= MAX_ERRORS) {
 		printk(KERN_ERR "fd%d: too many errors.\n", SelectedDrive );
 		fd_end_request_cur(BLK_STS_IOERR);
+		finish_fdc();
+		return;
 	}
 	else if (fd_request->error_count == RECALIBRATE_ERRORS) {
 		printk(KERN_WARNING "fd%d: recalibrating\n", SelectedDrive );
 		if (SelectedDrive != -1)
 			SUD.track = -1;
 	}
+	/* need to re-run request to recalibrate */
+	atari_disable_irq( IRQ_MFP_FDC );
+
+	setup_req_params( SelectedDrive );
+	do_fd_action( SelectedDrive );
+
+	atari_enable_irq( IRQ_MFP_FDC );
 }
 
 
@@ -729,8 +748,10 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	if (type) {
 		type--;
 		if (type >= NUM_DISK_MINORS ||
-		    minor2disktype[type].drive_types > DriveType)
+		    minor2disktype[type].drive_types > DriveType) {
+			finish_fdc();
 			return -EINVAL;
+		}
 	}
 
 	q = unit[drive].disk[type]->queue;
@@ -748,6 +769,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	}
 
 	if (!UDT || desc->track >= UDT->blocks/UDT->spt/2 || desc->head >= 2) {
+		finish_fdc();
 		ret = -EINVAL;
 		goto out;
 	}
@@ -788,6 +810,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 
 	wait_for_completion(&format_wait);
 
+	finish_fdc();
 	ret = FormatError ? -EIO : 0;
 out:
 	blk_mq_unquiesce_queue(q);
@@ -822,6 +845,7 @@ static void do_fd_action( int drive )
 		    else {
 			/* all sectors finished */
 			fd_end_request_cur(BLK_STS_OK);
+			finish_fdc();
 			return;
 		    }
 		}
@@ -1225,8 +1249,8 @@ static void fd_rwsec_done1(int status)
 	}
 	else {
 		/* all sectors finished */
-		finish_fdc();
 		fd_end_request_cur(BLK_STS_OK);
+		finish_fdc();
 	}
 	return;
   
@@ -1348,7 +1372,7 @@ static void fd_times_out(struct timer_list *unused)
 
 static void finish_fdc( void )
 {
-	if (!NeedSeek) {
+	if (!NeedSeek || !stdma_is_locked_by(floppy_irq)) {
 		finish_fdc_done( 0 );
 	}
 	else {
@@ -1383,7 +1407,8 @@ static void finish_fdc_done( int dummy )
 	start_motor_off_timer();
 
 	local_irq_save(flags);
-	stdma_release();
+	if (stdma_is_locked_by(floppy_irq))
+		stdma_release();
 	local_irq_restore(flags);
 
 	DPRINT(("finish_fdc() finished\n"));
@@ -1480,7 +1505,9 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	int drive = floppy - unit;
 	int type = floppy->type;
 
-	DPRINT(("Queue request: drive %d type %d last %d\n", drive, type, bd->last));
+	DPRINT(("Queue request: drive %d type %d sectors %d of %d last %d\n",
+		drive, type, blk_rq_cur_sectors(bd->rq),
+		blk_rq_sectors(bd->rq), bd->last));
 
 	spin_lock_irq(&ataflop_lock);
 	if (fd_request) {
@@ -1502,6 +1529,7 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		/* drive not connected */
 		printk(KERN_ERR "Unknown Device: fd%d\n", drive );
 		fd_end_request_cur(BLK_STS_IOERR);
+		stdma_release();
 		goto out;
 	}
 		
@@ -1518,11 +1546,13 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (--type >= NUM_DISK_MINORS) {
 			printk(KERN_WARNING "fd%d: invalid disk format", drive );
 			fd_end_request_cur(BLK_STS_IOERR);
+			stdma_release();
 			goto out;
 		}
 		if (minor2disktype[type].drive_types > DriveType)  {
 			printk(KERN_WARNING "fd%d: unsupported disk format", drive );
 			fd_end_request_cur(BLK_STS_IOERR);
+			stdma_release();
 			goto out;
 		}
 		type = minor2disktype[type].index;
@@ -1623,6 +1653,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 		/* what if type > 0 here? Overwrite specified entry ? */
 		if (type) {
 		        /* refuse to re-set a predefined type for now */
+			finish_fdc();
 			return -EINVAL;
 		}
 
@@ -1690,8 +1721,10 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 
 		/* sanity check */
 		if (setprm.track != dtp->blocks/dtp->spt/2 ||
-		    setprm.head != 2)
+		    setprm.head != 2) {
+			finish_fdc();
 			return -EINVAL;
+		}
 
 		UDT = dtp;
 		set_capacity(disk, UDT->blocks);
-- 
2.17.1

