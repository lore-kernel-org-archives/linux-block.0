Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40005 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeBUIW6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 03:22:58 -0500
Received: by mail-lf0-f66.google.com with SMTP id 37so1133874lfs.7
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 00:22:58 -0800 (PST)
From: hans.ml.holmberg@owltronix.com
To: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: don't recover unwritten lines
Date: Wed, 21 Feb 2018 09:22:32 +0100
Message-Id: <1519201352-15806-1-git-send-email-hans.ml.holmberg@owltronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

If the line has not been written to, we should not
try to recover any data from it, so check the state of the
chunks in the line before attempting to read smeta.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Javier González <javier@cnexlabs.com>
---

NOTE: This patch applies on top of the 2.0 patches since it depends
on chunk data structures to be in place.

 drivers/lightnvm/pblk-recovery.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 1574dbb..24ad021 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -864,6 +864,21 @@ static void pblk_recov_wa_counters(struct pblk *pblk,
 	}
 }
 
+static int pblk_line_was_written(struct pblk_line *line,
+			    struct pblk_line_meta *lm)
+{
+
+	int i;
+	int state_mask = NVM_CHK_ST_OFFLINE | NVM_CHK_ST_FREE;
+
+	for (i = 0; i < lm->blk_per_line; i++) {
+		if (!(line->chks[i].state & state_mask))
+			return 1;
+	}
+
+	return 0;
+}
+
 struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
@@ -900,6 +915,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		line->lun_bitmap = ((void *)(smeta_buf)) +
 						sizeof(struct line_smeta);
 
+		if (!pblk_line_was_written(line, lm))
+			continue;
+
 		/* Lines that cannot be read are assumed as not written here */
 		if (pblk_line_read_smeta(pblk, line))
 			continue;
-- 
2.7.4
