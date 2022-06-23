Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33B4C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiFWTBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiFWTAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:45 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4ABB98D6
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:03 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 9so161235pgd.7
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcBryfIH3c3Mgb+xHjj15LSwFf469iz1YM+xVl2AH5k=;
        b=j6qshMR1rRLcjnPDJ4VBpzXBtbichqr97d/YoGSE6SOK8udonP/VsBLGkcWO1xqf3k
         mSg4d2NMxAZ8mxxVRng0qf7mQgegh6kVf6fOpVHQNuxIQCYi8EYykx/mwnR3P0K8Q2CB
         pao/V/hZG5jbbtD/ZXG/AL4cg00u60z2RgsBvBOXTb8wgaTZAV+T/pwqTywcBkOjfjo9
         2Lse5hiZTqlmyRn1SHqWs5nntIFJxeRwprd3nlYKspHwnsZ7ECKXrJGYfcq6jQJOs3sD
         URx1PhqczXBFBD042gjgaPqNNfT1yLbyCAyy1YC0EoXJRzCy37NBqMeY9gT3CfXn+vBp
         pCAw==
X-Gm-Message-State: AJIora/KdWEx3crPMeqJhCKx74Dtd1DmH2kU7egiFyWaa9gnWX4Bgt7P
        LbgwXQACpiIwEUPIxrU/z+2jM+LHJ9A=
X-Google-Smtp-Source: AGRyM1uI8TzHtar6UBS+qJHdHLKjD7oX/BlP4IOhRcWvs3Kaw5GfcK56X6QtAKTkBhh44gKTEzUZdA==
X-Received: by 2002:a63:82c3:0:b0:40d:3b63:a806 with SMTP id w186-20020a6382c3000000b0040d3b63a806mr6580305pgd.75.1656007562603;
        Thu, 23 Jun 2022 11:06:02 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 18/51] dm/dm-flakey: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:04:55 -0700
Message-Id: <20220623180528.3595304-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for structure members that represent request
flags.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
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
