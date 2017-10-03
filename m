Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:50171 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbdJCKG6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:06:58 -0400
Received: by mail-wm0-f46.google.com with SMTP id b189so11675735wmd.4
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:06:58 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <jg@lightnvm.io>,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 9/9] lightnvm: pblk: correct valid lba count calculation
Date: Tue,  3 Oct 2017 12:05:13 +0200
Message-Id: <1507025113-13351-10-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

During garbage collect, lbas being written can end up
being invalidated. Make sure that this is reflected in
the valid lba count.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
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
2.7.4
