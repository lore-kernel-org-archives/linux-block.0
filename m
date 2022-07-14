Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F178BC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbiGNSJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiGNSJQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:16 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62DF1EAFD
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:56 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id s21so3538172pjq.4
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAnIQ2wh50N6A6804+eipwwgwCEnXx4ebscWIM0KY2w=;
        b=sKJ8wDa8AL4ERwJMzM7Lqi16Civcdn5LrEzGLgoNIsCTEFoOdJlQGZI3k2ejc2Zrgx
         84oC53bAqjXwrTwjn9ux82snC0ywMpjSFXYk+fC9uZr5cURfm1XKNNHfU5e0FuehZvm+
         ovcfmJSOYmN5ozdZQLZ1NENOMpDZz+xJFxTG316/CaBLKDb/RFFjXr83u7g1vOFUk9qe
         vyvwMkS5Qc3D/c/5fbUXxTjVNvRi03+KM5sPwmSN6WsPcjwRYkXufFDEHeWVkZFiH4zm
         KzG9aB6Oh7WCT+OffEamEUex0ecM7LhaONXf49pBrBptON6ByWq145V6bkeja3QU21ow
         pPjQ==
X-Gm-Message-State: AJIora/0f6CHSTOBPy869NURoBZnaSure248YybplonQPLI/4ORiKKD3
        PqwWPCY43zhMhwQ18PHbWoGS2BdWors=
X-Google-Smtp-Source: AGRyM1sdYbemMLv8WyZ4I4PtCKF5COYgdTydXnnFpcR60okjRZ44DmLQ2jzIHtyj2gbFqsHaooV5FQ==
X-Received: by 2002:a17:902:f691:b0:16c:4fb6:e08b with SMTP id l17-20020a170902f69100b0016c4fb6e08bmr9753653plg.174.1657822135920;
        Thu, 14 Jul 2022 11:08:55 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 49/63] fs/mpage: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:15 -0700
Message-Id: <20220714180729.1065367-50-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for the
combination of a block layer request with block layer request flags.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/mpage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 0d25f44f5707..c6d8bf8c22a5 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -145,13 +145,13 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	struct block_device *bdev = NULL;
 	int length;
 	int fully_mapped = 1;
-	int op = REQ_OP_READ;
+	blk_opf_t opf = REQ_OP_READ;
 	unsigned nblocks;
 	unsigned relative_block;
 	gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 
 	if (args->is_readahead) {
-		op |= REQ_RAHEAD;
+		opf |= REQ_RAHEAD;
 		gfp |= __GFP_NORETRY | __GFP_NOWARN;
 	}
 
@@ -269,7 +269,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 								page))
 				goto out;
 		}
-		args->bio = bio_alloc(bdev, bio_max_segs(args->nr_pages), op,
+		args->bio = bio_alloc(bdev, bio_max_segs(args->nr_pages), opf,
 				      gfp);
 		if (args->bio == NULL)
 			goto confused;
