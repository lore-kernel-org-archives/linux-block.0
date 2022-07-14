Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A250C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbiGNSIi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240384AbiGNSIh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:37 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75406872E
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:31 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id c6so1120113pla.6
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdFOPKpxgrGXWVeDSH79gtUBBwOBzr4BQKdYAum3LCc=;
        b=ITUvdaedILiwXkf2k88MV7J96SVpHsboDv1xzY6rkJQVOhKaKcm1/vnW4A7QweikWr
         jwF0s3nKi8pytPMTSlOA7RIA2rz5cun66YNEwUyf8qRMErKjoIBqFPwDkCEBYyEY61CX
         UTAWqWHuDva00jlrkzuz9sk2cuzhahBwJ6MPiFbqJUk6CjdwJ8OoYvIwmq8mw7h7omCO
         HtFM1g1eXdZTp/msi4rswZnWsvdX9/yhUxLn0zytDXRlTLyvIujoQcTvhdUmPIVcy2UU
         5FUYcoet/ffCtPgbhnBErCwPHSJp5M9xc/GOkqHe2ApYIQP9IjzsnQa6j7bYW4ZvDzDe
         rCPw==
X-Gm-Message-State: AJIora8LONmtefGnOu9qR2B8ycKPe/YRcWqyQ2VGQ5+MQc3HZHk4qWkB
        yi1VDtxlfLzE/SLrtZaINl0=
X-Google-Smtp-Source: AGRyM1tB3jSMhFzlGrg3I7cZXcLvPV6RwpAveKQCZJGz5I8bxndz8UsPTR9zquaQ0NwMkJV+Ge+0Tg==
X-Received: by 2002:a17:90a:408f:b0:1e3:23a:2370 with SMTP id l15-20020a17090a408f00b001e3023a2370mr10911738pjg.84.1657822110919;
        Thu, 14 Jul 2022 11:08:30 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 34/63] md/raid1: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:00 -0700
Message-Id: <20220714180729.1065367-35-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for
variables that represent request flags.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/raid1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 8f1a2e4a6e50..05d8438cfec8 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1220,8 +1220,8 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_info *mirror;
 	struct bio *read_bio;
 	struct bitmap *bitmap = mddev->bitmap;
-	const int op = bio_op(bio);
-	const unsigned long do_sync = (bio->bi_opf & REQ_SYNC);
+	const enum req_op op = bio_op(bio);
+	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	int rdisk;
 	bool r1bio_existed = !!r1_bio;
