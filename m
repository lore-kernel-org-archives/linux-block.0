Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F34C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 04:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80422146F
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 04:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GLQe3c8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfBZEel (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Feb 2019 23:34:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39394 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZEek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Feb 2019 23:34:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id b65so2559897plb.6
        for <linux-block@vger.kernel.org>; Mon, 25 Feb 2019 20:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=36udYreD9VHIWgXeUChbAuGDEmnbUQDAXR/nEf1Vug8=;
        b=GLQe3c8sLi92kzE/ZagJF4lIMWX22aFAbivtQAj/l0QX5LXmWXV9BdZnQr0cQ31N9l
         QzNIIweDOKq2H7YzaiNxoJHtY6BeNwKY4N/6rsTIXEojhZgWxPp6E8jj2CBqY3ZHmA4X
         1FaoXkX70/6SF0OpkDPydIR4IpRrACYBc+nqFcaad4z5cqkeM/wEjiIrxAzM7j6TkXne
         ejvcLX+g5+cZxj/mOWfVRc35Bc0FtT/pjYoU5QlCQAXx31EGU/QCoSDTI4OBrrLKRTxP
         pmEESWm31NYRupqPVJG08oaOuOuh6n3TqOH6rBQ8c/0+zad25eSWIN+V92dqMSMc7oEG
         c6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36udYreD9VHIWgXeUChbAuGDEmnbUQDAXR/nEf1Vug8=;
        b=CVv/2OqKUgbdoM3kY1XdgwN9H5TXwWnYhtRGiMMRewjJhqEtj/GHB25H1cP6nl1QsA
         nn9HBRZDSCkTZfqn/CLj4iyelEL5X2RJyPqhErE5rPLMuP+kpaN9VvIHw+/N7d2xRlM3
         valLCJ4xavu34SW7X5dY7Wq1t24vq0ZoyXWD7tFbE1bWqhkEpaHRFMKEbj7udr36mlVT
         ZfwO7kfJxhaLQ9hL/MwL3sbncirUJ6apvX81YqzhFqpGSbXe9imdpW6TKjiVtczf/GOt
         W+Itn/bskdlJ+txhGJXHfVM62iVrUnYbMD6ReGwcES2k07FFSgUPSxM5sqAdH69IB8Kv
         71vA==
X-Gm-Message-State: AHQUAuYBM9lc6aIkPj5PqoQUeqAeOmRB0D1+AhP4mf6JlDZiTTy1mqPX
        V1rzMoXRCGpPWdvJ5tmKpkcf1g==
X-Google-Smtp-Source: AHgI3IaCnQjPRGWg7TYTHYwPdx8UJ5fgzvQovXcM2/ZFfF63WDwrGnEuqCi4UoKRRUOdVwtYGrJcFA==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr22029186plp.118.1551155679915;
        Mon, 25 Feb 2019 20:34:39 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g71sm27011491pfg.157.2019.02.25.20.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 20:34:38 -0800 (PST)
Subject: Re: [PATCH 11/19] block: implement bio helper to add iter bvec pages
 to bio
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@zeniv.linux.org.uk
References: <20190211190049.7888-1-axboe@kernel.dk>
 <20190211190049.7888-13-axboe@kernel.dk> <20190220225856.GB28313@ming.t460p>
 <b143e8c3-33d5-5f09-c441-98b3bf326d81@kernel.dk>
 <20190226034613.GA676@sol.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa1184bb-b482-0637-21e4-1ddb0e7aea90@kernel.dk>
Date:   Mon, 25 Feb 2019 21:34:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226034613.GA676@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/25/19 8:46 PM, Eric Biggers wrote:
> Hi Jens,
> 
> On Thu, Feb 21, 2019 at 10:45:27AM -0700, Jens Axboe wrote:
>> On 2/20/19 3:58 PM, Ming Lei wrote:
>>> On Mon, Feb 11, 2019 at 12:00:41PM -0700, Jens Axboe wrote:
>>>> For an ITER_BVEC, we can just iterate the iov and add the pages
>>>> to the bio directly. This requires that the caller doesn't releases
>>>> the pages on IO completion, we add a BIO_NO_PAGE_REF flag for that.
>>>>
>>>> The current two callers of bio_iov_iter_get_pages() are updated to
>>>> check if they need to release pages on completion. This makes them
>>>> work with bvecs that contain kernel mapped pages already.
>>>>
>>>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>  block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
>>>>  fs/block_dev.c            |  5 ++--
>>>>  fs/iomap.c                |  5 ++--
>>>>  include/linux/blk_types.h |  1 +
>>>>  4 files changed, 56 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/block/bio.c b/block/bio.c
>>>> index 4db1008309ed..330df572cfb8 100644
>>>> --- a/block/bio.c
>>>> +++ b/block/bio.c
>>>> @@ -828,6 +828,23 @@ int bio_add_page(struct bio *bio, struct page *page,
>>>>  }
>>>>  EXPORT_SYMBOL(bio_add_page);
>>>>  
>>>> +static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>>>> +{
>>>> +	const struct bio_vec *bv = iter->bvec;
>>>> +	unsigned int len;
>>>> +	size_t size;
>>>> +
>>>> +	len = min_t(size_t, bv->bv_len, iter->count);
>>>> +	size = bio_add_page(bio, bv->bv_page, len,
>>>> +				bv->bv_offset + iter->iov_offset);
>>>
>>> iter->iov_offset needs to be subtracted from 'len', looks
>>> the following delta change[1] is required, otherwise memory corruption
>>> can be observed when running xfstests over loop/dio.
>>
>> Thanks, I folded this in.
>>
>> -- 
>> Jens Axboe
>>
> 
> syzkaller started hitting a crash on linux-next starting with this commit, and
> it still occurs even with your latest version that has Ming's fix folded in.
> Specifically, commit a566653ab5ab80a from your io_uring branch with commit date
> Sun Feb 24 08:20:53 2019 -0700.
> 
> Reproducer:
> 
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <linux/loop.h>
> #include <sys/ioctl.h>
> #include <sys/sendfile.h>
> #include <sys/syscall.h>
> #include <unistd.h>
> 
> int main(void)
> {
>         int memfd, loopfd;
> 
>         memfd = syscall(__NR_memfd_create, "foo", 0);
> 
>         pwrite(memfd, "\xa8", 1, 4096);
> 
>         loopfd = open("/dev/loop0", O_RDWR|O_DIRECT);
> 
>         ioctl(loopfd, LOOP_SET_FD, memfd);
> 
>         sendfile(loopfd, loopfd, NULL, 1000000);
> }
> 
> 
> Crash:
> 
> page:ffffea0001a6aab8 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x100000000000000()
> raw: 0100000000000000 ffffea0001ad2c50 ffff88807fca49d0 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff
> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)

I see what this is, I'll cut a fix for this tomorrow.

-- 
Jens Axboe

