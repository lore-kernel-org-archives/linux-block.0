Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4A8CCA47F
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiFWTBN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiFWTBA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:00 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93951B98F8
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:12 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id m2so11564923plx.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Q602S72IjnxpqADwZEMgtbxEodM4Brb55UwO2z/frM=;
        b=aixw3GEvNfduFnoipNWgcxJCfGpCRgHngp2+3nJ6Nt7Sy7zfvSdd3JSgQWhf7eIx+l
         GTFUBOkibBMfc8Nlc00zVHKL5hXSWpVAQDI9Cpgvk/jdU4nRQUCpCa31tfThmemg2Qmp
         MK20tgbTIqSiJggA2YZv1c0EEE3xZcghkfaCZKqAlPSBCYkfpsDHS9C8K2aL0uWd4/O2
         13jklS2IiVSeFXcKsNJLujzr/vKAoS5S2gx3GMSmPEZC5ReYsUdUWzBNOaBBpFVMWqXK
         htdRu+VrVTAksB8d3dZHtty2xojBeZCKUexfLF0Eb5aG9x8QPOTTL9ZLNP04NQA6grvC
         oe8g==
X-Gm-Message-State: AJIora9xYGO15OWOKsgCIyvkRMfYBQeBh6daBpLyRb+NDRBRC2fIh1Jp
        bBDB0sT7ateFnMXiiq5SJA0=
X-Google-Smtp-Source: AGRyM1tTD3dl/zUY0MuTB4BA611vmlkDU7bYeaspK17abZEMXTiWRI/wvpcidLe5zJSXn7vyBcZ8zw==
X-Received: by 2002:a17:90b:3506:b0:1e8:8449:6acb with SMTP id ls6-20020a17090b350600b001e884496acbmr5221780pjb.27.1656007572060;
        Thu, 23 Jun 2022 11:06:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH 24/51] md/raid1: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:05:01 -0700
Message-Id: <20220623180528.3595304-25-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for
variables that represent request flags.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 258d4eb2d63c..63b3f70abbc3 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1221,7 +1221,7 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	struct bio *read_bio;
 	struct bitmap *bitmap = mddev->bitmap;
 	const int op = bio_op(bio);
-	const unsigned long do_sync = (bio->bi_opf & REQ_SYNC);
+	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	int rdisk;
 	bool r1bio_existed = !!r1_bio;
