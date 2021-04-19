Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB32C43462
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A79A61221
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhDSHiU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbhDSHiT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EBCC061760
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i3so13745406edt.1
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4UM9nmnedCsNvLF6PWr9uH8F58/UWSesStUgueFg/I=;
        b=OfbsbqZS7Il7HiyLxwoJh45Pd3DvchCW37i1aAKsH5LnCberjo2Z297kp2AE59rSBZ
         uGQ0OGp8lV2Z1kuhOhcLz4AQjGRMCpO4bclfx2z/Xa2YgyqGl+3BFNIhyab7eQE29bPy
         vrjk95PBOHEjMepVd9aj2/cFOLAV4G1O0dlfKgH+GxQ93mz1rYpecwObxA60SJfvDbTk
         8wZ1jKUfdcvpb1h46wF8oZMklBr9sypLy7/yY0yNBiyxgYcRYNRUaHkv8dzXMpZiUgDy
         0YMvG5E2Wbn/jvTQnRvsW85bA8IaHH9/lxGxLowSz4L9MZWAEjuvBNI+BIrhG5CkKYf5
         nswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4UM9nmnedCsNvLF6PWr9uH8F58/UWSesStUgueFg/I=;
        b=bb7T/WBolVUSjcGiOMfVRsYV0R7iaxVNEoHVHhb2AFPCnUsodl3RISD8KQLJEYsSRo
         ENGfQ0EDBOkMD8xCLcdRCGBJW2JoRCblS/ulHm3nrvhTWl9OgJUv2YnMDjNya7CNeort
         gXCYux7l1t6bLiKSliMxqgJ+RJf85ZGOatkoTkhVBddn0BsDlzuzWAZ5A8fYOJ7fyJjd
         hacEhtRqRAkLlual4Z1RMPEUV2YhQmCB4Ojn89VHj55VNOmPU9+sixVlh4YDwTo1e/de
         RrYbDjA0VHuAd1gYAKPZ/fVzXrb/e2qmKfh93vJMvXJH/WZIgjPt3Zl592ahRCu2Npzv
         p3+A==
X-Gm-Message-State: AOAM531Mwgtgeepx1eblTK5DCGKMgx9qOX9LHHTLH2d8C8GLo8VEp27J
        B22uTB7M0Qe/OjLU5W61dBcUcAMN2BKkUCuJ
X-Google-Smtp-Source: ABdhPJz4Gu/lJVVq+o55nf6hAxkrdBhd6ai1pNvefHrF0R/2cActSp4BEgeSroyqW8Z66R14kwK8WA==
X-Received: by 2002:a05:6402:350:: with SMTP id r16mr16482943edw.227.1618817868709;
        Mon, 19 Apr 2021 00:37:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:37:48 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv5 for-next 01/19] MAINTAINERS: Change maintainer for rnbd module
Date:   Mon, 19 Apr 2021 09:37:04 +0200
Message-Id: <20210419073722.15351-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Danil Kipnis <danil.kipnis@cloud.ionos.com>

Danil steps down, Haris will take over.
Also update email address to ionos.com, the old
cloud.ionos.com will still work for some time.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Acked-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf947775390c..723ba354dce6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15358,8 +15358,8 @@ N:	riscv
 K:	riscv
 
 RNBD BLOCK DRIVERS
-M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
-M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
+M:	Jack Wang <jinpu.wang@ionos.com>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	drivers/block/rnbd/
-- 
2.25.1

