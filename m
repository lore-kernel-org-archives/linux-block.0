Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B3C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiFWTBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFWTBB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:01 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2AB8858A
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:14 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so328735pjj.5
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kTj2GXVNl7+zFYPFnYZPqnF36iK5I7RBbvm/rOsyNU=;
        b=v0QJR26Mvt2Cjjw3OmL0/Yf2DDyV1v7I3ST6kvrHg1O3qMtnirG9/lNiMofg7AnMFd
         FsfCBtWAt/txbmtlIhbZYhsHoExaNl09xaAZR79I61YHTyyiWmUhhOY80BtdAfu6PSNn
         dwQ5mH80l0iN2snCIgfp878YKDI/eYyPwG5qC5qyoIf6cyskcL5h2TXtcUs4icyNw+lU
         6n5xa8aPPHykZ4K0Kk0GCOlJ7R5eIYAaKiHtZ/qTiAGTU4vZceSyZVbpomSfm2nDrV+q
         XsNVzwc80VlSa0Ueqs24IcMZ4wuLf4Tewj2ttekQOCLYJhxpbQB5eGgeKFqHSgqA6F6F
         0iRA==
X-Gm-Message-State: AJIora+Z8/KSU0SiKOL5SIHoiJYyT4WbmOlowb+kvgv9i6Euom31FqpF
        jsKKK42AncU9H2UGsEEd7dW/6hAKeG8=
X-Google-Smtp-Source: AGRyM1tkJupTi6C6eLcTx6wZEiMlFWC/ljZzBA6DIWRzX6BLFXUiZyUPuJkAxZTb9YDXXAgEk1PK2g==
X-Received: by 2002:a17:902:f688:b0:163:ee37:91c5 with SMTP id l8-20020a170902f68800b00163ee3791c5mr41312907plg.86.1656007573693;
        Thu, 23 Jun 2022 11:06:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH 25/51] md/raid10: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:05:02 -0700
Message-Id: <20220623180528.3595304-26-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
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
 drivers/md/raid10.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index d589f823feb1..649635e04e38 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1137,7 +1137,7 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	struct r10conf *conf = mddev->private;
 	struct bio *read_bio;
 	const int op = bio_op(bio);
-	const unsigned long do_sync = (bio->bi_opf & REQ_SYNC);
+	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	struct md_rdev *rdev;
 	char b[BDEVNAME_SIZE];
@@ -1231,8 +1231,8 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 				  int n_copy)
 {
 	const int op = bio_op(bio);
-	const unsigned long do_sync = (bio->bi_opf & REQ_SYNC);
-	const unsigned long do_fua = (bio->bi_opf & REQ_FUA);
+	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
+	const blk_opf_t do_fua = bio->bi_opf & REQ_FUA;
 	unsigned long flags;
 	struct blk_plug_cb *cb;
 	struct raid1_plug_cb *plug = NULL;
