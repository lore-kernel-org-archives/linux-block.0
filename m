Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624F6C433E1
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CBA206E9
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457619;
	bh=lYKOELODA4KiSILqoskDg8YT5iR81f5zJokRkkWKqsI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dfjA9NpTGR0kS8qKZDD7MPbAr+yDlm18Mp62X4rR/RgYMd4/cBmS+fgOAMOHoyfWi
	 Ar33MqwRrx0qQFz4zj9IMdH9ZcMGDGO1hupk8mg2gN3siy56PuM6NQjFo9IqY3SXdX
	 bQ20Ud9xD4L1Y7UUeffHe711erM6k/0+RBHoyeMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgF2TG5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbgF2TGp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:45 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B452064B;
        Mon, 29 Jun 2020 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593457605;
        bh=lYKOELODA4KiSILqoskDg8YT5iR81f5zJokRkkWKqsI=;
        h=From:To:Cc:Subject:Date:From;
        b=xBFTeAe+lRqxcnZRTxt/1w8+lzYOx77dMiFTvagG2i0jmJ/zKb9koYrdz0s3NnD6o
         lW9I0+mJCeYUY5YVFSMRb59TZKAl4wfFMRT1ZCvjQG7gMCzxjtbyztXghNeQJGf9wl
         hffM2Ra3JB4V5h7vU29H7lZVftorPfhRyHXXULrQ=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/5] nvme support for zoned namespace command set
Date:   Mon, 29 Jun 2020 12:06:36 -0700
Message-Id: <20200629190641.1986462-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes since v3:

  Replaced older ID controller definition with the updated one from the
  ratified spec (zamds -> zasl).

  Verify power of 2 zone size (internal test)

  Check for valid capacity for report zones; a namespace deletion event
  sets the capacity to 0. If zone revalidation happens around the same
  time, we'd not fill in any zones and hit a BUG() later in the
  blk_zone_revalidate_disk_zones(). (internal testing)

  Fixup for identify namespace descriptors to hide retryable errors
  (Sagi, Nikals; requires a currently unincorporated patch from Sagi)

  Removed unnecessary __GFP_ZERO (Johannes)

  Endian conversion typo (Johannes)

  Added warnings when a zoned namespace can't be added (Klaus, Matias)

  Added received reviews

Background:

The NVM Express workgroup has ratified technical proposals enabling new
command sets. The specifications may be viewed from the following link:

  https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs.zip

This series implements support for the Zoned Namespace (ZNS) Command Set
defined in TP4053, and the Namespace Types base support it depends on
from TP4056. As this series depends on the block layer's append support
infrastructure, append-capable ZNS devices are required for this patch
sets enabling.

The block layer is updated to include the new zone writeable capacity
feature from ZNS, and existing zone block device drivers are updated to
incorporate this feature.

Aravind Ramesh (1):
  null_blk: introduce zone capacity for zoned device

Keith Busch (2):
  nvme: support for multi-command set effects
  nvme: support for zoned namespaces

Matias Bjørling (1):
  block: add capacity field to zone descriptors

Niklas Cassel (1):
  nvme: implement I/O Command Sets Command Set support

 block/Kconfig                  |   5 +-
 block/blk-zoned.c              |   1 +
 drivers/block/null_blk.h       |   1 +
 drivers/block/null_blk_main.c  |  10 +-
 drivers/block/null_blk_zoned.c |  16 ++-
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       | 227 +++++++++++++++++++++++------
 drivers/nvme/host/hwmon.c      |   2 +-
 drivers/nvme/host/lightnvm.c   |   4 +-
 drivers/nvme/host/multipath.c  |   2 +-
 drivers/nvme/host/nvme.h       |  50 ++++++-
 drivers/nvme/host/zns.c        | 253 +++++++++++++++++++++++++++++++++
 drivers/scsi/sd_zbc.c          |   1 +
 include/linux/nvme.h           | 134 ++++++++++++++++-
 include/uapi/linux/blkzoned.h  |  15 +-
 15 files changed, 667 insertions(+), 55 deletions(-)
 create mode 100644 drivers/nvme/host/zns.c

-- 
2.24.1

