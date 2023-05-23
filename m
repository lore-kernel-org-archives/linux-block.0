Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4B8C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjEWHzi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbjEWHyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:54:35 -0400
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [IPv6:2001:41d0:1004:224b::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61760E7E
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:54:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684828420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDqXMvcGDEREr+267KKM9DNlrobYoEWDWjxq6ZGw3Lg=;
        b=EasMEymaWSUvUZuky6Q1IurOYnzfv58bj+prFV79B1kqw5Kxvxlyn2sB0NQyWD2SYP1oi3
        UVW0QlJ4G7DQyrS0ZPQ1DZz7YnOwwkmh8pJ7CzgcFROUPqIRyUxavms1Snj1Ke8QKC3ynS
        eo0UGwTihz0l8TzC3vhSy6eHdoShKoM=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 02/10] block/rnbd-srv: remove unused header
Date:   Tue, 23 May 2023 15:53:23 +0800
Message-Id: <20230523075331.32250-3-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-1-guoqing.jiang@linux.dev>
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need to include it since none of macros in limits.h are
used by rnbd-srv.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index d5d9267e1fa5..9fe7d9e0ab63 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -9,7 +9,6 @@
 #undef pr_fmt
 #define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
 
-#include <uapi/linux/limits.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <linux/stat.h>
-- 
2.35.3

