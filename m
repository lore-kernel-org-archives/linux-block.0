Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC32C4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 08:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249CB2074D
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 08:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhUVEuMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCWIxU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:53:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44925 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCWIxU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 04:53:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id 142so1617493pgf.11;
        Mon, 23 Mar 2020 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=skJJq7KG4isrrpdNlj7U3AQArFcvGSy+YbvbhSYAKX0=;
        b=BhUVEuMtXvTJbUOdRhu5Q9bOT509Kmv14mj/vHD+ZHTp/y8TzuTR5rWCpsz9/ZzSYe
         26eWfJ9BSEX2atIbcEtSmmWLTUNe1qmlxnSJgY+bHEBN76pPgmNr2aiPGLlJz2i/y37c
         l/m9cMR9Msq/j0VLcXygok3CwLTadrpLsYwEtaUjH1Wlg5ZZ3IM8q5Ev3UFyqFTKnti0
         FNEuoKDeasK3OaOhludTCept9NHRhsQM7+hd0afS2hDMHw9QwpaQ31NsUOmJObmfKABQ
         uwwTEp9cdgGyIGBKBus3+cDLGgOSVDc/vy5HMxJQ5H9cZmtctFP5wZL7+Yhp9i6xOc0z
         h3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=skJJq7KG4isrrpdNlj7U3AQArFcvGSy+YbvbhSYAKX0=;
        b=Sj1CSpbvzy0Pzf5Qo4zAb/n2LcjoksoCMa4LyAbz9RHWvPJtGZr4m6wCUB6OeesPZv
         N0pg65a0YzRaf92IDX9sAfFe/CmkExDrvofCRFBV/EaH94eDGqguNExAGmUF7aW7Wo7U
         k2nQH1buIRE2bXUwyU0bNVKvtF7mpbpVwWj2U/GPchqiAW5ns3MxJvIjfQz+mGu7vtWV
         a0PjGt2vrk8aYk5X9Nd+RNLC2sJ2T0RQjNxGjRVRO/IauqzBnZX9O2q8/dZa+fLETBWi
         2xNilULfVvLuk55zOVzs12PNARUUGJ3DtRqakI9z2VL7ICbahKbl12UbMZ5+RpP6t0Qf
         O8qg==
X-Gm-Message-State: ANhLgQ0LOBSJjUfYE6tgP9yC//k6di9U9CmAeQx6acbeafVVlwfFMT+c
        KLOBLGc3EPjUGNcf2YCyiSa1R2bI
X-Google-Smtp-Source: ADFU+vuWPgHNvLVxJVdPaShX2k4rpl1ER445cSFfrLPJDSMGDZyyYdWCgI/8m8UrHXWsQqdGW8UlYA==
X-Received: by 2002:a62:8202:: with SMTP id w2mr23032068pfd.117.1584953599215;
        Mon, 23 Mar 2020 01:53:19 -0700 (PDT)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id c126sm12723263pfb.83.2020.03.23.01.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2020 01:53:18 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk
Cc:     huyue2@yulong.com, zbestahu@163.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH RESEND] drivers/block/zram/zram_drv.c: remove WARN_ON_ONCE() in free_block_bdev()
Date:   Mon, 23 Mar 2020 16:53:10 +0800
Message-Id: <20200323085310.8272-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, free_block_bdev() only happens after alloc_block_bdev() which
will ensure blk_idx bit to be set using test_and_set_bit(). So no need to
do WARN_ON_ONCE(!was_set) again when freeing.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/block/zram/zram_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1bdb579..61b10ab 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -570,10 +570,7 @@ static unsigned long alloc_block_bdev(struct zram *zram)
 
 static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 {
-	int was_set;
-
-	was_set = test_and_clear_bit(blk_idx, zram->bitmap);
-	WARN_ON_ONCE(!was_set);
+	clear_bit(blk_idx, zram->bitmap);
 	atomic64_dec(&zram->stats.bd_count);
 }
 
-- 
1.9.1

