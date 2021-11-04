Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2704C4332F
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE74C61212
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhKDRjJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbhKDRjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 13:39:07 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D2C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 10:36:29 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so9313271otf.2
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SNflTKuhJeup8uJxUkdnnXBFpeHypWR4LuxBzBUB9SU=;
        b=K/yzhI87P5uXcBJ6Wuh6Wmjtw1mHuZmf+yDrfUhU5EZLfQQ8JKCO4ru9d5hVuHl1w2
         O++4+MvPr2DMKiH4TosHACcTOCKcFVlLE7lzs8gkvMyQY0ucWgJ12Cevabau11JVToYZ
         DZY7w863fPz/uhAYrEcfUUSXxLfLJRAo9deoDHPb3guRE6nKtZAEQlpYaiiEkkXVCaN2
         BQPh7MKZoxeCJaN813LdJGky/YektDGFixnBktesBKd59K7GE86q6pYgF+ywQt1JRvIq
         P2sTGkj+izLUifB3NT90yznqe0Er/EBxU35Ef8yVndoQEONn9YRNI4KLhCtJQ7Oghh7z
         MI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SNflTKuhJeup8uJxUkdnnXBFpeHypWR4LuxBzBUB9SU=;
        b=U3ddL08fqI3+MKjShBzNwiY27xIS+vU/IObi0SrKOObI7h5c98kucC23VN++/ds8sD
         50nO9luy2FaAoAnNnvMy+GDkJSu4RTpe4KuaSel6snJ919xQ2thNSC46+CsF9dhMx0ae
         YwYUPuAK0JSPrmsixf3pwN2vCpfM8to6+tAUMEXbvQEFqyHM08CL+mtaDqbXEuCEn35W
         fEJ8Eg48ZUgbhGm+ObbK7BfwvRnV2KGH9P8MiswvhI+99Vg6jKJlyvMst3jnE5Uw9We9
         njukPtkx+G/ojSXjEKxoWMeKEcSzbvDjgvDxh6nLBI8IY+GaLrBf8mZMcrREw6WKNLIL
         MgKw==
X-Gm-Message-State: AOAM532mhXy1n4HLqA2yPAAJ32fMrrf2FWBU26kkIyBkg+/gj5nlLt0B
        ngkS8OX/SNh8o/54ZBYsTKePV7AIrsv0jg==
X-Google-Smtp-Source: ABdhPJy9iQx3I9qOlSowmJIH154LJcC0xAZRCwSJlqgLkEDse3KMAp9z1mzzeduY42zlDiDlkJIQxw==
X-Received: by 2002:a9d:744d:: with SMTP id p13mr31013147otk.295.1636047388790;
        Thu, 04 Nov 2021 10:36:28 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v1sm1476527oof.8.2021.11.04.10.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 10:36:28 -0700 (PDT)
Subject: Re: [PATCH 3/4] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-4-axboe@kernel.dk> <YYOjcuEExwJN1eiw@infradead.org>
 <ff6be121-5753-fe5f-90dc-8703da656d53@kernel.dk>
 <YYQYyEljsvANMP3q@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97ae421d-6942-eb24-337a-103fd8898fc7@kernel.dk>
Date:   Thu, 4 Nov 2021 11:36:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYQYyEljsvANMP3q@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 11:30 AM, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 05:41:35AM -0600, Jens Axboe wrote:
>>>>  	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
>>>> -		goto queue_exit;
>>>> +		return;
>>>
>>> This is broken, we really ant the submit checks under freeze
>>> protection to make sure the parameters can't be changed underneath
>>> us.
>>
>> Which parameters are you worried about in submit_bio_checks()? I don't
>> immediately see anything that would make me worry about it.
> 
> Mostly checks if certain operations are supported or not, as
> revalidation could clear those.
> 
>>> This looks weird, as blk_try_enter_queue is already called by
>>> bio_queue_enter.
>>
>> It's just for avoiding a pointless call into bio_queue_enter(), which
>> isn't needed it blk_try_enter_queue() is successful. The latter is short
>> and small and can be inlined, while bio_queue_enter() is a lot bigger.
> 
> If this is so impotant let's operated with an inlined bio_queue_enter
> that calls out of line into slow path instead of open coding it
> like this.

Sure, I can do that instead.

>>>>  	} else {
>>>>  		struct blk_mq_alloc_data data = {
>>>>  			.q		= q,
>>>> @@ -2528,6 +2534,11 @@ void blk_mq_submit_bio(struct bio *bio)
>>>>  			.cmd_flags	= bio->bi_opf,
>>>>  		};
>>>>  
>>>> +		if (unlikely(!blk_mq_queue_enter(q, bio)))
>>>> +			return;
>>>> +
>>>> +		rq_qos_throttle(q, bio);
>>>> +
>>>
>>> At some point the code in this !cached branch really needs to move
>>> into a helper..
>>
>> Like in the next patch?
> 
> No, I mean the !cached case which is a lot more convoluted.

Yeah, a helper there might be appropriate. I'll write it up.

-- 
Jens Axboe

