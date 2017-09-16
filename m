Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:58437 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751253AbdIPSDi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Sep 2017 14:03:38 -0400
Date: Sat, 16 Sep 2017 21:03:36 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH] lightnvm: protect target type list with correct locks
Message-ID: <20170916180334.GA2758@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

nvm_tgt_types list was protected by wrong lock for NVM_INFO ioctl call
and can race with addition or removal of target types.

Fixes: cd9e9808d ("lightnvm: Support for Open-Channel SSDs")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 9f9a137..790b0ab 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
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
