Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09D9C0032E
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 22:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjJTWh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 18:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjJTWh5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 18:37:57 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BF3D75
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 15:37:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-584a761b301so959406a12.3
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697841470; x=1698446270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp7b71HPUhZRYWiCA2ecvkahN2T6L1Zohh0DcisfMqo=;
        b=mpghkfyzOutQ8CeN0RTsOB/0AWJ4MqMMREcBV150vT/rU4NoA0CTQBI09Id5QZgKu6
         zsDGGBYpFyLGzg/FOj8u29B6DTgrQLkbAV7OQJmfl29HFC57Ux4CvgUWCFQvQMNMXN04
         gBLuVmp0DsoLj8I6TEB4/RGOu0MfMJ9eNFUnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697841470; x=1698446270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pp7b71HPUhZRYWiCA2ecvkahN2T6L1Zohh0DcisfMqo=;
        b=Mcsj15M1PhL9pkIJ8QwZyZBYCznJRoU8HAEIM6ZQ0WgG2BDaoPokJOIK7UJtAldZDb
         YX9JMstjcqiYHMK7YtL3kptxrEIK9gLl6A5PNdNRhya4yII92ow5aWGdyMWBBiItqrUb
         bP/AcqQC++EoFB614a+kK9OumPksstAfy94ZTsP5bd5ytt0S+eHwi8BWoOBSDoQ9054c
         K8mO0Pa1m9b/UTosANrcM4796x2hnY0fz/JUEi5ssQkOVn7Llj4hsDfHjvbsZGUD27s0
         aQH6WEWTx8tauAD5zKbDHMRbq8YLlCtnCV0NqWP3ERQB4GZBGPOerjzXkOxklI9JV+8y
         6OYw==
X-Gm-Message-State: AOJu0Yz/9+Qi6h0+v2+ArOl+WZauFYNQ/W/AbpTgIYdEp9a0r9vaviNX
        SI6SSZeah6MBFcf6sKHYg8V+pA==
X-Google-Smtp-Source: AGHT+IFTI62df7sLkxercIq20RisYKYexu5tSVNibXFRfdyyl/NCUMISJDc3unFPOyM3yu6AVX3h4w==
X-Received: by 2002:a17:903:610:b0:1c4:387a:3259 with SMTP id kg16-20020a170903061000b001c4387a3259mr3542740plb.46.1697841470337;
        Fri, 20 Oct 2023 15:37:50 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2a3:200:8e83:71b3:7861:9c5])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b001bbd1562e75sm2013392plg.55.2023.10.20.15.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 15:37:50 -0700 (PDT)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com, linan122@huawei.com,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH] blk-throttle: check for overflow in calculate_bytes_allowed
Date:   Fri, 20 Oct 2023 15:36:17 -0700
Message-ID: <20231020223617.2739774-1-khazhy@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inexact, we may reject some not-overflowing values incorrectly, but
they'll be on the order of exabytes allowed anyways.

This fixes divide error crash on x86 if bps_limit is not configured or
is set too high in the rare case that jiffy_elapsed is greater than HZ.

Fixes: e8368b57c006 ("blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()")
Fixes: 8d6bbaada2e0 ("blk-throttle: prevent overflow while calculating wait time")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/blk-throttle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 38a881cf97d0..13e4377a8b28 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -723,6 +723,12 @@ static unsigned int calculate_io_allowed(u32 iops_limit,
 
 static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 {
+	/*
+	 * Can result be wider than 64 bits?
+	 * We check against 62, not 64, due to ilog2 truncation.
+	 */
+	if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
+		return U64_MAX;
 	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }
 
-- 
2.42.0.655.g421f12c284-goog

