Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF2AC65BAF
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4132020838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4132020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeLFQsW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:48:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44112 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeLFQsW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:48:22 -0500
Received: from [191.13.27.189] (helo=calabresa.spo.virtua.com.br)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gUwp0-0000io-Ks; Thu, 06 Dec 2018 16:48:19 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 0/4] nvme multipath: expose slaves/holders
Date:   Thu,  6 Dec 2018 14:48:08 -0200
Message-Id: <20181206164812.30925-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Exposing slaves/holders is necessary in order to find out the real PCI device
and its driver for the root filesystem when generating an initramfs with
initramfs-tools. That fails right now for nvme multipath devices, which this
patchset fixes.

However, because the slave devices are hidden, lsblk fails without some extra
patches, as it can't find the device numbers for the slave devices, and exits.

Christoph Hellwig (2):
  block: move holder tracking from struct block_device to hd_struct
  nvme: create slaves/holder entries for multipath devices

Thadeu Lima de Souza Cascardo (2):
  nvme: Should not warn when a disk path is opened
  block: expose devt for GENHD_FL_HIDDEN disks

 block/genhd.c                 | 13 ++++++----
 block/partition-generic.c     |  4 +++
 drivers/block/drbd/drbd_nl.c  |  4 +--
 drivers/md/bcache/super.c     |  8 +++---
 drivers/md/dm.c               |  4 +--
 drivers/md/md.c               |  4 +--
 drivers/nvme/host/core.c      |  9 ++++---
 drivers/nvme/host/multipath.c | 13 ++++++++--
 drivers/nvme/host/nvme.h      | 12 ++++++---
 fs/block_dev.c                | 48 +++++++++++++++--------------------
 include/linux/fs.h            | 11 +++-----
 include/linux/genhd.h         |  4 +++
 12 files changed, 75 insertions(+), 59 deletions(-)

-- 
2.19.1

