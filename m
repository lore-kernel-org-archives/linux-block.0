Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37462 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJISao (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:30:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so656655pgq.4
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:18 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 19/45] lightnvm: pblk: fix up prints in pblk_read_check_rand
Date: Tue,  9 Oct 2018 13:11:49 +0200
Message-Id: <20181009111215.7653-20-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The prefix when printing ppas in pblk_read_check_rand should be "rnd"
not "seq", so fix this so we can differentiate between lba missmatches
in random and sequential reads. Also change the print order so
we align with pblk_read_check_seq, printing read lba first.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index d3ff8c3e9010..829e92857289 100644
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
2.17.1
