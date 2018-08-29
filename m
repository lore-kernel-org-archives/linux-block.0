Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34212 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeH2M55 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 08:57:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so3191976eds.1
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 02:02:02 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/4] lightnvm: pblk: remove unused variable.
Date: Wed, 29 Aug 2018 11:01:52 +0200
Message-Id: <1535533313-29944-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Removed unused struct ppa_addr variable.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 994a081994fb..22cc9bfbbb10 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1398,7 +1398,6 @@ static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 
 	if (rqd->opcode == NVM_OP_PWRITE) {
 		struct pblk_line *line;
-		struct ppa_addr ppa;
 		int i;
 
 		for (i = 0; i < rqd->nr_ppas; i++) {
-- 
2.7.4
