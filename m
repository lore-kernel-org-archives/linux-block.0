Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FADC63697
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02342222A
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 16:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgKSQtc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:49:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:36162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgKSQtc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 11:49:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FEC6AC59;
        Thu, 19 Nov 2020 16:49:31 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCHv2 0/2] block-layer interposer
Date:   Thu, 19 Nov 2020 17:49:22 +0100
Message-Id: <20201119164924.74401-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

here's a combined version of the earlier patchset from Sergei, fixing
some issues I've found during testing and including (some) feedback
from Mike. So with this patchset I could do a

echo "0 33554432 linear /dev/sda 0" | dmsetup create sda-cloned

on a system with root-fs on /dev/sda2, and things would continue to
run just like normal.

There are some things which might need to be improved:
- I've tried to remove the stub bio clone for the dm interposer as
suggested by Mike, but that resulted in an endless recursion in
submit_bio_noacct(). That needs more debugging,  but I'm also not
sure if we _can_ do it; the end_io callback might refer to
bi_disk->driver_private, and then will get confused as we've
reassigned the 'bi_disk' setting. Not sure if there are fixed rules
for it, so for now I'll probably leave it.
- The interposer is 'magically' hooked to the first block device
in the device-mapper table. What I really want is to have an explicit
listing of the interposer in the output of things like 'dmsetup table'
like

0 33554432 interposer /dev/dm-0
0 33554432 linear /dev/sda 0

and the first entry having the device number of /dev/sda.
Plan was to have that automatically registered once you set up
the original table, but then I'm not sure if that's the right
way to go. Mike?
- The removal of blkdev_get() as an exported API made things
awkward, as we now have to do a blkdev_get_by_dev(); if not we
end up with an uninitalized blkcg and a resulting crash.
We might be able to fix this up by moving bdget() into dm_blk_open(),
and have md->bdev uninitalized otherwise. But again I'm not
sure if that's the right way to go.

Anyway, comments and reviews are welcome.

Sergei Shtepa (2):
  blk_interposer - Block Layer Interposer
  dm_interposer - blk_interposer for device-mapper

 block/blk-core.c          |  34 +++++++++++
 block/genhd.c             |  55 ++++++++++++++++++
 drivers/md/dm-table.c     |  59 +++++++++++++++++++
 drivers/md/dm.c           | 140 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/md/dm.h           |   4 +-
 include/linux/blk_types.h |   6 +-
 include/linux/genhd.h     |  19 +++++++
 7 files changed, 303 insertions(+), 14 deletions(-)

-- 
2.16.4

