Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE336C4332F
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 08:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiK2I4r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 03:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiK2I4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 03:56:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D5D75
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 00:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7DoaJQXAg0BqFnr6I4AJNauIQJei6eXnwp2GkrtTSMQ=; b=0Zb6Yxe6RdUC/hn59qQjclpVbC
        5Lz/5ZffniiUqr212m6MUErGVaRyZdataQpta29Q7nePeWI6T5E+x9cbM1P1pBSL74KFoK/Ub7vst
        X52Qt1FRZRW3hCYsGaP0ruKQjchfNBoM9OkIysNGvDtEIHknbul54sh3dJQJ+9EyQOVSjjEx+uMEz
        I7izrxANRDRwGF4z1ulJWKQlZQXUuI63hrzuV8+HNtIrqUe7DcWkOprQAW1yDTfMH/yeLL/95PyKv
        mrlr7w2GicK5fd6H9LyeunJtwvWcFuwy7hNLo3wfeV3G2fkSvKuL88wn2xJWTPG6XWhJXW4eUxQRi
        GIzHWXLQ==;
Received: from [2001:4bb8:192:26e7:2e6b:fea:4668:9e6f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ozwPn-007asb-DY; Tue, 29 Nov 2022 08:56:31 +0000
Date:   Tue, 29 Nov 2022 09:56:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.2
Message-ID: <Y4XJPNP74KmdI8+7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is just the first round, there is quite a bit more in the queue.

The following changes since commit 5626196a5ae0937368b35c3625c428a2125b0f44:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.2/block (2022-11-14 12:57:50 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2022-11-29

for you to fetch changes up to 68c5444c317208f5a114f671140373f47f0a2cf6:

  nvmet: expose firmware revision to configfs (2022-11-21 08:35:58 +0100)

----------------------------------------------------------------
nvme updates for Linux 6.2

 - support some passthrough commands without CAP_SYS_ADMIN
   (Kanchan Joshi)
 - refactor PCIe probing and reset (Christoph Hellwig)
 - various fabrics authentication fixes and improvements (Sagi Grimberg)
 - avoid fallback to sequential scan due to transient issues
   (Uday Shankar)
 - implement support for the DEAC bit in Write Zeroes (Christoph Hellwig)
 - allow overriding the IEEE OUI and firmware revision in configfs for
   nvmet (Aleksandr Miloserdov)
 - force reconnect when number of queue changes in nvmet (Daniel Wagner)
 - minor fixes and improvements (Uros Bizjak, Joel Granados,
   Sagi Grimberg, Christoph Hellwig, Christophe JAILLET)

----------------------------------------------------------------
Aleksandr Miloserdov (2):
      nvmet: expose IEEE OUI to configfs
      nvmet: expose firmware revision to configfs

Christoph Hellwig (16):
      nvmet: only allocate a single slab for bvecs
      nvme: implement the DEAC bit for the Write Zeroes command
      nvme: don't call nvme_init_ctrl_finish from nvme_passthru_end
      nvme: move OPAL setup from PCIe to core
      nvme: simplify transport specific device attribute handling
      nvme-pci: put the admin queue in nvme_dev_remove_admin
      nvme-pci: move more teardown work to nvme_remove
      nvme-pci: factor the iod mempool creation into a helper
      nvme-pci: factor out a nvme_pci_alloc_dev helper
      nvme-pci: set constant paramters in nvme_pci_alloc_ctrl
      nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable
      nvme-pci: simplify nvme_dbbuf_dma_alloc
      nvme-pci: move the HMPRE check into nvme_setup_host_mem
      nvme-pci: split the initial probe from the rest path
      nvme-pci: don't unbind the driver on reset failure
      nvme: rename the queue quiescing helpers

Christophe JAILLET (1):
      nvme-fc: improve memory usage in nvme_fc_rcv_ls_req()

Daniel Wagner (1):
      nvmet: force reconnect when number of queue changes

Joel Granados (1):
      nvme: return err on nvme_init_non_mdts_limits fail

Kanchan Joshi (2):
      nvme: fine-granular CAP_SYS_ADMIN for nvme io commands
      nvme: identify-namespace without CAP_SYS_ADMIN

Sagi Grimberg (20):
      nvme-auth: rename __nvme_auth_[reset|free] to nvme_auth[reset|free]_dhchap
      nvme-auth: rename authentication work elements
      nvme-auth: remove symbol export from nvme_auth_reset
      nvme-auth: don't re-authenticate if the controller is not LIVE
      nvme-auth: remove redundant buffer deallocations
      nvme-auth: don't ignore key generation failures when initializing ctrl keys
      nvme-auth: don't override ctrl keys before validation
      nvme-auth: remove redundant if statement
      nvme-auth: don't keep long lived 4k dhchap buffer
      nvme-auth: guarantee dhchap buffers under memory pressure
      nvme-auth: clear sensitive info right after authentication completes
      nvme-auth: remove redundant deallocations
      nvme-auth: no need to reset chap contexts on re-authentication
      nvme-auth: check chap ctrl_key once constructed
      nvme-auth: convert dhchap_auth_list to an array
      nvme-auth: remove redundant auth_work flush
      nvme-auth: have dhchap_auth_work wait for queues auth to complete
      nvme-tcp: stop auth work after tearing down queues in error recovery
      nvme-rdma: stop auth work after tearing down queues in error recovery
      nvmet: fix a memory leak in nvmet_auth_set_key

Uday Shankar (1):
      nvme: avoid fallback to sequential scan due to transient issues

Uros Bizjak (1):
      nvmet: use try_cmpxchg in nvmet_update_sq_head

 drivers/nvme/host/apple.c         |  14 +-
 drivers/nvme/host/auth.c          | 258 ++++++++++++-----------
 drivers/nvme/host/core.c          | 125 ++++++++---
 drivers/nvme/host/fc.c            |  35 ++--
 drivers/nvme/host/ioctl.c         | 116 ++++++++---
 drivers/nvme/host/nvme.h          |  35 ++--
 drivers/nvme/host/pci.c           | 423 ++++++++++++++++++--------------------
 drivers/nvme/host/rdma.c          |  30 +--
 drivers/nvme/host/tcp.c           |  32 +--
 drivers/nvme/target/admin-cmd.c   |   9 +-
 drivers/nvme/target/auth.c        |   2 +
 drivers/nvme/target/configfs.c    | 121 ++++++++++-
 drivers/nvme/target/core.c        |  44 ++--
 drivers/nvme/target/io-cmd-file.c |  16 +-
 drivers/nvme/target/loop.c        |   8 +-
 drivers/nvme/target/nvmet.h       |   6 +-
 include/linux/nvme.h              |   2 +
 17 files changed, 766 insertions(+), 510 deletions(-)
