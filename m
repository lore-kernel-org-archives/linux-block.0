Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556C3C7EE20
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 17:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDTR2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjDTR23 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 13:28:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DC14ECE
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 10:28:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so1744779b3a.2
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682011701; x=1684603701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3x8N7sxsFvg5b0uwbahj+PwbPcqRN9aSzyeMa7PrIzY=;
        b=PInXabSKPMPkpHkuZFbSfZyAVvTSjLv36Kr/cvSO8TjzWJ6vlXl0FTCM4HkL4ZD4vw
         aQGfOydJeFSTT7e0EsizobBwWZQwg9OQ166TMTtcAizTmIwmi1rXZ701QcJfeofeXRlS
         9cUaCm4t2WOGkiOxpO7Yj6DFl8oRlg4ewN0fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011701; x=1684603701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3x8N7sxsFvg5b0uwbahj+PwbPcqRN9aSzyeMa7PrIzY=;
        b=AzewTNW4CO0vNubjTGtI4GHnvZ/cCg+qg5yQhBfJjBLMLDH+d3V22Llaq7R/uzOigD
         qBSWFkQHPKcO5fw/AK7i2tJs/3/+dENNnG1fcep4KISS+up5KAEkttbXf+pVeA5zrDrt
         mrdmAt0Or+tmU8RFuaXZMge6sFNmFm8stPzcP/1WE1pJmGTMPiIq7dC23aAASLc7x7yz
         ZDpnmKLywXQwE00IgdiqMI44J1ldgoIP4n2qRucX9k9Jrrqtomab3afV1fBf++rez0pz
         wBGC1afqf4KJykT6CbTwL935rGSclFayvbZm357QJMeP5StyTryGSm6pzFV8o988MD+D
         dKlw==
X-Gm-Message-State: AAQBX9csDy8kQbBUTMhY7Ao12LiQHORQ0PoqnV7iBzEGxe/g5aKh3hBc
        XkXo8iQoZIhxtJBQTEVB80Mzlg==
X-Google-Smtp-Source: AKy350aamevL738b4lQu+r4Mb45ADgAjxr+szLfVa8OCWWSr0APnPjIlT0WZwrlfZ+8BR9m9vFOf1A==
X-Received: by 2002:a05:6a20:d38d:b0:f0:558b:8fbb with SMTP id iq13-20020a056a20d38d00b000f0558b8fbbmr2889057pzb.34.1682011700784;
        Thu, 20 Apr 2023 10:28:20 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:42d9:debc:8d41:e6c4])
        by smtp.gmail.com with ESMTPSA id t9-20020a6549c9000000b0051b3ef1295csm1360372pgs.53.2023.04.20.10.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:28:20 -0700 (PDT)
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
        "Darrick J. Wong" <djwong@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v5-fix 1/5] block: Don't invalidate pagecache for invalid falloc modes
Date:   Thu, 20 Apr 2023 10:28:07 -0700
Message-ID: <20230420172807.323150-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.396.gfff15efe05-goog
In-Reply-To: <ZEFmS9h81Wwlv9+/@redhat.com>
References: <ZEFmS9h81Wwlv9+/@redhat.com>
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
---
 block/fops.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..20b1eddcbe25 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -648,24 +648,35 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
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
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (!error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
-- 
2.40.0.396.gfff15efe05-goog

