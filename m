Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44967 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdL3XJs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Dec 2017 18:09:48 -0500
Received: by mail-pl0-f67.google.com with SMTP id n13so24956626plp.11
        for <linux-block@vger.kernel.org>; Sat, 30 Dec 2017 15:09:47 -0800 (PST)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Michael Lyle <mlyle@lyle.org>
Subject: [for-416 PATCH 2/2] bcache: mark closure_sync() __sched
Date: Sat, 30 Dec 2017 15:09:34 -0800
Message-Id: <20171230230934.910-2-mlyle@lyle.org>
In-Reply-To: <20171230230934.910-1-mlyle@lyle.org>
References: <20171230230934.910-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

[edit by mlyle: include sched/debug.h to get __sched]

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
---
 drivers/md/bcache/closure.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index 8a4f4e4f5537..23eb3d1223e7 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -8,6 +8,7 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/sched/debug.h>
 
 #include "closure.h"
 
@@ -107,7 +108,7 @@ static void closure_sync_fn(struct closure *cl)
 	wake_up_process(cl->s->task);
 }
 
-void __closure_sync(struct closure *cl)
+void __sched __closure_sync(struct closure *cl)
 {
 	struct closure_syncer s = { .task = current };
 
-- 
2.14.1
