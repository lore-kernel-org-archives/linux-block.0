Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ECBC43462
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D37613AD
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhDFHMf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhDFHMc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:12:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E11C061760
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aoif01PUue5QRKpvdtssAJCbRh7ARJ/srpHsrkS/TPE=; b=2ekRNcAiRE4XHanJqzh2XPyG9j
        FMi2Vbm1MHNtJTPqtVykGzXMYk79GWZFjXr5VSbIeAOg51AB996jbJlOteSgMHSZgyGwoWXVHl4Sv
        zfGsmFT/2m9mQzu9Iw78/ifCMNgk5zKrCdHJZtPepep8Hi+liWayYPaIS68SYUoSBCCr31R9otTjJ
        IPmt1qjBQMVJXwThTgLSRGwEWm6oTLppg1ai41P1zzpQ0ZiDrJY9rJ25SNNjLMvNpfkKG2HUeENR6
        SQWvFZ/7TrayDCILxVQ0ueYmikVJNumKMhZW6sNWImtvu01GhlGSfn1eYPrfpFqWpV24zChVMQu2u
        kq3EvBdQ==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTfsq-007wiP-5q; Tue, 06 Apr 2021 07:12:22 +0000
Date:   Tue, 6 Apr 2021 09:12:18 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 5.13
Message-ID: <YGwJ0h0GCC/118r5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Note that there is a conflict with Linus' tree in
drivers/nvme/host/core.c.  Linus should take the version from this PR.

The following changes since commit 80755855f808c27c7154937667436f30e47bc820:

  mtip32xx: use LIST_HEAD() for list_head (2021-03-29 07:38:49 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-06

for you to fetch changes up to 8609c63fce58e94d82f6b6bf29c7806062e2e867:

  nvme: fix handling of large MDTS values (2021-04-06 08:34:39 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.13

 - fix handling of very large MDTS values (Bart Van Assche)
 - retrigger ANA log update if group descriptor isn't found
   (Hannes Reinecke)
 - fix locking contexts in nvme-tcp and nvmet-tcp (Sagi Grimberg)
 - return proper error code from discovery ctrl (Hou Pu)
 - verify the SGLS field in nvmet-tcp and nvmet-fc (Max Gurtovoy)
 - disallow passthru cmd from targeting a nsid != nsid of the block dev
   (Niklas Cassel)
 - do not allow model_number exceed 40 bytes in nvmet (Noam Gottlieb)
 - enable optional queue idle period tracking in nvmet-tcp
   (Mark Wunderlich)
 - various cleanups and optimizations (Chaitanya Kulkarni, Kanchan Joshi)
 - expose fast_io_fail_tmo in sysfs (Daniel Wagner)
 - implement non-MDTS command limits (Keith Busch)
 - reduce warnings for unhandled command effects (Keith Busch)
 - allocate storage for the SQE as part of the nvme_request (Keith Busch)

----------------------------------------------------------------
Bart Van Assche (1):
      nvme: fix handling of large MDTS values

Chaitanya Kulkarni (14):
      nvme-pci: remove the barriers in nvme_irq()
      nvme-pci: cleanup nvme_irq()
      nvmet: remove a duplicate status assignment in nvmet_alloc_ctrl
      nvmet: update error log page in nvmet_alloc_ctrl()
      nvmet: remove an unnecessary function parameter to nvmet_check_ctrl_status
      nvmet: replace white spaces with tabs
      nvme: rename nvme_init_identify()
      nvme: split init identify into helper
      nvme: mark nvme_setup_passsthru() inline
      nvme: don't check nvme_req flags for new req
      nvme: add new line after variable declatation
      nvme-fc: fix the function documentation comment
      nvmet-fc: update function documentation
      nvmet: remove unnecessary ctrl parameter

Daniel Wagner (3):
      nvme: use sysfs_emit instead of sprintf
      nvme: remove superfluous else in nvme_ctrl_loss_tmo_store
      nvme: export fast_io_fail_tmo to sysfs

Hannes Reinecke (1):
      nvme: retrigger ANA log update if group descriptor isn't found

Hou Pu (1):
      nvmet: return proper error code from discovery ctrl

Kanchan Joshi (2):
      nvme: use NVME_CTRL_CMIC_ANA macro
      nvme: reduce checks for zero command effects

Keith Busch (4):
      nvme-pci: allocate nvme_command within driver pdu
      nvme: use driver pdu command for passthrough
      nvme: warn of unhandled effects only once
      nvme: implement non-mdts command limits

Max Gurtovoy (2):
      nvme-tcp: check sgl supported by target
      nvme-fc: check sgl supported by target

Niklas Cassel (1):
      nvme: disallow passthru cmd from targeting a nsid != nsid of the block dev

Noam Gottlieb (1):
      nvmet: do not allow model_number exceed 40 bytes

Sagi Grimberg (2):
      nvme-tcp: block BH in sk state_change sk callback
      nvmet-tcp: fix incorrect locking in state_change sk callback

Wunderlich, Mark (1):
      nvmet-tcp: enable optional queue idle period tracking

 drivers/nvme/host/core.c          | 298 +++++++++++++++++++++++++-------------
 drivers/nvme/host/fc.c            |  14 +-
 drivers/nvme/host/multipath.c     |  12 +-
 drivers/nvme/host/nvme.h          |  10 +-
 drivers/nvme/host/pci.c           |  26 ++--
 drivers/nvme/host/rdma.c          |   7 +-
 drivers/nvme/host/tcp.c           |  16 +-
 drivers/nvme/target/admin-cmd.c   |   4 +-
 drivers/nvme/target/configfs.c    |   6 +
 drivers/nvme/target/core.c        |  33 +++--
 drivers/nvme/target/discovery.c   |   6 +-
 drivers/nvme/target/fabrics-cmd.c |  17 +--
 drivers/nvme/target/fc.c          |   1 +
 drivers/nvme/target/loop.c        |   6 +-
 drivers/nvme/target/nvmet.h       |   8 +-
 drivers/nvme/target/tcp.c         |  40 ++++-
 include/linux/nvme.h              |  10 ++
 17 files changed, 336 insertions(+), 178 deletions(-)
