Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE67AC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 16:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbhLCQiu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhLCQis (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 11:38:48 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CE3C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 08:35:23 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id 15so3285736ilq.2
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1qeWfvSCIJZvQVrGPshmVmH+uaG4Erun9h7pEUbu2Bc=;
        b=DsVO37JwMJgMmYLxOf+fyOyK8H8fScKV7kthHhJgPUj3RqBDWwSft4Sj70Xxjng0NP
         jjbn7MUP1+VrSYnIHWfjKGPInOeh4spMVSSQAsgHhLq1Q7dTD/tzo6Bsdb/4ODknDMW6
         RQER7K0mWGErRCKAku99keNy9gb02Ryuwq6HCO3rglrGJIkdx2759ZcVS2u0P6CsvuWP
         p5kj0y4Sqx7jSffLMSq+eWe68BoFMtNXsIatZdqR5OKSS81yuFTCIpnE8y4LP/C9Nvfw
         32dnYbVJipRwNwO1WbFNPZ3VtO0ilTz/ERuZjGk4SpCBXWfs17w6OusPJEjLYHdUryKe
         RZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qeWfvSCIJZvQVrGPshmVmH+uaG4Erun9h7pEUbu2Bc=;
        b=Rbes70zPjKOCNmzW2ecTKkFpu50E9LP1Y7/mFaOwN9yHcMbVZDax+29W80un2RWCiK
         cQUQPltLsaut9cg9X5iGjdkvjGWTjq8Ln16PZHVEoVVAbypWANqoknJFONnW5JEuziDq
         XCzermXIyOjVvkx9GpGOtbzcpBIZTum+L6CmQKOZbqvLL+tA1DYll8LEY5IMDX7LXEXl
         CtjwNp/zlEj2XEvxMsTDcUb7zprL8tODd0YKLKcH1zQaINeg7GevdA5VeRxxluLFNSN2
         PKOc99gRSYNXYeMyMZ4o8jY7yJa1//uvLdrBXsI51uS4f0bMNwxSt9wXoUusrR8uzyR1
         W9Fw==
X-Gm-Message-State: AOAM533kTCgnojsmsTP2MDavGsHkd92XMQCk1fMl2FwmVdfZ6fq2FH6t
        mQTQo4Bf9WNDhe21oqgmSCuCZw==
X-Google-Smtp-Source: ABdhPJz1DiNW7n9LmgAKMcJA7RcFFuZAF2ax8ELghhyidCNAKxvN8JITy7A+iwO5sTexPCI0b+3Y7w==
X-Received: by 2002:a05:6e02:148c:: with SMTP id n12mr20995263ilk.209.1638549323311;
        Fri, 03 Dec 2021 08:35:23 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s20sm1866720iog.25.2021.12.03.08.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 08:35:23 -0800 (PST)
Subject: Re: [PATCH 1/2] mm: move filemap_range_needs_writeback() into header
From:   Jens Axboe <axboe@kernel.dk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-2-axboe@kernel.dk>
 <YapC9cl6qsOAjzNj@casper.infradead.org>
 <f94d0fe4-1fc9-4c2d-f666-8ccf4251b950@kernel.dk>
 <5e92c117-0cdb-9ea6-3f1c-912e683c4e51@kernel.dk>
Message-ID: <89810ae4-7c9b-ec8f-5450-ef8dc51ad8a4@kernel.dk>
Date:   Fri, 3 Dec 2021 09:35:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5e92c117-0cdb-9ea6-3f1c-912e683c4e51@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 9:31 AM, Jens Axboe wrote:
> On 12/3/21 9:24 AM, Jens Axboe wrote:
>> On 12/3/21 9:16 AM, Matthew Wilcox wrote:
>>> On Fri, Dec 03, 2021 at 08:38:28AM -0700, Jens Axboe wrote:
>>>> +++ b/include/linux/fs.h
>>>
>>> fs.h is the wrong place for these functions; they're pagecache
>>> functionality, so they should be in pagemap.h.
>>>
>>>> +/* Returns true if writeback might be needed or already in progress. */
>>>> +static inline bool mapping_needs_writeback(struct address_space *mapping)
>>>> +{
>>>> +	return mapping->nrpages;
>>>> +}
>>>
>>> I don't like this function -- mapping_needs_writeback says to me that it
>>> tests a flag in mapping->flags.  Plus, it does exactly the same thing as
>>> !mapping_empty(), so perhaps ...
>>>
>>>> +static inline bool filemap_range_needs_writeback(struct address_space *mapping,
>>>> +						 loff_t start_byte,
>>>> +						 loff_t end_byte)
>>>> +{
>>>> +	if (!mapping_needs_writeback(mapping))
>>>> +		return false;
>>>
>>> just make this
>>> 	if (mapping_empty(mapping))
>>> 		return false;
>>>
>>> Other than that, no objections to making this static inline.
>>
>> Good idea, I'll make that change.
> 
> That does introduce a dependency from fs.h -> pagemap.h which isn't trivially
> resolvable...
> 
> What if we just rename the above funciton to mapping_has_pages() or something
> instead?

Or just drop the helper, to be honest. There are more tests for mapping->nrpages
right now than there are callers of this silly little helper.

-- 
Jens Axboe

