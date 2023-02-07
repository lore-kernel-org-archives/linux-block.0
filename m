Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFDBC636CD
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 06:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBGGQC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 01:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjBGGQB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 01:16:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ADC619B
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 22:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=in7O/nJOIhRgUXf4SpB0/wLFU0yehYjKtq5D0aZFnzc=; b=PEloaJdfpyvVRGNb+gm/5RCQAr
        yBoJtrV8QS7WFpQwu787jl/YUk9qRhBeW27hhJI8HsxLXIRDtfnOQRwNzdOtQOFm7ug/IjEbA8j7u
        R5LRmIb1Acl+dYxnK6ZYLcXV0kSaqL5bBGIyDkgjs6sgNc1Aizq9MHqVegNZsF8TsjKVeN++K49vT
        MkUpSoVByUgV2rKcKCj0QFIcytVCAh6M2UlZWtQag/+By5l7VYGpSlLrqBG20LugQtkWb37pZ++OL
        pfxJPoHQFiJAsZT2rFh+tALK7o8WqAVzVVn2Nfl9mhL/dbfUoFCs+vdf/3oCvN6WHlIpcdJWsXAVo
        dgEhn80g==;
Received: from [2001:4bb8:182:9f5b:f9be:8d78:f28f:18a1] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPHGf-00AxDX-DZ; Tue, 07 Feb 2023 06:15:49 +0000
Date:   Tue, 7 Feb 2023 07:15:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.3
Message-ID: <Y+Hsk7eOObSafEkz@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 2d97930d74b12467fd5f48d8560e48c1cf5edcb1:

  block: Remove mm.h from bvec.h (2023-01-31 09:21:50 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2023-02-07

for you to fetch changes up to baff6491448b487e920faaa117e432989cbafa89:

  nvme: mask CSE effects for security receive (2023-02-01 16:10:10 +0100)

----------------------------------------------------------------
nvme updates for Linux 6.3

 - small improvements to the logging functionality (Amit Engel)
 - authentication cleanups (Hannes Reinecke)
 - cleanup and optimize the DMA mapping cod in the PCIe driver
   (Keith Busch)
 - work around the command effects for Format NVM (Keith Busch)
 - misc cleanups (Keith Busch, Christoph Hellwig)

----------------------------------------------------------------
Amit Engel (3):
      nvme: add nvme_opcode_str function for all nvme cmd types
      nvme-tcp: add additional info for nvme_tcp_timeout log
      nvmet: for nvme admin set_features cmd, call nvmet_check_data_len_lte()

Christoph Hellwig (1):
      nvme: remove nvme_execute_passthru_rq

Hannes Reinecke (2):
      nvme-fabrics: clarify AUTHREQ result handling
      nvme-auth: don't use NVMe status codes

Keith Busch (5):
      nvme-pci: remove SGL segment descriptors
      nvme-pci: use mapped entries for sgl decision
      nvme-pci: place descriptor addresses in iod
      nvme: always initialize known command effects
      nvme: mask CSE effects for security receive

 drivers/nvme/host/auth.c        |  30 +++++-----
 drivers/nvme/host/constants.c   |  16 ++++++
 drivers/nvme/host/core.c        | 119 ++++++++++++++++++++++------------------
 drivers/nvme/host/fabrics.c     |  19 ++++++-
 drivers/nvme/host/ioctl.c       |   5 +-
 drivers/nvme/host/nvme.h        |  16 +++++-
 drivers/nvme/host/pci.c         | 100 +++++++++------------------------
 drivers/nvme/host/tcp.c         |   7 ++-
 drivers/nvme/target/admin-cmd.c |   2 +-
 drivers/nvme/target/passthru.c  |   5 +-
 10 files changed, 166 insertions(+), 153 deletions(-)
