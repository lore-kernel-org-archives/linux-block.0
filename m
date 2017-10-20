Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33215 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdJTNRt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2017 09:17:49 -0400
Date: Fri, 20 Oct 2017 15:17:39 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for 4.14
Message-ID: <20171020131739.nffgzny5465tboba@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

below are two regression fixes each for RDMA and FC, and a fix for a SQHD
update race in the target.

The following changes since commit 639812a1ed9bf49ae2c026086fbf975339cd1eef:

  nbd: don't set the device size until we're connected (2017-10-09 12:29:22 -0600)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.14

for you to fetch changes up to f04b9cc87b5fc466b1b7231ba7b078e885956c5b:

  nvme-rdma: Fix error status return in tagset allocation failure (2017-10-19 17:13:51 +0200)

----------------------------------------------------------------
James Smart (3):
      nvme-fc: fix iowait hang
      nvme-fc: retry initial controller connections 3 times
      nvmet: synchronize sqhd update

Sagi Grimberg (2):
      nvme-rdma: Fix possible double free in reconnect flow
      nvme-rdma: Fix error status return in tagset allocation failure

 drivers/nvme/host/fc.c      | 37 +++++++++++++++++++++++++++++++++----
 drivers/nvme/host/rdma.c    | 16 ++++++++++++----
 drivers/nvme/target/core.c  | 15 ++++++++++++---
 drivers/nvme/target/nvmet.h |  2 +-
 4 files changed, 58 insertions(+), 12 deletions(-)
