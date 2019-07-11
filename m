Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33146C74A52
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 11:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0648C2166E
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 11:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1dT7IzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfGKLUy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:20:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfGKLUx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 07:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/l5lu3MJYWmwlJlhbko/k/+4yVNmUhEbIb0gdJczBV0=; b=B1dT7IzGstEav48/IMYFoEpV1N
        LyTMCJhCYQog3HaJt1Vkxm7cNc534AtpFPRFP+nhBzPFyPsEbiAfUTeEBH4tZ9P7gMTGDg1jMYg6Y
        6RnTmdi61Dn2OxniEJyCbmrhRYH5TOkaswacDf1DHaMxLPiNkyakkMxUX5Bj8p+JWNToEKq7yT/g7
        BsyL+ZnUmTM+J0VYF/ZoHsHDmHFVa5W/k36ps5Urv6KM2UXv9E93f8VlGmimagqaITyfJFn8C9Csr
        G2voRZOTFgr5zU6snmeI72xqOvYKKDySaOnlZtvU8Oq8572YdzY0BdjOJ3XY+DM6OWO3UDU/m7W9t
        5KT+pD+g==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlX84-0003kQ-7c; Thu, 11 Jul 2019 11:20:51 +0000
Date:   Thu, 11 Jul 2019 13:20:31 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for 5.3
Message-ID: <20190711112031.GA5031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Lof of fixes all over the place, and two very minor features that
were in the nvme tree by the end of the merge window, but hadn't made
it out to Jens yet.


The following changes since commit c9b3007feca018d3f7061f5d5a14cb00766ffe9b:

  blk-iolatency: fix STS_AGAIN handling (2019-07-05 15:14:00 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.3

for you to fetch changes up to 420dc733f980246f2179e0144f9cedab9ad4a91e:

  nvme: fix regression upon hot device removal and insertion (2019-07-10 09:36:16 -0700)

----------------------------------------------------------------
Alan Mikhak (2):
      nvme-pci: don't create a read hctx mapping without read queues
      nvme-pci: check for NULL return from pci_alloc_p2pmem()

Bart Van Assche (3):
      nvmet: export I/O characteristics attributes in Identify
      nvme: add I/O characteristics fields
      nvme: set physical block size and optimal I/O size

Christoph Hellwig (2):
      nvme-pci: don't fall back to a 32-bit DMA mask
      nvme-pci: limit max_hw_sectors based on the DMA max mapping size

Colin Ian King (1):
      nvme-trace: fix spelling mistake "spcecific" -> "specific"

Hannes Reinecke (3):
      nvme-multipath: factor out a nvme_path_is_disabled helper
      nvme-multipath: also check for a disabled path if there is a single sibling
      nvme-multipath: do not select namespaces which are about to be removed

James Smart (3):
      nvme-fcloop: fix inconsistent lock state warnings
      nvme-fcloop: resolve warnings on RCU usage and sleep warnings
      nvme-fc: fix module unloads while lports still pending

Mikhail Skorzhinskii (3):
      nvmet: print a hint while rejecting NSID 0 or 0xffffffff
      nvme-tcp: set the STABLE_WRITES flag when data digests are enabled
      nvme-tcp: don't use sendpage for SLAB pages

Sagi Grimberg (1):
      nvme: fix regression upon hot device removal and insertion

Tom Wu (1):
      nvme-trace: add delete completion and submission queue to admin cmds tracer

YueHaibing (1):
      nvme-pci: make nvme_dev_pm_ops static

 drivers/nvme/host/core.c          | 43 ++++++++++++++++++++++++++++++---
 drivers/nvme/host/fc.c            | 51 ++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c     | 18 ++++++++++----
 drivers/nvme/host/nvme.h          |  1 +
 drivers/nvme/host/pci.c           | 26 ++++++++++++--------
 drivers/nvme/host/tcp.c           |  9 ++++++-
 drivers/nvme/host/trace.c         | 28 ++++++++++++++++++++-
 drivers/nvme/target/admin-cmd.c   |  3 +++
 drivers/nvme/target/configfs.c    |  4 ++-
 drivers/nvme/target/fcloop.c      | 44 ++++++++++++++++-----------------
 drivers/nvme/target/io-cmd-bdev.c | 39 ++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  8 ++++++
 drivers/nvme/target/trace.c       |  2 +-
 include/linux/nvme.h              | 12 ++++++---
 14 files changed, 237 insertions(+), 51 deletions(-)
