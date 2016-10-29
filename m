Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:57458
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S938815AbcJ2AXX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2016 20:23:23 -0400
Subject: [PATCH v5 13/14] nvme: Fix a race condition related to stopping
 queues
To: Jens Axboe <axboe@fb.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
CC: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <3a8cc957-ea9e-fe1d-f325-ad9ca1aae8a8@sandisk.com>
Date: Fri, 28 Oct 2016 17:23:19 -0700
MIME-Version: 1.0
In-Reply-To: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid that nvme_queue_rq() is still running when nvme_stop_queues()
returns.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8403996..fe15d94 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2083,7 +2083,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
 
-		blk_mq_stop_hw_queues(ns->queue);
+		blk_mq_quiesce_queue(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
-- 
2.10.1

