Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B840DC43461
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9912560FE6
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhESI5v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 04:57:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51170 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343679AbhESI5u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 04:57:50 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1ljI0D-000430-Vd
        for linux-block@vger.kernel.org; Wed, 19 May 2021 08:56:30 +0000
Received: by mail-ed1-f72.google.com with SMTP id i3-20020aa7dd030000b029038ce772ffe4so7338628edv.12
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 01:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQfDTjDJ+zDw3M/+SAlmmPaFpSe9q5rG8eps/qbC3cs=;
        b=TDOxPrrL8sVS7jx3kzP+U2IWWksbyOMCv/70Bc5KMD6q71xqsGFr0Fd+9bv25XxPjw
         p9dUfbZI2Z9JrumUK0rcK1VWFP1odecLDSkPPKd3PiP1NCqNzoQxuDQ6sWSwYhP5FIfP
         yHgL0HOof5xDLW+zooh9KGubf3Oo3P+Acm87W2/A312tCxjqNl/U8gNAqZgH0zVm5cxE
         ITVytxtG60kcZiPSlGMuLC2utccBJ9WhnQjO8F6tHGUzRIyGJvJdTMZmtMXCsADfYg8O
         gTCPs/ib0vCr/iBhVIDv+PniL+1e5I479Yid/stWAIU4V9bmmVt9WZvwjyNtarN0qfae
         p+xw==
X-Gm-Message-State: AOAM533JnVrDIhqcJLRh2rq2b/+KEx4mtBWWsPYXARn9LSx/loLQKEI8
        H2P+WoQrP7plAvZxXh/iHgT/EDKKLcEWLuDBPED5993PQ/SmLRJTJYLeB1fMeYv1jGo81ovKSfh
        ++u+BMXsehEHO+Yfc3oiJeu0bbG4RXth368uic4Ly
X-Received: by 2002:a17:907:20d1:: with SMTP id qq17mr11194633ejb.329.1621414589709;
        Wed, 19 May 2021 01:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwB+8Df65yrqPlUbwTYU26pd/VZ5jLmYgsR92CH6s0Adxh/N6hJZG9Vr8XGPZysz8/V5nJlzw==
X-Received: by 2002:a17:907:20d1:: with SMTP id qq17mr11194623ejb.329.1621414589548;
        Wed, 19 May 2021 01:56:29 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l28sm1364816edc.29.2021.05.19.01.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:56:29 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 1/3] init/Kconfig: Move BLK_CGROUP to block/Kconfig
Date:   Wed, 19 May 2021 10:56:13 +0200
Message-Id: <20210519085615.12101-2-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519085615.12101-1-juergh@canonical.com>
References: <20210519085615.12101-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While at it, make the option prompt more descriptive and fix the help
text indentation to be 1 tab + 2 spaces.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 block/Kconfig | 23 +++++++++++++++++++++++
 init/Kconfig  | 22 ----------------------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index a2297edfdde8..fbc4cf1a2075 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -202,6 +202,29 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_CGROUP
+	bool "Enable block IO cgroup controller"
+	depends on CGROUPS
+	default n
+	help
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
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/init/Kconfig b/init/Kconfig
index 1ea12c64e4c9..5be10c091603 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -921,28 +921,6 @@ config MEMCG_KMEM
 	depends on MEMCG && !SLOB
 	default y
 
-config BLK_CGROUP
-	bool "IO controller"
-	depends on BLOCK
-	default n
-	help
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
-
 config CGROUP_WRITEBACK
 	bool
 	depends on MEMCG && BLK_CGROUP
-- 
2.27.0

