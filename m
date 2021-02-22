Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17600C433E6
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5FF64E31
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhBVTCW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhBVTBy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 14:01:54 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663FAC06178B
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 11:01:13 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n20so5098222ejb.5
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 11:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BMVnVWbgA3Vc7YyOK5ql/rQggQNVPkXpg0QebYCGCmA=;
        b=S9GIbuLT8fULLS2cH7TQ6ZZTtgEQroFUNl6mlhzyxW7m7q7N53xc1vd7xRo8zhVTLw
         1tJohJ4stukFwIFPk0d/x//RagpPWVUoIwF7F0IMdtVY54PFTJkbKm8yqkdA/4biGjJP
         hVmIaB0DXjsPZLMe//rSYj3pCks8yf6tQmAXUKpHjYjvY8xahQ8jKY+ngA3Q5XyuFDIV
         c3ld2/VhBduQa0AHxdQDDpMLcwxk5SVY9RzkajukSdxHP13ovMEaoIhNdNsa7UoFyzYw
         vTEiMU1lcasrfkii8qZeh81w53QIDheojHjPBUZf8VU1ZsHhzYUHZzrRXu2KeVO/8BGG
         ccMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BMVnVWbgA3Vc7YyOK5ql/rQggQNVPkXpg0QebYCGCmA=;
        b=mJEBMijdDcVJ2SZ0UKFLCoHMQJCuQnnpDUcarfUeO2Otq3ztNJ6qygxbpDDD6Bnlpu
         VhmpQ6ixMAOqRwTrhPWC2bz9zTXPV1+hR4PkrbzIgr4AM/NQRE2LQaSg+7Hui6yS8Jlv
         xoWYM6FL59bT8E/PyDNWV1g383KezfaZ6RqyNfWtgzzh8dMPdgbgwwnPSlohkqDKtTdY
         VJykdDAb/EvaeiDoyRupIpUfJXaf4cZ3Kc9mQ/ueO9g5rEvg8dmpVPUw4/B68SZgN1Hd
         brbllMbdx3kok9ga9SNxv+bRtGy7hPe1MmKo/uqdEhgKyXsF2lyNu6aBVaQb4kDkGC2X
         /nHw==
X-Gm-Message-State: AOAM532NT0ism3CpfaZYFHaO/Yn6QifvyVGHeGSyx+VdXF6FyEnOMqKY
        Rnse1FVft6byfiJgyegfl0/K8g==
X-Google-Smtp-Source: ABdhPJw4WH+Mftr3Ggam0OCESHx1erRSnVtWm5h7BV63+LF66xGqvZP+PfrCNcTRcJr/ke+/xFeIVA==
X-Received: by 2002:a17:906:6942:: with SMTP id c2mr7313906ejs.425.1614020472153;
        Mon, 22 Feb 2021 11:01:12 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id d23sm9204528ejw.109.2021.02.22.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 11:01:11 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: [PATCH V5 2/2] nvme: allow open for nvme-generic char device
Date:   Mon, 22 Feb 2021 20:01:07 +0100
Message-Id: <20210222190107.8479-3-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222190107.8479-1-javier.gonz@samsung.com>
References: <20210222190107.8479-1-javier.gonz@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Minwoo Im <minwoo.im.dev@gmail.com>

Keep rejecting the hidden device access via open, but allow cases
through the nvme-generic char device.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4884105ad95..0d0522bd4c2f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1885,7 +1885,7 @@ static int nvme_ns_open(struct nvme_ns *ns)
 {
 #ifdef CONFIG_NVME_MULTIPATH
 	/* should never be called due to GENHD_FL_HIDDEN */
-	if (WARN_ON_ONCE(ns->head->disk))
+	if (WARN_ON_ONCE(!nvme_ns_is_generic(ns) && ns->head->disk))
 		goto fail;
 #endif
 	if (!kref_get_unless_zero(&ns->kref))
-- 
2.17.1

