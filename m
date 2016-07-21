Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54927 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbcGUJY0 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 21 Jul 2016 05:24:26 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, agordeev@redhat.com, linux-block@vger.kernel.org
Subject: resend: blk-mq: allow passing in an external queue mapping
Date: Thu, 21 Jul 2016 11:24:16 +0200
Message-Id: <1469093059-24594-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This series is one third of the earlier "automatic interrupt affinity for
MSI/MSI-X capable devices" series, and make uses of the new irq-level
interrupt / queue mapping code in blk-mq, as well as allowing the driver
to pass in such a mask obtained from the (PCI) interrupt code.  To fully
support this feature in drivers the final third in the PCI layer will
be needed as well.

For the patches to work you need to merge the irq/for-block branch of

   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

first, which will cause a conflict in block/blk-lib.c due to the discard
changes in 4.7 vs for-next.

I've pre-merged the branches in the git tree available at:

   git://git.infradead.org/users/hch/block.git queue-mapping

Gitweb:

   http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/queue-mapping

Changes since automatic interrupt affinity for MSI/MSI-X capable devices V3:
 - a trivial cleanup in blk_mq_create_mq_map pointed out by Alexander

