Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20512ECAAD8
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 08:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiITIIL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiITIH1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 04:07:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55905642FB
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=esF+HXZdlARYQPg7/MAFN+XNPN0Myox5IB5R3zI3vSY=; b=bIoBRl5Tc9vnUtui89vVJKkxz7
        prbn606nfka3XX9YTjIp/GvRFxkeZGGdv2Id7IQ8NbCdvKLkCfA5b+G16vmyRvsfR0ZQRcqbhXyZc
        7i0fKR/78YW5XhaEpgxWga9VpjGUNW8eZFib9jZ3KO4VBd2+6LB0VYwEOAWrEaHvAZiK8qUlMSVxf
        hEuVP/d+IBjgjnNRrasGMPI6G1KIIaNhAvkqdMufE5VtxH5mInmERHWpDUUKPNpvfdVm/bjMpM9m4
        j33bJBfihbTZL2uU0kslJWYU8MKHwBtOLrET19P79oiCcCsu5gQ5mMOTmYrsGhAjG15DjcvhFxoDp
        uma0ayag==;
Received: from [2001:4bb8:189:f4ee:2681:1838:8166:a6f8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaYEh-001aRl-6R; Tue, 20 Sep 2022 08:04:07 +0000
Date:   Tue, 20 Sep 2022 10:04:05 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for Linux 6.1
Message-ID: <Yylz9ST3BJeXmQCU@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

here is currently queue up nvme patches for 6.1, which are not a lot.
There are a few more patches under discussion that will follow later.

The following changes since commit 91418cc4fd8f8e2e21b409eb8983d074359c8be6:

  block/drbd: remove unused w_start_resync declaration (2022-09-12 01:47:57 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-09-20

for you to fetch changes up to 02c57a82c0081141abc19150beab48ef47f97f18:

  nvme-tcp: print actual source IP address through sysfs "address" attr (2022-09-19 17:55:28 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.1

 - handle number of queue changes in the TCP and RDMA drivers
   (Daniel Wagner)
 - allow changing the number of queues in nvmet (Daniel Wagner)
 - also consider host_iface when checking ip options (Daniel Wagner)
 - don't map pages which can't come from HIGHMEM (Fabio M. De Francesco)
 - avoid unnecessary flush bios in nvmet (Guixin Liu)
 - shrink and better pack the nvme_iod structure (Keith Busch)
 - add comment for unaligned "fake" nqn (Linjun Bao)
 - print actual source IP address through sysfs "address" attr
   (Martin Belanger)
 - various cleanups (Jackie Liu, Wolfram Sang, Genjian Zhang)

----------------------------------------------------------------
Daniel Wagner (4):
      nvmet: expose max queues to configfs
      nvme-tcp: handle number of queue changes
      nvme-rdma: handle number of queue changes
      nvme: consider also host_iface when checking ip options

Fabio M. De Francesco (1):
      nvmet-tcp: don't map pages which can't come from HIGHMEM

Genjian Zhang (1):
      nvmet-auth: remove redundant parameters req

Guixin Liu (1):
      nvmet: avoid unnecessary flush bio

Jackie Liu (2):
      nvme-auth: remove the redundant req->cqe->result.u16 assignment operation
      nvmet-auth: clean up with done_kfree

Keith Busch (4):
      nvme-pci: remove nvme_queue from nvme_iod
      nvme-pci: iod's 'aborted' is a bool
      nvme-pci: iod npages fits in s8
      nvme-pci: move iod dma_len fill gaps

Linjun Bao (1):
      nvme: add comment for unaligned "fake" nqn

Martin Belanger (1):
      nvme-tcp: print actual source IP address through sysfs "address" attr

Wolfram Sang (1):
      nvme: move from strlcpy with unused retval to strscpy

 drivers/nvme/host/core.c               |  8 +++--
 drivers/nvme/host/fabrics.c            | 25 +++++++++----
 drivers/nvme/host/pci.c                | 65 +++++++++++++++++-----------------
 drivers/nvme/host/rdma.c               | 26 +++++++++++---
 drivers/nvme/host/tcp.c                | 47 ++++++++++++++++++++----
 drivers/nvme/target/admin-cmd.c        |  2 +-
 drivers/nvme/target/configfs.c         | 29 +++++++++++++++
 drivers/nvme/target/discovery.c        |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 10 +++---
 drivers/nvme/target/fabrics-cmd.c      |  1 -
 drivers/nvme/target/io-cmd-bdev.c      |  8 +++++
 drivers/nvme/target/tcp.c              | 44 +++++++----------------
 12 files changed, 176 insertions(+), 91 deletions(-)
