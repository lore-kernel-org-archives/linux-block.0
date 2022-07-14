Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278E5C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiGNSID (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbiGNSIC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:02 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E168720
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:00 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 84so1455283pgb.6
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGYIF7OBu39zzjQenCbNLRwQp8djQqKGNFr7hhbq58Q=;
        b=swCnuxLCyINjb5b8aT99DR0hxeuBZP8C9ICR7FwiRx0twYyfguUMy/H1Lt6t1CYAjn
         tXDUKfXhpf0YZoWFw4M9Ua4kR4lQTDyomBH84i+g2No6PbTvKdtDTmZqUnUZ8UT4eyoz
         Tf5LraaOHTqpFtX6mfCHdbUAbEUmVKTNVaf6GOTZIA7KVLf4GsVKuOc80AihZmcLjwi4
         8nnE7C6jISQZ/guH+XDYEWBfxyQDsHC4ntgXSHPHcvXPsdPGpEA5R2nBchm4lu3kWcIC
         PpRd4q2XEUdZLy+70D9ZhsRVkHlWUZgO/eNqlV0M17Qrb/Vt7GVqmyNc8H8AODoGXfBy
         ySHQ==
X-Gm-Message-State: AJIora9I1tjNM86nB7WpiFTDFNEY/nCN3msOH6QT0Gf9kaVKgoh4Z14L
        ovSyXecqi/Rv1TM2caoG4JQ=
X-Google-Smtp-Source: AGRyM1uEAIQVmAzcsR5kS+JXxLkVSawugetZwLoR1Q7CwHhc1ZkcgK8y+VCwGY5zxh7BiIXx7qjzJg==
X-Received: by 2002:a65:5b44:0:b0:412:b6dc:7076 with SMTP id y4-20020a655b44000000b00412b6dc7076mr8423380pgr.601.1657822080136;
        Thu, 14 Jul 2022 11:08:00 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v3 15/63] block/floppy: Fix a sparse warning
Date:   Thu, 14 Jul 2022 11:06:41 -0700
Message-Id: <20220714180729.1065367-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the type of request.cmd_flags has been changed from u32 into
blk_opf_t, use the __force keyword when casting to an integer type to
prevent that sparse warns about this cast.

Cc: Denis Efremov <efremov@linux.com>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 491e7205a0db..ccad3d7b3ddd 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2859,7 +2859,7 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (WARN(atomic_read(&usage_count) == 0,
 		 "warning: usage count=0, current_req=%p sect=%ld flags=%llx\n",
 		 current_req, (long)blk_rq_pos(current_req),
-		 (unsigned long long) current_req->cmd_flags))
+		 (__force unsigned long long) current_req->cmd_flags))
 		return BLK_STS_IOERR;
 
 	if (test_and_set_bit(0, &fdc_busy)) {
