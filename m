Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34157 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755646AbcK1Vj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:57 -0500
Received: by mail-wj0-f194.google.com with SMTP id xy5so15802796wjc.1
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:56 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 21/23] lightnvm: introduce max_phys_sects helper function
Date: Mon, 28 Nov 2016 22:39:12 +0100
Message-Id: <20161128213914.12516-22-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Target devices do not have access to the device driver operations.
Introduce a helper function that exposes the max. number of physical
sectors supported by the underlying device.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
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
index 99cd1e7..9637531 100644
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
2.9.3

