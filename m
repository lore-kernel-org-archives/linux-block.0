Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03624C433FE
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB5B611EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhKDLoP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhKDLoP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 07:44:15 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA7C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 04:41:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l8so5850053ilv.3
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lQJLpIyALbgHLicql0qBfTiQWTS6b6fJLI43yG1kOi8=;
        b=iZR5Qvr2iM2mn+OsQjxvX8FvsMH7ECKWdTi1Ey25L7X9VdjsCzSMELB62Av7YOPcEU
         HHTsiteFakYvJWqK1r6JJrmIcE1NMe94GPC7dJe41mDyXDZhcVXJ2djGmG4uuqWqo3t0
         lGfA4e+6CajUpq0Xv3QnFELu2UCAee1tdK7WDhNnwMCoRFNgESYHbe5+b8sdveikcMBP
         OQCq/fNi3ZMjGtijHCnoK9i00cxlk2o4NUVHEg6LLqCGWCXkVRZUioySzNkydcnKarE+
         15AId06xKFYCnq2eDp1kscXGeHobId6Q60oqp/Ya4li4chTGHXSi/KkPApPZlurr3wTy
         LqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lQJLpIyALbgHLicql0qBfTiQWTS6b6fJLI43yG1kOi8=;
        b=VabAz65lrNO48LpeGBfxaM+JbzBe9adKJGQPF0EhHE0ZyZJmEBbPZizzwvg973jnUh
         XA1VV7lQEJfXZYbHwmzf+qqtclYLpVLoEvgHInpf9WuufbYiLap/ynrov6ngvJtMOUWz
         aSKlP/YIL9ND9BfnmTVnbhZyXpzBtUiF5ESbG5FpwCAMbh81mzjRhu/jJ28oVlBoOKim
         SDCvUmV+8ISLsnCk8Jv6ql7e3R921MYOlQNPEDGLAgG2vjC+3RbTmyjwPHdbbYTLNAwH
         u4QSu4qeLa93gSff22e2N/EJ7nX71CY6mcn4WqVeLk2B90gqtVg0FC3MPAPPi2LHIt8f
         R1yg==
X-Gm-Message-State: AOAM531ZGWg0Ru0qcFdZuyluTyrzlirLbPFPB3oxEDoQw49ofhcYDhUr
        DDariN5d3/Cls+L4j5ZAmxCWZfIuvcwGew==
X-Google-Smtp-Source: ABdhPJyb4qVJKX1HNyPEKDKCXR8oCLXFEmsdkL4Zr/0RE+dOFVpkg/kCBeVe3Cadtgx15J2AVv69Lw==
X-Received: by 2002:a05:6e02:1649:: with SMTP id v9mr15505630ilu.113.1636026096549;
        Thu, 04 Nov 2021 04:41:36 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id c3sm2752227ili.33.2021.11.04.04.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 04:41:36 -0700 (PDT)
Subject: Re: [PATCH 3/4] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-4-axboe@kernel.dk> <YYOjcuEExwJN1eiw@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff6be121-5753-fe5f-90dc-8703da656d53@kernel.dk>
Date:   Thu, 4 Nov 2021 05:41:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYOjcuEExwJN1eiw@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 3:10 AM, Christoph Hellwig wrote:
> On Wed, Nov 03, 2021 at 12:32:21PM -0600, Jens Axboe wrote:
>> Retain the old logic for the fops based submit, but for our internal
>> blk_mq_submit_bio(), move the queue entering logic into the core
>> function itself.
> 
> Can you explain the why?  I guess you want to skip the extra reference
> for the cached requests now that they already have one.  But please
> state that, and explain why it is a fix, as to me it just seems like
> another little optimization.

It's just pointless to grab double references, and counter productive
too.

>> We need to be a bit careful if going into the scheduler, as a scheduler
>> or queue mappings can arbitrarily change before we have entered the queue.
>> Have the bio scheduler mapping do that separately, it's a very cheap
>> operation compared to actually doing merging locking and lookups.
> 
> So just don't do the merges for cache requets and side step this
> extra bio_queue_enter for that case?

I'd be fine with that, but it's a bit of a chicken and egg situation as
we don't know. I guess we could move the plugged request check earlier,
and just bypass merging there. Though that makes it a special case
thing, and it's generally useful now. Not sure that would be a good
idea.

>> -	if (unlikely(bio_queue_enter(bio) != 0))
>> -		return;
>> -
>>  	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
>> -		goto queue_exit;
>> +		return;
> 
> This is broken, we really ant the submit checks under freeze
> protection to make sure the parameters can't be changed underneath
> us.

Which parameters are you worried about in submit_bio_checks()? I don't
immediately see anything that would make me worry about it.

>> +static inline bool blk_mq_queue_enter(struct request_queue *q, struct bio *bio)
>> +{
>> +	if (!blk_try_enter_queue(q, false) && bio_queue_enter(bio))
>> +		return false;
>> +	return true;
>> +}
> 
> This looks weird, as blk_try_enter_queue is already called by
> bio_queue_enter.

It's just for avoiding a pointless call into bio_queue_enter(), which
isn't needed it blk_try_enter_queue() is successful. The latter is short
and small and can be inlined, while bio_queue_enter() is a lot bigger.

>>  	} else {
>>  		struct blk_mq_alloc_data data = {
>>  			.q		= q,
>> @@ -2528,6 +2534,11 @@ void blk_mq_submit_bio(struct bio *bio)
>>  			.cmd_flags	= bio->bi_opf,
>>  		};
>>  
>> +		if (unlikely(!blk_mq_queue_enter(q, bio)))
>> +			return;
>> +
>> +		rq_qos_throttle(q, bio);
>> +
> 
> At some point the code in this !cached branch really needs to move
> into a helper..

Like in the next patch?

-- 
Jens Axboe

