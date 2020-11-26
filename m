Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D135C64E75
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70D92158C
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="TezphtH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbgKZKrb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388342AbgKZKr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:47:29 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2CAC061A47
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:28 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id u19so442361edx.2
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6hb7z/DWIkudEPm3vHYGG/k8WfnzjeNa9z9bipOSoo=;
        b=TezphtH3hj1KhCiOFtqlvZsJQjZmzMST0p+6BdJal3kHIE+/iYQ4dK0Qh/P8Yq4R8g
         KDNXJrONRhrVaOAAUVw5MUmYJ0TsESgxolRqj9zB8s0uh3AWdXPq7JgB1XKfrnTsTqIF
         bCI4CPV6h98QZopwAFC1vikP5M7gyT1wKZHCD6g4j3U40PdxM8ZrTxqubDdKK63v2JLF
         dtXD8lM4y3jUSt1furbMnGQwlseMS1/rdfiT1X0PKItWDjYQYJ6GUUTydT/f0pk/UBqo
         zbK8gIrR5Nax5SNJo5gz2Br98PBh4a0PZ2+8D9LJZ2K1bxYNvrYjB203JO+h/Xz7xswA
         qrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6hb7z/DWIkudEPm3vHYGG/k8WfnzjeNa9z9bipOSoo=;
        b=iVq4cPYpJLQ8r/bD2fvacAvsz/0pTsLCg8JRB6zajdEOzFplxrULhxTiJX6CS8WyHg
         YAjJJ4CTDxHMDFIJGlAxdahKyEnV4tf7pEETCe3b1KyYFJbnCtJdXPHdwgPtADodi2L+
         Q8xOYB1oID7cWKg5AJFWkwDnxixgW1PvwOe10fVCE1CQzlCGpjxa5AZ3ncxz5C7epzZw
         WXua+9vKQ8ySerFrHUSUYrJLg5+i3KcZynYh2bltJMngoL8EALmBm//a++5ImaLtujAN
         vK1cb/Vs9v5BJEagebe/llI+co+SEKqo7abJ7uB7k2Zg1e1rrL1/j1yj2/e4OoVSh5sA
         oDfw==
X-Gm-Message-State: AOAM530AOCS72CIK+QbxAU382zQfVTs0nqrSKE1w5xir6zChc8sSiYZU
        NkzxIIXT2ppoIt1R8bm9oyStTKXwakRDwQ==
X-Google-Smtp-Source: ABdhPJxjCduv2Iy1x9DNI8UO3Ewtpg8qsG8FT/IV7Bja7s0p3sf0hwLh2c96ygPG9dx52UQMj/U4GA==
X-Received: by 2002:a05:6402:1ac4:: with SMTP id ba4mr1884416edb.383.1606387647493;
        Thu, 26 Nov 2020 02:47:27 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4961:8400:6960:35a2:747a:e0ad])
        by smtp.gmail.com with ESMTPSA id f19sm2910053edm.70.2020.11.26.02.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:47:27 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 3/8] Documentation/ABI/rnbd-clt: fix typo in sysfs-class-rnbd-client
Date:   Thu, 26 Nov 2020 11:47:18 +0100
Message-Id: <20201126104723.150674-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
References: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

/sys/block/rnbd<N> is created, not /sys/block/rnbd_client/rnbd<N>

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-class-rnbd-client | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
index 00c0286733d4..ca3267b81886 100644
--- a/Documentation/ABI/testing/sysfs-class-rnbd-client
+++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
@@ -66,7 +66,7 @@ Description:	Expected format is the following::
 		    The rnbd_server prepends the <device_path> received from client
 		    with <dev_search_path> and tries to open the
 		    <dev_search_path>/<device_path> block device.  On success,
-		    a /dev/rnbd<N> device file, a /sys/block/rnbd_client/rnbd<N>/
+		    a /dev/rnbd<N> device file, a /sys/block/rnbd<N>/
 		    directory and an entry in /sys/class/rnbd-client/ctl/devices
 		    will be created.
 
-- 
2.25.1

