Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B971C433FB
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C64221E2
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgHFHmK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:42:10 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:46328 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgHFHmE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 03:42:04 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Aug 2020 03:42:03 EDT
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 66C94E80643;
        Thu,  6 Aug 2020 09:32:22 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id CB059160D57; Thu,  6 Aug 2020 09:32:21 +0200 (CEST)
Date:   Thu, 6 Aug 2020 09:32:21 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Martijn Coenen <maco@android.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] loop: unset GENHD_FL_NO_PART_SCAN on LOOP_CONFIGURE
Message-ID: <20200806073221.GA219724@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When LOOP_CONFIGURE is used with LO_FLAGS_PARTSCAN we need to propagate
this into the GENHD_FL_NO_PART_SCAN. LOOP_SETSTATUS does this,
LOOP_CONFIGURE doesn't so far. Effect is that setting up a loopback
device with partition scanning doesn't actually work when LOOP_CONFIGURE
is issued, though it works fine with LOOP_SETSTATUS.

Let's correct that and propagate the flag in LOOP_SETSTATUS too.

Signed-off-by: Lennart Poettering <lennart@poettering.net>
---
 drivers/block/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d18160146226..2f137d6ce169 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1171,6 +1171,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
+	if (partscan)
+		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;

 	/* Grab the block_device to prevent its destruction after we
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
--
2.26.2
