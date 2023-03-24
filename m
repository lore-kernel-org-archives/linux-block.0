Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5807C6FD1C
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 18:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjCXSE7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjCXSDv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 14:03:51 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4222DF5
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 11:02:18 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x8so2102860qvr.9
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 11:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QR+NKzxABFRAZ1kdMJ3IPIOMmvU3M9l0qrVDn7DCiqI=;
        b=eI7ct8guKBN3tJD7F0YTcYK288/kobNJR2kaKV+rLTkUuvD2Iasqi4LFGK8jUDu0uN
         d1NYinAPEqPlu5H45Lw4ZTeS5wZYgjyaWZYYye1sw5sp11DUYhaeylaSTu6U7E/Mv7Ui
         zexlpwIIzZgi+zcqUn3DwoIYsTqTso8RA53msCEWIrOVSlGouMX2vY0bUwRaUB7GIGwg
         qG+RBi2MtGfqINEPXwjvlbeWCZUwWNWRKStPXHAB9PeT0GJS3Z45MZO9MzZvxhL6Ro1L
         Zth1suFjUHRu/8w8Cxo3nbExHXywPamN9RqxV3hWO4CEYQBp7E5T1unmcnXEMnxUFUeE
         WSAA==
X-Gm-Message-State: AO0yUKWYMdOZlpdiBdmIt5G0BOjwtRvF09YHZKPGFuORIZYl2xAOWlNU
        zx9M3pCow10B95vtng4t7MUG
X-Google-Smtp-Source: AK7set9yhCEH2wAHH1Xt7DHGpawlCcVwVYIClvxbWIOkYTRq5XFKVwkEeJY+FKtLd6Dp+vZSYuNOrw==
X-Received: by 2002:a05:6214:501e:b0:584:8c13:3041 with SMTP id jo30-20020a056214501e00b005848c133041mr17397443qvb.24.1679680626298;
        Fri, 24 Mar 2023 10:57:06 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id u1-20020a05621411a100b005dd8b9345besm852144qvv.86.2023.03.24.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:57:05 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, ejt@redhat.com, mpatocka@redhat.com,
        heinzm@redhat.com, nhuck@google.com, ebiggers@kernel.org,
        keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v2 4/9] dm bufio: move dm_bufio_client members to avoid spanning cachelines
Date:   Fri, 24 Mar 2023 13:56:51 -0400
Message-Id: <20230324175656.85082-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324175656.85082-1-snitzer@kernel.org>
References: <20230324175656.85082-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Movement also consolidates holes in dm_bufio_client struct. But the
overall size of the struct isn't changed.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index a58f8ac3ba75..929685011e02 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -952,13 +952,16 @@ static void cache_remove_range(struct dm_buffer_cache *bc,
  *	context.
  */
 struct dm_bufio_client {
-	struct mutex lock;
-	spinlock_t spinlock;
-	bool no_sleep;
-
 	struct block_device *bdev;
 	unsigned int block_size;
 	s8 sectors_per_block_bits;
+
+	bool no_sleep;
+	struct mutex lock;
+	spinlock_t spinlock;
+
+	int async_write_error;
+
 	void (*alloc_callback)(struct dm_buffer *buf);
 	void (*write_callback)(struct dm_buffer *buf);
 	struct kmem_cache *slab_buffer;
@@ -970,23 +973,22 @@ struct dm_bufio_client {
 
 	unsigned int minimum_buffers;
 
-	struct dm_buffer_cache cache;
-	wait_queue_head_t free_buffer_wait;
-
 	sector_t start;
 
-	int async_write_error;
-
-	struct list_head client_list;
-
 	struct shrinker shrinker;
 	struct work_struct shrink_work;
 	atomic_long_t need_shrink;
 
+	wait_queue_head_t free_buffer_wait;
+
+	struct list_head client_list;
+
 	/*
 	 * Used by global_cleanup to sort the clients list.
 	 */
 	unsigned long oldest_buffer;
+
+	struct dm_buffer_cache cache;
 };
 
 static DEFINE_STATIC_KEY_FALSE(no_sleep_enabled);
-- 
2.40.0

