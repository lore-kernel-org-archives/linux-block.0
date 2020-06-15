Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84445C433E0
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F08B206DB
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HyJp/JLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFOXfQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:35:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40426 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXfP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 19:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592264114; x=1623800114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/dV0XpG3sEX/aw3d1RyhoLZ6PnRO6yjnnlAlMi46u0Q=;
  b=HyJp/JLu9tSAzCCvNbZ4On+pJorpOIg8ImvfShcn8eVB7J9bgg5F4wAC
   8yIXnuX7l82OplLH00dj2ChxLtxSdKNiWq5MIWhHGEKN233RBY6CPslE4
   kqg/mtIZ+n1FQyRCKLI2krxmFOrs+iNIkgDwBz009t+lKDl9lVlv3IeS8
   LJOq5LepQkr5raNp12cAp59pqnNSdxKmSAF3s4zZY5gg9CHZfhrrogXYa
   OuIbTJOk8qiv3q0TwvzHMxfto+wFQH8LQfWD5K99DVubSGIOzfJfxa+DP
   Iyb1KE77SgTyAMIFcPDrKez0dx/Yl8bnvYsA2dtPNuNudYhJdSrXVE+j1
   Q==;
IronPort-SDR: BsAl+mU6f0Q6MCjyetqASPwYVyVo8ZjGxxjo6udnp4xrZOmxmazG5dKgfJb+NeSlJYNeuWtV/z
 B60Dhzt2XfvD/GHcNa5xHczUYoPonPWMCBAG+I3sswIFSb0GyFiWiB+SuoNlUvP9MeGfSNgycT
 XbhyPouroga8XnNzc5oedbuZ8Zq2pALXOiapnoxgDYa+zRc+I+LQPHU8RpuUmkgvf9rzr4xWzP
 +27WhrPe6zA3Xjo/7gYOTKB00YGqPV7YvF1gdfXKEaV//YpQEIOgZQbmiJuwvD/LVNwrZ52Q1q
 8WQ=
X-IronPort-AV: E=Sophos;i="5.73,516,1583164800"; 
   d="scan'208";a="249248737"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 07:35:14 +0800
IronPort-SDR: O6nAAcI7wezLw+5wa8+BW22k95NUkyT64kyyuQordGqNVIDjbcYKBCcO8CrI3vM9k+3i1tqc+0
 k3UyxWDYvyyubu5Ds66br+iQuo8tuFpVU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 16:24:31 -0700
IronPort-SDR: rd/GBl9PzcZ6CyCsEG5yJjKOFPM8htXP5G8XouZ6r5RPQsoknm4/xjatsdkESO1XskIhTPYq+7
 UcMUBxWyOTGQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun51.ssa.fujisawa.hgst.com) ([10.149.66.26])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2020 16:35:13 -0700
From:   Keith Busch <keith.busch@wdc.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/5] nvme support for zoned namespace command set
Date:   Tue, 16 Jun 2020 08:34:19 +0900
Message-Id: <20200615233424.13458-1-keith.busch@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The NVM Express workgroup has ratified technical proposals enabling new
command sets. The specifications may be viewed from the following link:

  https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs.zip

This series implements support for the Zoned Namespace (ZNS) Command Set
defined in TP4053, and the Namespace Types base support it depends on
from TP4056. 

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

 block/blk-zoned.c              |   1 +
 drivers/block/null_blk.h       |   2 +
 drivers/block/null_blk_main.c  |   9 +-
 drivers/block/null_blk_zoned.c |  17 ++-
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       | 223 ++++++++++++++++++++++++------
 drivers/nvme/host/hwmon.c      |   2 +-
 drivers/nvme/host/lightnvm.c   |   4 +-
 drivers/nvme/host/multipath.c  |   2 +-
 drivers/nvme/host/nvme.h       |  51 ++++++-
 drivers/nvme/host/zns.c        | 238 +++++++++++++++++++++++++++++++++
 drivers/scsi/sd_zbc.c          |   1 +
 include/linux/nvme.h           | 134 ++++++++++++++++++-
 include/uapi/linux/blkzoned.h  |  15 ++-
 14 files changed, 647 insertions(+), 53 deletions(-)
 create mode 100644 drivers/nvme/host/zns.c

-- 
2.24.1

