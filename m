Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CE5C4338F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 18:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D0560C3E
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 18:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhHSSGj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:06:39 -0400
Received: from verein.lst.de ([213.95.11.211]:38473 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhHSSGi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 14:06:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8BDED6736F; Thu, 19 Aug 2021 20:05:59 +0200 (CEST)
Date:   Thu, 19 Aug 2021 20:05:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: Re: holders not working properly, regression [was: Re: use regular
 gendisk registration in device mapper v2]
Message-ID: <20210819180559.GA14001@lst.de>
References: <20210804094147.459763-1-hch@lst.de> <YR5/wMEkr1TwV7FD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR5/wMEkr1TwV7FD@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Manually reverting "block: remove the extra kobject reference in
bd_link_disk_holder" as show below fixed the issue for me.  I'll spend
some more time tomorrow trying to fully understan the life time rules
tomorrow before sending a patch, though.

---
From 6b94f5435900d23769db8d07ff47415aab4ac63e Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 19 Aug 2021 20:01:43 +0200
Subject: Revert "block: remove the extra kobject reference in
 bd_link_disk_holder"

This reverts commit fbd9a39542ecdd2ade55869c13856b2590db3df8.
---
 block/holder.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/holder.c b/block/holder.c
index 4568cc4f6827..ecbc6941e7d8 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -106,6 +106,12 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	}
 
 	list_add(&holder->list, &disk->slave_bdevs);
+	/*
+	 * bdev could be deleted beneath us which would implicitly destroy
+	 * the holder directory.  Hold on to it.
+	 */
+	kobject_get(bdev->bd_holder_dir);
+
 out_unlock:
 	mutex_unlock(&disk->open_mutex);
 	return ret;
@@ -138,6 +144,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		if (disk->slave_dir)
 			__unlink_disk_holder(bdev, disk);
+		kobject_put(bdev->bd_holder_dir);
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
-- 
2.30.2

