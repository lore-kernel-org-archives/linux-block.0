Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E2C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 22:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2DB2075B
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 22:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds2nI03B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfE2WHn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 18:07:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37315 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2WHm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 18:07:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so2576891qkl.4
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8lI5v1l3QAFtKlWKrildo5Iz9QoKYi26RMiSvdX15c=;
        b=ds2nI03B3eQ8kzh40sjLNa+b37X0EYYyVIX6GvId7Z4vmhXApVClnPMS1ugp+GtIq5
         kwfVuaJiWEilljDvIHFMmNqDncnyjYnbc+lqQfZZWr/h629FmldRWjIk0BXl+hU4mt5L
         Igi4VZzQs/F4Qy1rGXhy8klIlxrDdWKcZYRJ/TTta9fXpvB8bsBSkHgclHI7NecY1jpa
         istd41R0so6xxDYUjVGo7nJQ4pjApC74Ms9YNWN+FV7wzEwAO/lVL8S23jlfZysnTD+3
         5xd4l7V6iWAR5hXCHdVNGnl3RN38bGlFsuC0+em9ARmt6Pex5/bVzlUkEjzF7IdrFHHx
         F1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8lI5v1l3QAFtKlWKrildo5Iz9QoKYi26RMiSvdX15c=;
        b=sXezdAPqdEs0Z2jiYHjJ7LAYfNTdpI8FvwRFXrmtsoPDWbEGAKYEzqSi6YGjjpSisi
         hV4pB29GQ0IKSVqC5LSbr63fVzMlfmRIA0oZ/PzIhtJ/N7ahz4bLCo/kWEM+Wn276GLF
         SrCmYA+YFD8JfKTcKH6PmkPigV5bqfQS7HynIB6NKPjxMXm+0NDotgpxYvNSW9+zM0az
         rv5pOItnX7nyxy2OZESN0UIWR0azIPMW7m7JgDYmISdF6ZihAgSg6GDiRwviOTdHelM3
         UHktsZIQRBkbjP27wNiyA1Mnk9NcpJgsZonCTVI3CxMUX9+LOc409McL/ATQ9Jyp9jsH
         ea5w==
X-Gm-Message-State: APjAAAUP78+MvtnG4wK4AWzRn1z5guGGugahpwXCNHqQHU2C2TvozUH+
        HJK3AlH9m1N6sn9T+hsOOOUDy5s9
X-Google-Smtp-Source: APXvYqwH3bzYtR8qlAIZHbbS4Ab8Xj+/GjZl9I2r8vuD2JgqyNm3LbHQ8djioOxXwcTWQAoufq4q9w==
X-Received: by 2002:a37:9ac9:: with SMTP id c192mr176872qke.30.1559167661425;
        Wed, 29 May 2019 15:07:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:60e4])
        by smtp.gmail.com with ESMTPSA id q2sm511313qkm.39.2019.05.29.15.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 15:07:40 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, jbacik@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 1/5] blk-stat: rename batch to time
Date:   Wed, 29 May 2019 18:07:26 -0400
Message-Id: <20190529220730.28014-2-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
References: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

Batch isn't at all related to what it's actually used for, which is the
running sum of time spent doing IO.  Rename it to time so it makes
logical sense.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-stat.c          | 6 +++---
 include/linux/blk_types.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 940f15d600f8..1529f22044bd 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -22,7 +22,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
 	stat->max = stat->nr_samples = stat->mean = 0;
-	stat->batch = 0;
+	stat->time = 0;
 }
 
 /* src is a per-cpu stat, mean isn't initialized */
@@ -34,7 +34,7 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->min = min(dst->min, src->min);
 	dst->max = max(dst->max, src->max);
 
-	dst->mean = div_u64(src->batch + dst->mean * dst->nr_samples,
+	dst->mean = div_u64(src->time + dst->mean * dst->nr_samples,
 				dst->nr_samples + src->nr_samples);
 
 	dst->nr_samples += src->nr_samples;
@@ -44,7 +44,7 @@ void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
 {
 	stat->min = min(stat->min, value);
 	stat->max = max(stat->max, value);
-	stat->batch += value;
+	stat->time += value;
 	stat->nr_samples++;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 95202f80676c..6406430c517a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -442,7 +442,7 @@ struct blk_rq_stat {
 	u64 min;
 	u64 max;
 	u32 nr_samples;
-	u64 batch;
+	u64 time;
 };
 
 #endif /* __LINUX_BLK_TYPES_H */
-- 
2.17.1

