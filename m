Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: hch@lst.de, keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] nvme-pci: unquiesce queues after update hw queues
Date: Wed, 17 Oct 2018 17:07:12 +0800
Message-Id: <1539767232-9389-4-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1539767232-9389-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1539767232-9389-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

updating hw queues uses bio retrieve to drain the queues. unquiescing
queues before that is not needed and will cause requests to be issued
to dead hw queue. So move unquiescing queues after updating hw queues,
as well as the wait freeze.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682..dbf6904 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2327,11 +2327,11 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
-		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
+		nvme_start_queues(&dev->ctrl);
+		nvme_wait_freeze(&dev->ctrl);
 		nvme_unfreeze(&dev->ctrl);
 	}
 
-- 
2.7.4
