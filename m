Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f182.google.com ([209.85.214.182]:33175 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeJIScH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:32:07 -0400
Received: by mail-pl1-f182.google.com with SMTP id s4-v6so681755plp.0
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:15:40 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yongjun <weiyongjun1@huawei.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 43/45] lightnvm: pblk: fix error handling of pblk_lines_init()
Date: Tue,  9 Oct 2018 13:12:13 +0200
Message-Id: <20181009111215.7653-44-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In the too many bad blocks error handling case, we should release all
the allocated resources, otherwise it will cause memory leak.

Fixes: 2deeefc02dff ("lightnvm: pblk: fail gracefully on line alloc. failure")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e0db0cb3122d..e3573880dbda 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1024,7 +1024,8 @@ static int pblk_lines_init(struct pblk *pblk)
 
 	if (!nr_free_chks) {
 		pblk_err(pblk, "too many bad blocks prevent for sane instance\n");
-		return -EINTR;
+		ret = -EINTR;
+		goto fail_free_lines;
 	}
 
 	pblk_set_provision(pblk, nr_free_chks);
-- 
2.17.1
