Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF9DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 06:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiERGrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 02:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiERGrI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 02:47:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950A518E24
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 23:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=AaC8Wv8Wgc19tv6DjaGWjM6l0GS6aervzG+1mS2H99k=; b=e/rU5vNjyX6t0flfrUMJxXBovu
        zbh+IFMMnX7IenJ4DSsOrYwetBYL85rkTqNDca2waerL6ddTTAB645HEXjtROG4r5w6py2JKeivVS
        qeG4Rt1Pb+ei2UwNYy7gJfRruCP5Yp8ymv2KJK+0jHE8EihDNWa/lTDDxTBuSQ7fPX2ApJsyy62IV
        UPBqSkAERS1lWsEXUwxpdTXjfd3tRuREC57dvE9qhxQrPqRquqNhqSGxXyZ/2WBPtfrjg+N+J/FY1
        07yNp7NvR/KH0rh094wL5HO6TUFUsLv53ziWbb1oLGT9kmCll/lyb+X8qsCz0zyVfx4N1VKZwOQqk
        C7GOZbdQ==;
Received: from [2001:4bb8:19a:7bdf:8143:492c:c3b:39b6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrDSZ-00HTMT-SB; Wed, 18 May 2022 06:47:04 +0000
Date:   Wed, 18 May 2022 08:47:02 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 5.19
Message-ID: <YoSWZoB1/38DdP4S@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit c23d47abee3a54e4991ed3993340596d04aabd6a:

  loop: remove most the top-of-file boilerplate comment from the UAPI header (2022-05-10 06:30:05 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-05-18

for you to fetch changes up to e626f37e657adbab2a7abe51480925891662a5f3:

  nvme: split the enum used for various register constants (2022-05-17 07:33:27 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.19

 - tighten the PCI presence check (Stefan Roese):
 - fix a potential NULL pointer dereference in an error path
   (Kyle Miller Smith)
 - fix interpretation of the DMRSL field (Tom Yan)
 - relax the data transfer alignment (Keith Busch)
 - verbose error logging improvements (Max Gurtovoy, Chaitanya Kulkarni)
 - misc cleanups (Chaitanya Kulkarni, me)

----------------------------------------------------------------
Chaitanya Kulkarni (2):
      nvme: mark internal passthru request RQF_QUIET
      nvme-fabrics: add a request timeout helper

Christoph Hellwig (1):
      nvme: split the enum used for various register constants

Keith Busch (1):
      nvme: set dma alignment to dword

Max Gurtovoy (2):
      nvme: add missing status values to verbose logging
      nvme: remove unneeded include from constants file

Smith, Kyle Miller (Nimble Kernel) (1):
      nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags

Stefan Roese (1):
      nvme-pci: harden drive presence detect in nvme_dev_disable()

Tom Yan (1):
      nvme: fix interpretation of DMRSL

 drivers/nvme/host/constants.c |  4 +++-
 drivers/nvme/host/core.c      |  9 ++++++---
 drivers/nvme/host/fabrics.h   |  8 ++++++++
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/pci.c       |  5 ++++-
 drivers/nvme/host/rdma.c      |  5 +----
 drivers/nvme/host/tcp.c       |  5 +----
 include/linux/nvme.h          | 15 +++++++++++++--
 8 files changed, 37 insertions(+), 15 deletions(-)
