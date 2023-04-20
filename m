Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1082C6FD18
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 01:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDTBrw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 21:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDTBrv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 21:47:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D781C10C
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 18:47:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b60366047so463126b3a.1
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681955258; x=1684547258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyurZ/3V3e/TfJ64+oQeFZRXuRpGYngRPpwbALjOBlU=;
        b=OCgRfiXCuStjsazsK/NTRG8oGDsxx2kymbqOUtb5DkGOo4AaKoAVfks39i/pw3VtlW
         HpuCWlh+CByxmIJ1yPC8mnj0TEsEbjqKGq34F7DWBd1qrLUQEDifZ5lUmgOXKP6GrnNy
         Mdb+rAAbOF5E5UOc9S1Z3pCK9q/A1P2p4iX2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681955258; x=1684547258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyurZ/3V3e/TfJ64+oQeFZRXuRpGYngRPpwbALjOBlU=;
        b=NMwHulcfii0kP5+hAIu1205hVc4EdQH+d9HLCsgUig/snOhxVb1bHgSb/0XlQHpH3l
         /l59gg+xRFM2wa/NomUlJb7M08vu5Api+EKXwtmIsJwkCA7Jud18TUiCt98efcYI4cy9
         Hnzxs/BCTvQRFLIK5LF90SbsDXOTrGy4QAc12dDVHfJ1MqjoD11QEQAKNelolBl2hnW/
         0gUwjOA7ou3mOPedvGuGIW3BvGgrnoYt5EYVyP8HL5ouhF9Li6LV5lq7jDchjreg/dc3
         tFAI2208fosmdoX0Dn8SLNslRtKsvMSOSrQdzmjHzl6MbG8KW98jCRkxFg8zGxpIH3Tn
         60tA==
X-Gm-Message-State: AAQBX9cTtpg73tPv5NCXGL7IByBXEJtbaWbEeI/4f+0XVqkIZ3Qzb8Yh
        iwI/cA2MAGkfSp0P4ji+JYotnA==
X-Google-Smtp-Source: AKy350azF3Q2VfJRGkzUywFfeQrYRuuCXsZ99E9a6W8nqlVd2cwXSPd2Fqy1TX8MhR0Y0U2TO1ZDXA==
X-Received: by 2002:a05:6a00:1489:b0:63d:3aed:44fb with SMTP id v9-20020a056a00148900b0063d3aed44fbmr6882651pfu.21.1681955258324;
        Wed, 19 Apr 2023 18:47:38 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:402e:4c2e:4e90:d79d])
        by smtp.gmail.com with ESMTPSA id y4-20020a62ce04000000b006363690dddasm60753pfg.5.2023.04.19.18.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 18:47:37 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v5-fix 1/5] block: Don't invalidate pagecache for invalid falloc modes
Date:   Wed, 19 Apr 2023 18:47:34 -0700
Message-ID: <20230420014734.302304-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230420004850.297045-2-sarthakkukreti@chromium.org>
References: <20230420004850.297045-2-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only call truncate_bdev_range() if the fallocate mode is
supported. This fixes a bug where data in the pagecache
could be invalidated if the fallocate() was called on the
block device with an invalid mode.

Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/fops.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..d359254c645d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -648,26 +648,37 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		goto fail;
-
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
-		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL,
-					     BLKDEV_ZERO_NOUNMAP);
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (!error)
+			error = blkdev_issue_zeroout(bdev,
+						     start >> SECTOR_SHIFT,
+						     len >> SECTOR_SHIFT,
+						     GFP_KERNEL,
+						     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
-		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL,
-					     BLKDEV_ZERO_NOFALLBACK);
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (!error)
+			error = blkdev_issue_zeroout(bdev,
+						     start >> SECTOR_SHIFT,
+						     len >> SECTOR_SHIFT,
+						     GFP_KERNEL,
+						     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
-		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL);
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (!error)
+			error = blkdev_issue_discard(bdev,
+						     start >> SECTOR_SHIFT,
+						     len >> SECTOR_SHIFT,
+						     GFP_KERNEL);
 		break;
 	default:
 		error = -EOPNOTSUPP;
-- 
2.40.0.634.g4ca3ef3211-goog

