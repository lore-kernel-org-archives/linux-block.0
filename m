Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq-pci: Remove unneeded includes
Date: Thu,  6 Apr 2017 13:33:36 +0300
Message-Id: <1491474816-15422-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq-pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index 0c3354cf3552..70b8a6765cc7 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -10,12 +10,9 @@
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
  */
-#include <linux/kobject.h>
-#include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
 #include <linux/pci.h>
-#include <linux/module.h>
 
 /**
  * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
-- 
2.7.4
