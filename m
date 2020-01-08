Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA77C33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDC82070E
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fr4LDyzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAHCgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:36:10 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35439 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgAHCgK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 21:36:10 -0500
Received: by mail-pj1-f66.google.com with SMTP id s7so416848pjc.0
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 18:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3IPrRkTxih+gNL1kHop//VtG2AkOFgLUl6Dzo5FN/1Y=;
        b=fr4LDyzjTCmc8TZm1uAVCJeK5zGVTjVJgJ6s7fGWj5YAYyNClYn6P/HxxCz+QKxtt2
         vNuXjnFwMHpYxFS8H0afvggBFFQHFiah6LtOpKI5C/+TeF+93FX5bGhYBtQre/Ruv6Kc
         T9XgivI0F/FuysvFluteRzT67b1wBA/p7uBJVo5RKiNyC5QSXIvOl5XBLxUXsPmbEpI5
         de7sN2cy1Ri5a5CWUKA/oJKVsqWcVLxTRfN6cEFp4fEMPxzmuE3IxCrgI66xFwyinOI8
         Z6nHqtnSx+MKVj32xjpkij2gZpLdT1qyLjU+j176cEpHLI6S8oeU91yHeJkkLo1s0xj2
         60jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3IPrRkTxih+gNL1kHop//VtG2AkOFgLUl6Dzo5FN/1Y=;
        b=QmoS+3kajrpLrqgTjfLWNWY3z3Cl4DAnaZ2YxgfQqABzhHypht2AHqR6QpSiuHfF8V
         x538f7hysNWK1/g4mont3Qq4TO+FjgKOiVhVRAWDqB248I7c+WbIsM5at3IwEMU+vKiY
         ixDUWygOGex5+V5TQ3UgtMHI6hDOLTSEy7hapaj9grc8bHw9FXx564YqqHF/ANr1CQPg
         Pq40QRiHI/4RckQS2LzxP9pX+1gZTm+oxS3yHJu1LTm/JHgcXhppFKHm5/ukC1kb1p+W
         HjUNGvHk5dB6HGs3K9ZKzG1fqfC6ncZ8Gb/f96Ug3JB5J7m/c2mi3oO9yXUI1E/vWjgo
         PNVA==
X-Gm-Message-State: APjAAAWx0MBXv7HtVhBxUYeY/4YR9qA4zJlR/1+P/+cULiT533zIoEV/
        6LP2K1O8FQo98ynRVw6iyCvYlvA2ew0=
X-Google-Smtp-Source: APXvYqwRDqNJA6aQKPpWMFD56oHl14WtI869z/BdVtVCch+/tN4dN1V+gDOWhOu5FBl+dTu2TqLY8Q==
X-Received: by 2002:a17:90b:d94:: with SMTP id bg20mr1762951pjb.99.1578450969761;
        Tue, 07 Jan 2020 18:36:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y38sm1099885pgk.33.2020.01.07.18.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 18:36:09 -0800 (PST)
Subject: Re: [PATCH] block: fix splitting segments
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200107124708.GA20285@roeck-us.net> <20200107152339.GA23622@ming.t460p>
 <20200107181145.GA22076@roeck-us.net> <20200107223035.GA7505@ming.t460p>
 <25ce5140-ee29-c32c-7f5e-b8c6da5c7e90@kernel.dk>
 <20200108015915.GA28075@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b16267c-e3e5-8abc-6c4c-bbcb87e59b3f@kernel.dk>
Date:   Tue, 7 Jan 2020 19:36:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108015915.GA28075@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/7/20 6:59 PM, Ming Lei wrote:
> On Tue, Jan 07, 2020 at 03:32:58PM -0700, Jens Axboe wrote:
>> On 1/7/20 3:30 PM, Ming Lei wrote:
>>> On Tue, Jan 07, 2020 at 10:11:45AM -0800, Guenter Roeck wrote:
>>>> On Tue, Jan 07, 2020 at 11:23:39PM +0800, Ming Lei wrote:
>>>>> On Tue, Jan 07, 2020 at 04:47:08AM -0800, Guenter Roeck wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Sun, Dec 29, 2019 at 10:32:30AM +0800, Ming Lei wrote:
>>>>>>> There are two issues in get_max_segment_size():
>>>>>>>
>>>>>>> 1) the default segment boudary mask is bypassed, and some devices still
>>>>>>> require segment to not cross the default 4G boundary
>>>>>>>
>>>>>>> 2) the segment start address isn't taken into account when checking
>>>>>>> segment boundary limit
>>>>>>>
>>>>>>> Fixes the two issues.
>>>>>>>
>>>>>>> Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
>>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>>>
>>>>>> This patch, pushed into mainline as "block: fix splitting segments on
>>>>>> boundary masks", results in the following crash when booting 'versatilepb'
>>>>>> in qemu from disk. Bisect log is attached. Detailed log is at
>>>>>> https://kerneltests.org/builders/qemu-arm-master/builds/1410/steps/qemubuildcommand/logs/stdio
>>>>>>
>>>>>> Guenter
>>>>>>
>>>>>> ---
>>>>>> Crash:
>>>>>>
>>>>>> kernel BUG at block/bio.c:1885!
>>>>>> Internal error: Oops - BUG: 0 [#1] ARM
>>>>>
>>>>> Please apply the following debug patch, and post the log.
>>>>>
>>>>
>>>> Here you are:
>>>>
>>>> max_sectors 2560 max_segs 96 max_seg_size 65536 mask ffffffff
>>>> c738da80: 8c80/0 2416 28672, 0
>>>>          total sectors 56
>>>>
>>>> (I replaced %p with %px).
>>>>
>>>
>>> Please try the following patch and see if it makes a difference.
>>> If not, replace trace_printk with printk in previous debug patch,
>>> and apply the debug patch only & post the log.
>>
>> If it is a 32-bit issue, then we should use a 64-bit type to make
>> this nicer than ULL. But it seems reasonable that it could be!
> 
> oops, just saw this email after sending out the patch.
> 
> Do you need V2 to change ULL to u64?

Nah, I can just edit it, that's fine.

-- 
Jens Axboe

