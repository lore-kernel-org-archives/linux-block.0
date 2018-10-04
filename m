Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42882 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbeJDOFy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Oct 2018 10:05:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id b7-v6so1002104edd.9
        for <linux-block@vger.kernel.org>; Thu, 04 Oct 2018 00:14:04 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/2] lightnvm: pblk: add helper for printing chunk state
Date: Thu,  4 Oct 2018 09:13:54 +0200
Message-Id: <1538637235-25469-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
References: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Implement pblk helper for printing chunk state.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0f98ea24ee59..34c9c1dbeed9 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1218,6 +1218,15 @@ static inline int pblk_io_aligned(struct pblk *pblk, int nr_secs)
 	return !(nr_secs % pblk->min_write_pgs);
 }
 
+static inline void print_chunk(struct pblk *pblk, struct nvm_chk_meta *chk,
+			       char *msg, int error)
+{
+	pblk_err(pblk, "chunk: (%s: %x) s:%d,t:%d,wi:%d,slba:%llu,cnlb:%llu,wp:%llu\n",
+			msg, error,
+			chk->state, chk->type, chk->wi,
+			chk->slba, chk->cnlb, chk->wp);
+}
+
 #ifdef CONFIG_NVM_PBLK_DEBUG
 static inline void print_ppa(struct pblk *pblk, struct ppa_addr *p,
 			     char *msg, int error)
-- 
2.7.4
