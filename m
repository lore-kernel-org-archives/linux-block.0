Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F5FC636C9
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 14:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2DC61221
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 14:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhGUOEr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhGUOEq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 10:04:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE0C061575
        for <linux-block@vger.kernel.org>; Wed, 21 Jul 2021 07:45:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so3584963wmi.2
        for <linux-block@vger.kernel.org>; Wed, 21 Jul 2021 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dZ9NZi/HJJ8OP1lsauvNGj6ABfkPZ1DvU07PwWtLbaE=;
        b=Tm2fGfSKzJjtBmbMJ4XKcgby6XDENcyBu/4xcAL9tw0cBgkWHRxZXIy6mLbn/uQWUa
         f0O7lJ6PmhT5qYLrBWkJGcsOxZLI07ttK8hnwDFxVmzEractZNlff4i52DDl90fxvS2C
         ZgiC3WouVRbZP9z9ThPjAanzmVCGkGWqIfZNt0YQcIwTubTN1TFbVI4xWrD+aNjRQG1W
         Rng1qWFf5V3UhR46wv3eUpSzMtZu7WtnZNZFk27QqL+BohYhGJE9SuapiqTLbUVJv68F
         sw0TYilNqhhfeFRKfI23PN0QCnqXYsvD7eSIP34tt7PJpY2NpAkamusUus6qum3mG9zw
         aQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZ9NZi/HJJ8OP1lsauvNGj6ABfkPZ1DvU07PwWtLbaE=;
        b=YauehSTspv2fhhnplrcBeXBA3ZwQDWKQ3vWaUlPZR958E/YxodZIt9UyjIQTqhNKd3
         rjeKrvF89ZJc3l8jK4SsnFWJnAR0uaBOBl0TY8B4uO49NwMx42X3juASowfVbKSmEQsG
         xT11ioHNqPxcz/dMGG4mDURgQ/HA30XP4gRxvUVCaUDbD1JCKmWkgjl+4bqMsG7hoFS/
         kPrsGXluuP++YDMyNr/xX48pp00WrcS1FrTMbqEwfT4juCrpKuX4FTGSK48mr+005cKq
         JdBf9n5Ril87N+KvPBZrjLkBin6nFackYfzUbZeCRC8t5lZfFiJJ40SXEkSis2jGdWc6
         KpfQ==
X-Gm-Message-State: AOAM530t1+rQQws11T0UNwpkrUsv5LdVxlHuFoTXt5vJArelsw2y+Qnp
        gSh6F5tkqZyV67h6Vibl/lU=
X-Google-Smtp-Source: ABdhPJyLXpJU5LRQOkv2lA05SUcRnpJKsSrj1RXDQXcXd3Gk7W9MrcSZZNT7Y9Un+RRHY4Xr9Lp3+g==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr38754223wmj.148.1626878720154;
        Wed, 21 Jul 2021 07:45:20 -0700 (PDT)
Received: from [192.168.8.197] ([85.255.237.48])
        by smtp.gmail.com with ESMTPSA id b8sm141363wmb.20.2021.07.21.07.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 07:45:19 -0700 (PDT)
Subject: Re: [RFC] bio: fix page leak bio_add_hw_page failure
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
References: <1edfa6a2ffd66d55e6345a477df5387d2c1415d0.1626653825.git.asml.silence@gmail.com>
 <YPWbcdcpcD/lBmL9@T590> <90d2a028-c458-c260-c2c3-4870576ba370@gmail.com>
 <YPYw5Ma4QC9jFPYV@T590>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <6458d531-5ca1-1eae-9b43-6d7e30baec05@gmail.com>
Date:   Wed, 21 Jul 2021 15:44:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPYw5Ma4QC9jFPYV@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/21 3:11 AM, Ming Lei wrote:
> On Mon, Jul 19, 2021 at 06:06:49PM +0100, Pavel Begunkov wrote:
>> On 7/19/21 4:34 PM, Ming Lei wrote:
>>> On Mon, Jul 19, 2021 at 11:53:00AM +0100, Pavel Begunkov wrote:
>>>> __bio_iov_append_get_pages() doesn't put not appended pages on
>>>> bio_add_hw_page() failure, so potentially leaking them, fix it. Also, do
>>>> the same for __bio_iov_iter_get_pages(), even though it looks like it
>>>> can't be triggered by userspace in this case.
>>>>
>>>> Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
>>>> Cc: stable@vger.kernel.org # 5.8+
>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>> ---
>>>>
>>>> I haven't tested the fail path, thus RFC. Would be great if someone can
>>>> do it or take over the fix.
>>>>
>>>>  block/bio.c | 15 +++++++++++++--
>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/bio.c b/block/bio.c
>>>> index 1fab762e079b..d95e3456ba0c 100644
>>>> --- a/block/bio.c
>>>> +++ b/block/bio.c
>>>> @@ -979,6 +979,14 @@ static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *iter)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static void bio_put_pages(struct page **pages, size_t size, size_t off)
>>>> +{
>>>> +	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
>>>> +
>>>> +	for (i = 0; i < nr; i++)
>>>> +		put_page(pages[i]);
>>>> +}
>>>> +
>>>>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
>>>>  
>>>>  /**
>>>> @@ -1023,8 +1031,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>>>  			if (same_page)
>>>>  				put_page(page);
>>>>  		} else {
>>>> -			if (WARN_ON_ONCE(bio_full(bio, len)))
>>>> -                                return -EINVAL;
>>>> +			if (WARN_ON_ONCE(bio_full(bio, len))) {
>>>> +				bio_put_pages(pages + i, left, offset);
>>>> +				return -EINVAL;
>>>> +			}
>>>
>>> It is unlikely to happen:
>>>
>>>         unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
>>>         struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>>>         struct page **pages = (struct page **)bv;
>>>
>>> 		pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>>> 		size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
>>
>> Agree, mentioned in the commit, however ...
>>
>>>>  			__bio_add_page(bio, page, len, offset);
>>>>  		}
>>>>  		offset = 0;
>>>> @@ -1069,6 +1079,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>>>>  		len = min_t(size_t, PAGE_SIZE - offset, left);
>>>>  		if (bio_add_hw_page(q, bio, page, len, offset,
>>>>  				max_append_sectors, &same_page) != len) {
>>>> +			bio_put_pages(pages + i, left, offset);
>>>
>>> Same with above.
>>
>> ... bio_add_hw_page() is more complex and additionally does checks
>> against queue_max_zone_append_sectors(), queue_max_segments(), and
>> queue_virt_boundary() in of bvec_gap_to_prev().
>>
>> It may be unlikely, but are you sure that those are just safety
>> checks? It's not so obvious to me, so would be great if you could
>> point out the other place where the verification is done.
> 
> OK, bio_add_hw_page() is special, and it needs the handling, but 
> __bio_iov_iter_get_pages() needn't that since it is so obvious.

Right. I don't mind to drop the first chunk, but it doesn't hurt, and
I'd guess the bug came from copy-pasting and editing
__bio_iov_iter_get_pages(). That's the reason I added it in the first
place.

-- 
Pavel Begunkov
