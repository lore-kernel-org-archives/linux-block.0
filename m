Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CDAC433F5
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 14:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5DE61056
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 14:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhJVOVz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhJVOVz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 10:21:55 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9642C061764
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 07:19:37 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id y207so5164193oia.11
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k9e8WyMd1qfMhPo9VdVqOG2FyHldcmSV6mWD6oKAoeY=;
        b=wH/RdseJWRiQhEie1xIATdF2YWf0Tt9II/ETYc5olSHDiNMcJEE3XxjbGIYaUA7iGK
         XJDmxd5MDYabrWvU6UOcwQ01QNQa704eQNyV/bsaLkJK5akCtKiDxgsE8urY9vt4HL/1
         spwnTvJHx6CU+On7JPKg+BJiUmmfbnwaC7tH19k/Ws8CShBcXtumhNayUY9ScCkl9AXS
         seWxMFNbhzV0K26XfBZ3WcnBs0Q6MMjLGhu4+Xn+HjUujBVveMchGtq6gNBLr9jq2oac
         SIJP3LdiZNbcqJ2bQjfpUKAJoIBjp3JhRSqJGU5QsKMZD+gJ5LqW47gsil7+hcROm4lH
         vtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k9e8WyMd1qfMhPo9VdVqOG2FyHldcmSV6mWD6oKAoeY=;
        b=4DPrWa4sj9Qnf3rvZpdfgUhWn7bvl5crgBoVhK5RBZdqA8sBchrXISuYQh+86Mmcjm
         U5EgV+Mb3uss6D/Vj2n1fgyMeBm2DsL85q/v//N+nK7Edz7n7l9WNA3r+TQTKTnbJon4
         8YKQIj+02YhlNGmDG0CRb0aIgl3PNjDK2diXMf996bWyI6+hfosUDl9ydhbv6k/LUBZq
         05dJ9bXdI+ys/tkz1jhM9IP/C0TOprqW7K1xHIgzKFMWnwUgL+degQDdECHAc9KTTije
         PkizeuMavbt2mNTjcpLq0GEFEs/fBybunfMC/IWQdhji9zII5thpHwGEZYId72R/rcu4
         wpUA==
X-Gm-Message-State: AOAM532x/FqVv2ZPIHwf5fx1xzjr1TVS16NKeWXgi8C5ykMahxkgzxBn
        KMPyOHHTwIVStZheSRmke18Azg==
X-Google-Smtp-Source: ABdhPJz9MHdu+kULCD2Ld82e2jghT/yuW0dOuVAcgAqwROJxs06ZYVe3X6nfvAORBrB2B0QfLBgh6w==
X-Received: by 2002:aca:c6d8:: with SMTP id w207mr10218293oif.145.1634912377096;
        Fri, 22 Oct 2021 07:19:37 -0700 (PDT)
Received: from [172.20.15.86] (rrcs-24-173-18-66.sw.biz.rr.com. [24.173.18.66])
        by smtp.gmail.com with ESMTPSA id d18sm1489112ook.14.2021.10.22.07.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 07:19:36 -0700 (PDT)
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments with
 a single argument
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
 <YXElk52IsvCchbOx@infradead.org> <YXFHgy85MpdHpHBE@infradead.org>
 <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
 <YXF8X3RgRfZpL3Cb@infradead.org>
 <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk>
 <x49ee8ev21s.fsf@segfault.boston.devel.redhat.com>
 <6338ba2b-cd71-f66d-d596-629c2812c332@kernel.dk>
 <x497de6uubq.fsf@segfault.boston.devel.redhat.com>
 <7a697483-8e44-6dc3-361e-ae7b62b82074@kernel.dk>
 <x49wnm6t7r9.fsf@segfault.boston.devel.redhat.com>
 <x49sfwut7i8.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d67c3d6f-56a2-4ace-7b57-cb9c594ad82c@kernel.dk>
Date:   Fri, 22 Oct 2021 08:19:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <x49sfwut7i8.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/21 3:03 PM, Jeff Moyer wrote:
> Jeff Moyer <jmoyer@redhat.com> writes:
> 
>> Jens Axboe <axboe@kernel.dk> writes:
>>
>>> On 10/21/21 12:05 PM, Jeff Moyer wrote:
>>>>
>>>>>> I'll follow up if there are issues.
>>>>
>>>> s390 (big endian, 64 bit) is failing libaio test 21:
>>>>
>>>> # harness/cases/21.p
>>>> Expected -EAGAIN, got 4294967285
>>>>
>>>> If I print out both res and res2 using %lx, you'll see what happened:
>>>>
>>>> Expected -EAGAIN, got fffffff5,ffffffff
>>>>
>>>> The sign extension is being split up.
>>>
>>> Funky, does it work if you apply this on top?
>>>
>>> diff --git a/fs/aio.c b/fs/aio.c
>>> index 3674abc43788..c56437908339 100644
>>> --- a/fs/aio.c
>>> +++ b/fs/aio.c
>>> @@ -1442,8 +1442,8 @@ static void aio_complete_rw(struct kiocb *kiocb, u64 res)
>>>  	 * 32-bits of value at most for either value, bundle these up and
>>>  	 * pass them in one u64 value.
>>>  	 */
>>> -	iocb->ki_res.res = lower_32_bits(res);
>>> -	iocb->ki_res.res2 = upper_32_bits(res);
>>> +	iocb->ki_res.res = (long) (res & 0xffffffff);
>>> +	iocb->ki_res.res2 = (long) (res >> 32);
>>>  	iocb_put(iocb);
>>>  }
>>
>> I think you'll also need to clamp any ki_complete() call sites to 32
>> bits (cast to int, or what have you).  Otherwise that sign extension
>> will spill over into res2.
>>
>> fwiw, I tested with this:
>>
>> 	iocb->ki_res.res = (long)(int)lower_32_bits(res);
>> 	iocb->ki_res.res2 = (long)(int)upper_32_bits(res);
>>
>> Coupled with the call site changes, that made things work for me.
> 
> This is all starting to feel like a minefield.  If you don't have any
> concrete numbers to show that there is a speedup, I think we should
> shelf this change.

It's really not a minefield at all, we just need a proper help to encode
the value. I'm out until Tuesday, but I'll sort it out when I get back.
Can also provide some numbers on this.

-- 
Jens Axboe

