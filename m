Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41811 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeHQNZI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 09:25:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id s24-v6so4249821edr.8
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 03:22:15 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: fix race condition on metadata I/O
Date: Fri, 17 Aug 2018 12:22:04 +0200
Message-Id: <1534501324-13693-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In pblk, when a new line is allocated, metadata for the previously
written line is scheduled. This is done through a fixed memory region
that is shared through time and contexts across different lines and
therefore protected by a lock. Unfortunately, this lock is not properly
covering all the metadata used for sharing this memory regions,
resulting on a race condition.

This patch fixes this race condition by protecting this metadata
properly.

Fixes: dd2a43437337 ("lightnvm: pblk: sched. metadata on write thread")

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 508c63701eda..df99c45778d4 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -417,12 +417,11 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 			rqd->ppa_list[i] = addr_to_gen_ppa(pblk, paddr, id);
 	}
 
+	spin_lock(&l_mg->close_lock);
 	emeta->mem += rq_len;
-	if (emeta->mem >= lm->emeta_len[0]) {
-		spin_lock(&l_mg->close_lock);
+	if (emeta->mem >= lm->emeta_len[0])
 		list_del(&meta_line->list);
-		spin_unlock(&l_mg->close_lock);
-	}
+	spin_unlock(&l_mg->close_lock);
 
 	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
 
@@ -491,14 +490,15 @@ static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
 	struct pblk_line *meta_line;
 
 	spin_lock(&l_mg->close_lock);
-retry:
 	if (list_empty(&l_mg->emeta_list)) {
 		spin_unlock(&l_mg->close_lock);
 		return NULL;
 	}
 	meta_line = list_first_entry(&l_mg->emeta_list, struct pblk_line, list);
-	if (meta_line->emeta->mem >= lm->emeta_len[0])
-		goto retry;
+	if (meta_line->emeta->mem >= lm->emeta_len[0]) {
+		spin_unlock(&l_mg->close_lock);
+		return NULL;
+	}
 	spin_unlock(&l_mg->close_lock);
 
 	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd))
-- 
2.7.4
