Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DFCC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 13:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCD4610CC
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 13:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhJNNDm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhJNNDm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 09:03:42 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67198C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 06:01:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d125so3639696iof.5
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DAEGDAuPbU/UsEoguNMCXNFrBpM9xfKecWAU03Wi78o=;
        b=RHxWXpdV7UcUHoT8i2VRhVrjtVF7IK8zWSzF2ccOgEoEdRkFSGatWYrTDbjAAYeqyj
         5lKzfWdfvQ0dL7xdKxQeYysC5ZwznZ6a835EHa7GbmxTvxumYkeWYfSIzL7YhLpCHNqN
         ZsrH5/tFGBrW+Top8U5Wo4wku5db+BFtpCz/S/Qaqps+tm9gDfUj7yCoRfK0WfaMtXUF
         Af3Gm32TRnBrhDuPL0+TOaTjPi7Wq9+s0Aixcc+QZhnDT0I2KKB/kLLJRUmQ1zcorNGF
         /b+uTQpDqPRPVB/HUW9GgqoYfOPf7qtkl+a3uksYGIl/1zs2hKSedfbAHuKiQGnTY3uI
         VjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DAEGDAuPbU/UsEoguNMCXNFrBpM9xfKecWAU03Wi78o=;
        b=Y+RZPJChRWzA14kTe7gaAyMc7rYA6wsKgYEbgYETD1IufYequuzcR8ydadUMXtoJmf
         1fcGP1L9B5wfGdL7vmFuvA5yPhAywk3kE+OLMWn+3Tcirh0YehgM7p1zAE1+x9AAsoVb
         ZOQd1rXzYqDVFr4ZMhS72pT49dtOqC9B99kgvMRvgisJ/cr6MsfZyoTFkY0mb66CcOoQ
         GWl1caF5GGP0B8UwCR066DJBqZDPw5oTmQBx18fx4ZdehTWgYw8s1QWK+1ByBo1Kxduf
         Rpc0jYyheG/2ppHHhaLoeaVw6ha/KF87xPszfJgeXmc6hQT2cRFN32tfCQWZqBG9cIV1
         5JJQ==
X-Gm-Message-State: AOAM530eKkIg5rW4aaa2yeWqIcY15gjarOXWaXQFr1gUZlYtMppeSAn6
        MfIand0qz5IAS8eg1w6YNI+ln90nH0CZ3Q==
X-Google-Smtp-Source: ABdhPJzE+YXFRd50IX1QHTk+L0yPpGGhE3xZJxt4W2TLUEZcFRZe0oDvjwgi0TqRvUvkruL9o00aRg==
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr2252996iow.87.1634216496482;
        Thu, 14 Oct 2021 06:01:36 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l125sm1196284ioa.2.2021.10.14.06.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 06:01:36 -0700 (PDT)
Subject: Re: [PATCH 4/9] sbitmap: test bit before calling test_and_set_bit()
To:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-5-axboe@kernel.dk>
 <409c693c-4570-b6f4-3839-501633856151@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b8569fa-cb9f-0f9b-9272-225ce243b71f@kernel.dk>
Date:   Thu, 14 Oct 2021 07:01:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <409c693c-4570-b6f4-3839-501633856151@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 1:20 AM, Hannes Reinecke wrote:
> On 10/13/21 6:54 PM, Jens Axboe wrote:
>> If we come across bits that are already set, then it's quicker to test
>> that first and gate the test_and_set_bit() operation on the result of
>> the bit test.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   lib/sbitmap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index c6e2f1f2c4d2..11b244a8d00f 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -166,7 +166,7 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>>   			return -1;
>>   		}
>>   
>> -		if (!test_and_set_bit_lock(nr, word))
>> +		if (!test_bit(nr, word) && !test_and_set_bit_lock(nr, word))
>>   			break;
>>   
>>   		hint = nr + 1;
>>
> Hah. Finally something to latch on.
> 
> I've seen this coding pattern quite a lot in the block layer, and, of 
> course, mostly in the hot path.
> (Kinda the point, I guess :-)
> 
> However, my question is this:
> 
> While 'test_and_set_bit()' is atomic, the combination of
> 'test_bit && !test_and_set_bit()' is not.
> 
> IE this change moves an atomic operation into a non-atomic one.
> So how can we be sure that this patch doesn't introduce a race condition?
> And if it doesn't, should we add some comment above the code why this is 
> safe to do here?

If test_bit() returns true, we don't bother with the atomic
test_and_set. That's to avoid re-dirtying a cacheline when the operation
would be pointless. There's no race in this case, we just skip this bit.

The sequence of !test_bit && !test_and_set_bit is very much still
atomic, it's just gated on the fact that our optimistic first check said
that the bit is currently clear. It obviously has to be.

-- 
Jens Axboe

