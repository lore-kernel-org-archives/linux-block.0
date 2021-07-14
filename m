Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55291C12002
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 20:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EA161407
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 20:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhGNUIL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:08:11 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:12095 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbhGNUGq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jul 2021 16:06:46 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jul 2021 16:06:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626292670;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=8P7wGc9DchHY3VEHEGxTt2/euWEZk2R70ItYGtj4KtQ=;
    b=CLVVg8dm2aK9Llh0kX1mi7dvCXo5C/qJ8qWZdpnsG1afNfdTdx1ufyc2fLr03uOa0Q
    Iz6KDUOGRBsFLqRwERzW+UiqJb+Bbrm35GNI8dbOIF8+OeHGbt2imoXwYXL6MV+f7Ef9
    VQDjFyzTXZYTR5GhFZf29dYmRiDDvww4/JzWGSkFStozeQW7K3uJMWahw2UECc34efyk
    dlV5wNDmU0kyFikugqnnZrSRDcpVB1JjNa/T3b90xZozxY0WdCLP4EURC3FRqTsBmvz1
    gEzGvKXgR7MGWzyZQszt6WCYZfQsE27cxEmML3cx7smz5J6dZqJAEXl83gkUABM4Ce2+
    YJwA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh+JyKAeyWJabqMyH2G"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.28.1 AUTH)
    with ESMTPSA id Z03199x6EJvo0T7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jul 2021 21:57:50 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-block@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Kay Sievers <kay@vrfy.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ioprio: move user space relevant ioprio bits to UAPI includes
Date:   Wed, 14 Jul 2021 21:56:55 +0200
Message-Id: <20210714195655.181943-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

systemd added a modified copy of include/linux/ioprio.h into its
code to get the relevant content definitions for the exposed
ioprio_[get|set] system calls.

Move the user space relevant ioprio bits to the UAPI includes to be
able to use the ioprio_[get|set] syscalls as intended.

Cc: Kay Sievers <kay@vrfy.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/ioprio.h      | 41 +--------------------------------
 include/uapi/linux/ioprio.h | 46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 40 deletions(-)
 create mode 100644 include/uapi/linux/ioprio.h

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index e9bfe6972aed..ef9ad4fb245f 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -4,50 +4,11 @@
 
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
 #include <linux/iocontext.h>
 
-/*
- * Gives us 8 prio classes with 13-bits of data for each class
- */
-#define IOPRIO_CLASS_SHIFT	(13)
-#define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
-
-#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)
-#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)
-#define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
-
-#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
-
-/*
- * These are the io priority groups as implemented by CFQ. RT is the realtime
- * class, it always gets premium service. BE is the best-effort scheduling
- * class, the default for any process. IDLE is the idle scheduling class, it
- * is only served when no one else is using the disk.
- */
-enum {
-	IOPRIO_CLASS_NONE,
-	IOPRIO_CLASS_RT,
-	IOPRIO_CLASS_BE,
-	IOPRIO_CLASS_IDLE,
-};
-
-/*
- * 8 best effort priority levels are supported
- */
-#define IOPRIO_BE_NR	(8)
-
-enum {
-	IOPRIO_WHO_PROCESS = 1,
-	IOPRIO_WHO_PGRP,
-	IOPRIO_WHO_USER,
-};
-
-/*
- * Fallback BE priority
- */
-#define IOPRIO_NORM	(4)
+#include <uapi/linux/ioprio.h>
 
 /*
  * if process has set io priority explicitly, use that. if not, convert
  * the cpu scheduler nice value to an io priority
  */
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
new file mode 100644
index 000000000000..77b17e08b0da
--- /dev/null
+++ b/include/uapi/linux/ioprio.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_IOPRIO_H
+#define _UAPI_LINUX_IOPRIO_H
+
+/*
+ * Gives us 8 prio classes with 13-bits of data for each class
+ */
+#define IOPRIO_CLASS_SHIFT	(13)
+#define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
+
+#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)
+#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)
+#define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
+
+/*
+ * These are the io priority groups as implemented by CFQ. RT is the realtime
+ * class, it always gets premium service. BE is the best-effort scheduling
+ * class, the default for any process. IDLE is the idle scheduling class, it
+ * is only served when no one else is using the disk.
+ */
+enum {
+	IOPRIO_CLASS_NONE,
+	IOPRIO_CLASS_RT,
+	IOPRIO_CLASS_BE,
+	IOPRIO_CLASS_IDLE,
+};
+
+#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
+
+/*
+ * 8 best effort priority levels are supported
+ */
+#define IOPRIO_BE_NR	(8)
+
+enum {
+	IOPRIO_WHO_PROCESS = 1,
+	IOPRIO_WHO_PGRP,
+	IOPRIO_WHO_USER,
+};
+
+/*
+ * Fallback BE priority
+ */
+#define IOPRIO_NORM	(4)
+
+#endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.30.2

