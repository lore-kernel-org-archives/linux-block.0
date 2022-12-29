Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623AFC4332F
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 08:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiL2INX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 03:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiL2INT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 03:13:19 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B405711A16
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 00:13:06 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b2so18283445pld.7
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97i6P/h7b+1gvIVRYO+DX34CDfR4Yqv0wh8jpsVN6uA=;
        b=J3UxtnO0lRODuALIZIbXFjggUs9csqzYnLWy6fCUhVcEssVoXOgvKDKzSKMFzlyrjx
         IAcfKrnfFQdpsDZbxkBzRb3HsHRv4Zx0R+LRjDqk5C1MorbFDuEtB4dQo6e2wnJcboJU
         lOoPqaeq28xjwQUyT3StdCsVbKKsSKUNoIs8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97i6P/h7b+1gvIVRYO+DX34CDfR4Yqv0wh8jpsVN6uA=;
        b=FTbBPwUGkUeRkUtZ956P10WfcatfZVqSa4hlD4HOPWgR/mor/Kl93l+wz8PTN+bHlF
         E+TIQg4PWi8ubvYLkJ9/e6aNYEnuJ23zzwWQoDq/UWdjgro3n5UOz+1WEa2KPq8chIXQ
         MbpW9FU1hmMDIbUmZ39GOsQbBYQ8drUGPS4e2Wut0WjmmXRJ7kYyCeEVCs4NOoi2EQPf
         OlrIXojHcC206U++/wPSz5q4ITo6D+Eyf+6YBiTVW/3y3Umo8fmlNlraMoV3KEYfAxbL
         m0XhmsHm+I6t+kc5CLMm8Bq/yeK5MpEZDd/iWZXmRFSP1CgutRuEHFNbMrU0PyMnv9KN
         YIAg==
X-Gm-Message-State: AFqh2kqoOibwOlP+WIJIOk9uy4Roy9Q4TxFQCMPkNSIyKhOtW4ogw/mq
        25+RWmsaeMZpbh/QJSCQWBeaaA==
X-Google-Smtp-Source: AMrXdXuG8djGml0FmIoeHtIQvCDtglHyJ1RnAJ0w5NvdgLWhnB8c6w6P+S+xrI2iEBZecvFqN4EojA==
X-Received: by 2002:a17:902:9687:b0:192:9ab2:fd1c with SMTP id n7-20020a170902968700b001929ab2fd1cmr2910136plp.26.1672301586179;
        Thu, 29 Dec 2022 00:13:06 -0800 (PST)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:75ff:1277:3d7b:d67a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b00192820d00d0sm6496325plk.120.2022.12.29.00.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:13:05 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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
Subject: [PATCH v2 3/7] fs: Introduce FALLOC_FL_PROVISION
Date:   Thu, 29 Dec 2022 00:12:48 -0800
Message-Id: <20221229081252.452240-4-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221229081252.452240-1-sarthakkukreti@chromium.org>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FALLOC_FL_PROVISION is a new fallocate() allocation mode that
sends a hint to (supported) thinly provisioned block devices to
allocate space for the given range of sectors via REQ_OP_PROVISION.

The man pages for both fallocate(2) and posix_fallocate(3) describe
the default allocation mode as:

```
The default operation (i.e., mode is zero) of fallocate()
allocates the disk space within the range specified by offset and len.
...
subsequent writes to bytes in the specified range are guaranteed
not to fail because of lack of disk space.
```

For thinly provisioned storage constructs (dm-thin, filesystems on sparse
files), the term 'disk space' is overloaded and can either mean the apparent
disk space in the filesystem/thin logical volume or the true disk
space that will be utilized on the underlying non-sparse allocation layer.

The use of a separate mode allows us to cleanly disambiguate whether fallocate()
causes allocation only at the current layer (default mode) or whether it propagates
allocations to underlying layers (provision mode) for thinly provisioned filesystems/
block devices. For devices that do not support REQ_OP_PROVISION, both these
allocation modes will be equivalent. Given the performance cost of sending provision
requests to the underlying layers, keeping the default mode as-is allows users to
preserve existing behavior.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/fops.c                | 15 +++++++++++----
 include/linux/falloc.h      |  3 ++-
 include/uapi/linux/falloc.h |  8 ++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 50d245e8c913..01bde561e1e2 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -598,7 +598,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
-		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
+		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |	\
+		 FALLOC_FL_PROVISION)
 
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
@@ -634,9 +635,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	filemap_invalidate_lock(inode->i_mapping);
 
 	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		goto fail;
+	if (mode != FALLOC_FL_PROVISION) {
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+	}
 
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
@@ -654,6 +657,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
+	case FALLOC_FL_PROVISION:
+		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
+					       len >> SECTOR_SHIFT, GFP_KERNEL);
+		break;
 	default:
 		error = -EOPNOTSUPP;
 	}
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index f3f0b97b1675..b9a40a61a59b 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -30,7 +30,8 @@ struct space_resv {
 					 FALLOC_FL_COLLAPSE_RANGE |	\
 					 FALLOC_FL_ZERO_RANGE |		\
 					 FALLOC_FL_INSERT_RANGE |	\
-					 FALLOC_FL_UNSHARE_RANGE)
+					 FALLOC_FL_UNSHARE_RANGE |	\
+					 FALLOC_FL_PROVISION)
 
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_X86_64)
diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
index 51398fa57f6c..2d323d113eed 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -77,4 +77,12 @@
  */
 #define FALLOC_FL_UNSHARE_RANGE		0x40
 
+/*
+ * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
+ * blocks for the range/EOF.
+ *
+ * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
+ */
+#define FALLOC_FL_PROVISION		0x80
+
 #endif /* _UAPI_FALLOC_H_ */
-- 
2.37.3

