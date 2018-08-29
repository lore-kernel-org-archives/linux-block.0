Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:55138 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2MeI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 08:34:08 -0400
Received: by mail-it0-f68.google.com with SMTP id f14-v6so6512674ita.4
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 01:38:19 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: add helpers for chunk addresses
Date: Wed, 29 Aug 2018 10:37:51 +0200
Message-Id: <1535531871-23255-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Implement helpers to go from ppas to a chunk within a line and an
address within a chunk.

These helpers will be used on the patches adding trace support in pblk,
which will be sent in this window.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index be67bbfa3d0a..1bfbd3315598 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1034,6 +1034,37 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
 	return ppa;
 }
 
+static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct pblk *pblk,
+							struct ppa_addr p)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line *line = &pblk->lines[pblk_ppa_to_line(p)];
+	int pos = pblk_ppa_to_pos(geo, p);
+
+	return &line->chks[pos];
+}
+
+static inline u64 pblk_dev_ppa_to_chunk_addr(struct pblk *pblk,
+							struct ppa_addr p)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	u64 caddr;
+
+	if (geo->version == NVM_OCSSD_SPEC_12) {
+		struct nvm_addrf_12 *ppaf = (struct nvm_addrf_12 *)&pblk->addrf;
+
+		caddr = (u64)p.g.pg << ppaf->pg_offset;
+		caddr |= (u64)p.g.pl << ppaf->pln_offset;
+		caddr |= (u64)p.g.sec << ppaf->sec_offset;
+	} else {
+		caddr = p.m.sec;
+	}
+
+	return caddr;
+}
+
 static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
 							struct ppa_addr p)
 {
-- 
2.7.4
