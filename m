Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A35DC19F35
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BAF0610A4
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhHKTgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhHKTgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 15:36:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285C3C061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:35:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e19so4019696pla.10
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPHR9+/srqubnx1IylV7gQnOmmOqOlKCpGfW9/b0t68=;
        b=Gn68Gv0X+76XfYrCArMrLcLPqzknELSJKAuyrHdrGzix21DE/eqSRfrWSFN4SWJaCg
         +JMXaKuFKpMGx0jUV7s64y8UY/0n+9/3xaN2ZQpxjcDgj7wm/KsXdfFfAZO+F0bfMRKy
         YDZQcSKvqvXYeTmYdAl9KshM1rtEGzvRC4Ad9QY6QlH9tZCW6qUP/Y0gVNCDlrNOX63g
         2Q1sUqPz1wd0krTQK5B4gR21aJRh6IFREdrxprE1LuFXzLUVwHpLwymHVOgNn26huGy3
         M1iqqJ+JlVpZmsyRCYGmV2xRtaG4AyZiElS1T3Ld4n+Q0OBx2nb9arZGaOyAmOwwDYvj
         exXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPHR9+/srqubnx1IylV7gQnOmmOqOlKCpGfW9/b0t68=;
        b=B1TALRZj4ObZ5d4cHxwHIf3eHrHJqg/S8Igwf6/P9Y/phHlFDMUaYItrl2B/rXM2LP
         n1jXnMQnxleIpHa/3F2KU0rfcU9m251UpDxUzMrK46/R6VnMjjY92kGgl0jqE52eLtdX
         ucRREz/F0EbckT193OJ269TylDPu710yGMGOlEmjSuAdSqNvGHjU/Pu0ZdyaVCHpX/8x
         TgJ4FS2HrpX0icWmk5Ds3AoaBGRKEb8RXbaIx8fduuPhSexZYr8mPKIUw3e8YDJ8GkHz
         YWA5h0S0kn4meaKJ2ctw0JZqzvYhusbmTL2psqVP8so41VVF7C/IZ81cD5AyAJMUUw32
         H/MA==
X-Gm-Message-State: AOAM5312JYw4h8yUlR91um1QTMsCnrmW8zDim6V0KqkUUZoC5UznIJax
        bQHiLqkpGnQg+50FPb/caOXaVw==
X-Google-Smtp-Source: ABdhPJwtoG2aWyj8p2ouXV0qKbPEkI2k8GUibvKupEVpZmlq5szola+EWrLsdd7T7R6joLqN3r5/lg==
X-Received: by 2002:a05:6a00:888:b029:3c3:ff1:38e with SMTP id q8-20020a056a000888b02903c30ff1038emr317565pfj.17.1628710544550;
        Wed, 11 Aug 2021 12:35:44 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u20sm286487pgm.4.2021.08.11.12.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:35:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] block: enable use of bio allocation cache
Date:   Wed, 11 Aug 2021 13:35:33 -0600
Message-Id: <20210811193533.766613-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811193533.766613-1-axboe@kernel.dk>
References: <20210811193533.766613-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Initialize the bio_set used for IO with per-cpu bio caching enabled,
and use the new bio_alloc_kiocb() helper to dip into that cache.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9ef4f1fc2cb0..798bb9d8f533 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -385,7 +385,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
+	bio = bio_alloc_kiocb(iocb, GFP_KERNEL, nr_pages, &blkdev_dio_pool);
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->is_sync = is_sync = is_sync_kiocb(iocb);
@@ -513,7 +513,9 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static __init int blkdev_init(void)
 {
-	return bioset_init(&blkdev_dio_pool, 4, offsetof(struct blkdev_dio, bio), BIOSET_NEED_BVECS);
+	return bioset_init(&blkdev_dio_pool, 4,
+				offsetof(struct blkdev_dio, bio),
+				BIOSET_NEED_BVECS|BIOSET_PERCPU_CACHE);
 }
 module_init(blkdev_init);
 
-- 
2.32.0

