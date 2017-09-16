Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:59537 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751314AbdIPSjz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Sep 2017 14:39:55 -0400
Date: Sat, 16 Sep 2017 21:39:53 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH V2] lightnvm: protect target type list with correct locks
Message-ID: <20170916183931.GA2824@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

nvm_tgt_types list was protected by wrong lock for NVM_INFO ioctl call
and can race with addition or removal of target types.  Also
unregistering target type was not protected correctly.

Fixes: 5cd907853 ("lightnvm: remove nested lock conflict with mm")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---

V2: also add correct lock while unregistering and fix "Fixes" tag at
end.  Note I found these while investigating another issue and
skimming the core code but worth fixing.

 drivers/lightnvm/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 9f9a137..1b8338d 100644
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
 
@@ -1190,7 +1190,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
 	info->version[1] = NVM_VERSION_MINOR;
 	info->version[2] = NVM_VERSION_PATCH;
 
-	down_write(&nvm_lock);
+	down_write(&nvm_tgtt_lock);
 	list_for_each_entry(tt, &nvm_tgt_types, list) {
 		struct nvm_ioctl_info_tgt *tgt = &info->tgts[tgt_iter];
 
@@ -1203,7 +1203,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
 	}
 
 	info->tgtsize = tgt_iter;
-	up_write(&nvm_lock);
+	up_write(&nvm_tgtt_lock);
 
 	if (copy_to_user(arg, info, sizeof(struct nvm_ioctl_info))) {
 		kfree(info);
-- 
2.7.4
