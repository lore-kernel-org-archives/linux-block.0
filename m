Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdC2REk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2017 13:04:40 -0400
Received: from bzq-82-81-101-184.red.bezeqint.net ([82.81.101.184] helo=bombadil.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1ctH1S-0001dv-QO
        for linux-block@vger.kernel.org; Wed, 29 Mar 2017 17:04:39 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org
Subject: [PATCH] blk-mq-pci: Fix two spelling mistakes
Date: Wed, 29 Mar 2017 20:04:36 +0300
Message-Id: <1490807076-23246-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index 966c2169762e..0c3354cf3552 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -23,7 +23,7 @@
  * @pdev:	PCI device associated with @set.
  *
  * This function assumes the PCI device @pdev has at least as many available
- * interrupt vetors as @set has queues.  It will then queuery the vector
+ * interrupt vectors as @set has queues.  It will then query the vector
  * corresponding to each queue for it's affinity mask and built queue mapping
  * that maps a queue to the CPUs that have irq affinity for the corresponding
  * vector.
-- 
2.7.4
