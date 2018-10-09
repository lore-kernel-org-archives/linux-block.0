Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34115 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeJISas (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:30:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so684880pfi.1
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:22 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 20/45] lightnvm: pblk: fix write amplificiation calculation
Date: Tue,  9 Oct 2018 13:11:50 +0200
Message-Id: <20181009111215.7653-21-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When the user data counter exceeds 32 bits, the write amplification
calculation does not provide the right value. Fix this by using
div64_u64 in stead of div64.

Fixes: 76758390f83e ("lightnvm: pblk: export write amplification counters to sysfs")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
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
2.17.1
