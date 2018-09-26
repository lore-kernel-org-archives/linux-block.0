Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:44161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbeIZL6a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Sep 2018 07:58:30 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Matias Bjorling <mb@lightnvm.io>,
        Javier Gonzlez <javier@javigon.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] lightnvm: pblk: fix error handling of pblk_lines_init()
Date: Wed, 26 Sep 2018 05:56:24 +0000
Message-ID: <1537941384-25324-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In the too many bad blocks error handling case, we should release all
the alloced resources instead direct return, otherwise it will cause
memory leak.

Fixes: 2deeefc02dff ("lightnvm: pblk: fail gracefully on line alloc. failure")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/lightnvm/pblk-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 537e98f..a26f4e6 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1083,7 +1083,8 @@ static int pblk_lines_init(struct pblk *pblk)
 
 	if (!nr_free_chks) {
 		pblk_err(pblk, "too many bad blocks prevent for sane instance\n");
-		return -EINTR;
+		ret = -EINTR;
+		goto fail_free_lines;
 	}
 
 	pblk_set_provision(pblk, nr_free_chks);
