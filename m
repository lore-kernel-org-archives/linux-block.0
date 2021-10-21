Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C00FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 12:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3599160F25
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 12:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJUM5y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJUM5y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 08:57:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB5C06161C
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 05:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+2QEXpAZsUx7TOL11cEn/BgB4monX6Fu2g7j5eJ7+m8=; b=RfSZRiE2M46XFy3wYPl+rRwNwR
        tYx9KZF5nIak2XtTpc1VofQ2Cssfm69w9jxbkTvinP844dahvo+nrBnTBSiDoSTN+ttSPDdxBYpls
        lQKITAaZ2nGo2J6/yBnP97dH48KKlsCmMyvgNlk64wYRmJcT/qecdIiNDJlfyP8icmJ6SwxX/bjSf
        ObyiZW/6banLRrtpMic9jW44n8EQivLb0d3549yLZXyjuc/h/u+XzlWs2b8lKgyOEc0tRFEAGmnZ7
        JkTABaWHlE9WbumcEeeMJiQyWdIpMejLsCgnM7qhM7YwiXH9c4ML89KIlSR+3lid5NrGsZNRXxjW7
        1wOs9dTw==;
Received: from [2001:4bb8:180:8777:dd70:8011:36d9:4c23] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdXbc-007ZuB-HF; Thu, 21 Oct 2021 12:55:36 +0000
Date:   Thu, 21 Oct 2021 14:55:34 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for Linux 5.16
Message-ID: <YXFjRq8JzDdVXww/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit a9a7e30fd918588bc312ba782426e3a1282df359:

  nvme: don't memset() the normal read/write command (2021-10-19 12:41:09 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.16-2021-10-21

for you to fetch changes up to 117d5b6d00ee02f73d7065fe906e2ef1af74bb68:

  nvmet: use struct_size over open coded arithmetic (2021-10-20 19:23:30 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.16

 - fix a multipath partition scanning deadlock (Hannes Reinecke)
 - generate uevent once a multipath namespace is operational again
   (Hannes Reinecke)
 - support unique discovery controller NQNs (Hannes Reinecke)
 - fix use-after-free when a port is removed (Israel Rukshin)
 - clear shadow doorbell memory on resets (Keith Busch)
 - use struct_size (Len Baker)
 - add error handling support for add_disk (Luis Chamberlain)
 - limit the maximal queue size for RDMA controllers (Max Gurtovoy)
 - use a few more symbolic names (Max Gurtovoy)
 - fix error code in nvme_rdma_setup_ctrl (Max Gurtovoy)
 - add support for ->map_queues on FC (Saurav Kashyap)

----------------------------------------------------------------
Hannes Reinecke (9):
      nvme: generate uevent once a multipath namespace is operational again
      nvmet: make discovery NQN configurable
      nvme: add CNTRLTYPE definitions for 'identify controller'
      nvmet: add nvmet_is_disc_subsys() helper
      nvmet: set 'CNTRLTYPE' in the identify controller data
      nvme: expose subsystem type in sysfs attribute 'subsystype'
      nvme: Add connect option 'discovery'
      nvme: display correct subsystem NQN
      nvme: drop scan_lock and always kick requeue list when removing namespaces

Israel Rukshin (3):
      nvmet: fix use-after-free when a port is removed
      nvmet-rdma: fix use-after-free when a port is removed
      nvmet-tcp: fix use-after-free when a port is removed

Keith Busch (1):
      nvme-pci: clear shadow doorbell memory on resets

Len Baker (1):
      nvmet: use struct_size over open coded arithmetic

Luis Chamberlain (1):
      nvme-multipath: add error handling support for add_disk()

Max Gurtovoy (6):
      nvme-rdma: limit the maximal queue size for RDMA controllers
      nvmet: add get_max_queue_size op for controllers
      nvmet-rdma: implement get_max_queue_size controller op
      nvmet: use macro definition for setting nmic value
      nvmet: use macro definitions for setting cmic value
      nvme-rdma: fix error code in nvme_rdma_setup_ctrl

Saurav Kashyap (2):
      nvme-fc: add support for ->map_queues
      qla2xxx: add ->map_queues support for nvme

 drivers/nvme/host/core.c          | 36 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.c       |  6 +++++-
 drivers/nvme/host/fabrics.h       |  8 ++++++++
 drivers/nvme/host/fc.c            | 26 ++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c     | 30 +++++++++++++++++++---------
 drivers/nvme/host/nvme.h          |  1 +
 drivers/nvme/host/pci.c           |  9 ++++++++-
 drivers/nvme/host/rdma.c          | 11 ++++++++++-
 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/admin-cmd.c   | 16 ++++++++++-----
 drivers/nvme/target/configfs.c    | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 17 +++++++++-------
 drivers/nvme/target/discovery.c   |  2 ++
 drivers/nvme/target/fabrics-cmd.c |  3 ++-
 drivers/nvme/target/nvmet.h       |  6 ++++++
 drivers/nvme/target/rdma.c        | 30 ++++++++++++++++++++++++++++
 drivers/nvme/target/tcp.c         | 16 +++++++++++++++
 drivers/scsi/qla2xxx/qla_nvme.c   | 15 ++++++++++++++
 include/linux/nvme-fc-driver.h    |  7 +++++++
 include/linux/nvme-rdma.h         |  2 ++
 include/linux/nvme.h              | 11 ++++++++++-
 21 files changed, 266 insertions(+), 29 deletions(-)
