Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4514C07E9D
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 23:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiI0XMj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 19:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiI0XMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 19:12:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA4210FE0C
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 16:12:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l9-20020a17090a4d4900b00205e295400eso148996pjh.4
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 16:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8jvxUEsEXzdnQ9fp8pMlMpLnN6o97/pojDsoW5SNbwM=;
        b=39Nrzvw+bkaAqKEbE2u4dZP8uLABAs+tCi3pYpZMZRLhxtWeUmBYY9GE68/z+4F0n9
         HLkxPt3bLDKUQmc3j6TZKfwXGw0xQ67WTcqDFIJMIlA6wYGqfyddgpDcVxXUKZ2pija1
         WoTr7R/P/Thz0jyrgXiBjG9E7vabRVx8MHR/Ljuq/zq84S91kCb0jn5pCICZ0VuP4yb4
         GY0VO+m3zfXIqIbfHpZ/AdyHLNyqgP3l+L1iaCL1iJHY00nAkh9ovsAw+Dry3WxAC0me
         YwG0UpB/b99/vQfZC6ZSPqqa4awq1gKA6117WtDiqifBe3Vg9SbGOtIi7KlRdo7b7vta
         JLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8jvxUEsEXzdnQ9fp8pMlMpLnN6o97/pojDsoW5SNbwM=;
        b=YSkWvDbg1Gm7tzrabj3/6sQPrrTHOpzSCj+QMJOePoPII7tK22NOdfXK4vug1yrouw
         1dUcwC+I3v8QH+VtpxSa0LlBD+dJBTIebXMmX1cb/9CBmx3DpfwnQG8+1LORT455iII0
         3CaVucTsPgKcbYNuulJb+LxtoE4EyKHNbUGaYf0mrxBMJMMucGey8jdVGCUqSmF9MLRy
         5ST969ABD8+dZ1JUNNMljdvbaZl5Dyx+aJk8E+PvCP0QtAvZLTaV06VmWn1MeeLkPqKO
         esxTJ+3F7sdEPpS6QhzxG24KxrPna9VTLi6gPH4py5HljpDbXYg6yhK0aw1nyGpuW54Q
         6Msg==
X-Gm-Message-State: ACrzQf3060YYnJLXcoBKs0Wi+okgOUfLU1AoIwLlOvOvjCHbfyom5KSD
        zbm1vgvIXQw3OXDDtrtqDRLIj31AXBZcJw==
X-Google-Smtp-Source: AMsMyM7Zkdg/3SQvwMIVK2EZ9+FlPrt+e9YCunK7I5hI1VmgLdUkCej+nQOEXG2LO4kQ9pRAk+QejA==
X-Received: by 2002:a17:90b:1a87:b0:202:6b60:be62 with SMTP id ng7-20020a17090b1a8700b002026b60be62mr6899536pjb.69.1664320356900;
        Tue, 27 Sep 2022 16:12:36 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902c60200b00176e6f553efsm2108178plr.84.2022.09.27.16.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 16:12:36 -0700 (PDT)
Message-ID: <038d0238-19e0-70ff-49b6-b9c8f4429ac1@kernel.dk>
Date:   Tue, 27 Sep 2022 17:12:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
        gost.dev@samsung.com
References: <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
 <YzG6fZdz6XBDbrVB@infradead.org>
 <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
 <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
 <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
 <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
 <fa80eef0-42a4-6ffc-cced-18ecbe5b1f5a@kernel.dk>
 <YzMp+SIsv6Aw4bFW@infradead.org>
 <3c6002c7-cd69-e020-24b8-650aaf9ad893@kernel.dk>
 <8ed09dfb-0c09-c04a-76fd-5971c7ddc794@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8ed09dfb-0c09-c04a-76fd-5971c7ddc794@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/22 5:07 PM, Damien Le Moal wrote:
> On 9/28/22 01:52, Jens Axboe wrote:
>> On 9/27/22 10:51 AM, Christoph Hellwig wrote:
>>> On Tue, Sep 27, 2022 at 10:04:19AM -0600, Jens Axboe wrote:
>>>> Ah yes, good point. We used to have this notion of 'fs' request, don't
>>>> think we do anymore. Because it really should just be:
>>>
>>> A fs request is a !passthrough request.
>>
>> Right, that's the condition I made below too.
>>
>>>> if (zoned && (op & REQ_OP_WRITE) && fs_request)
>>>>          return NULL;
>>>>
>>>> for that condition imho. I guess we could make it:
>>>>
>>>> if (zoned && (op & REQ_OP_WRITE) && !(op & REQ_OP_DRV_OUT))
>>>>          return NULL;
>>>
>>> Well, the only opcodes we do zone locking for is REQ_OP_WRITE and
>>> REQ_OP_WRITE_ZEROES.  So this should be:
>>>
>>> 	if (zoned && (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES))
>>> 		return NULL;
>>
>> I'd rather just make it explicit and use that. Pankaj, do you want
>> to spin a v2 with that?
> 
> It would be nice to reuse the bio equivalent of
> blk_req_needs_zone_write_lock().
> 
> The test would be:
> 
> 	if (bio_needs_zone_write_locking())
> 		return NULL;
> 
> With something like:
> 
> static inline bool bio_needs_zone_write_locking()
> {
> 	 if (!bdev_is_zoned(bio->bi_bdev))
> 		return false;
> 
> 	switch (bio_op(bio)) {
>         case REQ_OP_WRITE_ZEROES:
> 
>         case REQ_OP_WRITE:
> 
>                 return true;
>         default:
> 
>                 return false;
> 
>         }
> }

I'd be fine with that (using a shared helper), but let's please just
make it:

static inline bool op_is_zoned_write(bdev, op)
{
	 if (!bdev_is_zoned(bio->bi_bdev))
		return false;

	return op == REQ_OP_WRITE_ZEROES || op == REQ_OP_WRITE;
}

and avoid a switch for this basic case and name it a bit more logically
too. Not married to the above name, but the helper should not imply
anything about zone locking. That's for the caller.

-- 
Jens Axboe
