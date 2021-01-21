Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CED0C433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 10:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1712204EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 10:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbhAUK1P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 05:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbhAUK0K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 05:26:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AE1C233EF;
        Thu, 21 Jan 2021 10:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224726;
        bh=1WqH3NdCK1Aq7P98SXwjbmM2Zdvym1uIUTpuB2RRcL8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=elv1kMdaVzgDBRV2OScyEeuPivjIFBFpHBpelrYLvprzGAjfenBqWdqWe2I2hjNDn
         VQHCYP0vjYGkrCcY5aMc9UIpsDW5oQUCTUOB+DDsfN+0EjpiWX6JTWDoeiFDR4MwsR
         JdXiulX7C/RM13EtMBgRuu1yYCWTELFBTCXPylTNa9eTc+a9lmHUUzmh7y7ItXCMil
         pyTHGv/BDgL68Pi02rpYKc81dnoGwDGgjNsK1FcqPSAhdBRORZOR5uJPnY8o0fAyDe
         dXnKckQ4ArvULxO8b/nFzeh37e2T7HjztHNpIeG5wfFq4Dp7PFsPm8oD1pRv7dh4Yd
         xHw7akBcncUuA==
Date:   Thu, 21 Jan 2021 11:25:23 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Denis Efremov <efremov@linux.com>
cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Wim Osterholt <wim@djo.tudelft.nl>
Subject: Re: [PATCH RESEND] floppy: fix open(O_ACCMODE) for ioctl-only open
In-Reply-To: <5cb57175-7f0b-5536-925d-337241bcda93@linux.com>
Message-ID: <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm>
References: <20160610230255.GA27770@djo.tudelft.nl> <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm> <20160614184308.GA6188@djo.tudelft.nl> <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm> <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm> <20160615224722.GA9545@djo.tudelft.nl> <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm> <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm> <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
 <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm> <5cb57175-7f0b-5536-925d-337241bcda93@linux.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Jan 2021, Denis Efremov wrote:

> I think it's hard to recall the exact reasons after so many years. 

Yeah, I guess so :)

> I'll send a patch today based on this one.

I am currently waiting for confirmation by the original reporter that the 
patch below fixes the issue.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] floppy: reintroduce O_NDELAY fix

Originally fixed in 09954bad4 ("floppy: refactor open() flags handling")
then reverted for unknown reason in f2791e7eadf437 instead of taking
the open(O_ACCMODE) for ioctl-only open fix, which had the changelog below

====
Commit 09954bad4 ("floppy: refactor open() flags handling"), as a
side-effect, causes open(/dev/fdX, O_ACCMODE) to fail. It turns out that
this is being used setfdprm userspace for ioctl-only open().

Reintroduce back the original behavior wrt !(FMODE_READ|FMODE_WRITE)
modes, while still keeping the original O_NDELAY bug fixed.

Cc: stable@vger.kernel.org # v4.5+
Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
Tested-by: Wim Osterholt <wim@djo.tudelft.nl>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
=====

Fixes: 09954bad4 ("floppy: refactor open() flags handling")
Fixes: f2791e7ead ("Revert "floppy: refactor open() flags handling"")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/block/floppy.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index dfe1dfc901cc..bda9417aa0a8 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4121,23 +4121,22 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	if (fdc_state[FDC(drive)].rawcmd == 1)
 		fdc_state[FDC(drive)].rawcmd = 2;
 
-	if (!(mode & FMODE_NDELAY)) {
-		if (mode & (FMODE_READ|FMODE_WRITE)) {
-			drive_state[drive].last_checked = 0;
-			clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
-				  &drive_state[drive].flags);
-			if (bdev_check_media_change(bdev))
-				floppy_revalidate(bdev->bd_disk);
-			if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags))
-				goto out;
-			if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags))
-				goto out;
-		}
-		res = -EROFS;
-		if ((mode & FMODE_WRITE) &&
-		    !test_bit(FD_DISK_WRITABLE_BIT, &drive_state[drive].flags))
+	if (mode & (FMODE_READ|FMODE_WRITE)) {
+		UDRS->last_checked = 0;
+		clear_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags);
+		check_disk_change(bdev);
+		if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags))
+			goto out;
+		if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags))
 			goto out;
 	}
+
+	res = -EROFS;
+
+	if ((mode & FMODE_WRITE) &&
+			!test_bit(FD_DISK_WRITABLE_BIT, &drive_state[drive].flags))
+		goto out;
+
 	mutex_unlock(&open_lock);
 	mutex_unlock(&floppy_mutex);
 	return 0;

-- 
Jiri Kosina
SUSE Labs

