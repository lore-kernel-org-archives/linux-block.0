Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C11C76196
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 18:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjCXSAG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjCXR7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 13:59:37 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4341D931
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:03 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id c19so2182125qtn.13
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPEdicCB9nRHVOXH2vFQPCJlJzheS4Tji6ZAfc8sIpM=;
        b=WoIKEs4J6rNjn1u+3fBlUwzg5HRY59i48aATCqZHGmok+z/s1pS7rKB73y4tk3/uXb
         q9v0bDnQe8zYKAPkoDwIEE2xuiSGwvmfbtV7G1Ycx4jDxvq4OynW9txpQTeoCe8lfiIh
         /AZSPg+pGV5jjk7+f2cdySO+7bBuw0S2+7JfXGwEjGVr1eahqKoXrfBH1ZWLfbwM9//q
         fqGJw83nTKd8zvkfOJpmzjYooCRKbtMdoPRKDkitwlJT2oRZOJpKAOsALCnGJSgmfM9J
         xmkkN/MA/sIkqN6qO6l9PlYvSOSk+qaimK7/P04lk9xaY/oQMCm2FURpI8AmcEyXEWOm
         0xrQ==
X-Gm-Message-State: AO0yUKWt+FTzJ+RNb8ItVCz2aKFtiz52YKROeHmP/i1tNmHjQXL3MKMb
        UC/nxPDK6BNXL8JULTZK+Sdh
X-Google-Smtp-Source: AK7set874hQQKW0EEPbAQ7o+UY6Py6ockTr+/OJGNDaye/vhx4Jz7AyzqhfNoaP3JCO5x35hKOaRCA==
X-Received: by 2002:a05:622a:b:b0:3bf:d161:79a1 with SMTP id x11-20020a05622a000b00b003bfd16179a1mr6603831qtw.29.1679680623345;
        Fri, 24 Mar 2023 10:57:03 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id 11-20020a37060b000000b0071d0f1d01easm8319902qkg.57.2023.03.24.10.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:57:02 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, ejt@redhat.com, mpatocka@redhat.com,
        heinzm@redhat.com, nhuck@google.com, ebiggers@kernel.org,
        keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v2 2/9] dm bufio: move dm_buffer struct
Date:   Fri, 24 Mar 2023 13:56:49 -0400
Message-Id: <20230324175656.85082-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324175656.85082-1-snitzer@kernel.org>
References: <20230324175656.85082-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Movement prepares for finer grained dm_buffer changes, in the next
commit, to be more easily seen.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 97 ++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 79434b38f368..1de1bdcda1ce 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -66,6 +66,56 @@
 #define LIST_DIRTY	1
 #define LIST_SIZE	2
 
+/*
+ * Buffer state bits.
+ */
+#define B_READING	0
+#define B_WRITING	1
+#define B_DIRTY		2
+
+/*
+ * Describes how the block was allocated:
+ * kmem_cache_alloc(), __get_free_pages() or vmalloc().
+ * See the comment at alloc_buffer_data.
+ */
+enum data_mode {
+	DATA_MODE_SLAB = 0,
+	DATA_MODE_GET_FREE_PAGES = 1,
+	DATA_MODE_VMALLOC = 2,
+	DATA_MODE_LIMIT = 3
+};
+
+struct dm_buffer {
+	struct rb_node node;
+	struct list_head lru_list;
+	struct list_head global_list;
+
+	sector_t block;
+	void *data;
+	unsigned char data_mode;		/* DATA_MODE_* */
+
+	unsigned int accessed;
+	unsigned int hold_count;
+	unsigned long last_accessed;
+
+	unsigned char list_mode;		/* LIST_* */
+	blk_status_t read_error;
+	blk_status_t write_error;
+	unsigned long state;
+	unsigned int dirty_start;
+	unsigned int dirty_end;
+	unsigned int write_start;
+	unsigned int write_end;
+	struct dm_bufio_client *c;
+	struct list_head write_list;
+	void (*end_io)(struct dm_buffer *b, blk_status_t bs);
+#ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
+#define MAX_STACK 10
+	unsigned int stack_len;
+	unsigned long stack_entries[MAX_STACK];
+#endif
+};
+
 /*
  * Linking of buffers:
  *	All buffers are linked to buffer_tree with their node field.
@@ -117,53 +167,6 @@ struct dm_bufio_client {
 	atomic_long_t need_shrink;
 };
 
-/*
- * Buffer state bits.
- */
-#define B_READING	0
-#define B_WRITING	1
-#define B_DIRTY		2
-
-/*
- * Describes how the block was allocated:
- * kmem_cache_alloc(), __get_free_pages() or vmalloc().
- * See the comment at alloc_buffer_data.
- */
-enum data_mode {
-	DATA_MODE_SLAB = 0,
-	DATA_MODE_GET_FREE_PAGES = 1,
-	DATA_MODE_VMALLOC = 2,
-	DATA_MODE_LIMIT = 3
-};
-
-struct dm_buffer {
-	struct rb_node node;
-	struct list_head lru_list;
-	struct list_head global_list;
-	sector_t block;
-	void *data;
-	unsigned char data_mode;		/* DATA_MODE_* */
-	unsigned char list_mode;		/* LIST_* */
-	blk_status_t read_error;
-	blk_status_t write_error;
-	unsigned int accessed;
-	unsigned int hold_count;
-	unsigned long state;
-	unsigned long last_accessed;
-	unsigned int dirty_start;
-	unsigned int dirty_end;
-	unsigned int write_start;
-	unsigned int write_end;
-	struct dm_bufio_client *c;
-	struct list_head write_list;
-	void (*end_io)(struct dm_buffer *buf, blk_status_t stat);
-#ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-#define MAX_STACK 10
-	unsigned int stack_len;
-	unsigned long stack_entries[MAX_STACK];
-#endif
-};
-
 static DEFINE_STATIC_KEY_FALSE(no_sleep_enabled);
 
 /*----------------------------------------------------------------*/
-- 
2.40.0

