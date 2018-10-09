Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44885 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeJISaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:30:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so639613pgu.11
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:13:57 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 13/45] lightnvm: pblk: fix comment typo
Date: Tue,  9 Oct 2018 13:11:43 +0200
Message-Id: <20181009111215.7653-14-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

Fix comment typo Decrese -> Decrease

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index c23b65aaa27b..625ed5a3a020 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -168,7 +168,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		/* Release flags on write context. Protect from writes */
 		smp_store_release(&w_ctx->flags, flags);
 
-		/* Decrese the reference count to the line as we will
+		/* Decrease the reference count to the line as we will
 		 * re-map these entries
 		 */
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
-- 
2.17.1
