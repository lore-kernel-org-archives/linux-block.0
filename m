Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32449 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752713AbeADWvB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jan 2018 17:51:01 -0500
From: Keith Busch <keith.busch@intel.com>
To: Linux Block <linux-block@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Device Mapper <dm-devel@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Bart VanAssche <bart.vanassche@wdc.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/5] nvme/multipath: Use blk_retryable
Date: Thu,  4 Jan 2018 15:46:22 -0700
Message-Id: <20180104224623.8944-5-keith.busch@intel.com>
In-Reply-To: <20180104224623.8944-1-keith.busch@intel.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Uses common code for determining if an error should be retried on
alternate path.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/multipath.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ae9abb600c0f..93bb72b6efb6 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -37,19 +37,7 @@ bool nvme_req_needs_failover(struct request *req, blk_status_t error)
 {
 	if (!(req->cmd_flags & REQ_NVME_MPATH))
 		return false;
-
-	switch (error) {
-	case BLK_STS_NOTSUPP:
-	case BLK_STS_NOSPC:
-	case BLK_STS_TARGET:
-	case BLK_STS_NEXUS:
-	case BLK_STS_MEDIUM:
-	case BLK_STS_PROTECTION:
-		return false;
-	}
-
-	/* Everything else could be a path failure, so should be retried */
-	return true;
+	return blk_retryable(error);
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
-- 
2.13.6
