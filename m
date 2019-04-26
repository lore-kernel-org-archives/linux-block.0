Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1E4C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6DF206BA
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt5+uZZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfDZAVR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:21:17 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42221 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfDZAVR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 20:21:17 -0400
Received: by mail-yw1-f65.google.com with SMTP id y131so565597ywa.9
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2019 17:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AcZ92YH0X8djThbWKLrf0MusGXZCJVm/wjWNJQyN0zw=;
        b=Pt5+uZZMse7LoMU02YGfkh4V6NNM64zWc5jb9uFADxiyv+MhXQSeea4tJhtJ6ateIU
         TjfIQ6AUYy80Fv714H8biQFs+ucUtcbeBPvuz1MywCKx4dsOPMz4uC3V9ieyDXvmz1Sn
         h5phx3a+1q72UokLDxMmnSrrL2lch65anF6vhF3VoMkSdfPx6vg6mgQobLFVap7mUjIo
         57OC4A9R7JSvnbRZrNfEKM4TglkzXhq6bj5n9qa7EBfUhqtJ5VUOVaFcbkzO2LJoaFNS
         spF38xpGDA7T22sds3WQJssi3Z3sars1obRiC9DlffwiSN59xy/51ce9t6Xx9ffLchI0
         5S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AcZ92YH0X8djThbWKLrf0MusGXZCJVm/wjWNJQyN0zw=;
        b=jlIhG8Au3h83Q1mEsTXad6dO8xyyVWs7qlYWIIa2GaO+uI8g8+FtJMFS6t0i+F1Dr4
         kTCItKNGrpfWwgtYcmrQwQMtS+ZC5bhYX9/E1Jc/rmgYuQZV5DHrz9DzVBsIGzVrYi/q
         8o9pVTGe+auy+3PUImw0L5nl5HQ3pI0r1F2Cg4pRJirTw5FltEAU1rYbe2DmEwjHxTj+
         2KV8fkCAg8DGnRviiIQ+dk4AG5Pg5TnMjOEY5RCE6ngOCJmZjlALTL+kDBNjWlrgcAjL
         mOIanYvfhN9X6YXkbfvmtfaJIqA/1o4TciDTMitoDeAichpnBEwt6AJkcZClBHi+aJ6v
         +Yyw==
X-Gm-Message-State: APjAAAXbwfUpKgwFEtD6rl5oHZG4eMvcovcGx3cwSoDK0p5vuoX2ghcK
        A13ucOFDHqEyh7iGiZVcdl3eCDr7
X-Google-Smtp-Source: APXvYqzqvHdaCYxCvoGRQIvKuzAd5308rO5l0Ekt+Tuq+WnwjTRHY+VJG9ytl+Uiqfq5csIFwXYFOw==
X-Received: by 2002:a81:4cd5:: with SMTP id z204mr13469334ywa.318.1556238076159;
        Thu, 25 Apr 2019 17:21:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::5484])
        by smtp.gmail.com with ESMTPSA id 193sm8022184ywf.22.2019.04.25.17.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 17:21:15 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 1/5] blk-stat: rename batch to time
Date:   Thu, 25 Apr 2019 20:20:46 -0400
Message-Id: <20190426002050.15499-2-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
References: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
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
index 696a04176e4d..8a40ac719ba7 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -21,7 +21,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
 	stat->max = stat->nr_samples = stat->mean = 0;
-	stat->batch = 0;
+	stat->time = 0;
 }
 
 /* src is a per-cpu stat, mean isn't initialized */
@@ -33,7 +33,7 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->min = min(dst->min, src->min);
 	dst->max = max(dst->max, src->max);
 
-	dst->mean = div_u64(src->batch + dst->mean * dst->nr_samples,
+	dst->mean = div_u64(src->time + dst->mean * dst->nr_samples,
 				dst->nr_samples + src->nr_samples);
 
 	dst->nr_samples += src->nr_samples;
@@ -43,7 +43,7 @@ void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
 {
 	stat->min = min(stat->min, value);
 	stat->max = max(stat->max, value);
-	stat->batch += value;
+	stat->time += value;
 	stat->nr_samples++;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 791fee35df88..df24baf455c2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -446,7 +446,7 @@ struct blk_rq_stat {
 	u64 min;
 	u64 max;
 	u32 nr_samples;
-	u64 batch;
+	u64 time;
 };
 
 #endif /* __LINUX_BLK_TYPES_H */
-- 
2.17.1

