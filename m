Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD25C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 16:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352765AbhLCQfM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245728AbhLCQfM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 11:35:12 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E1CC061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 08:31:48 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id x10so4398487ioj.9
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZcsX6oN4wS3zxJ3zo+xbdu1vWpMx9AGIYv2p8B7anf4=;
        b=J39C5XMln9NSv4mKVH0f60Rj2Tni4VHIJgOixZw0aVawRw1TM4FWwNnO1VBv0UeeXI
         urieMrjLrysvTC3/aEvrK38PCTJnmWqzxHLoXy6DmYyygPktD5kApE0mlI3fURGolGh9
         Px6IPzaQbZ9JjEscJPMbBpevvEfrNpmYjBSwKLCtTdt/Tey0sk6MeNKXEdhquFs7C2iP
         wWiuW48nmOMG4Mp5pZTKHzqh1qyxM95YsRswWPwqrxJgED6kV9UYT0MJGV5tzqQr/Gak
         fjl3PmBv/eXcxNEaFptCn6834WUww/2d+KGNwL2lVFkxSV2CA6u6I1I3KnJk4Y33Fyw/
         F+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZcsX6oN4wS3zxJ3zo+xbdu1vWpMx9AGIYv2p8B7anf4=;
        b=R+yYRr8eJu3ol9EvGt9E5Ub6eFcSjO+XjzUEJOT5TXHSkzn7pYre2ir/34jUysTq9C
         1MtPVpSKOu6Ys0WplPnnwbWInCCvgP6d1FCnAaae4aQOrk38JqZvqgIFSPKkt2je5Qo7
         oFBPC7tY++DS9NAQGVB3MQ2C6VKhbLytzGwdFJfiVQDu5V7kX/rczW0yh2KEHhGd15xt
         4+Mh3UwYFOuQaxB3P1pFaSNs9seBZjPZ4QlxN+giYuet9VvXEUY+U9Ubm2PiB/VIDOHK
         e/Wh9FN5gBNPkXVUNU8g1llCTYbQ/5xxOIYO47ydGbTw8N2nPiWIWs/oxgJP98xQ1ajh
         P0Hw==
X-Gm-Message-State: AOAM5318PdmLM/ecCLqNEsgo6uegTQ4l99ma36+eXisPTjVdc21KloWM
        Oodh5v+fpC5aU6awQ5+iHWdFNA==
X-Google-Smtp-Source: ABdhPJwXBcVITgjbtxedzF/PeDC+NWPIrYNnBdxaRzCwCahRYAUIGGze/XL0MK4m2FkN1edpilU6/A==
X-Received: by 2002:a05:6602:42:: with SMTP id z2mr22055851ioz.208.1638549107877;
        Fri, 03 Dec 2021 08:31:47 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 11sm1982828ilq.23.2021.12.03.08.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 08:31:47 -0800 (PST)
Subject: Re: [PATCH 1/2] mm: move filemap_range_needs_writeback() into header
From:   Jens Axboe <axboe@kernel.dk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-2-axboe@kernel.dk>
 <YapC9cl6qsOAjzNj@casper.infradead.org>
 <f94d0fe4-1fc9-4c2d-f666-8ccf4251b950@kernel.dk>
Message-ID: <5e92c117-0cdb-9ea6-3f1c-912e683c4e51@kernel.dk>
Date:   Fri, 3 Dec 2021 09:31:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f94d0fe4-1fc9-4c2d-f666-8ccf4251b950@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 9:24 AM, Jens Axboe wrote:
> On 12/3/21 9:16 AM, Matthew Wilcox wrote:
>> On Fri, Dec 03, 2021 at 08:38:28AM -0700, Jens Axboe wrote:
>>> +++ b/include/linux/fs.h
>>
>> fs.h is the wrong place for these functions; they're pagecache
>> functionality, so they should be in pagemap.h.
>>
>>> +/* Returns true if writeback might be needed or already in progress. */
>>> +static inline bool mapping_needs_writeback(struct address_space *mapping)
>>> +{
>>> +	return mapping->nrpages;
>>> +}
>>
>> I don't like this function -- mapping_needs_writeback says to me that it
>> tests a flag in mapping->flags.  Plus, it does exactly the same thing as
>> !mapping_empty(), so perhaps ...
>>
>>> +static inline bool filemap_range_needs_writeback(struct address_space *mapping,
>>> +						 loff_t start_byte,
>>> +						 loff_t end_byte)
>>> +{
>>> +	if (!mapping_needs_writeback(mapping))
>>> +		return false;
>>
>> just make this
>> 	if (mapping_empty(mapping))
>> 		return false;
>>
>> Other than that, no objections to making this static inline.
> 
> Good idea, I'll make that change.

That does introduce a dependency from fs.h -> pagemap.h which isn't trivially
resolvable...

What if we just rename the above funciton to mapping_has_pages() or something
instead?

-- 
Jens Axboe

