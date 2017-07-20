Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59029 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935391AbdGTJCv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2017 05:02:51 -0400
Date: Thu, 20 Jul 2017 11:02:42 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme updates for 4.13-rc
Message-ID: <20170720090242.lektog4im7prs5on@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

below are a couple nvme fixes for 4.13 that I'd like to get out
before -rc2.  We have a few more things on the list that still
need review and should go into 4.13 as well.

The following changes since commit cb8c65ccff7f77d0285f1b126c72d37b2572c865:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2017-07-17 15:08:29 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.13

for you to fetch changes up to ed4151f9422706fc0afe09f55f30dd4bbc2ebb49:

  nvmet: don't report 0-bytes in serial number (2017-07-18 19:33:44 +0200)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: fix byte swapping in the streams code
      nvmet-fc: fix byte swapping in nvmet_fc_ls_create_association

Christophe JAILLET (1):
      nvme-pci: Fix an error handling path in 'nvme_probe()'

David Wayne Fugate (1):
      nvme-pci: add another device ID with stripe quirk

Johannes Thumshirn (3):
      nvmet: prefix version configfs file with attr
      nvmet: Move serial number from controller to subsystem
      nvmet: preserve controller serial number between reboots

Keith Busch (1):
      nvme-pci: Remove nvme_setup_prps BUG_ON

Martin Wilck (1):
      nvmet: don't report 0-bytes in serial number

 drivers/nvme/host/core.c        |  2 +-
 drivers/nvme/host/pci.c         | 43 ++++++++++++++++++++++++++++++-----------
 drivers/nvme/target/admin-cmd.c | 16 +++++++++++++--
 drivers/nvme/target/configfs.c  | 30 ++++++++++++++++++++++++----
 drivers/nvme/target/core.c      |  5 ++---
 drivers/nvme/target/fc.c        |  8 ++++----
 drivers/nvme/target/nvmet.h     |  2 +-
 include/linux/nvme.h            | 14 +++++++-------
 8 files changed, 87 insertions(+), 33 deletions(-)
