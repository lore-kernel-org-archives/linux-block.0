Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:64969 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbdIUL1d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:27:33 -0400
Date: Thu, 21 Sep 2017 14:27:31 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 4/6] lightnvm: pblk: improve error message if down_timeout
 fails
Message-ID: <20170921112729.GA28553@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The two pr_err messages are useless as they don't even differentiate
error code.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index b92eabc..74ddb30 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1734,16 +1734,8 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
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
2.5.0
