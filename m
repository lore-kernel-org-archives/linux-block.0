Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A4DC433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 17:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0200664DED
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 17:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhA1R0c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 12:26:32 -0500
Received: from mx2.veeam.com ([64.129.123.6]:53910 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233120AbhA1RY2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 12:24:28 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id CBACD41344;
        Thu, 28 Jan 2021 12:12:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1611853969; bh=BA0Er6zcH5w4NN84e+3hlB2zoRXintRQzFb3m91ZDx0=;
        h=From:To:CC:Subject:Date:From;
        b=Fdxg+0yOHNqvRtjoOYd+OPu46ljAAh3xQ2F2OlJiUpYjT8zY8WaXX6dhYaVjeky9a
         UIBo0/rVc8QkRL9IrfefFBRXdXLxCVx9CQ3NoRMGT6vF2+wfDGdVKgnALbsM6BGqff
         N4n20s45nDxj5AlFS1QSeIyljnayhEnbxwFnt0I8=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 28 Jan 2021 18:12:46 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <hare@suse.de>, <ming.lei@redhat.com>, <agk@redhat.com>,
        <snitzer@redhat.com>, <dm-devel@redhat.com>,
        <linux-block@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH 0/2] block: blk_interposer v3
Date:   Thu, 28 Jan 2021 20:12:33 +0300
Message-ID: <1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D265677D6B
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

I`m ready to suggest the blk_interposer again.
blk_interposer allows to intercept bio requests, remap bio to
another devices or add new bios.

This version has support from device mapper.

For the dm-linear device creation command, the `noexcl` parameter
has been added, which allows to open block devices without
FMODE_EXCL mode. It allows to create dm-linear device on a block
device with an already mounted file system.
The new ioctl DM_DEV_REMAP allows to enable and disable bio
interception.

Thus, it is possible to add the dm-device to the block layer stack
without reconfiguring and rebooting.


Sergei Shtepa (2):
  block: blk_interposer
  [dm] blk_interposer for dm-linear

 block/bio.c                   |   2 +
 block/blk-core.c              |  29 +++
 block/blk-mq.c                |  13 ++
 block/genhd.c                 |  82 ++++++++
 drivers/md/dm-core.h          |  46 +++-
 drivers/md/dm-ioctl.c         |  39 ++++
 drivers/md/dm-linear.c        |  17 +-
 drivers/md/dm-table.c         |  12 +-
 drivers/md/dm.c               | 383 ++++++++++++++++++++++++++++++++--
 drivers/md/dm.h               |   2 +-
 include/linux/blk-mq.h        |   1 +
 include/linux/blk_types.h     |   6 +-
 include/linux/device-mapper.h |   7 +
 include/linux/genhd.h         |  19 ++
 include/uapi/linux/dm-ioctl.h |  15 +-
 15 files changed, 643 insertions(+), 30 deletions(-)

-- 
2.20.1

