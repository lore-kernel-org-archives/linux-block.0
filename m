Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41839 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbeJISbn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so666821plr.8
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:15:16 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 36/45] lightnvm: pblk: add SPDX license tag
Date: Tue,  9 Oct 2018 13:12:06 +0200
Message-Id: <20181009111215.7653-37-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

Add GLP-2.0 SPDX license tag to all pblk files

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-cache.c    | 1 +
 drivers/lightnvm/pblk-core.c     | 1 +
 drivers/lightnvm/pblk-gc.c       | 1 +
 drivers/lightnvm/pblk-init.c     | 1 +
 drivers/lightnvm/pblk-map.c      | 1 +
 drivers/lightnvm/pblk-rb.c       | 1 +
 drivers/lightnvm/pblk-read.c     | 1 +
 drivers/lightnvm/pblk-recovery.c | 1 +
 drivers/lightnvm/pblk-rl.c       | 1 +
 drivers/lightnvm/pblk-sysfs.c    | 1 +
 drivers/lightnvm/pblk-write.c    | 1 +
 drivers/lightnvm/pblk.h          | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
index f565a56b898a..c9fa26f95659 100644
--- a/drivers/lightnvm/pblk-cache.c
+++ b/drivers/lightnvm/pblk-cache.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a3ce4a36dd33..4045a9b1ee74 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index e05d06bd5b83..2fa118c8eb71 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 7ef8249108f0..f84c428a76f1 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 IT University of Copenhagen (rrpc.c)
  * Copyright (C) 2016 CNEX Labs
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index ff677ca6e4e1..6dcbd44e3acb 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index a7648e12f54f..c26eab2ba8bd 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f5fe01d3a07f..9fba614adeeb 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index fccf65bc70b3..5740b7509bd8 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index a32790f7b7fc..db55a1c89997 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index e56eeeeb914e..cba83ac43e62 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index a276f25d3931..277abc8633f7 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 4c015c457197..e710f6db2a35 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015 IT University of Copenhagen (rrpc.h)
  * Copyright (C) 2016 CNEX Labs
-- 
2.17.1
