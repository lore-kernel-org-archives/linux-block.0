Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752985AbdDOS4S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:18 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Scott Bauer <scott.bauer@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 02/19] nvme/lightnvm: Prevent small buffer overflow in nvme_nvm_identify
Date: Sat, 15 Apr 2017 20:55:36 +0200
Message-ID: <20170415185553.16098-3-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Scott Bauer <scott.bauer@intel.com>

There are two closely named structs in lightnvm:
struct nvme_nvm_addr_format and
struct nvme_addr_format.

The first struct has 4 reserved bytes at the end, the second does not.
(gdb) p sizeof(struct nvme_nvm_addr_format)
$1 = 16
(gdb) p sizeof(struct nvm_addr_format)
$2 = 12

In the nvme_nvm_identify function we memcpy from the larger struct to the
smaller struct. We incorrectly pass the length of the larger struct
and overflow by 4 bytes, lets not do that.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 21cac85..fd98954 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -324,7 +324,7 @@ static int nvme_nvm_identity(struct nvm_dev *nvmdev, struct nvm_id *nvm_id)
 	nvm_id->cap = le32_to_cpu(nvme_nvm_id->cap);
 	nvm_id->dom = le32_to_cpu(nvme_nvm_id->dom);
 	memcpy(&nvm_id->ppaf, &nvme_nvm_id->ppaf,
-					sizeof(struct nvme_nvm_addr_format));
+					sizeof(struct nvm_addr_format));
 
 	ret = init_grps(nvm_id, nvme_nvm_id);
 out:
-- 
2.9.3
