Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C18C4167B
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 14:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiLIO4J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiLIOzs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 09:55:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF981381
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 06:55:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v8so3423375edi.3
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 06:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr0DjBH1YEnasxrYesj7cvRVZfRH4rPEDs0TxXAHiSg=;
        b=6BR4ftmEi4cwaY0Zq2EMADfCq7D3R7dRhGj565BcwcOdftO7DpLqU7m1Uq+/yJ+AGZ
         jh/kM4TgyggxJ+OTIBjhyKG6SAj9vKbh98eNvUeU43HoQPObiR6Pz9b5QNHJ3vavH2k1
         ZtqdFgFQq6/oMk76hY+leei80rWiI5ExUI3F5vd83sJCp4F/ZTicV1hH7KE6ocr2Kxbc
         vIl+6NtxjPHuGXJE2mutZpRE0s5Mz54VT5WHCKvnLwDfs5udM6eQpLVXxJ2N+nbLSW9f
         wqeE2ymttBeIpxn5/ahdOSnUceCLnfxZJcAzEMCvBIYv079KyzKGFg/I7JNLpD/SZZ9L
         d6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nr0DjBH1YEnasxrYesj7cvRVZfRH4rPEDs0TxXAHiSg=;
        b=Dx8icUFu2fbExxlRCETf8Y0gj1xyGaVDiIUX/w1f6qRXoRQoNEQ6OXqRhjdpSM6/uI
         tbKiy/LZ8bZU03lYz5a0k8n8QDcUfG0G3UZpVA/odFi768yWH8qA68SSKPxljINhPT4y
         j9FyMae0WFIKDu07hGu+XIYXBuSuRQcIufZpd9MgySV5VWUpDwLTOQpHzCc4lTWl2Fxt
         ULqHv04ol8cCkS99IW/ZrHTDqhXrmU7hOTN2SlJmV/5jyREpbBBpqP06zkueYytwAjQ9
         g+8VSAhUVDf5mVAqlcpD/8XY8r3xqvumq18CaFJ/LF6N7oxN0PImNxwsP7BpPFbzxJ6z
         BXZA==
X-Gm-Message-State: ANoB5plZqxXk149TgGl7IAnhqgNGpw6xeJKsJUiBkCdF+62rkmjt+oOR
        LmNh6AxjnrKJvZV2l5VxsA3JfA==
X-Google-Smtp-Source: AA0mqf4Yb/BOvMLtH6r67H46I1phEPMg/pmN85YtjlgWU29uNdJPkmrZ6mICq1Tm5TiV5cKxNxgBlA==
X-Received: by 2002:a05:6402:1004:b0:46b:c156:9965 with SMTP id c4-20020a056402100400b0046bc1569965mr5266982edu.38.1670597708861;
        Fri, 09 Dec 2022 06:55:08 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b0046b1d63cfc1sm716856edq.88.2022.12.09.06.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:55:08 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 3/3] drbd: split off drbd_config into separate file
Date:   Fri,  9 Dec 2022 15:55:04 +0100
Message-Id: <20221209145504.2273072-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
References: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To be more similar to what we do in the out-of-tree module and ease the
upstreaming process.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_buildtag.c |  2 +-
 drivers/block/drbd/drbd_int.h      |  1 +
 include/linux/drbd.h               |  6 ------
 include/linux/drbd_config.h        | 16 ++++++++++++++++
 4 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/drbd_config.h

diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd_buildtag.c
index 956a4d5c339b..cb1aa66d7d5d 100644
--- a/drivers/block/drbd/drbd_buildtag.c
+++ b/drivers/block/drbd/drbd_buildtag.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/drbd.h>
+#include <linux/drbd_config.h>
 #include <linux/module.h>
 
 const char *drbd_buildtag(void)
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index edce1f7ac2da..d89b7d03d4c8 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -34,6 +34,7 @@
 #include <linux/prefetch.h>
 #include <linux/drbd_genl_api.h>
 #include <linux/drbd.h>
+#include <linux/drbd_config.h>
 #include "drbd_strings.h"
 #include "drbd_state.h"
 #include "drbd_protocol.h"
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index df65a8f5228a..5468a2399d48 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -38,12 +38,6 @@
 
 #endif
 
-extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.11"
-#define PRO_VERSION_MIN 86
-#define PRO_VERSION_MAX 101
-
-
 enum drbd_io_error_p {
 	EP_PASS_ON, /* FIXME should the better be named "Ignore"? */
 	EP_CALL_HELPER,
diff --git a/include/linux/drbd_config.h b/include/linux/drbd_config.h
new file mode 100644
index 000000000000..d215365c6bb1
--- /dev/null
+++ b/include/linux/drbd_config.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * drbd_config.h
+ * DRBD's compile time configuration.
+ */
+
+#ifndef DRBD_CONFIG_H
+#define DRBD_CONFIG_H
+
+extern const char *drbd_buildtag(void);
+
+#define REL_VERSION "8.4.11"
+#define PRO_VERSION_MIN 86
+#define PRO_VERSION_MAX 101
+
+#endif
-- 
2.38.1

