Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BC4C33CA2
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 12:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E6220721
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 12:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qC1GTFWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgAJMsx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:48:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38069 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAJMsx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 07:48:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so974223pgm.5
        for <linux-block@vger.kernel.org>; Fri, 10 Jan 2020 04:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hl2QXDuNj7kgfyuISeoToxET79hHFfP1oLVDEwUg/c4=;
        b=qC1GTFWLekqagLM2TWN5LSLcGTvGdeCfJILFnSTjV3m8d1o2Q7vL0ALcp0f+u1umBy
         YDuHrTXRORao9VTO++gepbhQz8b9hVR9I1gpiCzePN5I6ye4Amw/K+9bp/N5iqGbvCvv
         J9ZzEWT6nsmLN6rYthhc1e63AJ2F0lBKrO8soUj6hnSuSGtmUxYCgDvbnsT/Vwbm9Ht8
         mtVINuGwhYrw+OZuxI5PXwKzJt8PkXrXjOWgZ7/PtPwE4k9oWSQCioG6J52wVsQ/aM3+
         hCZq+lt+Mu2I4POgFjvdKRyZaxFR8WNewJonQYKNnpsgC6VP2z7Sk8JKr7YwAxtlf5L7
         7PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hl2QXDuNj7kgfyuISeoToxET79hHFfP1oLVDEwUg/c4=;
        b=Skj2NZjcE4Wg9YvqgD9rGtrLqw6ZtI8HQNUTAnmBU+l7l9i+X6vJ3LsurEU7zCl9gn
         bGC0qs4CW46Fw/KM5wwAjHnIAxcXVbuBuf8r4wZ1cpISCos+HiED5Y9X6PiYGqS4+P/T
         5LMwA6aeo6JOSbOTAcARgllei4x8onmwTzOuLIQfP2pNPMcx+fBA574uw0C9S6bwOCGH
         WtbtM6YBwlI/NRtx45U3vaQzPgeI1IbRVIf/bCU5PXWX8YrO6ueJBWodAh2iFonhSrk2
         FASh3Fz0vx58CLp9xmY+9PwM7DP7D841sot7qSwt0ajUBRXkI5bdYvWlOSPbcvmPFeeP
         NZUw==
X-Gm-Message-State: APjAAAUmLwHX5OOJIiGa177V7KyDVPhMgnnk3XbUid8Rrga37eBtP0NL
        eNvMg+QmEgaagg3wBBS0GWMEoRMU
X-Google-Smtp-Source: APXvYqwZTx8kJ05fNAAKHlvGoOwr6Zk+KRZ8JZFLW1r6FHGRYsD38E4KdsWEnLTHcX5sJu1xfp8liA==
X-Received: by 2002:a63:215f:: with SMTP id s31mr4055983pgm.27.1578660531494;
        Fri, 10 Jan 2020 04:48:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b98sm2757653pjc.16.2020.01.10.04.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 04:48:50 -0800 (PST)
Subject: Re: [PATCH] block: fix splitting segments
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200108140248.GA2896@infradead.org> <20200109020341.GC9655@ming.t460p>
 <20200109071616.GA32217@infradead.org>
 <cd3f3aa8-4880-f06b-7ac5-1982b890ca53@kernel.dk>
 <20200110025801.GC4501@ming.t460p> <20200110030006.GD4501@ming.t460p>
 <0c25bc64-d249-0b83-1d5d-6f7226293fb6@roeck-us.net>
 <20200110063744.GA16724@ming.t460p> <20200110071548.GA23264@ming.t460p>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <af2cfd4a-dfdf-c9b0-c467-c0ba7136d3d6@roeck-us.net>
Date:   Fri, 10 Jan 2020 04:48:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110071548.GA23264@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/20 11:15 PM, Ming Lei wrote:
> On Fri, Jan 10, 2020 at 02:37:44PM +0800, Ming Lei wrote:
>> On Thu, Jan 09, 2020 at 09:10:24PM -0800, Guenter Roeck wrote:
>>> On 1/9/20 7:00 PM, Ming Lei wrote:
>>>> On Fri, Jan 10, 2020 at 10:58:01AM +0800, Ming Lei wrote:
>>>>> On Thu, Jan 09, 2020 at 08:18:04AM -0700, Jens Axboe wrote:
>>>>>> On 1/9/20 12:16 AM, Christoph Hellwig wrote:
>>>>>>> On Thu, Jan 09, 2020 at 10:03:41AM +0800, Ming Lei wrote:
>>>>>>>> It has been addressed in:
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=ecd255974caa45901d0b8fab03626e0a18fbc81a
>>>>>>>
>>>>>>> That is probably correct, but still highly suboptimal for most 32-bit
>>>>>>> architectures where physical addresses are 32 bits wide.  To fix that
>>>>>>> the proper phys_addr_t type should be used.
>>>>>>
>>>>>> I'll swap it for phys_addr_t - we used to use dma_address_t or something
>>>>>> like that, but I missed this type.
>>>>>
>>>>> Guenter mentioned that 'page_to_phys(start_page) as well as offset are
>>>>> sometimes 0'[1].
>>>>>
>>>>> If that(zero page physical address) can happen when phys_addr_t is 32bit,
>>>>> I guess phys_addr_t may not work too.
>>>>>
>>>>> Guener, could you test the patch in link[2] again?
>>>>>
>>>>>
>>>>> [1] https://lore.kernel.org/linux-block/20200108023822.GB28075@ming.t460p/T/#m5862216b960454fc41a85204defbb887983bfd75
>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=b6a89c4a9590663f80486662fe9a9c1f4cee31f4
>>>>
>>>> Loop Guener in.
>>>>
>>>
>>> The patch at [2] doesn't work.
>>>
>>> My understanding is that the page in question is not mapped when
>>> get_max_segment_size() is called (after all, the operation is the
>>> result of a page fault). This is why page_to_phys() returns 0.
>>
>> page_to_phys() supposes to return page's physical address, which
>> should just depend on this machine's physical address space,
>> not related with page mapping.
>>
>> I understand physical address 0 might be valid, such as the 1st
>> page frame of ram.
>>
>>>
>>> You'll either need a local u64 variable, or use some other means
>>> to handle that situation. Something like
>>>
>>>      phys_addr_t paddr = page_to_phys(start_page);
>>>
>>>      if (paddr == 0)
>>> 	return queue_max_segment_size(q);
>>>
>>> at the beginning of the function might do, though there might
>>> still be a problem when the page is later assigned and crosses
>>> a segment boundary (if that is possible).
>>
>> IMO, zero physical address case is the only corner case not
>> covered by using 'phys_addr_t'. If phys_addr_t is 32bit, sum of
>> page_to_phys(start_page) and offset shouldn't be >= 4G.
> 
> Or could you test the following patch?
> 

That patch applied to ToT (without the other patch) fixes the problem for me.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 347782a24a35..d1bed8c382bf 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -164,8 +164,13 @@ static inline unsigned get_max_segment_size(const struct request_queue *q,
>   	unsigned long mask = queue_segment_boundary(q);
>   
>   	offset = mask & (page_to_phys(start_page) + offset);
> -	return min_t(unsigned long, mask - offset + 1,
> -		     queue_max_segment_size(q));
> +
> +	/*
> +	 * overflow may be triggered in case of zero page physical address
> +	 * on 32bit arch, use queue's max segment size when that happens
> +	 */
> +	return min_not_zero(mask - offset + 1,
> +			(unsigned long)queue_max_segment_size(q));
>   }
>   
>   /**
> 
> 
> Thanks,
> Ming
> 

