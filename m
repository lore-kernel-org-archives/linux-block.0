Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329CFC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 23:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BC920868
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 23:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfAQXPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:15:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQXPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 18:15:24 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkGsY-0000xQ-04; Fri, 18 Jan 2019 00:15:18 +0100
Message-Id: <20190117231500.874215239@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 18 Jan 2019 00:14:17 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [patch 1/9] block: Cleanup license notice
References: <20190117231416.111952141@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the imprecise and sloppy:

  "This files is licensed under the GPL."

license notice in the top level comment.

1) The file already contains a SPDX license identifier which clearly
   states that the license of the file is GPL V2 only

2) The notice resolves to GPL v1 or later for scanners which is just
   contrary to the intent of SPDX identifiers to provide clear and non
   ambiguous license information. Aside of that the value add of this
   notice is below zero,

Fixes: 6a5ac9846508 ("block: Make struct request_queue smaller for CONFIG_BLK_DEV_ZONED=n")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Matias Bjorling <mb@lightnvm.io>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---

P.S.: This patch is part of a larger cleanup, but independent of other
      patches and is intended to be picked up by the maintainer directly.

 block/blk-mq-debugfs-zoned.c |    2 --
 1 file changed, 2 deletions(-)

--- a/block/blk-mq-debugfs-zoned.c
+++ b/block/blk-mq-debugfs-zoned.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Western Digital Corporation or its affiliates.
- *
- * This file is released under the GPL.
  */
 
 #include <linux/blkdev.h>


