Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1248C77B71
	for <linux-block@archiver.kernel.org>; Fri, 14 Apr 2023 05:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjDNFWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 01:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNFWj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 01:22:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3899C1FD2
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 22:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=AGeICsuA9uEhadHjkh4URyIX1Dc4rlat2MsAlY3egPs=; b=p/RY894meWRGQTjLtT9y4wYH6p
        Md1iDcb1Xk/iMO2IUQxFYFUQpEdLDzyWT18iU75Ho7dE+TEuoMyYmV43wiJC3XyeYOWXRNCXfHnG7
        65jvqMkI8Ze0S35YIfAYCXTP4CvSD7Ucngc3gwHpts7Hm6IhVAKJpIxRuE2jMPYN6d5IVlqwgM1mE
        h4F3akndUSM7zIY79aZjhWvKsO0GGgQaqE0mbtgUB4+0CA7r1+aSDjeYII6xbI6GEWozZG8jzBBmU
        gwXu2IaT8SJT8EPMc5zlCNtN8iIGltWx7p/OQSV/6pkRwzh7Nz5Hep6+Hgscn0K61kwwgsEgWQ5WB
        72bT/2kA==;
Received: from [2001:4bb8:192:2d6c:7f18:1319:183f:920d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBtJ-008M2y-1G;
        Fri, 14 Apr 2023 05:22:33 +0000
Date:   Fri, 14 Apr 2023 07:22:31 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.4
Message-ID: <ZDjjF9NWdq+gC0tI@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit d8898ee50edecacdf0141f26fd90acf43d7e9cd7:

  s390/dasd: fix hanging blockdevice after request requeue (2023-04-11 19:53:08 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.4-2023-04-14

for you to fetch changes up to 4f86a6ff6fbd891232dda3ca97fd1b9630b59809:

  nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage" (2023-04-13 09:02:55 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.4

 - drop redundant pci_enable_pcie_error_reporting (Bjorn Helgaas)
 - validate nvmet module parameters (Chaitanya Kulkarni)
 - fence TCP socket on receive error (Chris Leech)
 - fix async event trace event (Keith Busch)
 - minor cleanups (Chaitanya Kulkarni, zhenwei pi)
 - fix and cleanup nvmet Identify handling (Damien Le Moal,
   Christoph Hellwig)
 - fix double blk_mq_complete_request race in the timeout handler
   (Lei Yin)
 - fix irq locking in nvme-fcloop (Ming Lei)
 - remove queue mapping helper for rdma devices (Sagi Grimberg)

----------------------------------------------------------------
Bjorn Helgaas (1):
      nvme-pci: drop redundant pci_enable_pcie_error_reporting()

Chaitanya Kulkarni (4):
      nvmet-tcp: validate so_priority modparam value
      nvmet-tcp: validate idle poll modparam value
      nvme-apple: return directly instead of else
      nvme-apple: return directly instead of else

Chris Leech (1):
      nvme-tcp: fence TCP socket on receive error

Christoph Hellwig (3):
      nvmet: fix Identify Identification Descriptor List handling
      nvmet: rename nvmet_execute_identify_cns_cs_ns
      nvmet: remove nvmet_req_cns_error_complete

Damien Le Moal (6):
      nvmet: fix error handling in nvmet_execute_identify_cns_cs_ns()
      nvmet: fix Identify Namespace handling
      nvmet: fix Identify Controller handling
      nvmet: fix Identify Active Namespace ID list handling
      nvmet: fix I/O Command Set specific Identify Controller
      nvmet: cleanup nvmet_execute_identify()

Keith Busch (1):
      nvme: fix async event trace event

Lei Yin (1):
      nvme: fix double blk_mq_complete_request for timeout request with low probability

Ming Lei (1):
      nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"

Sagi Grimberg (1):
      blk-mq-rdma: remove queue mapping helper for rdma devices

zhenwei pi (1):
      nvme-rdma: minor cleanup in nvme_rdma_create_cq()

 block/Kconfig                   |  5 ---
 block/Makefile                  |  1 -
 block/blk-mq-rdma.c             | 44 ----------------------
 drivers/nvme/host/apple.c       |  8 ++--
 drivers/nvme/host/core.c        |  9 ++---
 drivers/nvme/host/pci.c         |  6 +--
 drivers/nvme/host/rdma.c        | 19 +++-------
 drivers/nvme/host/tcp.c         |  3 ++
 drivers/nvme/host/trace.h       | 15 +++-----
 drivers/nvme/target/admin-cmd.c | 81 +++++++++++++++++------------------------
 drivers/nvme/target/fcloop.c    | 48 +++++++++++++-----------
 drivers/nvme/target/nvmet.h     | 12 +-----
 drivers/nvme/target/tcp.c       | 34 +++++++++++++++--
 drivers/nvme/target/zns.c       | 20 +++++-----
 include/linux/blk-mq-rdma.h     | 11 ------
 15 files changed, 126 insertions(+), 190 deletions(-)
 delete mode 100644 block/blk-mq-rdma.c
 delete mode 100644 include/linux/blk-mq-rdma.h
