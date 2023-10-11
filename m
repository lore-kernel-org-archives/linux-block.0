Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40465CDB47E
	for <linux-block@archiver.kernel.org>; Wed, 11 Oct 2023 20:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjJKUMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 16:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJKUMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 16:12:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679CA9
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 13:12:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9b70b9656so1685485ad.1
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697055156; x=1697659956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQNnXBnSwzfsN2zrI7/k3aUY1SO1WpMoDwjEZpkrIxM=;
        b=Yo4Q9xdIFr68Wucs1ifeWk5zzo6mpTk23PUK4877tDeNxUT6CDiDDdTOUGHGLNeMTR
         GBM7NgfKkr2feCVJQypkGgCDDHNkU6H7toLWftB1Q92P6gbcuutxH9NDa5WZjDWaIFg6
         Ew+8TxPS2uFzCf/LZx7OBa1ncesTw7KwgK0Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697055156; x=1697659956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQNnXBnSwzfsN2zrI7/k3aUY1SO1WpMoDwjEZpkrIxM=;
        b=RsBungTLuXHYSUZpCEMNXV3Ounqd8d3u7kROEHyA/jdlYVV5M92ZzH+lhbsQqCz5qn
         8ud8P6S2YaoJFhx3GEmOY7yS4+qz9IZ+ZlOV7HmtHt9HQUz008Cc23w+OrN+vL2SaS9w
         OJtqWyE6ENii4zIR2JpLknR4n6uHiWdwzCid9R3LW8tM3nRVBPZxYO5Xmph2EpeNgpmM
         KSD1q+OkoC7ziPdnyY9C26YYHAWjuYc0s3eHLr8bTnAluA+Svajq0h/c9dS1A54EE7kU
         NGnm+103GSTWO4h1R9+/kU9h1++23gAccoGbY+z0v3CDDNtMHsABvc7WWMMlN8g2W0NA
         pFxw==
X-Gm-Message-State: AOJu0YzK7Q2nliAXqsoVMsg3kwrMABdsn7o55o17cEBQXOP9/Z3YZPo6
        k3RedRbCCpXptB681hhFubIJ9vgLwwigSi0sN28=
X-Google-Smtp-Source: AGHT+IHnC5io+CLGcm9SFSID5XfybPMNO3Vqy63f8KprIuTpCwNwyaYRhoXL3YLKxVI+4yIF8orucA==
X-Received: by 2002:a17:902:db10:b0:1bd:f7d7:3bcd with SMTP id m16-20020a170902db1000b001bdf7d73bcdmr21362238plx.50.1697055156027;
        Wed, 11 Oct 2023 13:12:36 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:2c44:f765:835a:f6b3])
        by smtp.gmail.com with UTF8SMTPSA id jc5-20020a17090325c500b001bf8779e051sm233685plb.289.2023.10.11.13.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:12:35 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH] block: Don't invalidate pagecache for invalid falloc modes
Date:   Wed, 11 Oct 2023 13:12:30 -0700
Message-ID: <20231011201230.750105-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
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
Cc: stable@vger.kernel.org
Reported-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 block/fops.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index acff3d5d22d4..73e42742543f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -772,24 +772,35 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
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
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
-- 
2.42.0.609.gbb76f46606-goog

