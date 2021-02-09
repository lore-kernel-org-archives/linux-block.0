Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FE4C433E6
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 14:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCFC64DED
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 14:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhBIObj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 09:31:39 -0500
Received: from mx2.veeam.com ([64.129.123.6]:54696 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhBIObi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Feb 2021 09:31:38 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id DEBBD415DC;
        Tue,  9 Feb 2021 09:30:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1612881053; bh=OFwZKhsGuko0X0w9i3hfgoHaa6lOMWeFSq7BdeGM+gE=;
        h=From:To:CC:Subject:Date:From;
        b=jjIOlUjDYhD6wQzoQ38zXyiaan4xG0YFvs4Ko3dpIeUvhfILESU2wP9sNuxxGZsBj
         AQ5slmF490CQ2LXBumDoo8jB1eUIOREpLspTwvRyJPiP0j6V8sStk+8y5aRlzNGuam
         AoOE8pkL3XU8SxrK5YiI6zkgwV7sHYGBHkCrDe30=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 9 Feb 2021 15:30:45 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <Damien.LeMoal@wdc.com>, <snitzer@redhat.com>, <hare@suse.de>,
        <ming.lei@redhat.com>, <agk@redhat.com>, <corbet@lwn.net>,
        <axboe@kernel.dk>, <jack@suse.cz>, <johannes.thumshirn@wdc.com>,
        <gregkh@linuxfoundation.org>, <koct9i@gmail.com>, <steve@sk2.org>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v5 0/6] block-layer interposer
Date:   Tue, 9 Feb 2021 17:30:22 +0300
Message-ID: <1612881028-7878-1-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D265617465
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all.

I'm joyful to suggest the block-layer interposer (blk_interposer) v5.
blk_interposer allows to intercept bio requests, remap bio to another
devices or add new bios.

This patch series adds support blk_interposer for dm-linear.

In the first patch, I suggest the remap_and_filter.rst file.
Yes, Mike, it's probably too early for documentation, but maybe it will be
interesting for someone. In the documentation I tried to explain
the purpose of blk_interposer and what prospects it opens up.

The second patch adds the function blk_mq_is_queue_frozen(). It allows to
assert a queue state.

The third patch is dedicated to blk_interposer itself, which provides
the ability to intercept bio.

The fourth one adds support for blk_interposer from the device mapper.
Added ioctl DM_DEV_REMAP_CMD.

In the fifth - added the 'noexcl' option for dm-linear, which allows
to open the underlying block-device without the FMODE_EXCL mode.
This allows to create a dm device to which can redirect bio requests
using DM_DEV_REMAP_CMD.

The latest patch changes linear.rst with the description of the 'noexcl'
option that is added for dm-linear.

A little history of changes:

v5 - current patch set
Changes:
 * rebase for v5.11-rc7;
 * patch set organization;
 * fix defects in documentation;
 * add some comments;
 * change mutex names for better code readability;
 * remove calling bd_unlink_disk_holder() for targets with non-exclusive
   flag;
 * change type for struct dm_remap_param from uint8_t to __u8.

v4 - https://patchwork.kernel.org/project/linux-block/cover/1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com/
Mostly changes were made, due to Damien's comments:
 * on the design of the code;
 * by the patch set organization;
 * bug with passing a wrong parameter to dm_get_device();
 * description of the 'noexcl' parameter in the linear.rst.
Also added remap_and_filter.rst.

v3 - https://patchwork.kernel.org/project/linux-block/cover/1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com/
In this version, I already suggested blk_interposer to apply to dm-linear.
Problems were solved:
 * Interception of bio requests from a specific device on the disk, not
   from the entire disk. To do this, we added the dm_interposed_dev
   structure and an interval tree to store these structures.
 * Implemented ioctl DM_DEV_REMAP_CMD. A patch with changes in the lvm2
   project was sent to the team lvm-devel@redhat.com.
 * Added the 'noexcl' option for dm-linear, which allows you to open
   the underlying block-device without FMODE_EXCL mode.

v2 - https://patchwork.kernel.org/project/linux-block/cover/1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com/
I tried to suggest blk_interposer without using it in device mapper,
but with the addition of a sample of its use. It was then that I learned
about the maintainers' attitudes towards the samples directory :).

v1 - https://lwn.net/ml/linux-block/20201119164924.74401-1-hare@suse.de/
This Hannes's patch can be considered as a starting point, since this is
where the interception mechanism and the term blk_interposer itself
appeared. It became clear that blk_interposer can be useful for
device mapper.

before v1 - https://patchwork.kernel.org/project/linux-block/cover/1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com/
I tried to offer a rather cumbersome blk-filter and a monster-like
blk-snap module for creating snapshots.

Thank you to everyone who was able to take the time to review
the previous versions.
I hope that this time I achieved the required quality.

Thanks,
Sergei.

Sergei Shtepa (6):
  docs: device-mapper: add remap_and_filter
  block: add blk_mq_is_queue_frozen()
  block: add blk_interposer
  dm: new ioctl DM_DEV_REMAP_CMD
  dm: add 'noexcl' option for dm-linear
  docs: device-mapper: 'noexcl' option for dm-linear

 .../admin-guide/device-mapper/index.rst       |   1 +
 .../admin-guide/device-mapper/linear.rst      |  26 +-
 .../device-mapper/remap_and_filter.rst        | 132 ++++++
 block/bio.c                                   |   2 +
 block/blk-core.c                              |  35 ++
 block/blk-mq.c                                |  13 +
 block/genhd.c                                 |  86 ++++
 drivers/md/dm-core.h                          |  20 +
 drivers/md/dm-ioctl.c                         |  35 ++
 drivers/md/dm-linear.c                        |  14 +-
 drivers/md/dm-table.c                         |  14 +-
 drivers/md/dm.c                               | 401 +++++++++++++++++-
 drivers/md/dm.h                               |   2 +-
 include/linux/blk-mq.h                        |   1 +
 include/linux/blk_types.h                     |   6 +-
 include/linux/device-mapper.h                 |   7 +
 include/linux/genhd.h                         |  18 +
 include/uapi/linux/dm-ioctl.h                 |  15 +-
 18 files changed, 796 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/admin-guide/device-mapper/remap_and_filter.rst

--
2.20.1

