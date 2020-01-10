Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9996C33C99
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 05:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD7820721
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 05:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGW7dzns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgAJFK1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 00:10:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47059 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgAJFK1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 00:10:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so400104pgb.13
        for <linux-block@vger.kernel.org>; Thu, 09 Jan 2020 21:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=go3mxZ5ZmLbwmx8GTJxQxCx+NZCTeXNXyfqEUrRnDxk=;
        b=ZGW7dznsjSxgENIeb6ilmin2M4KDQaIGov9K1GfzhaB3sLZAtmaSwX/R2JenuRXi1F
         8vKT+U8NfzYPjLzvVZN2g+YncJ2IaYi9pFiTdFVBm1nArIxe1nEuI7vSiOSGvSRdDtgB
         E5pCsEMba+b88hH+IyPASJedfAdUOTs1gQP1CLaPz+YiHg8o9LTtQ4HQ5mkn1nwQ+Ej7
         eXl85r66YO4YEXYadvP9G32qNdJr6jAB01K/hRXDk0Vb56+kR40iX87UjpYOMDt8DsLj
         ihvlt+UvBHXc84b8gbQ3YnDyszQ0Z4IfzbwnIQCBrbYuC2+Z31KIOERPgmNHWNWJFT/q
         Q+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=go3mxZ5ZmLbwmx8GTJxQxCx+NZCTeXNXyfqEUrRnDxk=;
        b=GogwzjSxujPwCQtIExsadIeOQ2YWeL8OTYpi6e2iDFEDEcKV7bjLSFN2LXxerILyaY
         yineMBX28bu3BWsFtavPYSu/mh2Dwv654cosGt5x2+Yb+nluAaTwObvDOjis4fRIBn5A
         /wBQ/ERn/zr9AJ7FJfFEk+lSACY/zCsQO1vU4IwZyyTLq20daG+7x8XnTwRbkot/r3Xd
         L++euHHDtV/p3OkEFPGY7EdBK52cBpuCNLFGHpajCJ5u8MnH4UP6qzzRTLgRWIFybBQg
         5Pl0hdD81ZYUTelpkKPvQEVC1+mkW2/PDNSv3IgM4c4tVomjN4bwyYImTkLLukq0LUHU
         parA==
X-Gm-Message-State: APjAAAUUuiW7qsUCaolzWeQpahAz8mDlHkVTvTv3e6A8yvirODCgnzB5
        mfIqx7De+K5DQ/wBu4rxvrGu54Mx
X-Google-Smtp-Source: APXvYqzyMW3G6h23MPzc+OoA9cGN5deDEgWVthwo9AtXViSHGHhGh3czwqz5/lfqtgo7Pzjjz7HemQ==
X-Received: by 2002:a65:4d46:: with SMTP id j6mr2125835pgt.63.1578633026530;
        Thu, 09 Jan 2020 21:10:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26sm834345pfo.130.2020.01.09.21.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 21:10:25 -0800 (PST)
Subject: Re: [PATCH] block: fix splitting segments
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200108140248.GA2896@infradead.org> <20200109020341.GC9655@ming.t460p>
 <20200109071616.GA32217@infradead.org>
 <cd3f3aa8-4880-f06b-7ac5-1982b890ca53@kernel.dk>
 <20200110025801.GC4501@ming.t460p> <20200110030006.GD4501@ming.t460p>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0c25bc64-d249-0b83-1d5d-6f7226293fb6@roeck-us.net>
Date:   Thu, 9 Jan 2020 21:10:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110030006.GD4501@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/20 7:00 PM, Ming Lei wrote:
> On Fri, Jan 10, 2020 at 10:58:01AM +0800, Ming Lei wrote:
>> On Thu, Jan 09, 2020 at 08:18:04AM -0700, Jens Axboe wrote:
>>> On 1/9/20 12:16 AM, Christoph Hellwig wrote:
>>>> On Thu, Jan 09, 2020 at 10:03:41AM +0800, Ming Lei wrote:
>>>>> It has been addressed in:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=ecd255974caa45901d0b8fab03626e0a18fbc81a
>>>>
>>>> That is probably correct, but still highly suboptimal for most 32-bit
>>>> architectures where physical addresses are 32 bits wide.  To fix that
>>>> the proper phys_addr_t type should be used.
>>>
>>> I'll swap it for phys_addr_t - we used to use dma_address_t or something
>>> like that, but I missed this type.
>>
>> Guenter mentioned that 'page_to_phys(start_page) as well as offset are
>> sometimes 0'[1].
>>
>> If that(zero page physical address) can happen when phys_addr_t is 32bit,
>> I guess phys_addr_t may not work too.
>>
>> Guener, could you test the patch in link[2] again?
>>
>>
>> [1] https://lore.kernel.org/linux-block/20200108023822.GB28075@ming.t460p/T/#m5862216b960454fc41a85204defbb887983bfd75
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=b6a89c4a9590663f80486662fe9a9c1f4cee31f4
> 
> Loop Guener in.
> 

The patch at [2] doesn't work.

My understanding is that the page in question is not mapped when
get_max_segment_size() is called (after all, the operation is the
result of a page fault). This is why page_to_phys() returns 0.

You'll either need a local u64 variable, or use some other means
to handle that situation. Something like

     phys_addr_t paddr = page_to_phys(start_page);

     if (paddr == 0)
	return queue_max_segment_size(q);

at the beginning of the function might do, though there might
still be a problem when the page is later assigned and crosses
a segment boundary (if that is possible).

Guenter
