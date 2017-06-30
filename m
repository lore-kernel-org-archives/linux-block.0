Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34863 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbdF3P45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 11:56:57 -0400
Received: by mail-wm0-f45.google.com with SMTP id w126so113903697wme.0
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 08:56:56 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 05/10] lightnvm: pblk: use right metadata buffer for recovery
Date: Fri, 30 Jun 2017 17:56:38 +0200
Message-Id: <1498838203-21539-6-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
References: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fix bad metadata buffer assignations introduced when refactoring the
medatada write path.

Fixes: dd2a43437337 lightnvm: pblk: sched. metadata on write thread
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-recovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 7e1c314f2766..6d58659fa3da 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -801,7 +801,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 	set_bit(meta_line, &l_mg->meta_bitmap);
 	smeta = l_mg->sline_meta[meta_line];
 	emeta = l_mg->eline_meta[meta_line];
-	smeta_buf = smeta->buf;
+	smeta_buf = (struct line_smeta *)smeta;
 	spin_unlock(&l_mg->free_lock);
 
 	/* Order data lines using their sequence number */
@@ -888,9 +888,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		nr_bb = bitmap_weight(line->blk_bitmap, lm->blk_per_line);
 		off -= nr_bb * geo->sec_per_pl;
 
-		memset(&emeta->buf, 0, lm->emeta_len[0]);
-		line->emeta = emeta;
 		line->emeta_ssec = off;
+		line->emeta = emeta;
+		memset(line->emeta->buf, 0, lm->emeta_len[0]);
 
 		if (pblk_line_read_emeta(pblk, line, line->emeta->buf)) {
 			pblk_recov_l2p_from_oob(pblk, line);
-- 
2.7.4
