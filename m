Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E014C7C7E0
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBBF2087E
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="vsDvwOEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgD0Hml (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgD0Hml (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 03:42:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A936FC061A0F
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 00:42:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v8so15256991wma.0
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2ueFYfJbnvHeCjbZWouiTCT/5yxNTxRW64HSkOHS6k=;
        b=vsDvwOEJ4ADtwAftYHFSGr7eBIujIoTjebnwYye1XpqKCZSfYnAOH7Cf97R/2uLbnb
         JBWFiDcW1XLYhlp3+3xx6qpbdMCcCzISQUNLQn5V5r5eVxUwEDL7jeBGpQMzPcWpI+S5
         D9Au/BHAZkiwzA/a+CYZBYvVx0yLdfpxoXubCjvQAUcxc/0iYSGepnCTGTQtx0fj/YPM
         3xcF1tgHw8rbdb5u8fz0PjvwmjumdZu+YXalSfKfb+PRtbXJYLUPtR8zgzeGUT/bA4UE
         QNhsXd0HnLuSuR0NAWfTfJJ9NBzya/1L9ejLH/TzbGP/g6yQfD6LTLRvV2lp4a/FFgXc
         ydQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2ueFYfJbnvHeCjbZWouiTCT/5yxNTxRW64HSkOHS6k=;
        b=Bqe4jsMEW/rgnpOLoeNQNJQZdHMumWtlFlQIWu6iGPvO3Ew3GwBoxE2AFVPmBzHOAl
         kOkfwWligVC69ciV6kpJSdmmLyhBzJ9mzPTev7UnKTiwAUihhlQmAKVoJp3pBY3h/JyV
         f1GfBdD3FQobJk2vHdGrP5KmCOI1UOg7hwMJEfZd2AyoaGunvEOcpiOTOwiLggGrHo5r
         E/sFmWNAkI7w4dbjL7E0xZL/Zhdlm/UHtfaIzlgXB+lYeTXHtgUtTvvo4SgdOMGQt2Ii
         kVCb9l8C2vuI95Y5U78XE7Lb6u53Nu4aXt9PcMXyaMKBSKrNCmZhHvVaR/k3QklzpFwu
         0i3A==
X-Gm-Message-State: AGi0PuaGPnRJMDazjmFsqClzz4ri4FxHTPFKT6GSymw1QeWVVsc/y+rq
        L1rgeblnXfWk6F59NI3gVOKw9g==
X-Google-Smtp-Source: APiQypLAVK+627PiCW2wwBfbRkTRj2/fkVJ1Yx3bN4CYoMqpPxAa2E0f2Q6Ce/yiBmIBM5BPj0wBZQ==
X-Received: by 2002:a1c:96c6:: with SMTP id y189mr26153350wmd.106.1587973359410;
        Mon, 27 Apr 2020 00:42:39 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id x132sm15091658wmg.33.2020.04.27.00.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:42:38 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v3 5/9] loop: Remove figure_loop_size()
Date:   Mon, 27 Apr 2020 09:42:18 +0200
Message-Id: <20200427074222.65369-6-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200427074222.65369-1-maco@android.com>
References: <20200427074222.65369-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function was now only used by loop_set_capacity(), and updating the
offset and sizelimit is no longer necessary in that case. Just open code
the remaining code in the caller instead.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d0f17ee1e29b..d9a1a7e8b192 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -259,26 +259,6 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
 }
 
-static int
-figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
-{
-	int err;
-	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-
-	err = loop_validate_size(size);
-	if (err)
-		return err;
-
-	if (lo->lo_offset != offset)
-		lo->lo_offset = offset;
-	if (lo->lo_sizelimit != sizelimit)
-		lo->lo_sizelimit = sizelimit;
-
-	loop_set_size(lo, size);
-
-	return 0;
-}
-
 static inline int
 lo_do_transfer(struct loop_device *lo, int cmd,
 	       struct page *rpage, unsigned roffs,
@@ -1566,10 +1546,21 @@ loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
 
 static int loop_set_capacity(struct loop_device *lo)
 {
+	int err;
+	loff_t size;
+
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+	size = get_loop_size(lo, lo->lo_backing_file);
+
+	err = loop_validate_size(size);
+	if (err)
+		return err;
+
+	loop_set_size(lo, size);
+
+	return 0;
 }
 
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
-- 
2.26.2.303.gf8c07b1a785-goog

