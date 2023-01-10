Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA93C5479D
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 01:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjAJBDt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 20:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjAJBDt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 20:03:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EA53FCB1
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 17:03:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso14686373pjp.4
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 17:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=417pHCyxuNwenY/oUvL6z7WCeVnEJbQK6qAtpup0R08=;
        b=li3/45nw/S9b0/LWcYkjiByzeX8QMMPeHaCinIcJGlBIiY2fF6hymsBZXz1B5tOLqh
         l4M2hD3EnP3CVBYpXNUgqpWxJ//2pmJBkmfKzh994+ZipvujmaiQrNahg2BA9TK9NGWG
         d3mpoeLtUEv3TAn3E20xbtcVOw8LRUefazcYx7aDXfOr2cUx54OyrETeJsQcuz3nrEEI
         86d9DoHWrXvdncBuzQhCKo42n26ZxsM6FVXCp/SkmhivhsNnZgFSC1Ep+0Bw/uY+d0lR
         XELFGmUCXphq9LO0kJdauVBIVyCp8bRIHTQ6MuRrBLwzEhYWbwR6PJUGuQGJADCbXkM5
         a9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=417pHCyxuNwenY/oUvL6z7WCeVnEJbQK6qAtpup0R08=;
        b=7nRmkHFF8phndJ+YrRkEtdQ6P0ayfzkNegZORLbCuFSWCJksdY/INrhSDRx/C01C7s
         JB7NCqjL6CqI9kag2hUlosFSVKupNcSzcz08aG3pO4ucLLkOKoYIFyUlzdi+sz1OzNSq
         8FpgRpP1LcKglHfRjprTFDiHGF13poWCRNAEbrbBu+f7s3RBXWP8z77ROZEW7iVVyk8i
         uMDGgFpJiggy0pKnhzbLS67Ghie9/s19ABlOBU0+5vsRcn+V7JhibZwQXKLbLbKHW/+G
         Tl1xlZLb/cMMXiEJy4yKCeLOseC6rNTC9Ek3u4Gj7skeQKDhGzfhlasPnPb3RKhZrjOp
         T3Sw==
X-Gm-Message-State: AFqh2kr6JApP+YyjAqUc0rI1fOveTTiv9hM0bPp2JpNK7cd9HBjbYy3I
        rZ9WAFQqAnzMtyxNNSRB8z8tFQ==
X-Google-Smtp-Source: AMrXdXueO1DTSomrorzLSeJruRWHTpuO9W05gTWRt7k0bEsAjL+58bKVT65xJHB24Vr8UTJn9KGiIQ==
X-Received: by 2002:a17:902:c389:b0:193:1203:6e3f with SMTP id g9-20020a170902c38900b0019312036e3fmr2779213plg.3.1673312627571;
        Mon, 09 Jan 2023 17:03:47 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x16-20020a634a10000000b004812f798a37sm4075378pga.60.2023.01.09.17.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 17:03:46 -0800 (PST)
Message-ID: <86eef990-0725-9669-6b7e-1fe935a6b648@kernel.dk>
Date:   Mon, 9 Jan 2023 18:03:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
 <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
 <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
 <2f0f4f28-4096-ab76-5be3-56c44231fed3@kernel.dk>
 <49a9fd49-c9dd-8e5d-368a-ac182f7165ca@kernel.dk>
 <07084f70-00a7-d142-479c-52c75af28246@acm.org>
 <72092951-3de8-35a3-9e50-74cdcc9ee772@kernel.dk>
 <31d32f69-4c14-c9be-494f-7071112073f9@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <31d32f69-4c14-c9be-494f-7071112073f9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 5:56?PM, Bart Van Assche wrote:
> On 1/9/23 16:48, Jens Axboe wrote:
>> On 1/9/23 5:44?PM, Bart Van Assche wrote:
>>> On 1/9/23 16:41, Jens Axboe wrote:
>>>> Or, probably better, a stacked scheduler where the bottom one can be zone
>>>> away. Then we can get rid of littering the entire stack and IO schedulers
>>>> with silly blk_queue_pipeline_zoned_writes() or blk_is_zoned_write() etc.
>>>
>>> Hi Jens,
>>>
>>> Isn't one of Damien's viewpoints that an I/O scheduler should not do
>>> the reordering of write requests since reordering of write requests
>>> may involve waiting for write requests, write request that will never
>>> be received if all tags have been allocated?
>>
>> It should be work conservering, it should not wait for anything. If
>> there are holes or gaps, then there's nothing the scheduler can do.
>>
>> My point is that the strict ordering was pretty hacky when it went in,
>> and rather than get better, it's proliferating. That's not a good
>> direction.
> 
> Hi Jens,
> 
> As you know one of the deeply embedded design choices in the blk-mq
> code is that reordering can happen at any time between submission of a
> request to the blk-mq code and request completion. I agree with that
> design choice.

Indeed. And getting rid of any ordering ops like barriers greatly
simplified things and fixed a number of issued related to that.

> For the use cases I'm looking at the sequential write required zone
> type works best. This zone type works best since it guarantees that
> data on the storage medium is sequential. This results in optimal
> sequential read performance.

That's a given.

> Combining these two approaches is not ideal and I agree that the
> combination of these two approaches adds some complexity. Personally I
> prefer to add a limited amount of complexity rather than implementing
> a new block layer from scratch.

I'm not talking about a new block layer at all, ordered devices are not
nearly important enough to warrant that kind of attention. Nor would it
be a good solution even if they were. I'm merely saying that I'm getting
more and more disgruntled with the direction that is being taken to
cater to these kinds of devices, and perhaps a much better idea is to
contain that complexity in a separate scheduler (be it stacked or not).
Because I'm really not thrilled to see the addition of various "is this
device ordered" all over the place, and now we are getting "is this
device ordered AND pipelined". Do you see what I mean? It's making
things _worse_, not better, and we really should be making it better
rather than pile more stuff on top of it.

-- 
Jens Axboe

