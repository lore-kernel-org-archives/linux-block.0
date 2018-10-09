Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39015 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeJISa1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:30:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so674752pfe.6
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:01 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 14/45] lightnvm: pblk: remove unused variable.
Date: Tue,  9 Oct 2018 13:11:44 +0200
Message-Id: <20181009111215.7653-15-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

Removed unused struct ppa_addr variable.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index af9477b7e803..1865ac1560fa 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1373,7 +1373,6 @@ static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 
 	if (rqd->opcode == NVM_OP_PWRITE) {
 		struct pblk_line *line;
-		struct ppa_addr ppa;
 		int i;
 
 		for (i = 0; i < rqd->nr_ppas; i++) {
-- 
2.17.1
