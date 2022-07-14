Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA3EC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiGNSLJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbiGNSIy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:54 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2621B7B7
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:50 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id s27so2257266pga.13
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KpF7BPOEPb4P8mB27/+DF8FLB4YeptuBZNErZcEKoE8=;
        b=wmWE8rkzFNEso6suWzwc5VaMKyAzuM2r7pR/SaNr2ry1AdGDjbSu2kiyuUvvmJgI+G
         fG+aT4Z27LdSGHECMhFTKFkJicD4U4odmnzEGH94VnvFzdhCxO5puIVRxs5S2DRCnG9n
         l/9oK1+UaQbIamzGnfPJfLy1PlWj7ymjXk/HvDE9jUSidwGhOZWExbGk2b3xHXQQEZ5x
         GRBHhRRpr0p0LZyUnbM9Y8l7iwgBCfKx5mawJpbcYCILKvn+NJMO7vJejCphyxvKlHkQ
         eTnDraIy7/rPihV7tx+0Ry08Fq1abFwLn/tfsYlTJM0ckj/UhLUPN0rIkNQvwacWT7yF
         YzLQ==
X-Gm-Message-State: AJIora9BBKcFJD4UIBcKepVubvrHPqnZarM6l4tkM9f2+JVG5Q5WwRpe
        UJ+E20LXc6ExY4LxOJf6aPMOc4OwSZU=
X-Google-Smtp-Source: AGRyM1sStgCNEfFPOyMGRnl8H5QTHpIs2AIiTol4+sKefk2psUfQu79ImEjWaSlUyLUtip0BDBb7XA==
X-Received: by 2002:a63:1220:0:b0:411:f661:f819 with SMTP id h32-20020a631220000000b00411f661f819mr8775931pgl.250.1657822129532;
        Thu, 14 Jul 2022 11:08:49 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Stefan Roesch <shr@fb.com>,
        NeilBrown <neilb@suse.de>
Subject: [PATCH v3 45/63] mm: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:11 -0700
Message-Id: <20220714180729.1065367-46-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for block
layer request flags.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>
Cc: Stefan Roesch <shr@fb.com>
Cc: NeilBrown <neilb@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/writeback.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index da21d63f70e2..e91bea371b18 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -101,9 +101,9 @@ struct writeback_control {
 #endif
 };
 
-static inline int wbc_to_write_flags(struct writeback_control *wbc)
+static inline blk_opf_t wbc_to_write_flags(struct writeback_control *wbc)
 {
-	int flags = 0;
+	blk_opf_t flags = 0;
 
 	if (wbc->punt_to_cgroup)
 		flags = REQ_CGROUP_PUNT;
