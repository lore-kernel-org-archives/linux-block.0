Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52776 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423697AbcFHMbh (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2016 08:31:37 -0400
From: Christoph Hellwig <hch@lst.de>
To: keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@lightbits.io, ming.l@ssi.samsung.com,
	Ming Lin <ming.l@samsung.com>
Subject: [PATCH 09/11] nvmet-rdma: check for a valid adrfam
Date: Wed,  8 Jun 2016 14:31:04 +0200
Message-Id: <1465389066-19119-10-git-send-email-hch@lst.de>
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Ming Lin <ming.l@samsung.com>

For now only ipv4 is supported.

Signed-off-by: Ming Lin <ming.l@samsung.com>
Acked-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/rdma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index fccb01d..c184ee5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1313,6 +1313,15 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 	u16 port_in;
 	int ret;
 
+	switch (port->disc_addr.adrfam) {
+	case NVMF_ADDR_FAMILY_IP4:
+		break;
+	default:
+		pr_err("address family %d not supported\n",
+				port->disc_addr.adrfam);
+		return -EINVAL;
+	}
+
 	ret = kstrtou16(port->disc_addr.trsvcid, 0, &port_in);
 	if (ret)
 		return ret;
-- 
2.1.4

