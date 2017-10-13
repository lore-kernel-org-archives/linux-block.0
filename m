Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56362 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932391AbdJMMr6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id l68so21514528wmd.5
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:57 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 53/58] lightnvm: pblk: correct valid lba count calculation
Date: Fri, 13 Oct 2017 14:46:42 +0200
Message-Id: <20171013124647.32668-54-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

During garbage collect, lbas being written can end up
being invalidated. Make sure that this is reflected in
the valid lba count.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-map.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 3bc4c94..6f3ecde 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -45,6 +45,8 @@ static void pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 	paddr = pblk_alloc_page(pblk, line, nr_secs);
 
 	for (i = 0; i < nr_secs; i++, paddr++) {
+		__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+
 		/* ppa to be sent to the device */
 		ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
 
@@ -61,10 +63,9 @@ static void pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			w_ctx->ppa = ppa_list[i];
 			meta_list[i].lba = cpu_to_le64(w_ctx->lba);
 			lba_list[paddr] = cpu_to_le64(w_ctx->lba);
-			line->nr_valid_lbas++;
+			if (lba_list[paddr] != addr_empty)
+				line->nr_valid_lbas++;
 		} else {
-			__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
-
 			lba_list[paddr] = meta_list[i].lba = addr_empty;
 			__pblk_map_invalidate(pblk, line, paddr);
 		}
-- 
2.9.3
