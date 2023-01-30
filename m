Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57988C636CD
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 21:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjA3Vqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 16:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjA3Vq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 16:46:29 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0E748A25
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 13:46:22 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso12463365pjb.4
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 13:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocTiwjXQLQgzWBO9Us1qnSu03XVDe8OK5n+rPgOFzw0=;
        b=e70VkUIv8wV+SOtRavpKaZqwzGi70g57ttXXLrKV4H5FpFOWLHwYFHtF/HGj/TVSgM
         Kb0X0Z6pt51l+/4N8MbEWTUN+VMArHTzXMOtTV4R8/lbTXTeoUs77XPeHmw7yi7JZzMl
         zwUAOj9+nqVzskRYDlma5Z1IZHe5d0dDpEP/2CYXinyGWBjm3tTV0ix9rQo/NVKx3UBP
         1Wgjk5hQvv3bfR8bCzPIwvC9UQnwT30qfFOhQY9s38HHtr4YZezAUswu9FNH0NOJGWf5
         pHuy+oNM2KhdHvlCQbK6VwGVGibDgIGb7vTMULmQCOPVCiHwAglovfuHfdndbu2aBtne
         f/9A==
X-Gm-Message-State: AO0yUKUbOCia3hqhr63ir4Ki8IHIHisSSLZSsS+orLNo5tlsYJaTcbBd
        DA0loBEiBLrEu0+xlO7AID4=
X-Google-Smtp-Source: AK7set/MIrNZZqqXuJUq5PTFBWqRb0dDhhmBeEO+eGp0NbUKN4FPbYTz2uA+uhWRW2VzqN4MtTTWIg==
X-Received: by 2002:a17:903:190:b0:196:86d2:86dc with SMTP id z16-20020a170903019000b0019686d286dcmr5628234plg.50.1675115182191;
        Mon, 30 Jan 2023 13:46:22 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:5016:3bcd:59fe:334b? ([2620:15c:211:201:5016:3bcd:59fe:334b])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902bc4200b001745662d568sm8182928plz.278.2023.01.30.13.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 13:46:21 -0800 (PST)
Message-ID: <8cca27c1-17a1-d73f-a372-45a6dc1e3606@acm.org>
Date:   Mon, 30 Jan 2023 13:46:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] null_blk: Support configuring the maximum segment size
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20230128005926.79336-1-bvanassche@acm.org>
 <ff478889-7a02-135f-57b6-f56d386d7065@opensource.wdc.com>
 <beafab98-df34-8f1c-1108-7e61080a7e21@acm.org>
 <66b9601f-148e-3954-036b-b053d2d04316@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <66b9601f-148e-3954-036b-b053d2d04316@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/23 18:03, Damien Le Moal wrote:
> On 1/28/23 11:48, Bart Van Assche wrote:
>> On 1/27/23 17:18, Damien Le Moal wrote:
>>> On 1/28/23 09:59, Bart Van Assche wrote:
>>>> +	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
>>>> +		  dev->max_segment_size);
>>>
>>> Shouldn't this be an EIO return as this is not supposed to happen ?
>>
>> Hmm ... the above WARN_ONCE() statement is intended as a precondition
>> check. This statement is intended as a help for developers to check that
>> the code below works fine. I'm not sure how returning EIO here would help?
> 
> My point was that given that null_transfer() is called like this:
> 
> 	rq_for_each_segment(bvec, rq, iter) {
>                  len = bvec.bv_len;
>                  err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
>                                       ...);
> 
> len should never be larger than max_segment_size, no ? Unless I am missing
> something else...

Hi Damien,

null_transfer() supports the case len > dev->max_segment_size so I think 
that a warning is sufficient and also that we don't need to return -EIO.

Thanks,

Bart.

