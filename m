Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:42825
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755899AbdDOS5A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:57:00 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 13/19] lightnvm: clean unused variable
Date: Sat, 15 Apr 2017 20:55:47 +0200
Message-ID: <20170415185553.16098-14-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Clean unused variable on lightnvm core.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index eb9ab1a..258007a 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -501,7 +501,6 @@ void nvm_part_to_tgt(struct nvm_dev *dev, sector_t *entries,
 		int *lun_roffs;
 		struct ppa_addr gaddr;
 		u64 pba = le64_to_cpu(entries[i]);
-		int off;
 		u64 diff;
 
 		if (!pba)
@@ -511,8 +510,6 @@ void nvm_part_to_tgt(struct nvm_dev *dev, sector_t *entries,
 		ch_rmap = &dev_rmap->chnls[gaddr.g.ch];
 		lun_roffs = ch_rmap->lun_offs;
 
-		off = gaddr.g.ch * geo->luns_per_chnl + gaddr.g.lun;
-
 		diff = ((ch_rmap->ch_off * geo->luns_per_chnl) +
 				(lun_roffs[gaddr.g.lun])) * geo->sec_per_lun;
 
-- 
2.9.3
