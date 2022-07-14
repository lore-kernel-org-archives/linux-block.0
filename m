Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F83CCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiGNSI0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbiGNSIT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:19 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F8167585
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:17 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so3863213pjf.2
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoXsNI17wFBinjkUqaJ29cF+6CKFeJOGy8SfkJXh7+E=;
        b=Rrx2T2zEgm9mCxNLampxUf1CWwN80noVkZh05efLVz2cjy/BFvv5DCBWPi95H5qCqn
         Y8BaB1/lZomRrzAzxH0mSZY1D1ZqH12g5YcI2aU7dIDBOhMtUvFpRAApE8LKDGdsLHbe
         CYSLAZfUpdAfz2+MPWEo5h5eh2u3+TuF1YJ6Jqadwt/nLU5gg5C+kOXaGDR1nA/ipD7W
         CljV0NQElUcrX0dPmIOT4hHKqdaXPY/WxY8dzV2CdRcHPmruHke+dHvio0lwxk2cTfpK
         D4tJ16VIB5ZE9S8r7AQc8y7hCNt/tK4eAxX1hAlbQdMpcevRPMVsPhf+GvIeMIulNDKw
         xJUA==
X-Gm-Message-State: AJIora8DOklDWt+3FD7FoOOrkDc6vH0cYl/pckfOzmJMEMxoGF4GuIj7
        hr4QfMI7FYXGAY0KeHdSS3I=
X-Google-Smtp-Source: AGRyM1tT8+orqeHFgveJXXlKReag44vHCgyEa0ohnzFgw/yztoCMZn54o23kSpY7YDXuz8iazqLkWg==
X-Received: by 2002:a17:902:f708:b0:153:839f:bf2c with SMTP id h8-20020a170902f70800b00153839fbf2cmr9219177plo.113.1657822096661;
        Thu, 14 Jul 2022 11:08:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 25/63] dm/dm-flakey: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:06:51 -0700
Message-Id: <20220714180729.1065367-26-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for structure members that represent request
flags.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-flakey.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index f2305eb758a2..89fa7a68c6c4 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -32,7 +32,7 @@ struct flakey_c {
 	unsigned corrupt_bio_byte;
 	unsigned corrupt_bio_rw;
 	unsigned corrupt_bio_value;
-	unsigned corrupt_bio_flags;
+	blk_opf_t corrupt_bio_flags;
 };
 
 enum feature_flag_bits {
@@ -145,7 +145,11 @@ static int parse_features(struct dm_arg_set *as, struct flakey_c *fc,
 			/*
 			 * Only corrupt bios with these flags set.
 			 */
-			r = dm_read_arg(_args + 3, as, &fc->corrupt_bio_flags, &ti->error);
+			BUILD_BUG_ON(sizeof(fc->corrupt_bio_flags) !=
+				     sizeof(unsigned int));
+			r = dm_read_arg(_args + 3, as,
+				(__force unsigned *)&fc->corrupt_bio_flags,
+				&ti->error);
 			if (r)
 				return r;
 			argc--;
