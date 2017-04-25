Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36645 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1950308AbdDYQPq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2017 12:15:46 -0400
Received: by mail-pg0-f66.google.com with SMTP id v1so4989140pgv.3
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2017 09:15:46 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-block@vger.kernel.org
Subject: [PATCH -next] lightnvm: fix possible memory leak in pblk_bb_discovery()
Date: Tue, 25 Apr 2017 16:15:30 +0000
Message-Id: <20170425161530.13445-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

'blks' is malloced in pblk_bb_discovery() and should be freed
before leaving from the nvm_get_tgt_bb_tbl() error handling cases,
otherwise it will cause memory leak. Also skip assign blks to
rlun->bb_list when error.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/lightnvm/pblk-init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3996e4b..5c8f404 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -399,13 +399,15 @@ static int pblk_bb_discovery(struct nvm_tgt_dev *dev, struct pblk_lun *rlun)
 
 	nr_blks = nvm_bb_tbl_fold(dev->parent, blks, nr_blks);
 	if (nr_blks < 0) {
-		kfree(blks);
 		ret = nr_blks;
+		goto out;
 	}
 
 	rlun->bb_list = blks;
 
+	return 0;
 out:
+	kfree(blks);
 	return ret;
 }
