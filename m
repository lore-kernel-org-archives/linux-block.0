Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754810AbdDOS4Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:25 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 06/19] lightnvm: enable nvme size compile asserts
Date: Sat, 15 Apr 2017 20:55:40 +0200
Message-ID: <20170415185553.16098-7-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
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
index 4ea9c93..12c5a40 100644
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
