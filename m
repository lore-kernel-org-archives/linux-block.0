Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34923 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKQei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 12:34:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so18988355edq.2
        for <linux-block@vger.kernel.org>; Tue, 11 Sep 2018 04:35:41 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/2] lightnvm: pblk: add helper for printing chunk state
Date: Tue, 11 Sep 2018 13:35:33 +0200
Message-Id: <1536665734-14305-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1536665734-14305-1-git-send-email-javier@cnexlabs.com>
References: <1536665734-14305-1-git-send-email-javier@cnexlabs.com>
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
index 3d7248829013..5e4cec453a43 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1230,6 +1230,15 @@ static inline int pblk_io_aligned(struct pblk *pblk, int nr_secs)
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
