Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731651AbeITMJB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Sep 2018 08:09:01 -0400
Date: Thu, 20 Sep 2018 08:26:59 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 4.19
Message-ID: <20180920062659.GA18562@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The following changes since commit b228ba1cb95afbaeeb86cf06cd9fd6f6369c3b14:

  null_blk: fix zoned support for non-rq based operation (2018-09-12 18:21:11 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.19

for you to fetch changes up to be1277f5eb17a2e5788139eabb0b53dd04c695f3:

  nvme: count all ANA groups for ANA Log page (2018-09-17 15:49:40 +0200)

----------------------------------------------------------------
Hannes Reinecke (1):
      nvme: count all ANA groups for ANA Log page

 drivers/nvme/target/admin-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)
