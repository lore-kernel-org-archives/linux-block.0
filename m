Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ADCC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiGNSIG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbiGNSIF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:05 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1434474DB
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:02 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id o12so2552783pfp.5
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w4+f5UYf+WA/O9V3kHFhD7P0KGrJy6NeWvxFiCMfaoc=;
        b=rLQ1+BH47QvexWVBedSzDcGKLaiRkRz0zlCC9e9iqdTVsuWvWa55rw1wp+AmbVkIRv
         z/87CZ6VVMyRYG/svnYersaEwPbBHEQGmziJy03nNJ9rqDtVzhoZQi0123i5h+RMxFh6
         j9MtS4pnFCDyY7yZ2clbi9k630YfrajP0aa1BJAn+Bk/0f40agHXO46yehLIZkzLrPqZ
         5SyG4SQx0Xi2qbZIxUqgwUj59j0R2/Q7PAHWfVc6hFS4soinFXY0bFs0KrYygSBbe1m8
         LATcfZZn8i8+kly1IqppEUFV+tC4Zy2HgGJ65zaghTVjTW99SEGOAzdEUzfunDoclS9M
         Yr6w==
X-Gm-Message-State: AJIora9BaPjOI6vDHgeRAyDJT1erdmP74MrD85CxRXKSPv4qw7MxjABx
        csMs51z+bG0yFqUDyBzDlEQ=
X-Google-Smtp-Source: AGRyM1u136mGzjfLzbHJS+5LYyNv1mjA5tluuj2MDgIjAcyZ57d7bjBFilcM47MeLEkHssZNLKlamw==
X-Received: by 2002:a63:f58:0:b0:416:492:267d with SMTP id 24-20020a630f58000000b004160492267dmr8511986pgp.22.1657822082128;
        Thu, 14 Jul 2022 11:08:02 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>
Subject: [PATCH v3 16/63] block/rnbd: Use blk_opf_t where appropriate
Date:   Thu, 14 Jul 2022 11:06:42 -0700
Message-Id: <20220714180729.1065367-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type to represent
the combination of a request and request flags.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Cc: Md. Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-proto.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index bfb08dd434d1..ea7ac8bca63c 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -229,9 +229,9 @@ static inline bool rnbd_flags_supported(u32 flags)
 	return true;
 }
 
-static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
+static inline blk_opf_t rnbd_to_bio_flags(u32 rnbd_opf)
 {
-	u32 bio_opf;
+	blk_opf_t bio_opf;
 
 	switch (rnbd_op(rnbd_opf)) {
 	case RNBD_OP_READ:
@@ -286,7 +286,8 @@ static inline u32 rq_to_rnbd_flags(struct request *rq)
 		break;
 	default:
 		WARN(1, "Unknown request type %d (flags %llu)\n",
-		     req_op(rq), (unsigned long long)rq->cmd_flags);
+		     (__force u32)req_op(rq),
+		     (__force unsigned long long)rq->cmd_flags);
 		rnbd_opf = 0;
 	}
 
