Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41363 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbeC2WHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id o102-v6so10325236lfg.8
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:43 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 35/37] lightnvm: pblk: don't recover unwritten lines
Date: Fri, 30 Mar 2018 00:05:22 +0200
Message-Id: <20180329220524.30363-36-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
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
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 26356429dc72..3e079c2afa6e 100644
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
2.11.0
