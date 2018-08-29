Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45383 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeH2M54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 08:57:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id p52-v6so3345442eda.12
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 02:02:01 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/4] lightnvm: pblk: fix comment typo
Date: Wed, 29 Aug 2018 11:01:51 +0200
Message-Id: <1535533313-29944-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fix comment typo Decrese -> Decrease

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 767618eba4c2..617572717065 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -195,7 +195,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		/* Release flags on write context. Protect from writes */
 		smp_store_release(&w_ctx->flags, flags);
 
-		/* Decrese the reference count to the line as we will
+		/* Decrease the reference count to the line as we will
 		 * re-map these entries
 		 */
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
-- 
2.7.4
