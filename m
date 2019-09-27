Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6033FC4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BC920872
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a91DWZKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfI0R6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:58:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfI0R6E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 13:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mqV86Qk9ujuNkKtc+FM4/w2Ow1yHPT9HsqipeiB7mMI=; b=a91DWZKcNQ0kaF7hjxmQw0YDF
        3+277Yz9UyEdCKaB4mNlyzCUYPFtbB10io+bc49eyROZk8GxpIC/LIhPXNkdMlMD/lwkdCKr5as5C
        MTMA7pXjLTGwoPO3mDC/gRwEBSiRA36zWZ8VP5Zs6gXVHZBuOuQmu97CJYREtEcFrRp5ODjTgFaz+
        l8YbyBBkFg+yfrT9uHwA+Pj2J+pBEyR29AvaE25yQwupCZC4rAWweRlw48ZdMDKYcEa2/7d7AMjGT
        mM7+AfzwJiGBurhWDbe1ZviRaFvlBLYHH22ZzNZHGcSfEd+xYKSE5XOgtswRsffAklac/Uw7Ub80G
        JVRFmYFEw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDuVG-0005uQ-EQ; Fri, 27 Sep 2019 17:58:02 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [GIT PULL] nvme fixes for kernel 5.4-rc1
Date:   Fri, 27 Sep 2019 10:58:01 -0700
Message-Id: <20190927175801.12900-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Jens,

This set consists of various fixes and clenaups:
- controller removal race fix from Balbir
- quirk additions from Gabriel and Jian-Hong
- nvme-pci power state save fix from Mario
- Add 64bit user commands (for 64bit registers) from Marta
- nvme-rdma/nvme-tcp fixes from Max, Mark and Me
- Minor cleanups and nits from James, Dan and John

The following changes since commit d46fe2cb2dce7f5038473b5859e03f5e16b7428e:

  block: drop device references in bsg_queue_rq() (2019-09-23 11:17:24 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.4 

for you to fetch changes up to 67b483dd03c4cd9e90e4c3943132dce514ea4e88:

  nvme-rdma: fix possible use-after-free in connect timeout (2019-09-27 10:24:53 -0700)

----------------------------------------------------------------
Balbir Singh (1):
      nvme-pci: Fix a race in controller removal

Dan Carpenter (1):
      nvme: fix an error code in nvme_init_subsystem()

Gabriel Craciunescu (1):
      Added QUIRKs for ADATA XPG SX8200 Pro 512GB

James Smart (1):
      nvme: Add ctrl attributes for queue_count and sqsize

Jian-Hong Pan (1):
      nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T

John Pittman (1):
      nvmet: change ppl to lpp

Keith Busch (1):
      nvme: Move ctrl sqsize to generic space

Mario Limonciello (1):
      nvme-pci: Save PCI state before putting drive into deepest state

Marta Rybczynska (1):
      nvme: allow 64-bit results in passthru commands

Max Gurtovoy (1):
      nvme-rdma: Fix max_hw_sectors calculation

Sagi Grimberg (2):
      nvmet-tcp: remove superflous check on request sgl
      nvme-rdma: fix possible use-after-free in connect timeout

Wunderlich, Mark (1):
      nvme-tcp: fix wrong stop condition in io_work

 drivers/nvme/host/core.c          | 132 ++++++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h          |   2 +-
 drivers/nvme/host/pci.c           |  20 ++++--
 drivers/nvme/host/rdma.c          |  19 ++++--
 drivers/nvme/host/tcp.c           |   4 +-
 drivers/nvme/target/io-cmd-bdev.c |  16 ++---
 drivers/nvme/target/tcp.c         |  12 ++--
 include/uapi/linux/nvme_ioctl.h   |  23 +++++++
 8 files changed, 177 insertions(+), 51 deletions(-)
