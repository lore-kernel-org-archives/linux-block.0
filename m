Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F64C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiGNSIo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiGNSIk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:40 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4471A1092
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:37 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id c6so1120252pla.6
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1CZHK2jcu4W7RoOhMbkvwfbgGhOzDPwNMkMDqw5sbY=;
        b=HLJtdROVFWSD94VCDSRhEG4VVetfaz0J4WlN+U3xqnwyWmiRDSqM3ni5gKXjdtGy8R
         mXoLIcAVXIYX4L+ej6YVDnOWZW/mKNh7Yvw8224RPGUw4N9PiXTLFHpoIsXoYQGFbHLo
         RAkgcrmWk6p5t0CnjZ27JS6vU2nBdcu0oUXYRdyI53NtlDxnT9iKtettNIa+Am3OPOds
         OqD3/1K7eUSyF3by8FdjrN7JfgFR3o4vZ92m9egaTqcxPYzIdWVWUszyAHqiqZh/Wz8x
         aaBfzZ7RlfohI7rnSNssdLzO4ETD+mJcMkSka8RSngTs6gUIxdueHIdCrSKrrETUHhat
         AONA==
X-Gm-Message-State: AJIora+MLCosBz9CSk2V2391Zy61SNvVeFP2irpm9lhTJIDTk0bcoze9
        1CPSb5X50uVFKv5Pi1Piick=
X-Google-Smtp-Source: AGRyM1tzav4xZKq82b+3DnQOgZWImQcA5Qmaa3Brs1lt09KB07AGKEVhQAeg+1pg2ashuvKnGCg1gQ==
X-Received: by 2002:a17:902:8343:b0:167:8899:2f92 with SMTP id z3-20020a170902834300b0016788992f92mr9629368pln.117.1657822114530;
        Thu, 14 Jul 2022 11:08:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 36/63] md/raid5: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:07:02 -0700
Message-Id: <20220714180729.1065367-37-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/raid5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5d09256d7f81..cae1612580fc 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1082,7 +1082,8 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 	should_defer = conf->batch_bio_dispatch && conf->group_cnt;
 
 	for (i = disks; i--; ) {
-		int op, op_flags = 0;
+		enum req_op op;
+		blk_opf_t op_flags = 0;
 		int replace_only = 0;
 		struct bio *bi, *rbi;
 		struct md_rdev *rdev, *rrdev = NULL;
