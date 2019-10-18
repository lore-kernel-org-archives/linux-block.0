Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF1BCA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 09:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C2C21852
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 09:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390634AbfJRJhO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:37:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:49912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727917AbfJRJhO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 05:37:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D7DFB028;
        Fri, 18 Oct 2019 09:37:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 354CA1E4851; Fri, 18 Oct 2019 11:37:12 +0200 (CEST)
Date:   Fri, 18 Oct 2019 11:37:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: Disk size update on first open
Message-ID: <20191018093712.GA18593@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I have been debugging weird failures when using encrypted DVDs (bko#194965
for interested) but in the end it all boils down to the fact that
__blkdev_get() updates i_size of bdev inode only of the first open. This
seems as a sensible thing to do but there is some weird behavior resulting
out of this for devices with removable media:

1) If someone has the device (such as /dev/sr0) open while inserting the
media, bdev size will not get updated. This results in the media being
accessible but the device size is wrong resulting in weird and hard to
debug failures.

2) This is especially annoying when pktcdvd is in the game as pktcdvd
device holds corresponding sr device permanently open.

Upon some inspection this seems to be an issue with how check_disk_change()
(called from sr_block_open()) interacts with __blkdev_get(). If partition
scan is enabled, check_disk_change() will call flush_disk() which sets
bdev->bd_invalidated. And __blkdev_get() seeing bd_invalidated will call
rescan_partitions() which ends up updating bdev size through
check_disk_size_change(). But without partitioning none of this happens and
the disk size remains stale.

Now it seems strange that partitioned and unpartitioned devices behave
differently. So I'd be inclined to just unify the behavior and use
bd_invalidated for unpartitioned devices as well. Does anyone see a problem
with that?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
