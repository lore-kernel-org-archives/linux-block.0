Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63862C433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 10:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiCCKsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 05:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiCCKsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 05:48:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D60217B882
        for <linux-block@vger.kernel.org>; Thu,  3 Mar 2022 02:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CHiveUA1ib6yt3yralHpQUfLdOcJ5Wr1IxrQfv+iU7A=; b=TJCusTr9R7xW4pb9WeMXC+CweE
        8c4d1qzGXzHRogOzn7ZbxAaVOmFEIqUmls4OigZGnYSF3fOn9ujmtaZPws6/u8ftoIvd5TYs6gZz5
        zfu1su0fdNq5NXbet18VGV1DB2nank1Q9Geu0jwd9emVMXXzdU1cjSZLxTGCTxQFjoygI73aqfuVc
        22bO7I5LaM5J1GH+QqoMxWMXtyV62egscu8dBMoWczZm4Q1wZ+W/MbA9i4yfb2bCvaVmYS3fa0dnQ
        RgoE2PUe55K5BUV/aaqGBO5NCgqCQhEWylrp2XE6/IYCklmUXoDBK1f0IB4J4LmUWWWuzMuiZw3WK
        IUh9dVqw==;
Received: from [91.93.38.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPizQ-0066mF-RY; Thu, 03 Mar 2022 10:47:22 +0000
Date:   Thu, 3 Mar 2022 13:47:12 +0300
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for Linux 5.18
Message-ID: <YiCcsBPAQwEaDCH2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit df00b1d26c3c3ff9dae4b572a6ad878ab65334e1:

  null_blk: null_alloc_page() cleanup (2022-02-27 14:49:49 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-03

for you to fetch changes up to 2079f41ec6ffaad9aa51ca550105b2228467aec7:

  nvme: check that EUI/GUID/UUID are globally unique (2022-02-28 13:45:07 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.18

 - add vectored-io support for user-passthrough (Kanchan Joshi)
 - add verbose error logging (Alan Adamson)
 - support buffered I/O on block devices in nvmet (Chaitanya Kulkarni)
 - central discovery controller support (Martin Belanger)
 - fix and extended the globally unique idenfier validation (me)
 - move away from the deprecated IDA APIs (Sagi Grimberg)
 - misc code cleanup (Keith Busch, Max Gurtovoy, Qinghua Jin,
   Chaitanya Kulkarni)

----------------------------------------------------------------
Alan Adamson (1):
      nvme: add verbose error logging

Chaitanya Kulkarni (9):
      nvme-core: remove unnecessary semicolon
      nvme-core: remove unnecessary function parameter
      nvme-fabrics: use unsigned int type
      nvme-fabrics: use unsigned int type
      nvme-fabrics: use consistent zeroout pattern
      nvme-fabrics: remove unnecessary braces for case
      nvmet: use i_size_read() to set size for file-ns
      nvmet: allow bdev in buffered_io mode
      nvme: add a helper to initialize connect_q

Christoph Hellwig (4):
      nvme: cleanup __nvme_check_ids
      nvme: fix the check for duplicate unique identifiers
      nvme: check for duplicate identifiers earlier
      nvme: check that EUI/GUID/UUID are globally unique

Kanchan Joshi (1):
      nvme: add vectored-io support for user-passthrough

Keith Busch (2):
      nvme: explicitly set non-error for directives
      nvme: remove nssa from struct nvme_ctrl

Martin Belanger (2):
      nvme: send uevent on connection up
      nvme: expose cntrltype and dctype through sysfs

Max Gurtovoy (1):
      nvme-rdma: add helpers for mapping/unmapping request

Qinghua Jin (1):
      nvme-fc: fix a typo

Sagi Grimberg (6):
      nvme: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvme-fc: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet-fc: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet-rdma: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet-tcp: replace ida_simple[get|remove] with the simler ida_[alloc|free]

 drivers/nvme/host/Kconfig         |   8 ++
 drivers/nvme/host/Makefile        |   2 +-
 drivers/nvme/host/constants.c     | 185 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c          | 192 ++++++++++++++++++++++++++++++--------
 drivers/nvme/host/fabrics.c       |   9 +-
 drivers/nvme/host/fc.c            |  22 ++---
 drivers/nvme/host/ioctl.c         |  35 +++++--
 drivers/nvme/host/nvme.h          |  31 +++++-
 drivers/nvme/host/rdma.c          | 117 +++++++++++++----------
 drivers/nvme/host/tcp.c           |   6 +-
 drivers/nvme/target/core.c        |   4 +-
 drivers/nvme/target/fc.c          |  12 +--
 drivers/nvme/target/io-cmd-bdev.c |   8 ++
 drivers/nvme/target/io-cmd-file.c |  17 +---
 drivers/nvme/target/loop.c        |   6 +-
 drivers/nvme/target/nvmet.h       |   2 +-
 drivers/nvme/target/rdma.c        |   6 +-
 drivers/nvme/target/tcp.c         |   6 +-
 include/linux/nvme-fc-driver.h    |   2 +-
 include/linux/nvme.h              |  11 ++-
 include/uapi/linux/nvme_ioctl.h   |   6 +-
 21 files changed, 532 insertions(+), 155 deletions(-)
 create mode 100644 drivers/nvme/host/constants.c
