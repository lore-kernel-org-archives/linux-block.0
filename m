Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:38195 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJZQsx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Oct 2018 12:48:53 -0400
Received: by mail-it1-f194.google.com with SMTP id i76-v6so680802ita.3
        for <linux-block@vger.kernel.org>; Fri, 26 Oct 2018 01:12:50 -0700 (PDT)
From: Hans Holmberg <hans@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: fix chunk close trace event check
Date: Fri, 26 Oct 2018 10:12:24 +0200
Message-Id: <1540541544-7761-1-git-send-email-hans.holmberg@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The check for chunk closes suffers from an off-by-one issue, leading
to chunk close events not being traced. Fix this.

Fixes: 4c44abf43d00 ("lightnvm: pblk: add trace events for chunk states")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---

 drivers/lightnvm/pblk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6944aac43b01..6581c35f51ee 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -531,7 +531,7 @@ void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
 		if (caddr == 0)
 			trace_pblk_chunk_state(pblk_disk_name(pblk),
 							ppa, NVM_CHK_ST_OPEN);
-		else if (caddr == chunk->cnlb)
+		else if (caddr == (chunk->cnlb - 1))
 			trace_pblk_chunk_state(pblk_disk_name(pblk),
 							ppa, NVM_CHK_ST_CLOSED);
 	}
-- 
2.7.4
