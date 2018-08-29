Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44158 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbeH2QUj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id s10-v6so3757421edb.11
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 05:23:58 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 6/7] lightnvm: pblk: fix up prints in pblk_read_check_rand
Date: Wed, 29 Aug 2018 14:23:33 +0200
Message-Id: <1535545414-550-7-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The prefix when printing ppas in pblk_read_check_rand should be "rnd"
not "seq", so fix this so we can differentiate between lba missmatches
in random and sequential reads. Also change the print order so
we align with pblk_read_check_seq, printing read lba first.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index df3c4eb13be9..6d13763f2f6a 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -149,10 +149,10 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 #ifdef CONFIG_NVM_PBLK_DEBUG
 			struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-			print_ppa(pblk, &ppa_list[j], "seq", j);
+			print_ppa(pblk, &ppa_list[j], "rnd", j);
 #endif
 			pblk_err(pblk, "corrupted read LBA (%llu/%llu)\n",
-								lba, meta_lba);
+							meta_lba, lba);
 			WARN_ON(1);
 		}
 
-- 
2.7.4
