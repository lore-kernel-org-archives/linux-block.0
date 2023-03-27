Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBB9C6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjC0UOH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjC0UOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:06 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060C81BFD
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:22 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id cr18so5981723qtb.0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9SedxOrdczzTjA4k7blz5Fc7tZ0dfZriRfxA3Ti63I=;
        b=o6M0OlzKJOuribECt8iVPIfFtmtO4Tc7V0v/FXjM/gzCbtTc/LYxdQSZLh+2mcvHfU
         90Do/GtYfocPQ6UvY7JFWRn1/OD9IxDDw6wyMfx1YCE+ncufDUlLVPZAsNoyTXUrk0qc
         md/gsBr0KCTi3CLTk4UYWpi4VkTJ+MGvJ+uuFtnQfkym/PtGGF7Cx94HFfYhmhtW43wS
         1qeyNYyxuhFt0vMEXGlk+qRaaoc1qcDWlcYcA02BgdAGiE3+vhM5qTODgqZ1P8fDmarU
         SgAgHW+nNMM2Vekeie55QxHhc8sczgjCCQzySJlSV+Wrjs0mHwqisARRqteLnoEoCl//
         8b+w==
X-Gm-Message-State: AO0yUKV8IcwQovcs9Xn4J8Y3KbxK0Hi5rdx/kcUTUoaYskH9MQAUf/ye
        3SXl9B34EQCqX/h6fwozA0Cr
X-Google-Smtp-Source: AK7set98Y7dLUBXYMxUAgPYJRwSwe5G/4pJt7wTHoABVMGSpSmarcdzS7b1UEdwaYPt5vQLyrZsh/w==
X-Received: by 2002:a05:622a:170b:b0:3e3:7e24:a35a with SMTP id h11-20020a05622a170b00b003e37e24a35amr21832421qtk.9.1679948001588;
        Mon, 27 Mar 2023 13:13:21 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id 201-20020a3708d2000000b007456efa7f73sm12278213qki.85.2023.03.27.13.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:21 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 09/20] dm bufio: move dm_bufio_client members to avoid spanning cachelines
Date:   Mon, 27 Mar 2023 16:11:32 -0400
Message-Id: <20230327201143.51026-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
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
index 9ac50024006d..e5459741335d 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -936,13 +936,16 @@ static void cache_remove_range(struct dm_buffer_cache *bc,
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
@@ -954,23 +957,22 @@ struct dm_bufio_client {
 
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

