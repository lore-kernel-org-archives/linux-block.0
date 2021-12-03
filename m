Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F770C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 18:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351113AbhLCSEk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 13:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbhLCSEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 13:04:40 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C876C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 10:01:16 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z8so3508400ilu.7
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 10:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kZ3PTnb0foNG0vY9usa7lbYMHU4ZVKt50x7xLsKrnio=;
        b=Ts5QOvpP0FLyXYwn86u2OJJolEMOiKtZxUH9QHycNUJ7KcUL8mw6w9AGnszkDqsJQ7
         Rdgx8bfNgw1NfcCW6Hv7XPF3NT5F99LekaHU77DGZCguZqLoDpKzVp8OqoYuOgjQNcXG
         TMvhbr8fcvjPHYN1VL0AosK6DK1ac6pkIrc4WSVPUS/y6okyfJCjkUXoJJnsEsYJoFiQ
         u7fiXZFBgQziKLvZZ7J4GcY4Fc3uce1OQgv+uWFSV2zlKUIhs8R+6joQzgRyg9dN5PTl
         rULMZAyMJG0JFrpKQl66ppTPPGtiGoJEftmkgyEYq60dp2oWhqoZUTE1WdLTSzW64jph
         lP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kZ3PTnb0foNG0vY9usa7lbYMHU4ZVKt50x7xLsKrnio=;
        b=0na2ne7u8xs9IGv3rgyP93z6gZKbmCuJ5cPSJAR5ayVcIsGNL/+wu8EBKADz3PbZvK
         dd9SU207kWaZ538U5qsr+tbJnoRSbL70QM4alxzt2qrhnpSxXa0WhPrR5HCaYs9oMfd4
         x/fGbf1HKsR5M53pOCCosP5XfpOCq7O1GUMytnWxUGeyGpzaSbePDLsE1f6dSu10TLdV
         RGSUlld8VQr5PZCVeNkgBPavuqrZK0XtEmObI6SNwREkw7pWvMNE3kOdzSkEh2PGsPA0
         gWJLmC4dvOuZAECqcKH0fbuTerMaE3UesRv6lD07/thftFGz+DSAnL40jTtT69LPCyxh
         kqDw==
X-Gm-Message-State: AOAM531dXSh1owKL0FYnsoUrl/kyjQWkRRsNEsyM0gbAoS+WotCwyN9N
        XC8NtbD6Cj7alDTd3hhwkg3Ozg==
X-Google-Smtp-Source: ABdhPJx52SmRr5isL72Jfv4cF1XEO3vFGPzYJ7ed47ahO1e7Gw97xPJ8z/WqpVtgTz9niS6tH2vZyw==
X-Received: by 2002:a05:6e02:1c2a:: with SMTP id m10mr18369997ilh.279.1638554475529;
        Fri, 03 Dec 2021 10:01:15 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x18sm2235760iow.53.2021.12.03.10.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:01:15 -0800 (PST)
Subject: Re: [PATCH 1/2] mm: move filemap_range_needs_writeback() into header
From:   Jens Axboe <axboe@kernel.dk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-2-axboe@kernel.dk>
 <YapC9cl6qsOAjzNj@casper.infradead.org>
 <f94d0fe4-1fc9-4c2d-f666-8ccf4251b950@kernel.dk>
 <5e92c117-0cdb-9ea6-3f1c-912e683c4e51@kernel.dk>
 <89810ae4-7c9b-ec8f-5450-ef8dc51ad8a4@kernel.dk>
 <97e253f7-d945-0c6b-3d8b-dcf597f04f69@kernel.dk>
 <YapYAt7+r7K0aQ3+@casper.infradead.org>
 <e386e230-4eef-f4da-f327-9b0f1d33fe47@kernel.dk>
Message-ID: <9cabdcc3-e760-bab5-edfe-ae225e5d4db9@kernel.dk>
Date:   Fri, 3 Dec 2021 11:01:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e386e230-4eef-f4da-f327-9b0f1d33fe47@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 10:57 AM, Jens Axboe wrote:
>> I'm happy with this, if you just move it to pagemap.h
> 
> OK, I'll try it out.

Wasn't too bad at all, actually just highlighted that I missed removing
the previous declaration of filemap_range_needs_writeback() in fs.h
I'll do a full compile and test, but this seems sane.

commit 63c6b3846b77041d239d5b5b5a907b5c82a21c4c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Oct 28 08:47:05 2021 -0600

    mm: move filemap_range_needs_writeback() into header
    
    No functional changes in this patch, just in preparation for efficiently
    calling this light function from the block O_DIRECT handling.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..6b8dc1a78df6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2847,8 +2847,6 @@ static inline int filemap_fdatawait(struct address_space *mapping)
 
 extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
 				  loff_t lend);
-extern bool filemap_range_needs_writeback(struct address_space *,
-					  loff_t lstart, loff_t lend);
 extern int filemap_write_and_wait_range(struct address_space *mapping,
 				        loff_t lstart, loff_t lend);
 extern int __filemap_fdatawrite_range(struct address_space *mapping,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 605246452305..274a0710f2c5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -963,6 +963,35 @@ static inline int add_to_page_cache(struct page *page,
 int __filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		pgoff_t index, gfp_t gfp, void **shadowp);
 
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
+	if (!mapping->nrpages)
+		return false;
+	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
+	    !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+		return false;
+	return filemap_range_has_writeback(mapping, start_byte, end_byte);
+}
+
 /**
  * struct readahead_control - Describes a readahead request.
  *
diff --git a/mm/filemap.c b/mm/filemap.c
index daa0e23a6ee6..655c9eec06b3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -646,8 +646,8 @@ static bool mapping_needs_writeback(struct address_space *mapping)
 	return mapping->nrpages;
 }
 
-static bool filemap_range_has_writeback(struct address_space *mapping,
-					loff_t start_byte, loff_t end_byte)
+bool filemap_range_has_writeback(struct address_space *mapping,
+				 loff_t start_byte, loff_t end_byte)
 {
 	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
 	pgoff_t max = end_byte >> PAGE_SHIFT;
@@ -667,34 +667,8 @@ static bool filemap_range_has_writeback(struct address_space *mapping,
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
Jens Axboe

