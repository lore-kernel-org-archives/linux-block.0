Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D664EC433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiCQRJn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiCQRJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Mar 2022 13:09:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1D29859D
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lQ3egY4aIxLGH+D0H1ibKTPYVnLPBH+PAR5tYmFKY7s=; b=AXiMADfx5jdzlXRHTfy5GwNMRY
        2/jGXAvwSNPiarDVbA0uzNCdzJP1wwwJkBvufa/6StDy1W2I6KMFUng5h1mH/WccasAmB31IkZAJD
        EbEdqPxzY/G0IpTryw3iu4ECVlFhwaTYYYsEtcZbMKYRIYu+ZZS2W0u0LW/wxa/y6pE5LxxshQqv1
        S5pieKTZOVEu0l82BX2Zr3kunCd+7rxsQVN3CtIgc5P7z23jw0haO7BtmZJaOm5Km7kgDzb/fpObp
        R2eCELUTW/FxPv1fochwqNy4Xnutvyuia3+qxrTcI0Qr0vr5JCnUD3mwLKD87EIRu4SZdEWjpw1dL
        twqUhsWg==;
Received: from [46.140.54.162] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUtbo-00Gsfc-Ps; Thu, 17 Mar 2022 17:08:21 +0000
Date:   Thu, 17 Mar 2022 18:08:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] second round of nvme updates for Linux 5.18
Message-ID: <YjNrAsjvdSd+abfu@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 85d9abcd7331566781b93ff46e4bccd4806ef2b2:

  xen/blkfront: speed up purge_persistent_grants() (2022-03-11 05:15:33 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-17

for you to fetch changes up to ce8d78616a6b637d1b763eb18e32045687a84305:

  nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH (2022-03-16 16:48:00 +0100)

----------------------------------------------------------------
second round of nvme updates for Linux 5.18

 - add lockdep annotations for in-kernel sockets (Chris Leech)
 - use vmalloc for ANA log buffer (Hannes Reinecke)
 - kerneldoc fixes (Chaitanya Kulkarni)
 - cleanups (Guoqing Jiang, Chaitanya Kulkarni, me)
 - warn about shared namespaces without multipathing (me)

----------------------------------------------------------------
Chaitanya Kulkarni (7):
      nvme-tcp: don't initialize ret variable
      nvme-tcp: don't fold the line
      nvmet-fc: fix kernel-doc warning for nvmet_fc_register_targetport
      nvmet-fc: fix kernel-doc warning for nvmet_fc_unregister_targetport
      nvmet-rdma: fix kernel-doc warning for nvmet_rdma_device_removal
      nvmet: don't fold lines
      nvmet: use snprintf() with PAGE_SIZE in configfs

Chris Leech (1):
      nvme-tcp: lockdep: annotate in-kernel sockets

Christoph Hellwig (4):
      nvmet: move the call to nvmet_ns_changed out of nvmet_ns_revalidate
      nvme: cleanup how disk->disk_name is assigned
      nvme: remove nvme_alloc_request and nvme_alloc_request_qid
      nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH

Guoqing Jiang (1):
      nvme-multipath: call bio_io_error in nvme_ns_head_submit_bio

Hannes Reinecke (1):
      nvme-multipath: use vmalloc for ANA log buffer

 drivers/block/loop.c            |  1 +
 drivers/nvme/host/core.c        | 76 ++++++++++++++++++++---------------------
 drivers/nvme/host/ioctl.c       |  3 +-
 drivers/nvme/host/multipath.c   | 32 +++--------------
 drivers/nvme/host/nvme.h        | 16 ++++-----
 drivers/nvme/host/pci.c         | 17 +++++----
 drivers/nvme/host/tcp.c         | 45 ++++++++++++++++++++++--
 drivers/nvme/target/admin-cmd.c |  6 +++-
 drivers/nvme/target/configfs.c  | 30 ++++++++--------
 drivers/nvme/target/core.c      |  5 ++-
 drivers/nvme/target/fc.c        |  4 +--
 drivers/nvme/target/nvmet.h     |  2 +-
 drivers/nvme/target/passthru.c  |  3 +-
 drivers/nvme/target/rdma.c      |  2 +-
 drivers/nvme/target/zns.c       |  6 +++-
 15 files changed, 138 insertions(+), 110 deletions(-)
