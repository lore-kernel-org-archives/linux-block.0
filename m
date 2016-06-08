Return-Path: <BATV+10e0b2ba6b8830823af0+4672+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: keith.busch@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@lightbits.io,
	ming.l@ssi.samsung.com
Subject: [PATCH 10/11] nvme: keep alive should use any queue
Date: Wed,  8 Jun 2016 14:31:05 +0200
Message-Id: <1465389066-19119-11-git-send-email-hch@lst.de>
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

No need to specify a queue ID for admin commands.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfd2fd7..86886c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -499,7 +499,8 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_keep_alive;
 
-	rq = nvme_alloc_request(ctrl->admin_q, &c, BLK_MQ_REQ_RESERVED, 0);
+	rq = nvme_alloc_request(ctrl->admin_q, &c, BLK_MQ_REQ_RESERVED,
+			NVME_QID_ANY);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
-- 
2.1.4
