Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46898 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757833AbdJMMrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id m72so21262538wmc.1
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:10 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 03/58] lightnvm: protect target type list with correct locks
Date: Fri, 13 Oct 2017 14:45:52 +0200
Message-Id: <20171013124647.32668-4-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

nvm_tgt_types list was protected by wrong lock for NVM_INFO ioctl call
and can race with addition or removal of target types.  Also
unregistering target type was not protected correctly.

Fixes: 5cd907853 ("lightnvm: remove nested lock conflict with mm")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index c490711..ee2b6d7 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -589,9 +589,9 @@ void nvm_unregister_tgt_type(struct nvm_tgt_type *tt)
 	if (!tt)
 		return;
 
-	down_write(&nvm_lock);
+	down_write(&nvm_tgtt_lock);
 	list_del(&tt->list);
-	up_write(&nvm_lock);
+	up_write(&nvm_tgtt_lock);
 }
 EXPORT_SYMBOL(nvm_unregister_tgt_type);
 
@@ -1195,7 +1195,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
 	info->version[1] = NVM_VERSION_MINOR;
 	info->version[2] = NVM_VERSION_PATCH;
 
-	down_write(&nvm_lock);
+	down_write(&nvm_tgtt_lock);
 	list_for_each_entry(tt, &nvm_tgt_types, list) {
 		struct nvm_ioctl_info_tgt *tgt = &info->tgts[tgt_iter];
 
@@ -1208,7 +1208,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
 	}
 
 	info->tgtsize = tgt_iter;
-	up_write(&nvm_lock);
+	up_write(&nvm_tgtt_lock);
 
 	if (copy_to_user(arg, info, sizeof(struct nvm_ioctl_info))) {
 		kfree(info);
-- 
2.9.3
