Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7667C77B7E
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 00:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjDTAtC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 20:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjDTAs7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 20:48:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDCF5B9D
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 17:48:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a66b9bd893so5515595ad.1
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 17:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681951737; x=1684543737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8Jg49/KQsZt4WzBpHKtXWTZpexlXZcV39964TwtkKY=;
        b=Q4O+/LqSIe1dsLzJhrazbt5goLnGi1zJWJbTolX3hoDJhRdiYIt8oP3uueEYErY/Me
         zQFFkE4rPiCEQLA8DNT5eqI7xXNcKG9o07MjxHnnVHAWwiIa2Rlq84+FMrIzrcymDMj0
         zmTM8yrT7jralZt9fyBveGGYaxRpJ9r5tkzj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951737; x=1684543737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8Jg49/KQsZt4WzBpHKtXWTZpexlXZcV39964TwtkKY=;
        b=W+Vc18lPLjZvpibHHv/WyDpOUVGfAX/EJ7K3Y3c8m/+KKtVoyTmDOA8uYgaY1wyVr4
         HrWFJZPz53u2PwZKF+HYDZLHrFSl5L1SZd0kAP3UtAsglUVi2Bh2tBgT9wxFzjtwj/3F
         LYkQeqPBTaBVKNPDggND9Np2cfEFFQSc9f5M5IvO3wzxoOPn/eiBp9dSwU/moUgKweQx
         2kJBQQdjAIQV4ndwUVgTOgJjMiKgJQjEXqIl6OqhnH2QvcrfclXCZ33rBfHd6CzwgOsX
         49BnBDakBL6CwhyZy4Ci2VNUPtWz0p5mDfCnU34h4hzb3qOEsEDv7XHt1ryBdOVGkLla
         FelA==
X-Gm-Message-State: AAQBX9cTMYG8NQyhsKqO36ObbhkwOxgVeiP91vD4xpP+dTF1a59FOUF6
        RLYj26m2TH6O08vUVA1odxAT4Q==
X-Google-Smtp-Source: AKy350Zv7+C4nbn5BKw2snuixQns/eVqKDeE09iyFz2LG4XBGopEf6DRHNtYzyNhmmireBFKIpsriQ==
X-Received: by 2002:a17:902:ea0f:b0:19c:b11b:ffca with SMTP id s15-20020a170902ea0f00b0019cb11bffcamr8862265plg.23.1681951736959;
        Wed, 19 Apr 2023 17:48:56 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([2620:15c:9d:200:5113:a333:10ce:e2d])
        by smtp.gmail.com with ESMTPSA id io18-20020a17090312d200b001a65575c13asm74323plb.48.2023.04.19.17.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 17:48:56 -0700 (PDT)
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
Subject: [PATCH v5 1/5] block: Don't invalidate pagecache for invalid falloc modes
Date:   Wed, 19 Apr 2023 17:48:46 -0700
Message-ID: <20230420004850.297045-2-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230420004850.297045-1-sarthakkukreti@chromium.org>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230420004850.297045-1-sarthakkukreti@chromium.org>
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
 block/fops.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..2fd7e8b9ab48 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -648,25 +648,27 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
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
+		error = truncate_bdev_range(bdev, file->f_mode, start, end) ||
+			blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
-		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
+		error = truncate_bdev_range(bdev, file->f_mode, start, end) ||
+			blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
-		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
+		error = truncate_bdev_range(bdev, file->f_mode, start, end) ||
+			blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
 	default:
-- 
2.40.0.634.g4ca3ef3211-goog

