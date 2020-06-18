Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DAEC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2758D20897
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592492046;
	bh=tTWJjq+muqQxQ0SwSnC1nZeb0snxpyNIOwFazK0TuiI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xGLcf6qQ2anoR+3RvS6Pu1gx0by06x6A5Xb5W9LscWYF8BwRVpH5tTUlhb1/nLWZK
	 2oRyLrh9u0ddmAYpJC2aXl9EhZR54Tlo8aXTP86qESAU6kZQpAhBvZn0fufAs35Amg
	 g4X8JQmp56vTfh3NC0ui5vLEB4oa+8DfYwOk4Iv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgFROyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730930AbgFROyF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:54:05 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7992D20739;
        Thu, 18 Jun 2020 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592492044;
        bh=tTWJjq+muqQxQ0SwSnC1nZeb0snxpyNIOwFazK0TuiI=;
        h=From:To:Cc:Subject:Date:From;
        b=b0kqBnJpK7uAna+CdAsmLxbkeIuWx+Oz4Vc6Ghh/zSWOP7ZVIQIrwvdyeauToBrYx
         hTDK2lLtGuyUD9X9o4mQNCIyDvm4/r58TCMmeocokBhMewkTgOysj1vZRxxsCkyQhO
         hzM3GxJeuD2uxGpftdAU9XufPeLFAt0CUeJtpfWs=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/5] nvme support for zoned namespace command set
Date:   Thu, 18 Jun 2020 07:53:49 -0700
Message-Id: <20200618145354.1139350-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v1->v2:

  Addressed style/nits/naming (Chaitanya, Martin, Daniel, Javier)

  Added ZNS to the Kconfig info for CONFIG_BLK_DEV_ZONED (Niklas)

  Removed unnecessary ns descriptor's 'if' check (Martin, Niklas)

  Added received reviews (thank you, everyone)

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
 drivers/nvme/host/core.c       | 218 ++++++++++++++++++++++++------
 drivers/nvme/host/hwmon.c      |   2 +-
 drivers/nvme/host/lightnvm.c   |   4 +-
 drivers/nvme/host/multipath.c  |   2 +-
 drivers/nvme/host/nvme.h       |  51 ++++++-
 drivers/nvme/host/zns.c        | 238 +++++++++++++++++++++++++++++++++
 drivers/scsi/sd_zbc.c          |   1 +
 include/linux/nvme.h           | 137 ++++++++++++++++++-
 include/uapi/linux/blkzoned.h  |  15 ++-
 15 files changed, 648 insertions(+), 54 deletions(-)
 create mode 100644 drivers/nvme/host/zns.c

-- 
2.24.1

