Return-Path: <SRS0=ez2/=VO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110F2C76192
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 15:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF452173E
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 15:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mHNIGMlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfGQPEw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:04:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37661 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfGQPEw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 11:04:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so10976215pfa.4
        for <linux-block@vger.kernel.org>; Wed, 17 Jul 2019 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=4bWQku+DKq7mSVR+SXG0zsuNfqnseyl4FatutbVmxX8=;
        b=mHNIGMlVXPohlvgwplh0m8x1ZEH/cRfieROHK6jYxyIYs1bs2qoZIVRzgMSp5aToMs
         17L3LNhjuaEVBYBgyVLX4tPHhO9koi913bRUDefAHQe3DUbAukbYzFl5B1i4G42LWsM+
         L83imyn7dVP+LlYCgImo96l4dfgJ6/8hN7gidvbRQG6ZnNjVqb+VXjDNg5ziqBiqz8Xr
         V+6D80LE4dNWZn8mql3Yxx3JJJE3u4zHjjkr2xCfCqfxZOPcK2awZx10zfgM24tAITmp
         3zGCoCB0poVvTStEfkkLDVAEazQzUGL/5MK3wey+QQTkoPB3X6d2YEKnHsEP/T+SnwoX
         q+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=4bWQku+DKq7mSVR+SXG0zsuNfqnseyl4FatutbVmxX8=;
        b=H4cr0czajZQQPjjBeJtUJYOMN0cee8k7qERYU6HGM22LrB1C4NmnLFIxzhEPam6lk+
         UOLsOCtc5gMcDEAWouN60tvV/hBpOTsVD1z53zMgWIyaEALcuebqIhg/nbsRsblv1Hll
         7x2sHSpdS07b6kSflJBwI+lPRh6K9Xx6f19TImnu9nnjWmgCg0jcLTbds+zgUPRvwDoc
         GaPRTIiW9qIjBKV6QyMflwom6MIbo+hBU6qgUnm1UotG98vpRn1WQvD5oUG4EszAwaIK
         lUWGZ3iDXEzASaHbMDy1GlUNh8Hlnh3NoaBhjxMC6O1CSUM8bIMhapYj7muoLtd5fMte
         lgtg==
X-Gm-Message-State: APjAAAX0AlOVYVZXc7vjcAcd5xiWW8R/sYWJtzA1R0ohRbPSX9t1AI6U
        08SxzhBr6+O82tLcsdVRGHFZPFSwCo4=
X-Google-Smtp-Source: APXvYqwtsZAFvPLqpcxg6fE55RoXgTzaQq5FZcFcN6x+7k+/0CyZoXS3/nWoYFmDnCJ2QP6Bs/iOjg==
X-Received: by 2002:a17:90a:1ae2:: with SMTP id p89mr42220135pjp.26.1563375891131;
        Wed, 17 Jul 2019 08:04:51 -0700 (PDT)
Received: from x1.localdomain (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id o35sm14112299pgm.29.2019.07.17.08.04.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 08:04:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Filipp.Mikoian@acronis.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] blk-mq: allow REQ_NOWAIT to return an error inline
Date:   Wed, 17 Jul 2019 09:04:44 -0600
Message-Id: <20190717150445.1131-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717150445.1131-1-axboe@kernel.dk>
References: <20190717150445.1131-1-axboe@kernel.dk>
Reply-To: "[RFC PATCHSET 0/2]"@vger.kernel.org, Fix@vger.kernel.org,
          O_DIRECT@vger.kernel.org, blocking@vger.kernel.org,
          with@vger.kernel.org, IOCB_NOWAIT@vger.kernel.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

By default, if a caller sets REQ_NOWAIT and we need to block, we'll
return -EAGAIN through the bio->bi_end_io() callback. For some use
cases, this makes it hard to use.

Allow a caller to ask for inline return of errors related to
blocking by also setting REQ_NOWAIT_INLINE.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c            | 9 +++++++--
 include/linux/blk_types.h | 5 ++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec680e84..ac827e7e3bbe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1960,9 +1960,14 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	rq = blk_mq_get_request(q, bio, &data);
 	if (unlikely(!rq)) {
 		rq_qos_cleanup(q, bio);
-		if (bio->bi_opf & REQ_NOWAIT)
+
+		if (bio->bi_opf & REQ_NOWAIT_INLINE) {
+			cookie = BLK_QC_T_EAGAIN;
+		} else if (bio->bi_opf & REQ_NOWAIT) {
 			bio_wouldblock_error(bio);
-		return BLK_QC_T_NONE;
+			cookie = BLK_QC_T_NONE;
+		}
+		return cookie;
 	}
 
 	trace_block_getrq(q, bio, bio->bi_opf);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index feff3fe4467e..1b1fa1557e68 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -311,6 +311,7 @@ enum req_flag_bits {
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
 	__REQ_NOWAIT,           /* Don't wait if request will block */
+	__REQ_NOWAIT_INLINE,	/* Return would-block error inline */
 	/*
 	 * When a shared kthread needs to issue a bio for a cgroup, doing
 	 * so synchronously can lead to priority inversions as the kthread
@@ -345,6 +346,7 @@ enum req_flag_bits {
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
+#define REQ_NOWAIT_INLINE	(1ULL << __REQ_NOWAIT_INLINE)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
@@ -418,12 +420,13 @@ static inline int op_stat_group(unsigned int op)
 
 typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE		-1U
+#define BLK_QC_T_EAGAIN		-2U
 #define BLK_QC_T_SHIFT		16
 #define BLK_QC_T_INTERNAL	(1U << 31)
 
 static inline bool blk_qc_t_valid(blk_qc_t cookie)
 {
-	return cookie != BLK_QC_T_NONE;
+	return cookie != BLK_QC_T_NONE && cookie != BLK_QC_T_EAGAIN;
 }
 
 static inline unsigned int blk_qc_t_to_queue_num(blk_qc_t cookie)
-- 
2.17.1

