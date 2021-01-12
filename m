Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84182C433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351A623132
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391181AbhALPaq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbhALPap (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 10:30:45 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9167C061786
        for <linux-block@vger.kernel.org>; Tue, 12 Jan 2021 07:30:04 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 30so1668311pgr.6
        for <linux-block@vger.kernel.org>; Tue, 12 Jan 2021 07:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9nbRvwo7ac2ToiSLQSsfVzaqM5k2WvPOWvIf0XdbxA=;
        b=eM5ISxhZoCLEIGOwGetHhmmIPqAc56Qu0T8jpNBgasOwpZuIpmVYO1/o3tQF4L9TKf
         PejjotnzCIeDiOadl/7mp0/mC4naBqEeKjLSAzq5CTe1HEta0/k6DAgbZpr0ddwHvYjx
         RCwO2mO/OA5GlYOkH5WGg8YkIbbUkxNQU+Sf/cYW0ZU5v6l3MAE6skyV/bTzVg8VU8RA
         IrT6VB+p7d7pbhgNTurKa9uVbUFHYRWTk/0JApYylURP8jRNRkqAzj4R9ch+9Ka6qRFx
         rYQnfF1EQeWZ7hPFp5epVqs5O7SaKqxwdQkqgELzSs1Kyh9xI2kP0HhRCYL/i2gwucjK
         ZbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9nbRvwo7ac2ToiSLQSsfVzaqM5k2WvPOWvIf0XdbxA=;
        b=BvVm9uUd7UGAUf5hm0XQFDBBcvYA4hsg+qn2d6RER3hQJtlO02+6dULf5rHv5rfcJN
         OHyTmdLRYFMre24XO4Rw62kKlqWfw2vlhMvxz14sS4PtPeVEuKD2YxtmtTFfaMEawVaD
         y0CFiMzdUhcbHQmszUpUCdlXphsFaXbtuQeVh8YdS5D4v7MZOA7+1DUxGvwm704wfOOM
         sv3uTipYOZzacEOFho08fOxvQA4oiJVe8KcEJLTfRDwVUwLV3/iDH/0tqaI4QMTZ+P28
         XooWlKUYRj13xpYMonI+H5DW3ID3KGwy8b7JI2w2yjC9y/CcZsOpFDJSSKY2WHy0MJ5B
         VsLw==
X-Gm-Message-State: AOAM533CC3nptMNpbCnl6TY65OnllXzUP3zBJSEH4S4kQVbyG2OvXtBh
        R93cJeTaGViBZdSHR+f2HLyMMQ==
X-Google-Smtp-Source: ABdhPJyALuNVv1wvI+DDRekgkGo8NXfLozpA9HiGJxZ7KWqh/VVuh24KQ5EaDmvO2ic4y/u1/3k/Fg==
X-Received: by 2002:a63:3ec9:: with SMTP id l192mr5316862pga.104.1610465403297;
        Tue, 12 Jan 2021 07:30:03 -0800 (PST)
Received: from localhost.localdomain (ec2-18-163-103-0.ap-east-1.compute.amazonaws.com. [18.163.103.0])
        by smtp.gmail.com with ESMTPSA id n1sm3486878pfu.28.2021.01.12.07.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:30:02 -0800 (PST)
From:   Li Feng <fengli@smartx.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Cc:     lifeng1519@gmail.com, Li Feng <fengli@smartx.com>
Subject: [PATCH] blk: avoid divide-by-zero with zero granularity
Date:   Tue, 12 Jan 2021 23:29:51 +0800
Message-Id: <20210112152951.154024-1-fengli@smartx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the physical_block_size and io_min is less than a sector, the
'granularity >> SECTOR_SHIFT' will be zero.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 include/linux/blkdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..4d029e95adb4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1485,6 +1485,10 @@ static inline int queue_alignment_offset(const struct request_queue *q)
 static inline int queue_limit_alignment_offset(struct queue_limits *lim, sector_t sector)
 {
 	unsigned int granularity = max(lim->physical_block_size, lim->io_min);
+	granularity = granularity >> SECTOR_SHIFT;
+	if (!granularity)
+		return 0;
+
 	unsigned int alignment = sector_div(sector, granularity >> SECTOR_SHIFT)
 		<< SECTOR_SHIFT;
 
-- 
2.29.2

