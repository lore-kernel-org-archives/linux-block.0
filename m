Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:57232 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758088AbdJMMrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id l68so21509010wmd.5
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:15 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 09/58] lightnvm: pblk: improve error message if down_timeout fails
Date: Fri, 13 Oct 2017 14:45:58 +0200
Message-Id: <20171013124647.32668-10-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

The two pr_err messages are useless as they don't differentiate
error code.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index b53bb00..027c42b 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1691,16 +1691,8 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
 #endif
 
 	ret = down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
-	if (ret) {
-		switch (ret) {
-		case -ETIME:
-			pr_err("pblk: lun semaphore timed out\n");
-			break;
-		case -EINTR:
-			pr_err("pblk: lun semaphore timed out\n");
-			break;
-		}
-	}
+	if (ret == -ETIME || ret == -EINTR)
+		pr_err("pblk: taking lun semaphore timed out: err %d\n", -ret);
 }
 
 void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
-- 
2.9.3
