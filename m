Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDC2C12002
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 17:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85337610A5
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 17:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352809AbhGSQmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355399AbhGSQgR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 12:36:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA08DC04F946
        for <linux-block@vger.kernel.org>; Mon, 19 Jul 2021 09:46:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u1so22973924wrs.1
        for <linux-block@vger.kernel.org>; Mon, 19 Jul 2021 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oNKNgwDgN+KBVDUBsGkWXIxS0k04ANBMaQTnyNv4wYI=;
        b=gLVbf8f+79OvSCAU0TWIJtOxK7bdCDGqBJyukCPrue8AjXFadCpvT2nKzCYgNtrqGc
         FdtnbjGeiqPJWmX5YiVf7nN15x++6OIPbiBVCBwuHlxQ+IZd4p3pM4qBvmsWIz7YVY4w
         BNPyJZYnbAWyk6nhuJqQVvchDd4SGWhjhunqsKwRRu1nEHE3JbYBFgu6ebTL4+vJy9uT
         AIKnRUmIlaP7j8uAPoI4CBVF8a125weaLAamr4D/b0E+yLRSOtHoVNTBlrAncy6TJXhC
         nr+JRUy8qgmgsorql+jrg6+xOIYWO5zFNdMWdp78ZKoJZ06o6bhlNz5x94eXwikhqmRM
         s/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oNKNgwDgN+KBVDUBsGkWXIxS0k04ANBMaQTnyNv4wYI=;
        b=lFKG7ca+cmnxzrQxyTg6NYQyxjJHX9kaD87oPHHgblP0Bdd4E0jeFPMQdnXcvCD93D
         QF1rE7irQzTIRfFdaTSiHqbdOTsCSAuTPRwu93LjO/m9Yf8ZmBgrShf7wnajgJ7vdEb1
         +urObBJeYeL16kOoZuDDHvrr0yeuQXVZ9adUU/ZS0Audn/fEmShSM75tKWiRf25mXuEn
         equ9LdKn8nSyNHgtNmTefUHiGl/qFQCBABc3M0MiGTj6oAcR2osaE/SmG9cNI7c1rKFd
         HyEf1HZAi2F0RMSIke9M8khEhsT90lfX/Bq0Y/PAfJxoXv1oIuz5Opp6UBSC1Yp4jZ7n
         8KhQ==
X-Gm-Message-State: AOAM530ps1caXkiW+xWq6tCIcZtA/11Ej9ZMULR+453X2gPoisFtb5+G
        wZHWle5cwReSnLwpnMmnulY=
X-Google-Smtp-Source: ABdhPJyDU/WqqpLH+JuH8RTdW2A4S+/uZ5MYBXirYzvybtd6XhzdF4Abfz/PcpdO9YnSeXhLlYH0mg==
X-Received: by 2002:a5d:46c8:: with SMTP id g8mr30800857wrs.341.1626714430876;
        Mon, 19 Jul 2021 10:07:10 -0700 (PDT)
Received: from [192.168.8.197] ([148.252.132.204])
        by smtp.gmail.com with ESMTPSA id l24sm54646wmi.30.2021.07.19.10.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 10:07:10 -0700 (PDT)
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
References: <1edfa6a2ffd66d55e6345a477df5387d2c1415d0.1626653825.git.asml.silence@gmail.com>
 <YPWbcdcpcD/lBmL9@T590>
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC] bio: fix page leak bio_add_hw_page failure
Message-ID: <90d2a028-c458-c260-c2c3-4870576ba370@gmail.com>
Date:   Mon, 19 Jul 2021 18:06:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPWbcdcpcD/lBmL9@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/19/21 4:34 PM, Ming Lei wrote:
> On Mon, Jul 19, 2021 at 11:53:00AM +0100, Pavel Begunkov wrote:
>> __bio_iov_append_get_pages() doesn't put not appended pages on
>> bio_add_hw_page() failure, so potentially leaking them, fix it. Also, do
>> the same for __bio_iov_iter_get_pages(), even though it looks like it
>> can't be triggered by userspace in this case.
>>
>> Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
>> Cc: stable@vger.kernel.org # 5.8+
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> I haven't tested the fail path, thus RFC. Would be great if someone can
>> do it or take over the fix.
>>
>>  block/bio.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/bio.c b/block/bio.c
>> index 1fab762e079b..d95e3456ba0c 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -979,6 +979,14 @@ static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *iter)
>>  	return 0;
>>  }
>>  
>> +static void bio_put_pages(struct page **pages, size_t size, size_t off)
>> +{
>> +	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
>> +
>> +	for (i = 0; i < nr; i++)
>> +		put_page(pages[i]);
>> +}
>> +
>>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
>>  
>>  /**
>> @@ -1023,8 +1031,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>  			if (same_page)
>>  				put_page(page);
>>  		} else {
>> -			if (WARN_ON_ONCE(bio_full(bio, len)))
>> -                                return -EINVAL;
>> +			if (WARN_ON_ONCE(bio_full(bio, len))) {
>> +				bio_put_pages(pages + i, left, offset);
>> +				return -EINVAL;
>> +			}
> 
> It is unlikely to happen:
> 
>         unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
>         struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>         struct page **pages = (struct page **)bv;
> 
> 		pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> 		size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);

Agree, mentioned in the commit, however ...

>>  			__bio_add_page(bio, page, len, offset);
>>  		}
>>  		offset = 0;
>> @@ -1069,6 +1079,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>>  		len = min_t(size_t, PAGE_SIZE - offset, left);
>>  		if (bio_add_hw_page(q, bio, page, len, offset,
>>  				max_append_sectors, &same_page) != len) {
>> +			bio_put_pages(pages + i, left, offset);
> 
> Same with above.

... bio_add_hw_page() is more complex and additionally does checks
against queue_max_zone_append_sectors(), queue_max_segments(), and
queue_virt_boundary() in of bvec_gap_to_prev().

It may be unlikely, but are you sure that those are just safety
checks? It's not so obvious to me, so would be great if you could
point out the other place where the verification is done.

-- 
Pavel Begunkov
