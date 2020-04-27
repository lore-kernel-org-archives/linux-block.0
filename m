Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5395BC54FD0
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312AC205C9
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 16:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgD0QKV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:10:21 -0400
Received: from verein.lst.de ([213.95.11.211]:49693 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgD0QKV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 12:10:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1BEE168CFC; Mon, 27 Apr 2020 18:10:17 +0200 (CEST)
Date:   Mon, 27 Apr 2020 18:10:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qian Cai <cai@lca.pw>,
        Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: s390 boot woe due to "block: fix busy device checking in
 blk_drop_partitions"
Message-ID: <20200427161016.GA9719@lst.de>
References: <AD16A450-794F-4EEA-A7BF-42452F18294A@lca.pw> <20200410054544.GA17923@lst.de> <20200423110738.GA102241@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423110738.GA102241@blackbook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michal,

can you try the patch below?  That should solve the udev race for real
hopefully.

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e5..20dbe4cf62cf9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1318,6 +1318,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (err)
 		goto out_unfreeze;
 
+	/* don't send uevents until we've finished the partition scan */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
+
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
 		/* kill_bdev should have truncated all the pages */
@@ -1377,6 +1380,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	return err;
 }
 
