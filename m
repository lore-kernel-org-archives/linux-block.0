Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:42300 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756015AbdLTRWi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:38 -0500
Received: by mail-wm0-f65.google.com with SMTP id b199so11381861wme.1
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:37 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 23/25] lightnvm: pblk: print instance name on instance info
Date: Wed, 20 Dec 2017 18:22:03 +0100
Message-Id: <20171220172205.26464-24-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Add the instance name to the information printed out on target creation.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index d603b94..55d3b42 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1069,7 +1069,8 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	blk_queue_max_discard_sectors(tqueue, UINT_MAX >> 9);
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, tqueue);
 
-	pr_info("pblk init: luns:%u, lines:%d, secs:%llu, buf entries:%u\n",
+	pr_info("pblk(%s): luns:%u, lines:%d, secs:%llu, buf entries:%u\n",
+			tdisk->disk_name,
 			geo->all_luns, pblk->l_mg.nr_lines,
 			(unsigned long long)pblk->rl.nr_secs,
 			pblk->rwb.nr_entries);
-- 
2.9.3
