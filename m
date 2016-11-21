Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38213 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754191AbcKUMLJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2016 07:11:09 -0500
Received: by mail-wm0-f45.google.com with SMTP id f82so141189619wmf.1
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2016 04:11:09 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 7/8] lightnvm: introduce max_phys_sects helper function
Date: Mon, 21 Nov 2016 13:10:36 +0100
Message-Id: <1479730237-20797-8-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479730237-20797-1-git-send-email-javier@cnexlabs.com>
References: <1479730237-20797-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Target devices do not have access to the device driver operations.
Introduce a helper function that exposes the max. number of physical
sectors supported by the underlying device.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c  | 8 ++++++++
 include/linux/lightnvm.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 69f261e..3d8eaac 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -203,6 +203,14 @@ int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas,
 }
 EXPORT_SYMBOL(nvm_set_bb_tbl);
 
+int nvm_max_phys_sects(struct nvm_tgt_dev *tgt_dev)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+
+	return dev->ops->max_phys_sect;
+}
+EXPORT_SYMBOL(nvm_max_phys_sects);
+
 int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index b3ca603..44780ef 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -529,6 +529,7 @@ extern void nvm_unregister(struct nvm_dev *);
 extern int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas,
 							int nr_ppas, int type);
 
+extern int nvm_max_phys_sects(struct nvm_tgt_dev *);
 extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
 extern void nvm_generic_to_addr_mode(struct nvm_dev *, struct nvm_rq *);
 extern void nvm_addr_to_generic_mode(struct nvm_dev *, struct nvm_rq *);
-- 
2.7.4

