Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44445 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeH2M5z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 08:57:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so3344482edb.11
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 02:02:00 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/4] lightnvm: pblk: calculate line pad distance in helper
Date: Wed, 29 Aug 2018 11:01:50 +0200
Message-Id: <1535533313-29944-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If a line is padded, calculate the pad distance directly on the helper
being used for this purpose.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-recovery.c | 2 --
 drivers/lightnvm/pblk.h          | 5 +++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index fdc770f2545f..188c89819a40 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -487,8 +487,6 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 		bitmap_clear(line->map_bitmap, line->cur_sec, nr_error_bits);
 
 		pad_secs = pblk_pad_distance(pblk);
-		if (pad_secs > line->left_msecs)
-			pad_secs = line->left_msecs;
 
 		ret = pblk_recov_pad_oob(pblk, line, pad_secs);
 		if (ret)
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 54f937c1fb62..994a081994fb 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -990,12 +990,13 @@ static inline int pblk_line_vsc(struct pblk_line *line)
 	return le32_to_cpu(*line->vsc);
 }
 
-static inline int pblk_pad_distance(struct pblk *pblk)
+static inline int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
+	int distance = geo->mw_cunits * geo->all_luns * geo->ws_opt;
 
-	return geo->mw_cunits * geo->all_luns * geo->ws_opt;
+	return (distance > line->left_msecs) ? line->left_msecs : distance;
 }
 
 static inline int pblk_ppa_to_line_id(struct ppa_addr p)
-- 
2.7.4
