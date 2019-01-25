Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F795C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 07:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFA9218D0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 07:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EEf22r2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfAYHfF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:35:05 -0500
Received: from condef-03.nifty.com ([202.248.20.68]:44509 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfAYHfF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 02:35:05 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jan 2019 02:35:04 EST
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-03.nifty.com with ESMTP id x0P7OMO7031509
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 16:24:22 +0900
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x0P7NrIe018208;
        Fri, 25 Jan 2019 16:23:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x0P7NrIe018208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548401034;
        bh=Z/++O0uH9aXyE0dKkwp/Ew71RM7jlqo9SoheGBRqJgM=;
        h=From:To:Cc:Subject:Date:From;
        b=EEf22r2WEx9eQBmsyiukWO8T3/rlkl263MeTIJ6wIrdKdOe6IBoRIb8Sqm0CJ6Fjr
         cpjNmqNInxLtyqQw4TsHQEeKQOOAhICRyFa2ZyVvI/zgAaZ+7PqM1fS25EOVHwItuA
         Y1pWW70q3o4QgKHloK6G+QHWwhwhyB3bz3ECVPHAXV2PnwNi+TrOVy5+w1QzKWN/2W
         hGPtWerpibP+iMFWYrs2ea0W0tOQx+Tvf1tNl1H0+wosN8lO7vW/wSNqWT4YOQEHx5
         e8jBjlsb9ztqzwtWHT7ACCeaH57R+st7o5Vn6FKAshZkrW304+9hd8vdPTxMFyQuK5
         AxYPozNNXEhWw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: pblk: fix TRACE_INCLUDE_PATH
Date:   Fri, 25 Jan 2019 16:23:50 +0900
Message-Id: <1548401030-28860-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As the comment block in include/trace/define_trace.h says,
TRACE_INCLUDE_PATH should be a relative path to the define_trace.h

../../drivers/lightnvm is the correct relative path.

../../../drivers/lightnvm is working by coincidence because the top
Makefile adds -I$(srctree)/arch/$(SRCARCH)/include as a header
search path, but we should not rely on it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/lightnvm/pblk-trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
index 679e5c45..9534503 100644
--- a/drivers/lightnvm/pblk-trace.h
+++ b/drivers/lightnvm/pblk-trace.h
@@ -139,7 +139,7 @@ TRACE_EVENT(pblk_state,
 /* This part must be outside protection */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH ../../../drivers/lightnvm
+#define TRACE_INCLUDE_PATH ../../drivers/lightnvm
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE pblk-trace
 #include <trace/define_trace.h>
-- 
2.7.4

