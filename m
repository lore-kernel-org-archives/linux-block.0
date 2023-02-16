Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81515C64ED6
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 15:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBPPT0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 10:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjBPPTZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 10:19:25 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEDE93FA
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 07:19:24 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id f8so241099ioo.0
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 07:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/F3fWfMedxCdmHWDLO4jWxLDIXa+8W9/VD2h3x3YdLE=;
        b=n7NMQgUwwQ2lV3+N2KcdRGMX7e7mSpP5B+MqazTTWnq/qyDn7uAr5jVX1N91P2oV1a
         aIzr56pwYXFNBbz3xNrroizN63sx+BAovpMsQf2E8+VbgTNcIY9O3h0qQsIgg+qTL/kq
         CM/3S/ePYMOUBfdfZy0CVo+WlZZAlE6MilxcE3dYVQfDvgOtSo59LbSvh439ztwBfwMc
         mIN1Z+UB5S314OynuIlbE710Ym89tznIOp3M+3YuTcOPWkjagv2KZcB1np7Ez6WXS6KV
         dr2cJkRbe0mu+zi54KEp6kVkoRMDVzCzW3PmZiEIBvl+YouT9JiF7/lQahoBiXyfIUt6
         0PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/F3fWfMedxCdmHWDLO4jWxLDIXa+8W9/VD2h3x3YdLE=;
        b=GwLmbyf2RE2D6b++TaAZ8QFql0FLQaEDVDrtUYDSCLIA14kt1WkRbLdAgbeavVjWTe
         meGzpVESHtd6i3fFdCmwDtS0d0330bGQ6w+O70pPvNVb1ND4fQMi4JFxmK63AcNEvdKO
         wAR7GbX0CW2YrE1kWcR+qdqLRU0B8DGiguzPI2NtdCv4HFde7XL0Sp/aW5P66WJ1cj6P
         b/p/k4vw43eLLAYus1e3/bBzQIEODxdJGCulXcqnPaFIT3SL/qcU7ARzHjBskPbBiva8
         NTG4BKU+Vyj/3/V57NF6mMOXxheH4W99prsR4MuGAan7MHXnpDZ+VbSr6FoZG83eg9BU
         V5Cg==
X-Gm-Message-State: AO0yUKV604kybvKUy6XGusVOYWNaMzPtgj3GCycwn6oqbHS1jrDqYtFN
        4HBU+jjqTj4z/gpyK9yFhaG2B2yroJSaBuLH
X-Google-Smtp-Source: AK7set9LWTTzjD5GXy/p4+RQKI/uf/IChRvuK1DjWxxfbFY+Fi743xVLaKmgmrmeLMb5DAgnWuzd7A==
X-Received: by 2002:a05:6602:2ac8:b0:740:7d21:d96f with SMTP id m8-20020a0566022ac800b007407d21d96fmr4855169iov.1.1676560763243;
        Thu, 16 Feb 2023 07:19:23 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p10-20020a0566022b0a00b006e2f2369d3csm561600iov.50.2023.02.16.07.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 07:19:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>,
        stable@vger.kernel.org
Subject: [PATCH 1/4] brd: return 0/-error from brd_insert_page()
Date:   Thu, 16 Feb 2023 08:19:15 -0700
Message-Id: <20230216151918.319585-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216151918.319585-1-axboe@kernel.dk>
References: <20230216151918.319585-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It currently returns a page, but callers just check for NULL/page to
gauge success. Clean this up and return the appropriate error directly
instead.

Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/brd.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 20acc4a1fd6d..15a148d5aad9 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -78,11 +78,9 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 }
 
 /*
- * Look up and return a brd's page for a given sector.
- * If one does not exist, allocate an empty page, and insert that. Then
- * return it.
+ * Insert a new page for a given sector, if one does not already exist.
  */
-static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
+static int brd_insert_page(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
 	struct page *page;
@@ -90,7 +88,7 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
 
 	page = brd_lookup_page(brd, sector);
 	if (page)
-		return page;
+		return 0;
 
 	/*
 	 * Must use NOIO because we don't want to recurse back into the
@@ -99,11 +97,11 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
 	gfp_flags = GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM;
 	page = alloc_page(gfp_flags);
 	if (!page)
-		return NULL;
+		return -ENOMEM;
 
 	if (radix_tree_preload(GFP_NOIO)) {
 		__free_page(page);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	spin_lock(&brd->brd_lock);
@@ -120,8 +118,7 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
 	spin_unlock(&brd->brd_lock);
 
 	radix_tree_preload_end();
-
-	return page;
+	return 0;
 }
 
 /*
@@ -174,16 +171,17 @@ static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n)
 {
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
+	int ret;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
-	if (!brd_insert_page(brd, sector))
-		return -ENOSPC;
+	ret = brd_insert_page(brd, sector);
+	if (ret)
+		return ret;
 	if (copy < n) {
 		sector += copy >> SECTOR_SHIFT;
-		if (!brd_insert_page(brd, sector))
-			return -ENOSPC;
+		ret = brd_insert_page(brd, sector);
 	}
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.39.1

