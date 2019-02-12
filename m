Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9FFC282CE
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E540217D9
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="T6Gom75R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfBLQF2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:05:28 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34668 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730784AbfBLQF2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 11:05:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 85CC08EE1A4;
        Tue, 12 Feb 2019 08:05:27 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5WjtG-sBnXK7; Tue, 12 Feb 2019 08:05:27 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EB4448EE0E9;
        Tue, 12 Feb 2019 08:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1549987527;
        bh=yGdT2RdzTbttMGagIlorK/c+CPupmdDyZaLgmmxdp6M=;
        h=Subject:From:To:Cc:Date:From;
        b=T6Gom75RP3UXNrIfjDqkgNDeVMzwqFqWuvebaKStf4iaCfioo4EokFKHhWoXq5D7P
         NpGTcvc2IjHWaigIMx214udhsHUhGGbRydaHT3Rsh4TGfX51hH4FDSeWJS5OEoWVW3
         l54x/C/nsv/IKWGQfyAX7wLIHp0AZ13A4WvsFdRI=
Message-ID: <1549987525.3173.17.camel@HansenPartnership.com>
Subject: [PATCH] scsi: sd: fix entropy gathering for most rotational disks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Xuewei Zhang <xueweiz@google.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Date:   Tue, 12 Feb 2019 08:05:25 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The problem is that the default for MQ is not to gather entropy,
whereas the default for the legacy queue was always to gather it.  The
original attempt to fix entropy gathering for rotational disks under MQ
added an else branch in sd_read_block_characteristics(). 
Unfortunately, the entire check isn't reached if the device has no
characteristics VPD page.  Since this page was only introduced in SBC-3 
and its optional anyway, most less expensive rotational disks don't
have one, meaning they all stopped gathering entropy when we made MQ
the default.  In a wholly unrelated change, openssl and openssh won't
function until the random number generator is initialised, meaning lots
of people have been seeing large delays before they could log into
systems with default MQ kernels due to this lack of entropy, because it
now can take tens of minutes to initialise the kernel random number
generator.

The fix is to set the non-rotational and add-randomness flags
unconditionally early on in the disk initialization path, so they can
be reset only if the device actually reports being non-rotational via
the VPD page.

Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
Fixes: 83e32a591077 ("scsi: sd: Contribute to randomness when running rotational device")
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
I updated this slightly over the original proposal so we set the flags
even if the device doesn't have any VPD pages, so it should work for
very old disks.

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d0a980915801..3b8093c48eba 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2971,9 +2971,6 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 	if (rot == 1) {
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
-	} else {
-		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
-		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
 	}
 
 	if (sdkp->device->type == TYPE_ZBC) {
@@ -3110,6 +3107,15 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	if (sdkp->media_present) {
 		sd_read_capacity(sdkp, buffer);
 
+		/*
+		 * set the default to rotational.  All non-rotational devices
+		 * support the block characteristics VPD page, which will
+		 * cause this to be updated correctly and any device which
+		 * doesn't support it should be treated as rotational.
+		 */
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
+
 		if (scsi_device_supports_vpd(sdp)) {
 			sd_read_block_provisioning(sdkp);
 			sd_read_block_limits(sdkp);
