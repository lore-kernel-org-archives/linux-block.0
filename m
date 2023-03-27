Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E26CC77B6C
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjC0UOA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjC0UN7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:13:59 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC135A7
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:09 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id hf2so9810792qtb.3
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNKDXzqz05HkFrPteMNUMY0uT7UJYCgf272zyuZUZl4=;
        b=P2bP3zxprxxRbhvZPiIj0ofz6A9NEGq1/HdfjVyX+dWLO4+sjCFNLzksQ7KMgC1O7l
         /eoeV0UfoPtsZfjWgWzvLotchU43qk/sb94saZqwYteSqUYMF6qKsFlgKdcgOLJIdDJP
         awLrXsSC+O7Jr6JRI4r/p9HlnMEL1OPTCcl2Z4I92WhPUX6fqjbxGALCDIBhXa5yj8NA
         VYcW3KX1f0dMwxw97VeVM8tnVrArMi4pgu5v2CHBSK0u95Rr1iFwahmMpaBBA280j+vy
         /x7d98NoIWClOgU0+OkD7RyOUAJZe0hnwWImBHChF2CUzyQL5Gpphg8BW5HV6PoEqabz
         Czkg==
X-Gm-Message-State: AO0yUKUV9SWGAtY4ClYksf/qKym+kTzBYhUkEmWHAUIak/CcV4TxRH8D
        gUdbQGSZgQnm25oo4Lo1v1+A
X-Google-Smtp-Source: AK7set+7MMoq6Vd0Xdcf9qnBj1WT4JAtfpuUnRj7pcmV6oOeji14qNAy6w9DZt923oR8XoqLbUpKMQ==
X-Received: by 2002:ac8:5f0b:0:b0:3e1:c341:f618 with SMTP id x11-20020ac85f0b000000b003e1c341f618mr20781332qta.65.1679947988341;
        Mon, 27 Mar 2023 13:13:08 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id 128-20020a370486000000b00746772d78a6sm11397199qke.2.2023.03.27.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:07 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 01/20] dm bufio: remove unused dm_bufio_release_move interface
Date:   Mon, 27 Mar 2023 16:11:24 -0400
Message-Id: <20230327201143.51026-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
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

