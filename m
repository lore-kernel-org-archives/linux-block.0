Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE0C433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 14:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29F8239EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 14:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbhAUOpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 09:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbhAUOpQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 09:45:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75CE022248;
        Thu, 21 Jan 2021 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611240271;
        bh=MdhOmJTeoY10X6IiIajHpF8R5t8U+MEBa16TKOVmcxk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UlCF76E+cG7SVrvDlxBW6kUNw6ABi2JMPYXC33kkI+DBB325QdZfrHjo07Ko0lu/J
         ZBvTYV4yHy8kArJDt0mVwm8aqyz12wwQnt2BZkyZTLQRFna4ZWWKkQK+jdgcMAWzLF
         C/2miJtDj5UiHP8jXj1Q68xFWgEIZCo4ZmlNdJejewXnX32J1gD076Lh9G+zRKuVsm
         v4cNZ7N5AkIflcBWoRLYpVwP9epVzH9zIwSRR1FU2pMTI5PHzJkvpxn3RLAeF5uhW/
         g77dCVbFNvgM9w0JHeYyT+FYPNKn/UGIbUf0Y5uH4EprGePvvPgoUpMP+JU1Go1um+
         tr2JJTn9b6Pyw==
Date:   Thu, 21 Jan 2021 15:44:28 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Denis Efremov <efremov@linux.com>
cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Wim Osterholt <wim@djo.tudelft.nl>
Subject: Re: [PATCH RESEND] floppy: fix open(O_ACCMODE) for ioctl-only open
In-Reply-To: <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2101211543230.5622@cbobk.fhfr.pm>
References: <20160610230255.GA27770@djo.tudelft.nl> <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm> <20160614184308.GA6188@djo.tudelft.nl> <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm> <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm> <20160615224722.GA9545@djo.tudelft.nl> <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm> <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm> <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
 <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm> <5cb57175-7f0b-5536-925d-337241bcda93@linux.com> <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Jan 2021, Jiri Kosina wrote:

> I am currently waiting for confirmation by the original reporter that the 
> patch below fixes the issue.

... a now a patch that actually compiles :) (made a mistake when 
forward-porting from the older kernel on which this has been reported).



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH v2] floppy: reintroduce O_NDELAY fix

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

v1 -> v2: fix build issue due to bad forward-port

 drivers/block/floppy.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index dfe1dfc901cc..f9e839c8c5aa 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4121,23 +4121,23 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
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
+		if (bdev_check_media_change(bdev))
+			floppy_revalidate(bdev->bd_disk);
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

