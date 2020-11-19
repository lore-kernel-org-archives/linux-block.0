Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F59C6379F
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 23:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256CD2145D
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 23:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLyRdwi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgKSX16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 18:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgKSX15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 18:27:57 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF33BC0613CF;
        Thu, 19 Nov 2020 15:27:56 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id i19so10313667ejx.9;
        Thu, 19 Nov 2020 15:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vG0la9jq/M1aNuNVjI3CB3YTuTYiHqFptMWAHHu2/GY=;
        b=jLyRdwi89tUGez6ZXP1Zywcgv/TYl9a3cfj3c82Sur0K7xQFtnLPahePEpIYWZDVdF
         7kvhQAGbvUH17EwLsLHkIZZFl0BGshnpbFpvKVJkNRq2X1aeikzGVMRhcPABOdxdMGpx
         TzCJ94gKzQqJ3B1FBH8wCMAQkDkOW5itOgxtv/NjfOBzzM7SBE9NvKbI9e7g2GnRyHrN
         95l3s4xCF8TWXAOoC/ZYStJ5sXeiw41DXYWTQvoKj9IIjYB56ePcXTw/FaIqsHwBAFjp
         YYctGqoBLXIs4wOAqrnyRWDxMPhWkXs+g55kmStCfqOt3jsWP4b3amGodWCJTJb0TD//
         yG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vG0la9jq/M1aNuNVjI3CB3YTuTYiHqFptMWAHHu2/GY=;
        b=MtMdY9427WIioUBm4ozazEJKhcnLN/5FkF9PJRuoFdENIaWEyuZYt1SXhz/u5blNAw
         OIe3LKh7UteWshh9ty7HAR45pWu9cEdOAcvcJESWk5920ija1sQpI4TKy25wfBAofO4h
         RpVe1vAtRLno8Yt2LcdL7ZJQ9g4KFgwJKcsIJ4qrpmcHITVWaYFLyjxTwL84ram/YAYu
         Wu3fmQ14jYCgOCYo45feqL0L7AXH3n4otTxCxxa8T17LktiC6RzaNztxwqloIBlwNhQP
         3pz7Bf89q7QII4WVg4v8EE5cKfhezq2a6rFy69/M3eEp/sGoN3QUT7JhMfhpv/u+J2/6
         IpKw==
X-Gm-Message-State: AOAM531zevsaea3rxDO0J3aP+v2FxUOlFlQHcLGd06UuCB0ryaMSqox4
        M0INettBwsVRrhvPq6n0dndtKKbHApMQZQ==
X-Google-Smtp-Source: ABdhPJymWkJd80yAzlT02yp+AoXi45G9dWs64mgBWGw9Jv3MS5mr+duBUJXA8o5Mvk37jtI/ITmgxA==
X-Received: by 2002:a17:906:a195:: with SMTP id s21mr29337444ejy.146.1605828474887;
        Thu, 19 Nov 2020 15:27:54 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id n3sm458114ejl.33.2020.11.19.15.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:27:54 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Date:   Thu, 19 Nov 2020 23:24:38 +0000
Message-Id: <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1605827965.git.asml.silence@gmail.com>
References: <cover.1605827965.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer spends quite a while in iov_iter_npages(), but for the
bvec case the number of pages is already known and stored in
iter->nr_segs, so it can be returned immediately as an optimisation

Perf for an io_uring benchmark with registered buffers (i.e. bvec) shows
~1.5-2.0% total cycle count spent in iov_iter_npages(), that's dropped
by this patch to ~0.2%.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 lib/iov_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..0fa7ac330acf 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1594,6 +1594,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		return 0;
 	if (unlikely(iov_iter_is_discard(i)))
 		return 0;
+	if (unlikely(iov_iter_is_bvec(i)))
+		return min_t(int, i->nr_segs, maxpages);
 
 	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
@@ -1614,11 +1616,9 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 			- p / PAGE_SIZE;
 		if (npages >= maxpages)
 			return maxpages;
-	0;}),({
-		npages++;
-		if (npages >= maxpages)
-			return maxpages;
-	}),({
+	0;}),
+		0 /* bvecs are handled above */
+	,({
 		unsigned long p = (unsigned long)v.iov_base;
 		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
 			- p / PAGE_SIZE;
-- 
2.24.0

