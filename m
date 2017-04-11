Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38826 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753388AbdDKOTF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 10:19:05 -0400
Received: by mail-wm0-f52.google.com with SMTP id t189so2200742wmt.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 07:19:05 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/3] lightnvm: clean unused variable
Date: Tue, 11 Apr 2017 16:18:55 +0200
Message-Id: <1491920338-2348-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1491920338-2348-1-git-send-email-javier@cnexlabs.com>
References: <1491920338-2348-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Clean unused variable on lightnvm core.

Signed-off-by: Javier González <javier@cnexlabs.com>
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
2.7.4
