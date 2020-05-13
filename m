Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E927C2D0FA
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5427822384
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="eGCVZxVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbgEMNjs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 09:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388071AbgEMNi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 09:38:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2F4C061A0F
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:38:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so20926589wrn.6
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgaYzMr4at/dBaiZhwCRdQ4/MPv6wjkUvq/fU8vDFyU=;
        b=eGCVZxVH41xtk/Hjf+/yYBJ2rL1w6wlC3Q0Ug4CbUk3ChWSrV8fzgQX9ykCvUT+WD9
         k4TVZ93AvvFeUwiNHWIkVYVGAymD2Gk39up77TJ2y37bP9aBqIS3aqzRrhVmlB8WF7M0
         WDt5iLjYWw76K76yNr9+BBY784ZgOP7+9caXVVhTMgrdZ8fkU8Kc4SaUf2qcJEufNd4V
         rQECv2nuZtoI3PyLMqtZeRkyHn/P0sAzh3uUx1p2MjSKTFvAxy76bwFE0dIYoFBg5PmV
         1RajsSLC34y31X7v/094xPxLGacJnioom8pXaoWEHCGPCdXDpj2tEwylNfKY8m3YkA20
         uq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgaYzMr4at/dBaiZhwCRdQ4/MPv6wjkUvq/fU8vDFyU=;
        b=C/cMOIVqNe5ywMFpUtYjkMDr0LfWoghoFLXt5Ji1tlAXs8niM31aE9WaUw9gxfUotT
         OsrZ1pDonmfbglD4DfGkaP5Dh4QwJHesbe3u/oq6azCTepmTXBwqj5vbdncc1dK8RzIy
         622YCx+QRR9WcgOIy8J1P7jifjtN7OhxD4X/LBKDEYuj5L4o2QUMOzToYrcZNYb87j+D
         uN0MBIVnlctKiVkHEuPZGCPtqv7Ex77d8OK1UboY3mDQt858CtCW0yIG+pU8dJzoED4G
         dyP9eUnmPLGmOFEucJgooOgtuLKi0xzvngMghnOUEGiBp5FpKc5Z4FcCM7s0VICR+Flx
         WmcA==
X-Gm-Message-State: AGi0PuZ5ibLFFdCxjgjCskxFPNlE+QWaTgEh2PQnnZqvyeu/ZsYF3vZD
        EXnV/xQb4J8GpUo586bZVaAdAg==
X-Google-Smtp-Source: APiQypLgfx0bZ/W+soTyjb30iFZoKYeCoiNB6MFptekC6Ez/iO7aZR3TZFMjzWE1yIp6pLSqi1qjsQ==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr30927974wrx.42.1589377136723;
        Wed, 13 May 2020 06:38:56 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:55 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 06/11] loop: Remove figure_loop_size()
Date:   Wed, 13 May 2020 15:38:40 +0200
Message-Id: <20200513133845.244903-7-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function was now only used by loop_set_capacity(). Just open code
the remaining code in the caller instead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c134b3439483..e281a9f03d96 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -245,14 +245,6 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
 }
 
-static void
-figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
-{
-	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-
-	loop_set_size(lo, size);
-}
-
 static inline int
 lo_do_transfer(struct loop_device *lo, int cmd,
 	       struct page *rpage, unsigned roffs,
@@ -1534,10 +1526,13 @@ loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
 
 static int loop_set_capacity(struct loop_device *lo)
 {
+	loff_t size;
+
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+	size = get_loop_size(lo, lo->lo_backing_file);
+	loop_set_size(lo, size);
 
 	return 0;
 }
-- 
2.26.2.645.ge9eca65c58-goog

