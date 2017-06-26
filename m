Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37892 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdFZJ6O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:14 -0400
Received: by mail-wm0-f42.google.com with SMTP id b184so3025722wme.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:13 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 03/20] lightnvm: pblk: spare double cpu_to_le64 calc.
Date: Mon, 26 Jun 2017 11:57:12 +0200
Message-Id: <1498471049-25505-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Spare a double calculation on the fast write path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-map.c      | 5 +++--
 drivers/lightnvm/pblk-recovery.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 17c16955284d..18291c238930 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -53,8 +53,9 @@ static void pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			lba_list[paddr] = cpu_to_le64(w_ctx->lba);
 			le64_add_cpu(&line->emeta->nr_valid_lbas, 1);
 		} else {
-			meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
-			lba_list[paddr] = cpu_to_le64(ADDR_EMPTY);
+			u64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+
+			lba_list[paddr] = meta_list[i].lba = addr_empty;
 			pblk_map_pad_invalidate(pblk, line, paddr);
 		}
 	}
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index f8f85087cd3c..82787006b865 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -390,12 +390,12 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 
 		for (j = 0; j < pblk->min_write_pgs; j++, i++, w_ptr++) {
 			struct ppa_addr dev_ppa;
+			u64 addr_empty = cpu_to_le64(ADDR_EMPTY);
 
 			dev_ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
 
 			pblk_map_invalidate(pblk, dev_ppa);
-			meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
-			lba_list[w_ptr] = cpu_to_le64(ADDR_EMPTY);
+			lba_list[w_ptr] = meta_list[i].lba = addr_empty;
 			rqd->ppa_list[i] = dev_ppa;
 		}
 	}
-- 
2.7.4
