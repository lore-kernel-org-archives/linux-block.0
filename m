Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40131 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756008AbdLTRWe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:34 -0500
Received: by mail-wm0-f66.google.com with SMTP id f206so11105702wmf.5
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:33 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 19/25] lightnvm: pblk: ignore high ecc errors on recovery
Date: Wed, 20 Dec 2017 18:21:59 +0100
Message-Id: <20171220172205.26464-20-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

On recovery, do not stop L2P recovery if reads report high ECC error
as the data is still available.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-recovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index fd38036..1d5e961 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -288,7 +288,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 	/* At this point, the read should not fail. If it does, it is a problem
 	 * we cannot recover from here. Need FTL log.
 	 */
-	if (rqd->error) {
+	if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
 		pr_err("pblk: L2P recovery failed (%d)\n", rqd->error);
 		return -EINTR;
 	}
-- 
2.9.3
