Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCAFC7EE30
	for <linux-block@archiver.kernel.org>; Sat,  6 May 2023 06:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEFG3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 May 2023 02:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEFG3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 May 2023 02:29:24 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D77F8A76
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 23:29:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517c01edaaaso1659513a12.3
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 23:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683354562; x=1685946562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WfFr/Ybkjxxlz0qBx9KvOEXPiQmOGJ7KxenW4nxces=;
        b=mJupPz2tREQg3C+oWOIO/cyA+UB+QKYHbfZMxmj+IvofFe8Naoe0Y0D2XyVzoD76Rk
         /sKYPW0WK5m1g+WZoUMgDy8WhIHQh3LUkvRmIFr1SMupXKf+dC7s2hMwy4JE/UHsSGbU
         h1nW3O3Rcvb5h+gAmVfJMWnZQkNuv5GtZx6sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683354562; x=1685946562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WfFr/Ybkjxxlz0qBx9KvOEXPiQmOGJ7KxenW4nxces=;
        b=Clo3MaLkYVnNPSEA5soD9oD3WmCg1BsbMOtXbi4x7pVz9jc3Lud9ZguqrAPy54TC6p
         xWs47PP4aUqF8vjrt7Pcq6ui2DlTu45B+sMGqDcbvpfaF2OA/pAHEjVwxe3K7o0Yanuy
         P5QEuQNV1LhRhJzqC0FSpu4H642KkCd3Ddjc2nN4LMwZaIGF1EcFNU4tOaJY/9jicEGc
         GAqajX4ViW35f0SJThcp9+/KHsL6BHpWdOr4CnRddpI68nvnZ2HF4EQAUJNKSBkLLjRq
         /74QVAYXn2rLN8bc6pZtrSMyHhbkDUqKwGl4BF5zwnXfM7iSyb7DhMz67cneROkQZyje
         7DHA==
X-Gm-Message-State: AC+VfDzFwXJaXrOf5eiz45jK7Pyp5lzTerq13ZDD6h6nOKB5m8Mp3XnK
        Ic/ztZcQPICW5LpqqSeXLBYuFQ==
X-Google-Smtp-Source: ACHHUZ7OAUraDBnWZXSPqOYiIq8qtM/wfnvjpq6zwOo0KtFQaZ+pcntbtfauYsJHK69Wtp4Otp15eA==
X-Received: by 2002:a17:903:120d:b0:1a5:2993:8aa6 with SMTP id l13-20020a170903120d00b001a529938aa6mr4399812plh.63.1683354561829;
        Fri, 05 May 2023 23:29:21 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:f19c:a713:5517:ed4])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001ac381f1ce9sm2793598plx.185.2023.05.05.23.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 23:29:21 -0700 (PDT)
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
        "Darrick J. Wong" <djwong@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v6 1/5] block: Don't invalidate pagecache for invalid falloc modes
Date:   Fri,  5 May 2023 23:29:05 -0700
Message-ID: <20230506062909.74601-2-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230506062909.74601-1-sarthakkukreti@chromium.org>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
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
index d2e6be4e3d1c..4c70fdc546e7 100644
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
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
-- 
2.40.1.521.gf1e218fcd8-goog

