Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4CCC43460
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2432861059
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344131AbhESI5x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 04:57:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51178 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbhESI5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 04:57:52 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1ljI0G-000446-DM
        for linux-block@vger.kernel.org; Wed, 19 May 2021 08:56:32 +0000
Received: by mail-ej1-f70.google.com with SMTP id m18-20020a1709062352b02903d2d831f9baso3418737eja.20
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 01:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxgTSGLGsPNE+HFZu6RZbhOQgcO/K1P0N9aRKRAr0to=;
        b=SJ+vwZ4D8p52b8M2Ya/sPaq6AFTlM/BeDBDu/MI3DjrZIlzfnzWAoqUFSDW5HJF2Pn
         oZQsSaHHO3YDtbQqWUsB468TWl8CKUqGr+a/vSlNLEH8UsCe2Axk0NbN7ihlC2QB54vI
         GudkkF7+rVm4471qlVI4joPSWmqkGSmbqj4XVbXGyFCg9UWBP1BXU/6SPshThmpegaUt
         9pELz5s3wh7aG3TtUm/3xFMrnAvRjCtMZLcOOJnh9VdylfjhkcC5vQJzfG8NKLcQiGUo
         zLtzWatEwNe1WOKuh7wy9yeUMy0oN4EUF/WbBpJd4wiZaW0R1lqMe97GClgGnjaVzRIK
         zwcg==
X-Gm-Message-State: AOAM533GW1fB0arcYZoy06efaDVeMxOjB3P+UjJr7g26MrtdxWrt3of5
        ebmHT0REaPKFjVTZ/e95a/Y5gfEhZ51nb9HV8jGKyFb8g2cadMnPK+JExeZ9nMGf8Ib2IZ2/Gbl
        sqbr8MXJquQML3FUSSx3PabTi6hI0ig0ffMz/rxN/
X-Received: by 2002:a05:6402:281:: with SMTP id l1mr5443489edv.58.1621414592145;
        Wed, 19 May 2021 01:56:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5p+HilFZEesm7IJLBx/xeFdN1sN2PzqChZsE1Yf3YM6KA4aFN3PGm4tAME+XWzeliPAFPQA==
X-Received: by 2002:a05:6402:281:: with SMTP id l1mr5443472edv.58.1621414591927;
        Wed, 19 May 2021 01:56:31 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l28sm1364816edc.29.2021.05.19.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:56:31 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 3/3] block/Kconfig.iosched: Whitespace and indentation cleanups
Date:   Wed, 19 May 2021 10:56:15 +0200
Message-Id: <20210519085615.12101-4-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519085615.12101-1-juergh@canonical.com>
References: <20210519085615.12101-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace multiple whitespaces with a tab and make the help text indendation
1 tab + 2 spaces which seems to be the convention.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 block/Kconfig.iosched | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 2f2158e05a91..57939e7e1ff3 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -21,28 +21,27 @@ config MQ_IOSCHED_KYBER
 config IOSCHED_BFQ
 	tristate "BFQ I/O scheduler"
 	help
-	BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
-	of the device among all processes according to their weights,
-	regardless of the device parameters and with any workload. It
-	also guarantees a low latency to interactive and soft
-	real-time applications.  Details in
-	Documentation/block/bfq-iosched.rst
+	  BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
+	  of the device among all processes according to their weights,
+	  regardless of the device parameters and with any workload. It
+	  also guarantees a low latency to interactive and soft
+	  real-time applications.  Details in
+	  Documentation/block/bfq-iosched.rst
 
 config BFQ_GROUP_IOSCHED
-       bool "BFQ hierarchical scheduling support"
-       depends on IOSCHED_BFQ && BLK_CGROUP
-       select BLK_CGROUP_RWSTAT
+	bool "BFQ hierarchical scheduling support"
+	depends on IOSCHED_BFQ && BLK_CGROUP
+	select BLK_CGROUP_RWSTAT
 	help
-
-       Enable hierarchical scheduling in BFQ, using the blkio
-       (cgroups-v1) or io (cgroups-v2) controller.
+	  Enable hierarchical scheduling in BFQ, using the blkio
+	  (cgroups-v1) or io (cgroups-v2) controller.
 
 config BFQ_CGROUP_DEBUG
 	bool "BFQ IO controller debugging"
 	depends on BFQ_GROUP_IOSCHED
 	help
-	Enable some debugging help. Currently it exports additional stat
-	files in a cgroup which can be useful for debugging.
+	  Enable some debugging help. Currently it exports additional stat
+	  files in a cgroup which can be useful for debugging.
 
 endmenu
 
-- 
2.27.0

