Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA45C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiF2Xcu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiF2Xct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:49 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4C8CC8
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:48 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id c4so15475982plc.8
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtXVXh5FV9AcqLhi64ZzdFomJLYfgKOVTpUx1aD64bY=;
        b=B94XS8r426pvz4wCB0GwzzmY+eUxBhDaGtm30lq5L+FmxDNcyn//aZAQnW2ityrXB7
         fUpUD/C3g+3Ql9ybPeMD96TXyAIS9QhA4+feE2D87dM2QwbQvORCpttkrs4Icu7O+wNy
         tOEcCqnbsGS7N/ClmmhoaW6F677FUdsAY9h4WkvenJwadpWzUqtf8v6+P8TfJBsQOAn0
         G9NugB2Rdxp7nXZq7ymUJ/I7wUO5lJ4un8vFqKA5ca+/9G2FoN2rREgcW+MyMlOntCVP
         OwjQsBIQpVNHcyTG28tdXnogETuYcfX0PjMBvej6051Ct0JRzL3acMuUC65DhdwmBA5y
         bkxw==
X-Gm-Message-State: AJIora83bTv2604Bb7wGIVyttq1fuY/jaPK7nrn+JHxjX3rHWSfoA86T
        tqLxQdiSW6Cp0XIoIhZqeTCeREqkpwo95g==
X-Google-Smtp-Source: AGRyM1sHC3opzn3JRAH1d6xDBZZMbsbjy+H12SPHPuPVk/x1nfS6RT/rUTEtdVF3uqjYL2K8IFVneA==
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id s7-20020a170902988700b001516e1c7082mr11443050plp.162.1656545567625;
        Wed, 29 Jun 2022 16:32:47 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH v2 35/63] md/raid10: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:17 -0700
Message-Id: <20220629233145.2779494-36-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for
variables that represent a request flags.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/raid10.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 910d3cd73105..ac8bc7d2565a 100644
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
