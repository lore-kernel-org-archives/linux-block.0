Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB1AC43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9673220836
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Axhbg/63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLKUIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:08:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40771 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLKUIf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:08:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so11672plp.7
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 12:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TG7BGMclukZIVh2PNEJ8WzMh2yZaZJvzRjI13QQlG6A=;
        b=Axhbg/63I0kH/6ugO8fZtgaIrylZ+pPAasGg9/vzSnDRPZm1etfDwyUkI7N6s3mQ+g
         PD/pNbqjNnLZ8pDQHEejaCNPcG4FGtWIgpTmKp4T5nGCpRz/TsUiGFFxeb2fzZhhzndp
         kpDCCQA8lCUYFZAbbuSX7p462CaDwcBS/EoauCUH6R3ffFL4rGq+TX1ydQcJD1wioXtZ
         tScU4Zp88jvxqbQc2KOAsEVv7ynI6qZiddHTdHhjKZ/KBqX2eBO22+vfX0KbyLicJdQ6
         cNzJjD6IEEHwTNMFCV6T//QLXbM9PRZPDkT+MldqC/gbmW0U4lO80vNym7DMFT2TFuMK
         kuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TG7BGMclukZIVh2PNEJ8WzMh2yZaZJvzRjI13QQlG6A=;
        b=fGNdQAUf656Qgez2Q0Qb+bcXKIEfQ9LLszirXIR9uE4ezKNMEZ5lzef1bcc4HNxKR5
         UrIp36aFleGbfLCy8u46bcFH9utPv1vtLnsU0Ou+0JwzRyL8UcGv3wr9v6OT8pNSBfHk
         /wcFxp/8MCLDhVYkLxnUcmlF4usmsKZOWUSkEhDc7aSHMx5tySoDObrLbzIUEDH55OS2
         RuB2JIM5GiUi3rpthvD+b28YJmr3YK/xqAbwBDoM6CKJUMFSZjDuksGl4tdcPrFLqALZ
         WbF82sufNjOTy2Zp5CXZp+39Xp92Px/AjN1ysDNdOxIEYwkQxy3PGThuSEigtwMigqWB
         nqYg==
X-Gm-Message-State: APjAAAXJ5oW8sjHuK6tNjqtxn7IqqVsY9/KO/4Z5WoBD6UXLjK9d9unA
        8H2saHcfSAnPie1x1oSuKLPNeBU8v+0=
X-Google-Smtp-Source: APXvYqz3RV/ULFQvjvU1C8BqLCvdmFUWOScQPl6MLkTgmO1nZaWCCnSNgIBAX0Z6dnUDSc/LlZuFBQ==
X-Received: by 2002:a17:902:d893:: with SMTP id b19mr5165721plz.93.1576094914828;
        Wed, 11 Dec 2019 12:08:34 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1014? ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id h14sm3838304pfn.174.2019.12.11.12.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 12:08:34 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
Date:   Wed, 11 Dec 2019 13:08:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/19 1:03 PM, Linus Torvalds wrote:
> On Wed, Dec 11, 2019 at 11:34 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I can't tell a difference in the results, there's no discernable
>> difference between NOT calling mark_page_accessed() or calling it.
>> Behavior seems about the same, in terms of pre and post page cache full,
>> and kswapd still churns a lot once the page cache is filled up.
> 
> Yeah, that sounds like a bug. I'm sure the RWF_UNCACHED flag fixes it
> when you do the IO that way, but it seems to be a bug relardless.

Hard to disagree with that.

> Does /proc/meminfo have everything inactive for file data (ie the
> "Active(file)" line is basically zero?).

$ cat /proc/meminfo | grep -i active
Active:           134136 kB
Inactive:       28683916 kB
Active(anon):      97064 kB
Inactive(anon):        4 kB
Active(file):      37072 kB
Inactive(file): 28683912 kB

This is after a run with RWF_NOACCESS.

> Maybe pages got activated other ways (eg a problem with the workingset
> code)? You said "See patch below", but there wasn't any.

Oops, now below.

> 
> That said, it's also entirely possible that even with everything in
> the inactive list, we might try to shrink other things first for
> whatever odd reason..
> 
> The fact that you see that xas_create() so prominently would imply
> perhaps add_to_swap_cache(), which certainly implies that the page
> shrinking isn't hitting the file pages...

That's presumably misleading, as it's just lookups. But yes,
confusing...

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5ea5fc167524..b2ecc66f5bd5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -316,6 +316,7 @@ enum rw_hint {
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
 #define IOCB_UNCACHED		(1 << 8)
+#define IOCB_NOACCESS		(1 << 9)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -3423,6 +3424,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 		ki->ki_flags |= IOCB_APPEND;
 	if (flags & RWF_UNCACHED)
 		ki->ki_flags |= IOCB_UNCACHED;
+	if (flags & RWF_NOACCESS)
+		ki->ki_flags |= IOCB_NOACCESS;
 	return 0;
 }
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 357ebb0e0c5d..f20f0048d5c5 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -302,8 +302,10 @@ typedef int __bitwise __kernel_rwf_t;
 /* drop cache after reading or writing data */
 #define RWF_UNCACHED	((__force __kernel_rwf_t)0x00000040)
 
+#define RWF_NOACCESS	((__force __kernel_rwf_t)0x00000080)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_UNCACHED)
+			 RWF_APPEND | RWF_UNCACHED | RWF_NOACCESS)
 
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index 4dadd1a4ca7c..c37b0e221a8a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2058,7 +2058,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			if (iocb->ki_flags & IOCB_NOWAIT)
 				goto would_block;
 			/* UNCACHED implies no read-ahead */
-			if (iocb->ki_flags & IOCB_UNCACHED)
+			if (iocb->ki_flags & (IOCB_UNCACHED|IOCB_NOACCESS))
 				goto no_cached_page;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
@@ -2144,7 +2144,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		 * When a sequential read accesses a page several times,
 		 * only mark it as accessed the first time.
 		 */
-		if (prev_index != index || offset != prev_offset)
+		if ((prev_index != index || offset != prev_offset) &&
+		    !(iocb->ki_flags & IOCB_NOACCESS))
 			mark_page_accessed(page);
 		prev_index = index;
 

-- 
Jens Axboe

