Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5ACC433DF
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 16:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584432076A
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592843133;
	bh=vsp2NqCb9HBKuEC25SRN+ggXopdvn71qMC4Q5Bb1Zis=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZCWp58E+/GPE0wEbkI2qshq32QS5rysI+vGM0ftUErRSoSaHwqsc1qwvKajqHJNPd
	 YS/HSulaETl4iRFZh5jh8vJ3IqtISIz6P9f+u5DbqBD0Z3barK6N4quG8rman3SF5A
	 uH574ZWIUo7L81XXi50Gz65dcmU/3O454b19Qtbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgFVQZc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgFVQZc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 12:25:32 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 809702073E;
        Mon, 22 Jun 2020 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592843132;
        bh=vsp2NqCb9HBKuEC25SRN+ggXopdvn71qMC4Q5Bb1Zis=;
        h=From:To:Cc:Subject:Date:From;
        b=dr0F/9iZTW0iv0RzK7XlMQo4YejudbOiPs4OweOsK3RXu2r7Y3/63SzwVosJiSKMu
         6DMW+MI8eITeNl5OTrlpn/PMyVFpKuAA8ebSs0oakiXK5/cNjmBXKZGgh/5Wy4F8kD
         LlGDruqoLfwLRRuW2wrDObF0pjMXKbenYtHxg6Y8=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/5] nvme support for zoned namespace command set
Date:   Mon, 22 Jun 2020 09:25:25 -0700
Message-Id: <20200622162530.1287650-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v2->v3:

  Added warnings for unsupported ZNS drives (Klaus)

  Fixed double newline

  Added reviews

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
 drivers/nvme/host/core.c       | 218 +++++++++++++++++++++++------
 drivers/nvme/host/hwmon.c      |   2 +-
 drivers/nvme/host/lightnvm.c   |   4 +-
 drivers/nvme/host/multipath.c  |   2 +-
 drivers/nvme/host/nvme.h       |  50 ++++++-
 drivers/nvme/host/zns.c        | 245 +++++++++++++++++++++++++++++++++
 drivers/scsi/sd_zbc.c          |   1 +
 include/linux/nvme.h           | 137 +++++++++++++++++-
 include/uapi/linux/blkzoned.h  |  15 +-
 15 files changed, 654 insertions(+), 54 deletions(-)
 create mode 100644 drivers/nvme/host/zns.c

-- 
2.24.1

