Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E1BC433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 16:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382113AbhLCQlv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352818AbhLCQlu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 11:41:50 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A065C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 08:38:26 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id v23so4412485iom.12
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hQR8nMaVs3+3H3SI4QjS61V6NAG22S2Aw42uidCKSUw=;
        b=VIaiV1xbFdzDEzsikT7np9zKwMJS3F8hOZIpYswqbYAALnzFxNeVjIQOF8wr4F55MW
         15ogAunRqXm2je6IyVw2mwStePQIT96EXyqR4opFnQV/guW3qSTNS4KvPX5I2mh0SAzF
         guY6FGuHO1K2DC9M8M+gUclSrpue4mj/nK6Xsi6prL95+/GkkL1sdNs8c5ZVmyWynEBy
         LaJxImprjTz5P6WCC+t//kfTQTSfA+oyC6Wd7v0nFfIM6D50llWBDc7eNCITL+4ojP4v
         1wHbmtxV7jSnuz+oe+gcfT484cNDA34gA4y/eOcqPcFDmMUEwGSnYDZHpKPSyIqFtauW
         wj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQR8nMaVs3+3H3SI4QjS61V6NAG22S2Aw42uidCKSUw=;
        b=u5d9rvTqlZ9C3kOaKMLVfogMQEjk31UwmuDkA/8Wcl6W1LVXVwqv0GjSMdnE3op4uL
         cAZJyeyMQWbta/qrv2aG7VNgvs7pXCLxULXQT/s6iJVxm/6fCA645wVPKO65kF+eizRq
         CzOmu9MD674OGWCstwzl8KfJ5t1TuSmDaIocjWYWw7qwbGmcFjm6q6aRSkT12iT5rGZM
         kW10vhyrpVofUGnEDuBASU+/zCIkcL4u9+V+tghOhgM04KBa/BH6o0Xx8T2aYjld94qY
         LAgjhB4nZaHn2DvXa2ya9rEztlIFba2rH0y7AJC788P0/Jh/Z5iKricDXL+QDrZNCoC4
         xi1g==
X-Gm-Message-State: AOAM53059+nbSGGM7C9vjQvA3ZkDWe4X0RpiSJvckCh1Yk/32CDlQlvo
        wCpcsbQxte59fTkZdKdHOwuO/g==
X-Google-Smtp-Source: ABdhPJzB5gSDVE9hFAQoAUGMDvejcgC7/erW7F7bEmDdN+unjuGBrEUf2ODulSKSL9QEkHlPmmrn1w==
X-Received: by 2002:a05:6602:150b:: with SMTP id g11mr22512167iow.119.1638549505952;
        Fri, 03 Dec 2021 08:38:25 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e11sm2017660ilu.3.2021.12.03.08.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 08:38:25 -0800 (PST)
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
Message-ID: <97e253f7-d945-0c6b-3d8b-dcf597f04f69@kernel.dk>
Date:   Fri, 3 Dec 2021 09:38:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <89810ae4-7c9b-ec8f-5450-ef8dc51ad8a4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 9:35 AM, Jens Axboe wrote:
> On 12/3/21 9:31 AM, Jens Axboe wrote:
>> On 12/3/21 9:24 AM, Jens Axboe wrote:
>>> On 12/3/21 9:16 AM, Matthew Wilcox wrote:
>>>> On Fri, Dec 03, 2021 at 08:38:28AM -0700, Jens Axboe wrote:
>>>>> +++ b/include/linux/fs.h
>>>>
>>>> fs.h is the wrong place for these functions; they're pagecache
>>>> functionality, so they should be in pagemap.h.
>>>>
>>>>> +/* Returns true if writeback might be needed or already in progress. */
>>>>> +static inline bool mapping_needs_writeback(struct address_space *mapping)
>>>>> +{
>>>>> +	return mapping->nrpages;
>>>>> +}
>>>>
>>>> I don't like this function -- mapping_needs_writeback says to me that it
>>>> tests a flag in mapping->flags.  Plus, it does exactly the same thing as
>>>> !mapping_empty(), so perhaps ...
>>>>
>>>>> +static inline bool filemap_range_needs_writeback(struct address_space *mapping,
>>>>> +						 loff_t start_byte,
>>>>> +						 loff_t end_byte)
>>>>> +{
>>>>> +	if (!mapping_needs_writeback(mapping))
>>>>> +		return false;
>>>>
>>>> just make this
>>>> 	if (mapping_empty(mapping))
>>>> 		return false;
>>>>
>>>> Other than that, no objections to making this static inline.
>>>
>>> Good idea, I'll make that change.
>>
>> That does introduce a dependency from fs.h -> pagemap.h which isn't trivially
>> resolvable...
>>
>> What if we just rename the above funciton to mapping_has_pages() or something
>> instead?
> 
> Or just drop the helper, to be honest. There are more tests for
> mapping->nrpages right now than there are callers of this silly little
> helper.

Like this:


commit 80d0d63df336376f53375c98703bcae0ec50d26b
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Oct 28 08:47:05 2021 -0600

    mm: move filemap_range_needs_writeback() into header
    
    No functional changes in this patch, just in preparation for efficiently
    calling this light function from the block O_DIRECT handling.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..11a37adc2520 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2845,6 +2845,35 @@ static inline int filemap_fdatawait(struct address_space *mapping)
 	return filemap_fdatawait_range(mapping, 0, LLONG_MAX);
 }
 
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
 extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
 				  loff_t lend);
 extern bool filemap_range_needs_writeback(struct address_space *,
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

