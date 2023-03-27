Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E11DC76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjC0UOZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjC0UOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:25 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77562100
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:37 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id cn12so6457696qtb.8
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwFipSc82OIEFDU8Id4luDtLttcFOJWrHTnvxSKayKA=;
        b=mLYedgBLA5EDUqW7ZZnumufDDDQ2VubdDrhvPw5q6Bn2tQIbOgdzq3TkAaWUT6Fl3o
         ykM7PgetnBwq69g9AeWkSgX/OTJhk402C7d/nUYOL0q3CFjIFYwELk9nYALHbNkXJwU0
         dLSjrBpzn7lUaonMHTUwLlYCD8I+cwmf14URDVJsHkYGYgPG0khEHZyy1daGlgoLAbYU
         eLqrwiZ7Dzp5Z5Y33AbT9A4tt5z+jhuTvgx9Sa/9oaeYr2EsWrtXnH6LsSiGbJ3E4PyJ
         4dq5gn54iAzYpSfPOcv0L3iwRHLjq1w0dQ63tgxABttY858AeE/f9fbXSaj7LVuBJI9p
         lmtg==
X-Gm-Message-State: AO0yUKUjB17E4jmHYZe5ZdMg4ajbpWgtaLaN4ZTQCF0tf/w3WS/0AIer
        SWO/MHDfxMkaDFRMseXqvjYw
X-Google-Smtp-Source: AK7set/FmDxDs4w1j0e5PA+jX3MwJRj6+AOGAADIBIksQBRZljk9BW4Q1CQMIOVrgNxvcG4up41zZQ==
X-Received: by 2002:a05:622a:c6:b0:3b6:2c3b:8c00 with SMTP id p6-20020a05622a00c600b003b62c3b8c00mr23270455qtw.66.1679948016921;
        Mon, 27 Mar 2023 13:13:36 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b0074269db4699sm10226828qkp.46.2023.03.27.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:36 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 18/20] dm bufio: intelligently size dm_buffer_cache's buffer_trees
Date:   Mon, 27 Mar 2023 16:11:41 -0400
Message-Id: <20230327201143.51026-19-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Size the dm_buffer_cache's number of buffer_tree structs using
dm_num_sharded_locks().

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 2250799a70e4..7dc53f3d0739 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -21,6 +21,8 @@
 #include <linux/stacktrace.h>
 #include <linux/jump_label.h>
 
+#include "dm.h"
+
 #define DM_MSG_PREFIX "bufio"
 
 /*
@@ -379,8 +381,6 @@ struct dm_buffer {
  * only enough to ensure get/put are threadsafe.
  */
 
-#define NR_LOCKS 64
-
 struct buffer_tree {
 	struct rw_semaphore lock;
 	struct rb_root root;
@@ -393,7 +393,7 @@ struct dm_buffer_cache {
 	 * on the locks.
 	 */
 	unsigned int num_locks;
-	struct buffer_tree trees[NR_LOCKS];
+	struct buffer_tree trees[];
 };
 
 static inline unsigned int cache_index(sector_t block, unsigned int num_locks)
@@ -976,7 +976,7 @@ struct dm_bufio_client {
 	 */
 	unsigned long oldest_buffer;
 
-	struct dm_buffer_cache cache;
+	struct dm_buffer_cache cache; /* must be last member */
 };
 
 static DEFINE_STATIC_KEY_FALSE(no_sleep_enabled);
@@ -2422,6 +2422,7 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 					       unsigned int flags)
 {
 	int r;
+	unsigned int num_locks;
 	struct dm_bufio_client *c;
 	char slab_name[27];
 
@@ -2431,12 +2432,13 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 		goto bad_client;
 	}
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	num_locks = dm_num_sharded_locks();
+	c = kzalloc(sizeof(*c) + (num_locks * sizeof(struct buffer_tree)), GFP_KERNEL);
 	if (!c) {
 		r = -ENOMEM;
 		goto bad_client;
 	}
-	cache_init(&c->cache, NR_LOCKS);
+	cache_init(&c->cache, num_locks);
 
 	c->bdev = bdev;
 	c->block_size = block_size;
-- 
2.40.0

