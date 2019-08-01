Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A66AC19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2794F206A2
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfHAWjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:39:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47052 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389848AbfHAWjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 18:39:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so11744831pfa.13
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 15:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZYpK3orGoi0KMQkUjiRnCeqZ1NTFkyrmGmJYRGyOJT0=;
        b=A025oqmEnmiS3d1QPwZw02IxWvec9wpSNasCEtXPeZdpNMPF0nYS1UhvrZBdHzwaxe
         R3vcr6uZRJMRgaJSqbLxCsEUfB7IiQ2/7b0w2BFGUxT1wcQQHk1oyaGQyGKzpg0xQcxW
         DFURrmJfsXQdBkCVsdk9UvmjbOoibbwN09XD6k2fyIOe2bFYMFWw7gcquKK5+HNtfY1q
         3OlQdSEa/63xC9c0q5S4/Sf9Lc5LBf8J6cQrSV+hiOiF5FFrVkPoXvdSYSdFVLfqOQyR
         nu0lAVD+syVgPDcVDiZx+0UThg3P6NxdfNSKsiBKtIRFOSdrKGzjkIjHGfJyH5sdNXPU
         oVzQ==
X-Gm-Message-State: APjAAAXxT3+bmi3Y6D5zX6tFAFbDq4Q9vXPJZXS7XegzFwtPuS0M6raW
        bISXtFxROZNz7/poEgjV7wA=
X-Google-Smtp-Source: APXvYqy2rplbk2iGdPTk3mqo34K3wDXi00LzG1gXj7r+NPXxpTMeV1plHLvfPxBirEkm1KMn2QKA/Q==
X-Received: by 2002:a17:90a:cf8f:: with SMTP id i15mr1069893pju.110.1564699154122;
        Thu, 01 Aug 2019 15:39:14 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n17sm76604599pfq.182.2019.08.01.15.39.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:39:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: Fix spelling in the header above blkg_lookup()
Date:   Thu,  1 Aug 2019 15:39:07 -0700
Message-Id: <20190801223907.141042-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

See also commit 8f4236d9008b ("block: remove QUEUE_FLAG_BYPASS and ->bypass") # v5.0.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 689a58231288..96867399544d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -374,7 +374,7 @@ static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
  * @q: request_queue of interest
  *
  * Lookup blkg for the @blkcg - @q pair.  This function should be called
- * under RCU read loc.
+ * under RCU read lock.
  */
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 					   struct request_queue *q)
-- 
2.22.0.770.g0f2c4a37fd-goog

