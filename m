Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:51889 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdHKIBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2017 04:01:07 -0400
Date: Fri, 11 Aug 2017 10:00:58 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme updates for 4.13-rc
Message-ID: <20170811080058.k4ws7xgrbgaaavj7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A few more small fixes - the fc/lpfc update is the biggest by far.

The following changes since commit 7dd1ab163c17e11473a65b11f7e748db30618ebb:

  nvme: validate admin queue before unquiesce (2017-07-26 17:41:41 +0200)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.13

for you to fetch changes up to a082b426286d1ead97fb87646ea361d528be023d:

  nvme: fix directive command numd calculation (2017-08-10 19:53:44 +0200)

----------------------------------------------------------------
James Smart (2):
      nvmet_fc: add defer_req callback for deferment of cmd buffer return
      lpfc: support nvmet_fc defer_rcv callback

Keith Busch (1):
      nvme: fix nvme reset command timeout handling

Kwan (Hingkwan) Huen-SSI (1):
      nvme: fix directive command numd calculation

Martin Wilck (1):
      nvme: strip trailing 0-bytes in wwid_show

Max Gurtovoy (1):
      nvme-pci: fix CMB sysfs file removal in reset path

 drivers/nvme/host/core.c         |  35 +++++--
 drivers/nvme/host/pci.c          |  18 ++--
 drivers/nvme/target/fc.c         | 212 +++++++++++++++++++++++++++++++++------
 drivers/scsi/lpfc/lpfc_attr.c    |   4 +-
 drivers/scsi/lpfc/lpfc_debugfs.c |   5 +-
 drivers/scsi/lpfc/lpfc_nvmet.c   |  30 ++++++
 drivers/scsi/lpfc/lpfc_nvmet.h   |   1 +
 include/linux/nvme-fc-driver.h   |   7 ++
 8 files changed, 261 insertions(+), 51 deletions(-)
