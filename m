Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF34CC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 16:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiG0QBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiG0QBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:01:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85FA4B4A3
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=b83o6FRs8SLo8fYAOLwfuhX6v2fXupNgUAHvZX2og2o=; b=r0AD1EaFisjlAgqk/XnbAtvgl5
        mESBwlnEM4GQAMV47q8cuTpG7hvzj+7MJjO88xiRBkMVgFYbNmsrRdtIkXGkb8DQcE8jB1hrZiTWt
        vVHKCSgyokdSL3NEW9ckE8fwtrDAJBCuFLnF8yfwuxIKMd2pv8tl15oUxt4vxJaxKFmAlhOEyvgT0
        WUb3pBUumTcHX4zJiHSm/dcMTKS0kSAh5Vu4M570+/QU6I+6pu433LAqxDFfKWWySgGhcN7dNbsq+
        wsQIDccn9JGH2r/gLRZ6kilfgZh9i/3Kxtfq+/qIzf9DN+Hhs2iAel5QwPo8KS8igofvMAJXa3sz2
        mIAox9tA==;
Received: from [2607:fb90:18d2:b6be:6d6f:ba8a:ca81:9775] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGjTF-00FJ1j-Ll; Wed, 27 Jul 2022 16:01:14 +0000
Date:   Wed, 27 Jul 2022 12:01:11 -0400
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] second row of nvme updates for Linux 5.20
Message-ID: <YuFhR9OoPvM9VsdT@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Against the for-5.20/drivers-post tree.

The following changes since commit 2dc9e74e37124f1b43ea60157e5990fd490c6e8f:

  remove the sx8 block driver (2022-07-25 17:25:18 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.20-2022-07-27

for you to fetch changes up to 26203a5e04d5cb1d1715f71c48cf6eec0dd9b88f:

  nvme: update MAINTAINERS for the new auth code (2022-07-26 16:04:27 -0400)

----------------------------------------------------------------
nvme updates for Linux 5.20

 - use command_id instead of req->tag in trace_nvme_complete_rq()
   (Bean Huo)
 - various fixes for the new authentication code (Lukas Bulwahn,
   Dan Carpenter, Colin Ian King, Chaitanya Kulkarni, Hannes Reinecke)
 - small cleanups (Liu Song, Christoph Hellwig)
 - restore compat_ioctl support (Nick Bowler)
 - make a nvmet-tcp workqueue lockdep-safe (Sagi Grimberg)
 - enable generic interface (/dev/ngXnY) for unknown command sets
   (Joel Granados, Christoph Hellwig)
 - don't always build constants.o (Christoph Hellwig)
 - print the command name of aborted commands (Christoph Hellwig)

----------------------------------------------------------------
Bean Huo (1):
      nvme: use command_id instead of req->tag in trace_nvme_complete_rq()

Chaitanya Kulkarni (2):
      nvmet-auth: fix return value check in auth send
      nvmet-auth: fix return value check in auth receive

Christoph Hellwig (15):
      nvme: don't always build constants.o
      nvme-pci: print the command name of aborted commands
      nvme-pci: split nvme_alloc_admin_tags
      nvme-pci: split nvme_dev_add
      nvme-rdma: split nvme_rdma_alloc_tagset
      nvme-tcp: split nvme_tcp_alloc_tagset
      nvme-apple: stop casting function pointer signatures
      nvmet: don't check for NULL pointer before kfree in nvmet_host_release
      nvmet: fix a format specifier in nvmet_auth_ctrl_exponential
      nvme: catch -ENODEV from nvme_revalidate_zones again
      nvme: rename nvme_validate_or_alloc_ns to nvme_scan_ns
      nvme: generalize the nvme_multi_css check in nvme_scan_ns
      nvme: refactor namespace probing
      nvme: factor out a nvme_ns_is_readonly helper
      nvme: update MAINTAINERS for the new auth code

Colin Ian King (1):
      nvmet-auth: fix a couple of spelling mistakes

Dan Carpenter (2):
      nvme-auth: fix off by one checks
      nvme-auth: uninitialized variable in nvme_auth_transform_key()

Hannes Reinecke (1):
      nvme-auth: fixup kernel test robot warnings

Joel Granados (1):
      nvme: enable generic interface (/dev/ngXnY) for unknown command sets

Liu Song (1):
      nvme-pci: remove useless assignment in nvme_pci_setup_prps

Lukas Bulwahn (1):
      nvmet-auth: select the intended CRYPTO_DH_RFC7919_GROUPS

Nick Bowler (1):
      nvme: define compat_ioctl again to unbreak 32-bit userspace.

Sagi Grimberg (1):
      nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown

 MAINTAINERS                            |   3 +-
 drivers/nvme/common/auth.c             |  57 ++++---
 drivers/nvme/host/Makefile             |   3 +-
 drivers/nvme/host/apple.c              |  21 ++-
 drivers/nvme/host/constants.c          |   3 +-
 drivers/nvme/host/core.c               | 302 +++++++++++++++++++--------------
 drivers/nvme/host/multipath.c          |   1 +
 drivers/nvme/host/pci.c                | 139 +++++++--------
 drivers/nvme/host/rdma.c               |  92 +++++-----
 drivers/nvme/host/tcp.c                |  82 ++++-----
 drivers/nvme/host/trace.h              |   2 +-
 drivers/nvme/target/Kconfig            |   2 +-
 drivers/nvme/target/auth.c             |   4 +-
 drivers/nvme/target/configfs.c         |   4 +-
 drivers/nvme/target/fabrics-cmd-auth.c |   7 +-
 drivers/nvme/target/tcp.c              |   3 +-
 16 files changed, 398 insertions(+), 327 deletions(-)
