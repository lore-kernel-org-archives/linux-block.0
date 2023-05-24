Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA1DC7EE23
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 07:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbjEXHBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 03:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239573AbjEXHBJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 03:01:09 -0400
Received: from out-32.mta0.migadu.com (out-32.mta0.migadu.com [IPv6:2001:41d0:1004:224b::20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E5E4F
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 00:00:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684911648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvnWevgbNnqrb0ljh0IcRUEtPuY+r04BEZRVZgLcmkM=;
        b=vxSl+5YKtU3QICidTa37drKXWEln2msuu/TRbUGWZs3Dy5jjp+asdpurl00zx71mEXQOu2
        4paNYf6znLhvaij84Rvnqdt/Vp8r9PueogRi5FCGxzUPzfp8QQawN6DLuoH7us8QrIJL9d
        /rpC8K5KMUqM6fViDCfRdT8WCPSw4dE=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2 2/8] block/rnbd-srv: remove unused header
Date:   Wed, 24 May 2023 15:00:20 +0800
Message-Id: <20230524070026.2932-3-guoqing.jiang@linux.dev>
In-Reply-To: <20230524070026.2932-1-guoqing.jiang@linux.dev>
References: <20230524070026.2932-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need to include it since none of macros in limits.h are
used by rnbd-srv.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
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

