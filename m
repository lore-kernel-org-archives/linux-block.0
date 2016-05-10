Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38367 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbcEJHZb (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 03:25:31 -0400
Received: by mail-wm0-f43.google.com with SMTP id g17so10497236wme.1
        for <linux-block@vger.kernel.org>; Tue, 10 May 2016 00:25:30 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: expose mark_blk through core
Date: Tue, 10 May 2016 09:25:26 +0200
Message-Id: <1462865126-6044-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Expose mark_blk through the core LightNVM operations to hid the media
manager, as we do for the rest of the block operations. This is
necessary for targets to mark a growing bad block as bad before
returning it to the media manager.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c  | 6 ++++++
 include/linux/lightnvm.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 160c1a6..13993c9 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -210,6 +210,12 @@ void nvm_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
 }
 EXPORT_SYMBOL(nvm_put_blk);
 
+void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
+{
+	return dev->mt->mark_blk(dev, ppa, type);
+}
+EXPORT_SYMBOL(nvm_mark_blk);
+
 int nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 {
 	return dev->mt->submit_io(dev, rqd);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index ef2c7d2..9c56148 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -532,6 +532,8 @@ extern int nvm_register(struct request_queue *, char *,
 						struct nvm_dev_ops *);
 extern void nvm_unregister(char *);
 
+void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type);
+
 extern int nvm_submit_io(struct nvm_dev *, struct nvm_rq *);
 extern void nvm_generic_to_addr_mode(struct nvm_dev *, struct nvm_rq *);
 extern void nvm_addr_to_generic_mode(struct nvm_dev *, struct nvm_rq *);
-- 
2.5.0

