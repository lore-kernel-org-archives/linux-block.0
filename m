Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9CEC4320E
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403D7610CC
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbhHLPmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 11:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbhHLPmX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 11:42:23 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD9C061756
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 08:41:57 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u25so10988685oiv.5
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGh3DHNk1Pecrp3DYsOdrKTAPnauoq0TCqYdAequptQ=;
        b=DoiXWpYd2RHBJtHUgUh4Sg78Sfmx9ShUnUChmtkfLaqByRc92ip3oxNL7yYQexaD/C
         JD4pI0eg2qtQ7FKB9ZwvqN7KtRjvhEB9cOONFqlamaahBTI8tpXX7x+lVm9zJk8A2jqh
         349Qb3zWWDWc7QG3Li16aSaaNFnNU7T1EQQwyFsJDPqsloZOG4x/3pLzEVNGHf8jC5NN
         B3P2VIfL0MaB1StYr/72pS3HUHoTg78KkAh1blNi0uyYWp1qHJPLVTB9daT/ejJvD9nI
         ETNjPm/CtGeBH/CN8To+Mxo6zIF3cFO9XWv4huH0PzMN0wgg1hv8lZc+wJIWTgCifjgj
         aSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGh3DHNk1Pecrp3DYsOdrKTAPnauoq0TCqYdAequptQ=;
        b=ojdIt4jCTomJea7HurkHlFNssAF24OnA0Bzwgr6EpnVMaxAhSMmJSVdcQkEP2WjIZD
         z/JoRe8tQdxLGBq453If0J3KU2SF15gENUuYoW2MiaXPQBQiEK6ChLiK4Fo0Uix8vqCO
         uTHE2Ac0Rolassa0Zbm/wFI7945ibB8p0QSpzm2lG6nkUBR9gisl3GPy5uHJMtunSIJN
         S5uBZPPp2GPsEPU0gf5kDlLDk/TyPT+5WhzG592R00x4VHf4LHVvSYrq/q6DcM0310OK
         CaLW/6AGnWbx1mcN3lt49N23ggnUPeTTI7iCkFCtMsdFAby5QtzMh/j7nTTegs2j4/Do
         huEQ==
X-Gm-Message-State: AOAM532Xrrj/ddWjF/90D2iXSwUmdRsQiph3tMWyslUrVyPsInT1pAbS
        xUcyNAnzypuHn7WaIVLPke945g==
X-Google-Smtp-Source: ABdhPJx9b5fJYV9wguO/TCBrHRqtklbv/5xdkxNojagYy4U/38VaU5evI1UFOdIYrEs7Mxo2EDhWnw==
X-Received: by 2002:aca:230e:: with SMTP id e14mr3673238oie.93.1628782917172;
        Thu, 12 Aug 2021 08:41:57 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w16sm690973oih.19.2021.08.12.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 08:41:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] block: use the percpu bio cache in __blkdev_direct_IO
Date:   Thu, 12 Aug 2021 09:41:49 -0600
Message-Id: <20210812154149.1061502-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812154149.1061502-1-axboe@kernel.dk>
References: <20210812154149.1061502-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Use bio_alloc_kiocb to dip into the percpu cache of bios when the
caller asks for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9ef4f1fc2cb0..3c7fb7106713 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -385,7 +385,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
+	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
 
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

