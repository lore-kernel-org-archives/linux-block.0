Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86E5C6FD1C
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 18:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjCXSAN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjCXR7x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 13:59:53 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD7223301
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:18 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id x8so2102700qvr.9
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNKDXzqz05HkFrPteMNUMY0uT7UJYCgf272zyuZUZl4=;
        b=EDViqI/ERuR/bpBcTzv4RG2IbqAcItiSEH9H7CQv41uc2Xl/yEZA+flVSWolnFUhA1
         +nm2PDa+bHe+ZW+Wz48DCp+RDGOUwk32sfUDt8eqh0L7V6t52YxCFDaalzkcyMruwSfK
         VN3ACc5M9k/csK4scjlo1Lk2SQg6dXf2+xL4Kk6hNAfs7VDaTbmlTRMxQJZLdUh6STq+
         7zwAmuWOkmTjsuKssPWjbbM5UVVE/j484FD8R5mPZdpVKMA4Lw3ILMTfCkvR22LdAYMK
         gVtkLRBF/0VN4ZB2fleMWQgTqALotlSvoevBtDUh3TZ8qk04SlaJR1u8lsFcIiN3Gejn
         +vLg==
X-Gm-Message-State: AAQBX9chukU9IS6WEKFzJ/6IoZ4pinNP1ObPLfLaYKUN/HYic6/TjT1q
        EoRKf2AiVWmQGAX44WqtOiUv
X-Google-Smtp-Source: AKy350bGhp7W2newRVTBbmoZx2qXXA2gpmXP36PQU0b4o9rStz5h1Py2BEuc4rkgXhilOeRw/2nEUg==
X-Received: by 2002:a05:6214:1d2f:b0:5c2:3e10:53e4 with SMTP id f15-20020a0562141d2f00b005c23e1053e4mr6117499qvd.15.1679680621865;
        Fri, 24 Mar 2023 10:57:01 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id w16-20020a0cef90000000b005dd8b9345cfsm843233qvr.103.2023.03.24.10.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:57:01 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, ejt@redhat.com, mpatocka@redhat.com,
        heinzm@redhat.com, nhuck@google.com, ebiggers@kernel.org,
        keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v2 1/9] dm bufio: remove unused dm_bufio_release_move interface
Date:   Fri, 24 Mar 2023 13:56:48 -0400
Message-Id: <20230324175656.85082-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324175656.85082-1-snitzer@kernel.org>
References: <20230324175656.85082-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joe Thornber <ejt@redhat.com>

Was used by multi-snapshot DM target that never went upstream.

Signed-off-by: Joe Thornber <ejt@redhat.com>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c    | 77 ----------------------------------------
 include/linux/dm-bufio.h |  6 ----
 2 files changed, 83 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index cf077f9b30c3..79434b38f368 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1415,83 +1415,6 @@ int dm_bufio_issue_discard(struct dm_bufio_client *c, sector_t block, sector_t c
 }
 EXPORT_SYMBOL_GPL(dm_bufio_issue_discard);
 
-/*
- * We first delete any other buffer that may be at that new location.
- *
- * Then, we write the buffer to the original location if it was dirty.
- *
- * Then, if we are the only one who is holding the buffer, relink the buffer
- * in the buffer tree for the new location.
- *
- * If there was someone else holding the buffer, we write it to the new
- * location but not relink it, because that other user needs to have the buffer
- * at the same place.
- */
-void dm_bufio_release_move(struct dm_buffer *b, sector_t new_block)
-{
-	struct dm_bufio_client *c = b->c;
-	struct dm_buffer *new;
-
-	BUG_ON(dm_bufio_in_request());
-
-	dm_bufio_lock(c);
-
-retry:
-	new = __find(c, new_block);
-	if (new) {
-		if (new->hold_count) {
-			__wait_for_free_buffer(c);
-			goto retry;
-		}
-
-		/*
-		 * FIXME: Is there any point waiting for a write that's going
-		 * to be overwritten in a bit?
-		 */
-		__make_buffer_clean(new);
-		__unlink_buffer(new);
-		__free_buffer_wake(new);
-	}
-
-	BUG_ON(!b->hold_count);
-	BUG_ON(test_bit(B_READING, &b->state));
-
-	__write_dirty_buffer(b, NULL);
-	if (b->hold_count == 1) {
-		wait_on_bit_io(&b->state, B_WRITING,
-			       TASK_UNINTERRUPTIBLE);
-		set_bit(B_DIRTY, &b->state);
-		b->dirty_start = 0;
-		b->dirty_end = c->block_size;
-		__unlink_buffer(b);
-		__link_buffer(b, new_block, LIST_DIRTY);
-	} else {
-		sector_t old_block;
-
-		wait_on_bit_lock_io(&b->state, B_WRITING,
-				    TASK_UNINTERRUPTIBLE);
-		/*
-		 * Relink buffer to "new_block" so that write_callback
-		 * sees "new_block" as a block number.
-		 * After the write, link the buffer back to old_block.
-		 * All this must be done in bufio lock, so that block number
-		 * change isn't visible to other threads.
-		 */
-		old_block = b->block;
-		__unlink_buffer(b);
-		__link_buffer(b, new_block, b->list_mode);
-		submit_io(b, REQ_OP_WRITE, write_endio);
-		wait_on_bit_io(&b->state, B_WRITING,
-			       TASK_UNINTERRUPTIBLE);
-		__unlink_buffer(b);
-		__link_buffer(b, old_block, b->list_mode);
-	}
-
-	dm_bufio_unlock(c);
-	dm_bufio_release(b);
-}
-EXPORT_SYMBOL_GPL(dm_bufio_release_move);
-
 static void forget_buffer_locked(struct dm_buffer *b)
 {
 	if (likely(!b->hold_count) && likely(!smp_load_acquire(&b->state))) {
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index 2056743aaaaa..681656a1c03d 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -130,12 +130,6 @@ int dm_bufio_issue_flush(struct dm_bufio_client *c);
  */
 int dm_bufio_issue_discard(struct dm_bufio_client *c, sector_t block, sector_t count);
 
-/*
- * Like dm_bufio_release but also move the buffer to the new
- * block. dm_bufio_write_dirty_buffers is needed to commit the new block.
- */
-void dm_bufio_release_move(struct dm_buffer *b, sector_t new_block);
-
 /*
  * Free the given buffer.
  * This is just a hint, if the buffer is in use or dirty, this function
-- 
2.40.0

