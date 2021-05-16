Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DABC433B4
	for <linux-block@archiver.kernel.org>; Sun, 16 May 2021 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C735861182
	for <linux-block@archiver.kernel.org>; Sun, 16 May 2021 15:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhEPPEy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 May 2021 11:04:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40470 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhEPPEy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 May 2021 11:04:54 -0400
Received: from mail-lj1-f197.google.com ([209.85.208.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1liIIs-0007DC-Sc
        for linux-block@vger.kernel.org; Sun, 16 May 2021 15:03:38 +0000
Received: by mail-lj1-f197.google.com with SMTP id x26-20020a2e9c9a0000b02900eaf62d380eso2119267lji.2
        for <linux-block@vger.kernel.org>; Sun, 16 May 2021 08:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XTCfpt/56FbqDOoQ8sUsaMXNebh06g9CZvsUJW9+jNY=;
        b=LDYVzlBIhSSkbjKKMrlObYmWHgSfkPBLFSvxcv1Gli6pdPGjoil+DPIhC48OFTweqL
         KPUhF5FZLwsogiJ2Fy4ey5AgJsdvisduKD3G1nI3sUpkMj1NK5zkgWI82exAZgIHxEAh
         TqI/fJIAtkDxIswkh2/6kZqxZccybA0KXMR+jgwEzXdEksuc8s/V6IAmREHbAeBIjXRf
         oiVIJvRlgRj8aDXFAN7CgeSkHCI8DEAl/C0Ss6z0liv1GRxmMWUutJw1KDknAAPlTGhd
         XV58tiLNpuxvmUAOX+/v4BIUWL9MjV8ubt/oDfNqXEgKCdCBsgQ0klrHUNs4+Xri+PYw
         ncyQ==
X-Gm-Message-State: AOAM531P9drmS6H2HiqQolvErjcZIghzE5sj7P9ehk5taHW/j+rC/UzX
        SYpG84DucuAikUTpM0Um7Hsd8PC14nYnoYAn1KaFBI+izgnOnaNZldpwHKF5ZVpLEuyvDrm0QEy
        OzWhmAD7G9+2qJIGbKYtCK5n7La5MrEO9mpuZSYke
X-Received: by 2002:aa7:c781:: with SMTP id n1mr30536214eds.108.1621177058174;
        Sun, 16 May 2021 07:57:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgjPgNxbUF7hm+COhC/ooKGZrl9JgiTHUHstCcL7r40Cj4zYM5f1bEMCKhdjiXTEnIoj121A==
X-Received: by 2002:aa7:c781:: with SMTP id n1mr30536192eds.108.1621177057984;
        Sun, 16 May 2021 07:57:37 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id q26sm7164708ejc.3.2021.05.16.07.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 07:57:37 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] init/Kconfig: Fix BLK_CGROUP help text indentation
Date:   Sun, 16 May 2021 16:57:31 +0200
Message-Id: <20210516145731.61253-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The convention for help text indentation seems to be tab + 2 spaces.
Do that for BLK_CGROUP which currently only uses a single tab.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 init/Kconfig | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9f1cde503739..5beaa0249071 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -926,22 +926,23 @@ config BLK_CGROUP
 	depends on BLOCK
 	default n
 	help
-	Generic block IO controller cgroup interface. This is the common
-	cgroup interface which should be used by various IO controlling
-	policies.
-
-	Currently, CFQ IO scheduler uses it to recognize task groups and
-	control disk bandwidth allocation (proportional time slice allocation)
-	to such task groups. It is also used by bio throttling logic in
-	block layer to implement upper limit in IO rates on a device.
-
-	This option only enables generic Block IO controller infrastructure.
-	One needs to also enable actual IO controlling logic/policy. For
-	enabling proportional weight division of disk bandwidth in CFQ, set
-	CONFIG_BFQ_GROUP_IOSCHED=y; for enabling throttling policy, set
-	CONFIG_BLK_DEV_THROTTLING=y.
-
-	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
+	  Generic block IO controller cgroup interface. This is the common
+	  cgroup interface which should be used by various IO controlling
+	  policies.
+
+	  Currently, CFQ IO scheduler uses it to recognize task groups and
+	  control disk bandwidth allocation (proportional time slice allocation)
+	  to such task groups. It is also used by bio throttling logic in
+	  block layer to implement upper limit in IO rates on a device.
+
+	  This option only enables generic Block IO controller infrastructure.
+	  One needs to also enable actual IO controlling logic/policy. For
+	  enabling proportional weight division of disk bandwidth in CFQ, set
+	  CONFIG_BFQ_GROUP_IOSCHED=y; for enabling throttling policy, set
+	  CONFIG_BLK_DEV_THROTTLING=y.
+
+	  See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more
+	  information.
 
 config CGROUP_WRITEBACK
 	bool
-- 
2.27.0

