Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35986 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbeH2QUk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so3783945edq.3
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 05:23:59 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 7/7] lightnvm: pblk: fix write amplificiation calculation
Date: Wed, 29 Aug 2018 14:23:34 +0200
Message-Id: <1535545414-550-8-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When the user data counter exceeds 32 bits, the write amplification
calculation does not provide the right value. Fix this by using
div64_u64 in stead of div64.

Fixes: 76758390f83e ("lightnvm: pblk: export write amplification counters to sysfs")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 9fc3dfa168b4..e56eeeeb914e 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -337,7 +337,6 @@ static ssize_t pblk_get_write_amp(u64 user, u64 gc, u64 pad,
 {
 	int sz;
 
-
 	sz = snprintf(page, PAGE_SIZE,
 			"user:%lld gc:%lld pad:%lld WA:",
 			user, gc, pad);
@@ -349,7 +348,7 @@ static ssize_t pblk_get_write_amp(u64 user, u64 gc, u64 pad,
 		u32 wa_frac;
 
 		wa_int = (user + gc + pad) * 100000;
-		wa_int = div_u64(wa_int, user);
+		wa_int = div64_u64(wa_int, user);
 		wa_int = div_u64_rem(wa_int, 100000, &wa_frac);
 
 		sz += snprintf(page + sz, PAGE_SIZE - sz, "%llu.%05u\n",
-- 
2.7.4
