Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF4EC43217
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738D1610CC
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhJIM2c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 08:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhJIM2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 08:28:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5D8C061570;
        Sat,  9 Oct 2021 05:26:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k7so38057755wrd.13;
        Sat, 09 Oct 2021 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvPx8lZAWyHDeejaspcE8O05AFHduIeFac/IHHVZ+NY=;
        b=Ob+CtPivfLbryyTc3OWjMUHPC8fmy15GQtK5cE+lTSzNQTDfkbJeVa1z8bd/I5lKsV
         eX8DNR37fuK8It3nxcDsUT8fYf6qxvwWaxNP/o2oMFndRbUg9tRadMC1vH74XBUbKGdl
         JSbL3tMs/Y3D7Y2Umh9i5EarZWk0Qe+Yw99E60Hsgqhhm3JgADNl4z7fDnPqVq7yCC9R
         y6y4BNvxnBFFUpa9Y43rV5VdowFostf+P2DdcLm+pCV+H9KUTmtxZrpINoKTHpuyU8gv
         rB7fiHrsddEBXZNt44GWBOf9MnRKJCpTg1wvQLeKXR3OuX6PVgaL3Lku1RlQ0tlGE5BK
         Sing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvPx8lZAWyHDeejaspcE8O05AFHduIeFac/IHHVZ+NY=;
        b=r97UXRQJxYg+cfMjSa8JvsPHz+Tixrm4HVc1D/2/Z7Q0eAe9V1ZkpZLMLcY3+EmeMG
         n37i0dO6UlR/VEE0GOyE/0T6p0MxCloHoon8wVpjABk32GzPUf/hKMP1aXNThs1UlTJm
         AEzgdDEuDGDldFebZ/MtOJAd0ZCpHlS0y71jfFFayRhOMgOLyRSc8s/sn9rrPhe6uaEP
         8pM9s2WIQwEGXQSZWOBHYgoEU8AWg/4yGxq21b2d6ok5qLFXNiI4id/qxI9A1YyM78Jp
         ywZuWWJUs2/ePipZZqPDSW1dLTm81DAw/pPU+s0QWWY8+vJfbm4h2VzXcBcsohOPX8Yu
         it1Q==
X-Gm-Message-State: AOAM533pvMrU6EXSrtgHQHbadigMbSdTmgdQRBAbCZrFomoZc9BIObgG
        3UH6y/+HS1kIQX33QvfNP5xdHRwGqdU=
X-Google-Smtp-Source: ABdhPJyP9iHPJrjMXhzMc/NvIXnQnJyJbiEI+pZenh3603+4fOQe2WsGm1YjdwC32u4F9ylg2L8NDg==
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr9221840wmq.151.1633782392162;
        Sat, 09 Oct 2021 05:26:32 -0700 (PDT)
Received: from localhost.localdomain ([85.255.236.155])
        by smtp.gmail.com with ESMTPSA id o12sm2157468wrv.78.2021.10.09.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 05:26:31 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCH 3/6] blk-mq: optimise *end_request non-stat path
Date:   Sat,  9 Oct 2021 13:25:40 +0100
Message-Id: <908aa33b09e1fd6afa14caa719684121f380be71.1633781740.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633781740.git.asml.silence@gmail.com>
References: <cover.1633781740.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We already have a blk_mq_need_time_stamp() check in
__blk_mq_end_request() to get a timestamp, hide all the statistics
accounting under it. It cuts some cycles for requests that don't need
stats, and is free otherwise.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9430a0def2c9..c3da521efd35 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -584,12 +584,11 @@ static inline void __blk_mq_end_request_acct(struct request *rq,
 
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
-	u64 now = 0;
-
-	if (blk_mq_need_time_stamp(rq))
-		now = ktime_get_ns();
+	if (blk_mq_need_time_stamp(rq)) {
+		u64 now = ktime_get_ns();
 
-	__blk_mq_end_request_acct(rq, error, now);
+		__blk_mq_end_request_acct(rq, error, now);
+	}
 
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
-- 
2.33.0

