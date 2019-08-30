Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B6CC3A5A6
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 19:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2D523429
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 19:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ysna8C+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfH3TB0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:01:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3TB0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 15:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jLKj9srI163SIZUhloLUDG7FNhI8KgJujJBygc6monI=; b=Ysna8C+JFecxIP9dmIAc9SzhW
        t4pkvHWpYCcWbUUFCtc4roHjV9BDoDv868vWyH3ZedwotfVMROiELstDsL7dXeNaMi7kQld35+ptu
        Cz2xZ3PkM53HhYHvgnAx+NfR3NImUKQIxwu/1p0wmQMqObTWB+lGcERPntl0UGTkZGGOui1y0XwUG
        dkBJaAOkvVUXEMJPIviJC0d2mvhhF5cVHD5wa0GsfHia8lgQLq7qUAYOn0AurLVQcZ0a5q+Dt1tOE
        emJ7TpA3IuFlsTsc8adfMZrDksARWl131Ev8Gev2qrucmc/Q2mh93prjTWp7QgIot4lqAP4+/teqr
        t/aOCfpxw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3m9F-0004Ja-Tl; Fri, 30 Aug 2019 19:01:25 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [GIT PULL] nvme updates for 5.4
Date:   Fri, 30 Aug 2019 12:01:24 -0700
Message-Id: <20190830190124.11961-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Jens,

First pull request for 5.4. Note that we do have some more patchsets
in the pipe, but we'll have them settle first in the nvme tree.

Also, note that there will be a merge conflict with 5.3-rc fixes on
the nvme quirk enumeration from the Apple work-around patches from Ben
and the LiteON quirk cb32de1b7e25 ("nvme: Add quirk for LiteON CL1 devices
running FW 22301111"). The fix pretty trivial, as the quirks enums simply
need to increment.

I have the fixed series in a branch:

  git://git.infradead.org/nvme.git nvme-resolve-5.4-conflict

The nvme updates include:
- ana log parse fix from Anton
- nvme quirks support for Apple devices from Ben
- fix missing bio completion tracing for multipath stack devices from Hannes and
  Mikhail
- IP TOS settings for nvme rdma and tcp transports from Israel
- rq_dma_dir cleanups from Israel
- tracing for Get LBA Status command from Minwoo
- Some nvme-tcp cleanups from Minwoo, Potnuri and Myself
- Some consolidation between the fabrics transports for handling the CAP
  register
- reset race with ns scanning fix for fabrics (move fabrics commands to
  a dedicated request queue with a different lifetime from the admin
  request queue).

The following changes since commit 3532e7227243beb0b782266dc05c40b6184ad051:

  blkcg: fix missing free on error path of blk_iocost_init() (2019-08-29 09:59:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.4 

for you to fetch changes up to bc31c1eea99de9a8e65b011483716236af52f7ed:

  nvme-rdma: Use rq_dma_dir macro (2019-08-29 12:55:03 -0700)

----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix ana log nsid lookup when nsid is not found

Benjamin Herrenschmidt (4):
      nvme-pci: Pass the queue to SQ_SIZE/CQ_SIZE macros
      nvme-pci: Add support for variable IO SQ element size
      nvme-pci: Add support for Apple 2018+ models
      nvme-pci: Support shared tags across queues for Apple 2018 controllers

Hannes Reinecke (1):
      nvme: trace bio completion

Israel Rukshin (8):
      nvme-fabrics: Add type of service (TOS) configuration
      nvme-rdma: Add TOS for rdma transport
      nvme-tcp: Use struct nvme_ctrl directly
      nvme-tcp: Add TOS for tcp transport
      nvmet-tcp: Add TOS for tcp transport
      nvme-pci: Tidy up nvme_unmap_data
      nvme-fc: Use rq_dma_dir macro
      nvme-rdma: Use rq_dma_dir macro

Minwoo Im (5):
      nvme: tcp: selects CRYPTO_CRC32C for nvme-tcp
      nvme: add Get LBA Status command opcode
      nvme: trace: support for Get LBA Status opcode parsed
      nvme: trace: parse Get LBA Status command in detail
      nvmet: trace: parse Get LBA Status command in detail

Potnuri Bharat Teja (1):
      nvme-tcp: Use protocol specific operations while reading socket

Sagi Grimberg (9):
      nvme-tcp: cleanup nvme_tcp_recv_pdu
      nvme: have nvme_init_identify set ctrl->cap
      nvme-pci: set ctrl sqsize to the device q_depth
      nvme: move sqsize setting to the core
      nvme: don't pass cap to nvme_disable_ctrl
      nvme-tcp: support simple polling
      nvmet-tcp: fix possible NULL deref
      nvmet-tcp: fix possible memory leak
      nvme: make fabrics command run on a separate request queue

Tom Wu (1):
      nvmet: fix data units read and written counters in SMART log

 drivers/nvme/host/Kconfig       |   1 +
 drivers/nvme/host/core.c        |  37 +++++------
 drivers/nvme/host/fabrics.c     |  26 ++++++--
 drivers/nvme/host/fabrics.h     |   3 +
 drivers/nvme/host/fc.c          |  34 +++++------
 drivers/nvme/host/multipath.c   |   8 ++-
 drivers/nvme/host/nvme.h        |  36 ++++++++++-
 drivers/nvme/host/pci.c         |  99 +++++++++++++++++++++++-------
 drivers/nvme/host/rdma.c        |  53 ++++++++--------
 drivers/nvme/host/tcp.c         | 132 ++++++++++++++++++++++++++++------------
 drivers/nvme/host/trace.c       |  18 ++++++
 drivers/nvme/target/admin-cmd.c |  14 +++--
 drivers/nvme/target/loop.c      |  28 ++++-----
 drivers/nvme/target/tcp.c       |  24 ++++++--
 drivers/nvme/target/trace.c     |  18 ++++++
 include/linux/nvme.h            |   5 +-
 16 files changed, 379 insertions(+), 157 deletions(-)
