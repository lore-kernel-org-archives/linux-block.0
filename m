Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:40987 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751674AbeFEJIo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jun 2018 05:08:44 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Matias Bjorling <mb@lightnvm.io>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] lightnvm: pblk: make symbol write_buffer_size static
Date: Tue, 5 Jun 2018 09:15:12 +0000
Message-ID: <1528190112-15645-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fixes the following sparse warning:

drivers/lightnvm/pblk-init.c:23:14: warning:
 symbol 'write_buffer_size' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ce561f5..491df0f 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -20,7 +20,7 @@
 
 #include "pblk.h"
 
-unsigned int write_buffer_size;
+static unsigned int write_buffer_size;
 
 module_param(write_buffer_size, uint, 0644);
 MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
