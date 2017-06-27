Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40299 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751659AbdF0NnF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 09:43:05 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests v2 0/2] Test I/O to device while resetting PCI
Date: Tue, 27 Jun 2017 15:42:55 +0200
Message-Id: <20170627134257.15863-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Changes to v1:
* Ignore fio errors
* add an additional sleep .2 after re-enabling the pci device
* directly call readlink in _get_pci_dev_from_blkdev()

Johannes Thumshirn (2):
  rc: add helpers to handle PCI test devices
  block/011: Perform PCI reset while doing IO

 common/rc           | 13 +++++++++++++
 tests/block/011     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/011.out |  2 ++
 3 files changed, 70 insertions(+)
 create mode 100755 tests/block/011
 create mode 100644 tests/block/011.out

-- 
2.12.3
