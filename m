Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDF3C46467
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 23:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjAPXj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 18:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjAPXj2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 18:39:28 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153984C0A
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:39:27 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k18so7750502pll.5
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQF0auPzxI4Mn/L1YLBp7JsEV+bsm8x9t/TAEYcUnjs=;
        b=L7mqi0qHb/Pwi+2Fj1AIsRt+qnM/BV+vjIVc+GklKWXcdccRjVGyVVxDBYHZRVfSat
         SKjM3FtwqB8CcJsbLIfbdOORDNYuYCAwyvUw7OSQ/EdCdglSWAct92gapIbl8bgrpC2t
         Pj1cXIJl/CWN72Q0ITkcOfGthkJkoEm+i7HAgiM/qKzBA5w0FhuRi12vj23kK/4VthLv
         rBp8W1RzQLsKMNZwmG9fo9lA3IK6y4DIcblYQlUFqCRvYbA54qVMoO3ytfBZH/EZXVRs
         7dU3tdLQ1rs7Ig84BljaZKOqJTLR1x0An7oa18e90bC1+05CwAso0jRrdwX+2SLsQzcJ
         70gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQF0auPzxI4Mn/L1YLBp7JsEV+bsm8x9t/TAEYcUnjs=;
        b=gc1hOXe4NqJhxTcKwmSzSscdm5j+b8FmM56qNLOoKXvrhMeiX10xHUahU97xqepUyz
         YODqPNZ1jcMfsqmAEGPMTjanFpsyMrMqLxs0EA6+zn6Gvnv0v4nJyyI1MPW3k5igMTq7
         o9o9o2bVAkzcfmSf+LJLhMsRSXY3rBNL4VdBqZOf5fsNL+b6vQwFruPaNt+B57N7bvij
         xGUL80UdNWao6YMWUJLSyaEOzLbX+OotyDS1QhZV0CcscolHTpr0ZSVl6OImKkErfNN1
         i8RcCE+aySAUYj0DoGqw7XtOXV2cmmmLxyx8Yv+bCWA1d+3Wts1yew0k18pnEa5FaUTl
         AK/A==
X-Gm-Message-State: AFqh2kop7KGLlsK2HIS/a/z3d1PRtMikbKLKFtLSs3Ej5gNwBIu9+o0W
        QqIwCDzkpkLVxeNYBZXFWsKZZQ==
X-Google-Smtp-Source: AMrXdXtIZu0YPeyVxijlg0syxhmIA0sNGY+YbxS8OQMUxGMMritzc3aDimSEgdtJR1UkgNGjwmJM1A==
X-Received: by 2002:a17:903:41d2:b0:193:1c8f:183a with SMTP id u18-20020a17090341d200b001931c8f183amr345253ple.5.1673912366462;
        Mon, 16 Jan 2023 15:39:26 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709027e4700b00192740bb02dsm18517956pln.45.2023.01.16.15.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 15:39:26 -0800 (PST)
Message-ID: <da64245b-4127-f6be-76e4-a9c9546c8226@kernel.dk>
Date:   Mon, 16 Jan 2023 16:39:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Michael Kelley <mikelley@microsoft.com>
References: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
 <7c69e3b5-c81b-a3ba-9588-9a59c32c45b7@opensource.wdc.com>
 <4ed4090b-7bff-dd43-da23-915f269bd759@kernel.dk>
 <88d454ab-97bf-f5a9-7645-5fb89c4bc0e0@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <88d454ab-97bf-f5a9-7645-5fb89c4bc0e0@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/23 4:31 PM, Damien Le Moal wrote:
> On 1/17/23 08:28, Jens Axboe wrote:
>> On 1/16/23 4:20?PM, Damien Le Moal wrote:
>>> On 1/17/23 06:06, Jens Axboe wrote:
>>>> If we're doing a large IO request which needs to be split into multiple
>>>> bios for issue, then we can run into the same situation as the below
>>>> marked commit fixes - parts will complete just fine, one or more parts
>>>> will fail to allocate a request. This will result in a partially
>>>> completed read or write request, where the caller gets EAGAIN even though
>>>> parts of the IO completed just fine.
>>>>
>>>> Do the same for large bios as we do for splits - fail a NOWAIT request
>>>> with EAGAIN. This isn't technically fixing an issue in the below marked
>>>> patch, but for stable purposes, we should have either none of them or
>>>> both.
>>>>
>>>> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")
>>>>
>>>> Cc: stable@vger.kernel.org # 5.15+
>>>> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
>>>> Link: https://github.com/axboe/liburing/issues/766
>>>> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> ---
>>>>
>>>> Since v1: catch this at submit time instead, since we can have various
>>>> valid cases where the number of single page segments will not take a
>>>> bio segment (page merging, huge pages).
>>>>
>>>> diff --git a/block/fops.c b/block/fops.c
>>>> index 50d245e8c913..d2e6be4e3d1c 100644
>>>> --- a/block/fops.c
>>>> +++ b/block/fops.c
>>>> @@ -221,6 +221,24 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>>>  			bio_endio(bio);
>>>>  			break;
>>>>  		}
>>>> +		if (iocb->ki_flags & IOCB_NOWAIT) {
>>>> +			/*
>>>> +			 * This is nonblocking IO, and we need to allocate
>>>> +			 * another bio if we have data left to map. As we
>>>> +			 * cannot guarantee that one of the sub bios will not
>>>> +			 * fail getting issued FOR NOWAIT and as error results
>>>> +			 * are coalesced across all of them, be safe and ask for
>>>> +			 * a retry of this from blocking context.
>>>> +			 */
>>>> +			if (unlikely(iov_iter_count(iter))) {
>>>> +				bio_release_pages(bio, false);
>>>> +				bio_clear_flag(bio, BIO_REFFED);
>>>> +				bio_put(bio);
>>>> +				blk_finish_plug(&plug);
>>>> +				return -EAGAIN;
>>>
>>> Doesn't this mean that for a really very large IO request that has 100%
>>> chance of being split, the user will always get -EAGAIN ? Not that I mind,
>>> doing super large IOs with NOWAIT is not a smart thing to do in the first
>>> place... But as a user interface, it seems that this will prevent any
>>> forward progress for such really large NOWAIT IOs. Is that OK ?
>>
>> Right, if you asked for NOWAIT, then it would not necessarily succeed if
>> it:
>>
>> 1) Needs multiple bios
>> 2) Needs splitting
>>
>> You're expected to attempt blocking issue at that point. Reasoning is
>> explained in this (and the previous commit related to the issue),
>> otherwise you end up with potentially various amounts of the request
>> being written to disk or read from disk, but EAGAIN being returned for
>> the request as a whole.
> 
> Yes, I understood all that and completely agree with it.
> 
> I was only wondering if this change may not surprise some (bad) userspace
> stuff. Do we need to update some man page or other doc, mentioning that
> there are no guarantees that a NOWAIT IO may actually be executed if it
> too large (e.g. larger than max_sectors_kb) ?

We can certainly add it to the man pages talking about RWF_NOWAIT. But
there's never been a guarantee that any EAGAIN will later succeed
under the same conditions, and honestly there are various conditions
where this is already not true. And those same cases would spuriously
yield EAGAIN before already, it's not a new condition for those sizes
of IOs.

-- 
Jens Axboe


