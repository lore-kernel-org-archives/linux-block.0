Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109CCC04EB9
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13112145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P4jNQATX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13112145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeK3MUL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:20:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41423 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeK3MUK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 07:20:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so1914545pfi.8
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 17:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/BkC37cR1BMAuLA3V/wheSuC8+j44tyzekubWlTVNpI=;
        b=P4jNQATXG1Prp032p2SjvXDRmy2lrykiWSTY28cOMfr9lPMydgIkrARobvl6/5WTIW
         77cU8XXOHox+utu2Xcr7nh5EhX1ecLEp84aNn9LhCNxVTvlrzfzg8NowSv91IfYYYjgR
         7Tg8QvtncJFm2hXwaqTLsJc1rvQcxHpb+3O9K9vSwebHG6+zeYKA17yu7a5GrMohg1GL
         pCewvG4QJnJOnm1+FnZ/XmhsKbS0Q2GpjfwOrcwowZRm0cDrA2RI8bSQwwo0pMXX6ZqU
         yBiiQtmaYXPfl0kBiEJWShZShLYFSAMp0dTbGahC7bCMiPXu4ukg5UR/hVqv+wdYF4gv
         dtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/BkC37cR1BMAuLA3V/wheSuC8+j44tyzekubWlTVNpI=;
        b=S2mJyc+nALeQZkts9dVbullK0cCfvCU4zN3NFvxz+M4r/y//s3G1+mG154GfUCUbNp
         qsm6PBm7U/AQoZIVUvFhUyWnkTC5NXz5CleGy9JgGS7ZkuysbKnfHWqjj2e0m40qY+io
         Ho8vavU8B7q52UBpuuFuqLEQsv4AK4w/nSSgPzhNqS8zrvWWw1JIt6J3Z+I7w/a7FpFn
         I5xEybW+9rhMyxMWXhgdKyjIv/xSzvPFikSSwvEyn+lTfjBaxutgjtjjgtMB2CXGvZLr
         PE9h2zmGacdS+y75P8HU40etDt7Q8LO4tz9Vp7638Rar5HnWZmD+tAfuCJyi2O6C5np3
         xh/w==
X-Gm-Message-State: AA+aEWa4xGiF2bXDrlEF9N0hMyDkNlfsGWN+e/IKSL1kLc9f6Fse0NuX
        OgXS9sDpROPWzKkkCyHg764y04Spt0U=
X-Google-Smtp-Source: AFSGD/VfjGXOZ0vx0q2vBnTBXcY2gCBn56c9acSYPDadX54A7CWxPCPYeZWocRz9ydB+36fiZ3hXlw==
X-Received: by 2002:a62:56c7:: with SMTP id h68mr3830421pfj.134.1543540360738;
        Thu, 29 Nov 2018 17:12:40 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm4841749pfn.94.2018.11.29.17.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 17:12:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, osandov@osandov.com
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] sbitmap: ensure that sbitmap maps are properly aligned
Date:   Thu, 29 Nov 2018 18:12:32 -0700
Message-Id: <20181130011234.32674-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130011234.32674-1-axboe@kernel.dk>
References: <20181130011234.32674-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We try to be careful with alignment for cache purposes, but all of
that is worthless if we don't actually align the maps themselves.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/sbitmap.h | 11 ++++++++---
 lib/sbitmap.c           |  7 +++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 804a50983ec5..5cb1755d32da 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -63,9 +63,14 @@ struct sbitmap {
 	unsigned int map_nr;
 
 	/**
-	 * @map: Allocated bitmap.
+	 * @map: Aligned allocated bitmap.
 	 */
 	struct sbitmap_word *map;
+
+	/**
+	 * @map_ptr: Originally allocated map pointer
+	 */
+	void *map_ptr;
 };
 
 #define SBQ_WAIT_QUEUES 8
@@ -157,8 +162,8 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
  */
 static inline void sbitmap_free(struct sbitmap *sb)
 {
-	kfree(sb->map);
-	sb->map = NULL;
+	kfree(sb->map_ptr);
+	sb->map_ptr = sb->map = NULL;
 }
 
 /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 45cab6bbc1c7..21e776e3128d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -25,6 +25,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 {
 	unsigned int bits_per_word;
 	unsigned int i;
+	size_t size;
 
 	if (shift < 0) {
 		shift = ilog2(BITS_PER_LONG);
@@ -52,9 +53,11 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return 0;
 	}
 
-	sb->map = kcalloc_node(sb->map_nr, sizeof(*sb->map), flags, node);
-	if (!sb->map)
+	size = sb->map_nr * sizeof(*sb->map) + L1_CACHE_BYTES - 1;
+	sb->map_ptr = kzalloc_node(size, flags, node);
+	if (!sb->map_ptr)
 		return -ENOMEM;
+	sb->map = PTR_ALIGN(sb->map_ptr, L1_CACHE_BYTES);
 
 	for (i = 0; i < sb->map_nr; i++) {
 		sb->map[i].depth = min(depth, bits_per_word);
-- 
2.17.1

