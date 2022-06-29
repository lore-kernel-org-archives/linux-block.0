Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC0CCA47C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiF2Xce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiF2Xcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:33 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51A31F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:32 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id jb13so15477804plb.9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EyVekT965VWz2Z3JIHDw2eYG0fae7u/wXFyrRm9Eakg=;
        b=qk8L8b6/N4ZTDU5/kM6osOBBy661yQNVHKpybRXhfjyKqzAGpFco8sq2CZ3aIrcQ7G
         H4h94YmYzRXXXtNIS6Hqb6AanF2D+UHJf3YOiKgTkJSbcyHxGQjZk9uMtyuuvz3ATC7+
         4jXuV02sXbkIIOvyyOeMK1rxid99sSZlz57Zf8i567aYlnJ5Jiv1O2MmUJNC2E5p/LQ1
         nrzS9SUbCTucuxMYK2+XmrpiHieIIASIhg/Pf6qcUOiWxhPpsSBIf66b3BlO4+mKJ+XH
         eGitefHg719y4DP7Axm6HYksUQklB26aC75ljpZ0H/AHGlk90TJ6s9vKexrUxYiPSyms
         dPUA==
X-Gm-Message-State: AJIora9J5oklTzRWBZoJjznxLnrheDQGnBPp63K5W2uV6j9adZPYG+IX
        j1JKxqiPhtpZuFIrtWIrnR0=
X-Google-Smtp-Source: AGRyM1sA5gow4MBXRzPeAudp6S/ATu7u4oz3OvHAv06UipHkV55TGgMg1kwKUKAuqb+y20oNbcLZXg==
X-Received: by 2002:a17:902:ea0c:b0:16a:4b1d:71bd with SMTP id s12-20020a170902ea0c00b0016a4b1d71bdmr12704433plg.68.1656545552508;
        Wed, 29 Jun 2022 16:32:32 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Josef Bacik <josef@redhat.com>
Subject: [PATCH v2 25/63] dm/dm-flakey: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:07 -0700
Message-Id: <20220629233145.2779494-26-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for structure members that represent request
flags.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Josef Bacik <josef@redhat.com>
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
