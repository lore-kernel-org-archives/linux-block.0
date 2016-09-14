Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39949 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbcINOTI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:08 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: blk-mq: allow passing in an external queue mapping V3
Date: Wed, 14 Sep 2016 16:18:46 +0200
Message-Id: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This series is the remainder of the earlier "automatic interrupt affinity for
MSI/MSI-X capable devices" series, and make uses of the new irq-level
interrupt / queue mapping code in blk-mq, as well as allowing the driver
to pass in such a mask obtained from the (PCI) interrupt code.  To fully
support this feature in drivers the final third in the PCI layer will
be needed as well.

A git tree is available at:

   git://git.infradead.org/users/hch/block.git block-queue-mapping.2

Gitweb:

   http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-queue-mapping.2

Changes since V2:
 - major rework of the core IRQ affinity code to support sibling maps
 - reworked the block code to use the above
 
Changes since V1:
 - rebased on top of Linux 4.8-rc4

Changes since automatic interrupt affinity for MSI/MSI-X capable devices V3:
 - a trivial cleanup in blk_mq_create_mq_map pointed out by Alexander

