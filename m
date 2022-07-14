Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F64C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbiGNSIl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiGNSIi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:38 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C53C63
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:34 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id p9so3541488pjd.3
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6YahyHmBW9bwHUdqDMQSoaBIAkI/gNK5IswgEgkGYe8=;
        b=gf0HHUy4ZxfcoNNBjvdkHT968Qn9A+vQ/0GVlNYMhrJ76jx37IEicuhhGu7B2sPHWd
         dfTepcsAaTxaI0zC6pIS/bCk2YXjoIDS3zAtishco6nfghENdTLpYJwZlnQs5L3RhTnn
         2UaNl499r3Nz815CpZs8waFG9yY3ILojfQsZfRh73elwoe1izfyymvrID4tTwJm30LQK
         Eph/hwt9ECiZvVzpKTBqlwRNy+eCCgnXNRDU5sKg3529iSUYbUtG7zg9/Z3ZqiuzdcY0
         wxmsOsNESv34DvfqMjG/rHkdVt470z/lLAMJ8MSVHviDgd6LLe25MWX0oGWQU9UR4q5y
         tiOg==
X-Gm-Message-State: AJIora+p1Tk/xBB3IEre5cmTzGJjO5lFNHKM35l7TvDPipII80xo9r2U
        ea1Viegz3o77bdBspenEjFc=
X-Google-Smtp-Source: AGRyM1sM5iEzGvHZuA4SySMm4aIi3kbDkju7xeKA54ZOXl7R0n8YXJak6kcAFwnVPRNNQdvDprU5GA==
X-Received: by 2002:a17:903:244d:b0:16c:5bfe:2e87 with SMTP id l13-20020a170903244d00b0016c5bfe2e87mr9568522pls.148.1657822112831;
        Thu, 14 Jul 2022 11:08:32 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 35/63] md/raid10: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:01 -0700
Message-Id: <20220714180729.1065367-36-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for
variables that represent a request flags.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/raid10.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 3b80120cba30..26545950ca42 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1136,8 +1136,8 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 {
 	struct r10conf *conf = mddev->private;
 	struct bio *read_bio;
-	const int op = bio_op(bio);
-	const unsigned long do_sync = (bio->bi_opf & REQ_SYNC);
+	const enum req_op op = bio_op(bio);
+	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	struct md_rdev *rdev;
 	char b[BDEVNAME_SIZE];
@@ -1230,9 +1230,9 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 				  struct bio *bio, bool replacement,
 				  int n_copy)
 {
-	const int op = bio_op(bio);
-	const unsigned long do_sync = (bio->bi_opf & REQ_SYNC);
-	const unsigned long do_fua = (bio->bi_opf & REQ_FUA);
+	const enum req_op op = bio_op(bio);
+	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
+	const blk_opf_t do_fua = bio->bi_opf & REQ_FUA;
 	unsigned long flags;
 	struct blk_plug_cb *cb;
 	struct raid1_plug_cb *plug = NULL;
