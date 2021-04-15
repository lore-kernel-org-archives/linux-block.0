Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF0C433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 12:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9D96124B
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 12:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhDOMJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:09:56 -0400
Received: from verein.lst.de ([213.95.11.211]:34501 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232678AbhDOMJ4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 08:09:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E715568BFE; Thu, 15 Apr 2021 14:09:30 +0200 (CEST)
Date:   Thu, 15 Apr 2021 14:09:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: no EBUSY on BLKRRPART, regression?
Message-ID: <20210415120930.GA32146@lst.de>
References: <20210415113114.zquxo2up5vltht6u@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415113114.zquxo2up5vltht6u@ws.net.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks like the switch to go through blkdev_get_by_dev means we
now ignore the return value from bdev_disk_changed.

Something like the untested patch below should fix it:

diff --git a/block/ioctl.c b/block/ioctl.c
index ff241e663c018f..8ba1ed8defd0bb 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -89,6 +89,8 @@ static int blkdev_reread_part(struct block_device *bdev, fmode_t mode)
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
+	if (bdev->bd_part_count)
+		return -EBUSY;
 
 	/*
 	 * Reopen the device to revalidate the driver state and force a
