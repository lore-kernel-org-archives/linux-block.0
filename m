Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B16CCCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbiGNSJk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbiGNSJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:21 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E63B36
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:19 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id s206so2289044pgs.3
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdqfgVKQ9zIy7OKDf0PbnT8E0RG3lv1PgMLC8zqDl+0=;
        b=SwHPqcdGQA7g8tL+V/f9nPkuJj3bLAlovcxNiPlM6UhR004kv0vdvAvlfyvfE/zvdr
         1KIPkfvPCuK3G4UoNa3lNngV5Osnz7B3NrohKngrLO4mxtgo1ljlY2FxQXaSQ2kKrAps
         eWBe0nN5T7x0ZdHUOPz4AsJ3rarYGuke0/gpwVX3gVONp21PZaslGrBapYPujg14iqcQ
         soxKH3H1dEmPtRTZyJeiBy9TSmt2S4WFI8y7PlgPJNmFyTSFb7wcbvzoP32lBDwnR6RS
         nOP/Dt5+XYdkicGZ25sbU24qIP9VSQQ6NwWX2tiSR+LlP0oFUNuH5mM0tQl1w4L0jVCH
         NUAA==
X-Gm-Message-State: AJIora9AGuWEMNEy7sqlJTyZyznJTUTjLvhxOoNVD+8rYTCMvScSq14e
        FggNYb2iaS9fc4nPFbcll0I=
X-Google-Smtp-Source: AGRyM1t0EHEGsQ+muHxiTgePlLBZC2MurWQagTGYInXHq3ElnO03b87GyhxNVUTKtLuk4YG5tSh98A==
X-Received: by 2002:a63:1923:0:b0:419:b27c:7acf with SMTP id z35-20020a631923000000b00419b27c7acfmr3778463pgl.449.1657822159131;
        Thu, 14 Jul 2022 11:09:19 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 63/63] fs/zonefs: Use the enum req_op type for tracing request operations
Date:   Thu, 14 Jul 2022 11:07:29 -0700
Message-Id: <20220714180729.1065367-64-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for request
operations.

Reviewed-by: Johannes Thumshirn <jth@kernel.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/zonefs/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
index 21501da764bd..42edcfd393ed 100644
--- a/fs/zonefs/trace.h
+++ b/fs/zonefs/trace.h
@@ -25,7 +25,7 @@ TRACE_EVENT(zonefs_zone_mgmt,
 	    TP_STRUCT__entry(
 			     __field(dev_t, dev)
 			     __field(ino_t, ino)
-			     __field(int, op)
+			     __field(enum req_op, op)
 			     __field(sector_t, sector)
 			     __field(sector_t, nr_sectors)
 	    ),
