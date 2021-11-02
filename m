Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43248C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7A360F58
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhKBPaq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbhKBPap (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 11:30:45 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE08C061714
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 08:28:10 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 62so18572304iou.2
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jJVXxGkJ3zgqOucncA43mG2fFksNDaQOJDAYmWfa9D0=;
        b=eZcZ8i2N0cGILIBngLNiptkVAb+/0yXScqocDTu2mARBEDuf0VGRVk+awhOtVQZUif
         ZqvQmMNluSkTskIETDzpO07CQJLQ5JlZuIi/ivljHQn2Gedn/YoxoVZPeAUKDN1jh3wf
         yfwK6HtOq3ofYzS8vNRBRJQUnDbpi2xPHXOAnL4fjzm/3WnYD6ijApnVwCVlR3W5t++3
         5DpGwk2MfnD5lIHknvZpdaBHiQe00w99sYyopsU0VB85wQ9cntkhzsUvdevbmPwpkQ8U
         8ajuLpG2iCu+upsLj38ahISk/RT339KbAJg41Eh2Rwy1JJBgjopk7eHyKNnzNVndacos
         x/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jJVXxGkJ3zgqOucncA43mG2fFksNDaQOJDAYmWfa9D0=;
        b=UWWgdj/lUwa9E2qGjk2qa/M9OoNgMagh9cklzhRTWp0htlJTGv2tP8LsuyYeIcbf5y
         QrX45SzwQ08CeglOYfeLV9ZhFjqfMFJzusYH/kBruqxXoGvntlyca6k2RcaWDpvxJbzY
         BeO59TBV9iZ9t+kjORsWEc1bkCcZTHMBO5N3qvqS/6/hP1WNU9/3nwyg6a7LefWFazEg
         aPM5aFULY4izPmunMtGepf6vH+aUgIAwdjzL03hiPm5NTiLXEq2EHQa/9Fp+jMm/QpL5
         t5gYG6dNe/vVARd7f+1sppC4Hlel618Ezri2VjWEXH6ub8Ec+eqPorj3Rb0aPdmaBYAK
         duGQ==
X-Gm-Message-State: AOAM530ZvULATAJgolmjF5hbFq9KNHnc2xIy7k/8tNh4VtiCHQXkav0U
        cFkTWYBTPoghlrh64XI5XPT8QcIjquo2gA==
X-Google-Smtp-Source: ABdhPJyIwKphffcOexwYJ5bvkasr5t+2UNiZMTlMwZ1bXZU+IoF7r4ALSTu/9CSJHbEph2u9SOTdAg==
X-Received: by 2002:a05:6602:5c1:: with SMTP id w1mr26372134iox.149.1635866889965;
        Tue, 02 Nov 2021 08:28:09 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f15sm8519412iob.8.2021.11.02.08.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 08:28:09 -0700 (PDT)
Subject: Re: [GIT PULL] bdev size cleanups
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f870c029-140d-3e77-dcd1-1890025b5795@kernel.dk>
 <CAHk-=wii3c_VebHJxEyqU5P6FKjOLirYHQm+0=oaL59DNi-t1A@mail.gmail.com>
 <71c40f9b-7f83-be81-18cf-297077db005c@kernel.dk>
 <CAHk-=wh6dwyg9XMxiBB9or2oofXea7VY_hMjm4-0_9YU8o+LZQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74554d1d-7929-44d0-dadd-78df31bed0a2@kernel.dk>
Date:   Tue, 2 Nov 2021 09:28:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh6dwyg9XMxiBB9or2oofXea7VY_hMjm4-0_9YU8o+LZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/21 5:50 PM, Linus Torvalds wrote:
> On Mon, Nov 1, 2021 at 4:20 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Yes, probably safer just to make bdev_nr_bytes() return sector_t as
>> well, even if loff_t isn't strictly wrong.
> 
> Well, that would actually change the sign of some of the existing
> comparisons. Possibly changing their meaning entirely..
> 
> So having 'loff_t' being signed may be an odd choice for a byte size,
> but it is what it is. At least the current set of cleanups seemed to
> keep the type logic the same when it changed i_size_read() to be
> bdev_nr_bytes() instead.
> 
> Changing it to 'sector_t' not only doesn't make conceptual sense when
> it's a byte count, it might also be dangerous.
> 
> So my reaction was really that it wasn't obvious that bdev_nr_bytes()
> did the shift in the right type.. It does happen to do that, but
> historically sector_t was the smaller type.

OK, I misunderstood your original email, as per Christoph's email as
well. May be worth adding loff_t cast, if for nothing else just to have
it stick out to the next person touching it.

-- 
Jens Axboe

