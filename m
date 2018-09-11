Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45828 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKRHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 13:07:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so19011488eda.12
        for <linux-block@vger.kernel.org>; Tue, 11 Sep 2018 05:08:43 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: add SPDX license tag
Date: Tue, 11 Sep 2018 14:08:36 +0200
Message-Id: <1536667716-23004-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add GLP-2.0 SPDX license tag to all pblk files

Signed-off-by: Javier González <javier@cnexlabs.com>
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
index 77d811962818..74b912ee3c05 100644
--- a/drivers/lightnvm/pblk-cache.c
+++ b/drivers/lightnvm/pblk-cache.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 80f0ec756672..a23e965d32fc 100644
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
index 532ee0834dad..caed18fabd35 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 IT University of Copenhagen (rrpc.c)
  * Copyright (C) 2016 CNEX Labs
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 070ed53eca07..2f7ce572b29e 100644
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
index aa345a4045aa..16294701a748 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 09015fd8e0f2..c562e1fad243 100644
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
index 5e4cec453a43..127ee99c3efc 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015 IT University of Copenhagen (rrpc.h)
  * Copyright (C) 2016 CNEX Labs
-- 
2.7.4
