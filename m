Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:11538
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750995AbdBXRRY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2017 12:17:24 -0500
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 2/2] lightnvm: fix assert fixes and enable checks
Date: Fri, 24 Feb 2017 18:16:49 +0100
Message-ID: <20170224171649.27409-2-matias@cnexlabs.com>
In-Reply-To: <20170224171649.27409-1-matias@cnexlabs.com>
References: <20170224171649.27409-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The asserts in _nvme_nvm_check_size are not compiled due to the function
not begin called. Make sure that it is called, and also fix the wrong
sizes of asserts for nvme_nvm_addr_format, and nvme_nvm_bb_tbl, which
checked for number of bits instead of bytes.

Reported-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e37b432..b6a67ad 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -241,9 +241,9 @@ static inline void _nvme_nvm_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_l2ptbl) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_erase_blk) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_id_group) != 960);
-	BUILD_BUG_ON(sizeof(struct nvme_nvm_addr_format) != 128);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_addr_format) != 16);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_id) != 4096);
-	BUILD_BUG_ON(sizeof(struct nvme_nvm_bb_tbl) != 512);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_bb_tbl) != 64);
 }
 
 static int init_grps(struct nvm_id *nvm_id, struct nvme_nvm_id *nvme_nvm_id)
@@ -797,6 +797,8 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 	struct request_queue *q = ns->queue;
 	struct nvm_dev *dev;
 
+	_nvme_nvm_check_size();
+
 	dev = nvm_alloc_dev(node);
 	if (!dev)
 		return -ENOMEM;
-- 
2.9.3
