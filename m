Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D8C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 15:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381876AbhLCPmA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381843AbhLCPl7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 10:41:59 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A162C061359
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 07:38:35 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id a11so3087671ilj.6
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4DFUFvaV0G/Q7jMqV2RbUUz9oX67OaVlTxzTJrNM/Ao=;
        b=US11acHjTsIZlHpwqc0CpkAopjX/F5w0mftn0NuN4EDfAAQooNYA9xLEhw5iAM323n
         7qmNVtAAwmRGZ629l9uQibQFdzyhBn3Hmi4rNPJBse095i1lL4Rf6hsHskPDU85pVEpw
         s9M04LXnIC9YJIWREWtBmilPyEa2S7hkKulF8yl0/CAHowduzlhMSR2a+7HNzgcGyUPP
         IqWkBlhrWC3CAjm5maf5prTyjj3ij37qmA1sFel7FeQGbzQgTydxDL64jtXSgAlBW77+
         WmJfmlFtjbokqGU2i+vlQd7oMIVjwb3qfMRNeqWBsNPcRZaH3XOp7hDAQhnOiswsYDXJ
         7Fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4DFUFvaV0G/Q7jMqV2RbUUz9oX67OaVlTxzTJrNM/Ao=;
        b=tfvJCYRdFR3VDdoC0xyvA1l5z/7xilQyY9vFcCxHzPORK7OHxQ9jSLhqB8Q3mzK0B1
         bTr0P4GaP8FivafjAAH/kOvT+lTTk4yQNjiF/TpMBOFJ38FiU5+/WFnU9Zro98gCqNGk
         W7nvKE2/niglB4qvrfW0XjEsOCazeozfBWKt/SSL0r94xkVv4gSYzMBoB+fQpNOT4ae2
         Vjnxsao3yLJfOGLkxbWyDwuXfT72LyHEq9IdNPh6g84pnRuroOXDE8YlLKOFKcbqjHc2
         ldjgpU6cOHM96oskDhq0zW8yB1nV44S/+iaHsjFealKztNQjXsVpyUS0uTZoyoqE6eAK
         3sEw==
X-Gm-Message-State: AOAM531xdficVuzJiEoul1lNXPTZC+Vw1k7Arr8y8njgsr0fuyAokox7
        QOt2qdYC+zG9fWeV34Ib+aWSPYA8P4fKqJ81
X-Google-Smtp-Source: ABdhPJxF5B/TooZb00Dmyre+qqFISBooHUDLdPHCH1GXfo3mnLG1tprnmFTQZC7G9sMIsZ9oBk4wCw==
X-Received: by 2002:a92:d24e:: with SMTP id v14mr18550782ilg.55.1638545914395;
        Fri, 03 Dec 2021 07:38:34 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c15sm1753042ilq.50.2021.12.03.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 07:38:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] mm: move filemap_range_needs_writeback() into header
Date:   Fri,  3 Dec 2021 08:38:28 -0700
Message-Id: <20211203153829.298893-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203153829.298893-1-axboe@kernel.dk>
References: <20211203153829.298893-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No functional changes in this patch, just in preparation for efficiently
calling this light function from the block O_DIRECT handling.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 35 +++++++++++++++++++++++++++++++++++
 mm/filemap.c       | 38 +++-----------------------------------
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..0cc4f5fd4cfe 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2845,6 +2845,41 @@ static inline int filemap_fdatawait(struct address_space *mapping)
 	return filemap_fdatawait_range(mapping, 0, LLONG_MAX);
 }
 
+/* Returns true if writeback might be needed or already in progress. */
+static inline bool mapping_needs_writeback(struct address_space *mapping)
+{
+	return mapping->nrpages;
+}
+
+bool filemap_range_has_writeback(struct address_space *mapping,
+				 loff_t start_byte, loff_t end_byte);
+
+/**
+ * filemap_range_needs_writeback - check if range potentially needs writeback
+ * @mapping:           address space within which to check
+ * @start_byte:        offset in bytes where the range starts
+ * @end_byte:          offset in bytes where the range ends (inclusive)
+ *
+ * Find at least one page in the range supplied, usually used to check if
+ * direct writing in this range will trigger a writeback. Used by O_DIRECT
+ * read/write with IOCB_NOWAIT, to see if the caller needs to do
+ * filemap_write_and_wait_range() before proceeding.
+ *
+ * Return: %true if the caller should do filemap_write_and_wait_range() before
+ * doing O_DIRECT to a page in this range, %false otherwise.
+ */
+static inline bool filemap_range_needs_writeback(struct address_space *mapping,
+						 loff_t start_byte,
+						 loff_t end_byte)
+{
+	if (!mapping_needs_writeback(mapping))
+		return false;
+	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
+	    !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+		return false;
+	return filemap_range_has_writeback(mapping, start_byte, end_byte);
+}
+
 extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
 				  loff_t lend);
 extern bool filemap_range_needs_writeback(struct address_space *,
diff --git a/mm/filemap.c b/mm/filemap.c
index daa0e23a6ee6..65238440fa0a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -640,14 +640,8 @@ int filemap_fdatawait_keep_errors(struct address_space *mapping)
 }
 EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
 
-/* Returns true if writeback might be needed or already in progress. */
-static bool mapping_needs_writeback(struct address_space *mapping)
-{
-	return mapping->nrpages;
-}
-
-static bool filemap_range_has_writeback(struct address_space *mapping,
-					loff_t start_byte, loff_t end_byte)
+bool filemap_range_has_writeback(struct address_space *mapping,
+				 loff_t start_byte, loff_t end_byte)
 {
 	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
 	pgoff_t max = end_byte >> PAGE_SHIFT;
@@ -667,34 +661,8 @@ static bool filemap_range_has_writeback(struct address_space *mapping,
 	}
 	rcu_read_unlock();
 	return page != NULL;
-
-}
-
-/**
- * filemap_range_needs_writeback - check if range potentially needs writeback
- * @mapping:           address space within which to check
- * @start_byte:        offset in bytes where the range starts
- * @end_byte:          offset in bytes where the range ends (inclusive)
- *
- * Find at least one page in the range supplied, usually used to check if
- * direct writing in this range will trigger a writeback. Used by O_DIRECT
- * read/write with IOCB_NOWAIT, to see if the caller needs to do
- * filemap_write_and_wait_range() before proceeding.
- *
- * Return: %true if the caller should do filemap_write_and_wait_range() before
- * doing O_DIRECT to a page in this range, %false otherwise.
- */
-bool filemap_range_needs_writeback(struct address_space *mapping,
-				   loff_t start_byte, loff_t end_byte)
-{
-	if (!mapping_needs_writeback(mapping))
-		return false;
-	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
-	    !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
-		return false;
-	return filemap_range_has_writeback(mapping, start_byte, end_byte);
 }
-EXPORT_SYMBOL_GPL(filemap_range_needs_writeback);
+EXPORT_SYMBOL_GPL(filemap_range_has_writeback);
 
 /**
  * filemap_write_and_wait_range - write out & wait on a file range
-- 
2.34.1

