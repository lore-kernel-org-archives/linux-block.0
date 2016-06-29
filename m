Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33106 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbcF2OmX (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 29 Jun 2016 10:42:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id r201so14878683wme.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2016 07:42:15 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 06/11] lightnvm: remove nested lock conflict with mm
Date: Wed, 29 Jun 2016 16:41:51 +0200
Message-Id: <1467211316-22373-7-git-send-email-m@bjorling.me>
In-Reply-To: <1467211316-22373-1-git-send-email-m@bjorling.me>
References: <1467211316-22373-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If a media manager tries to initialize it targets upon media manager
initialization, the media manager will need to know which target types
are available in LightNVM. The lists of which managers and target types
are available shares the same lock.

Therefore, on initialization, the nvm_lock is taken by LightNVM core,
which later leads to a deadlock when target types are enumerated by the
media manager.

Add an exclusive lock for target types to resolve this conflict.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 8afb04c..04469e0 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -28,6 +28,7 @@
 #include <linux/sched/sysctl.h>
 
 static LIST_HEAD(nvm_tgt_types);
+static DECLARE_RWSEM(nvm_tgtt_lock);
 static LIST_HEAD(nvm_mgrs);
 static LIST_HEAD(nvm_devices);
 static DECLARE_RWSEM(nvm_lock);
@@ -37,7 +38,7 @@ struct nvm_tgt_type *nvm_find_target_type(const char *name, int lock)
 	struct nvm_tgt_type *tmp, *tt = NULL;
 
 	if (lock)
-		down_write(&nvm_lock);
+		down_write(&nvm_tgtt_lock);
 
 	list_for_each_entry(tmp, &nvm_tgt_types, list)
 		if (!strcmp(name, tmp->name)) {
@@ -46,7 +47,7 @@ struct nvm_tgt_type *nvm_find_target_type(const char *name, int lock)
 		}
 
 	if (lock)
-		up_write(&nvm_lock);
+		up_write(&nvm_tgtt_lock);
 	return tt;
 }
 EXPORT_SYMBOL(nvm_find_target_type);
@@ -55,12 +56,12 @@ int nvm_register_tgt_type(struct nvm_tgt_type *tt)
 {
 	int ret = 0;
 
-	down_write(&nvm_lock);
+	down_write(&nvm_tgtt_lock);
 	if (nvm_find_target_type(tt->name, 0))
 		ret = -EEXIST;
 	else
 		list_add(&tt->list, &nvm_tgt_types);
-	up_write(&nvm_lock);
+	up_write(&nvm_tgtt_lock);
 
 	return ret;
 }
-- 
2.1.4

