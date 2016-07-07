Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35051 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756609AbcGGHyi (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so3512986wme.2
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:36 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 02/17] lightnvm: add media manager mark_blk helper
Date: Thu,  7 Jul 2016 09:54:08 +0200
Message-Id: <1467878063-22919-3-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Expose media manager mark_blk() to targets, as done for the rest of the
media manager callback functions.

Signed-off-by: Javier González <javier@cnexlabs.com>
Updated description
Signed-off-by: Matias Bjørling <m@bjorling.me>

Signed-off-by: Matias Bjørling <m@bjorling.me>
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
2.1.4

