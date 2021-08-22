Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F865C4338F
	for <linux-block@archiver.kernel.org>; Sun, 22 Aug 2021 03:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643426128B
	for <linux-block@archiver.kernel.org>; Sun, 22 Aug 2021 03:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhHVDBo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Aug 2021 23:01:44 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44839 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhHVDBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Aug 2021 23:01:44 -0400
Received: by mail-pl1-f178.google.com with SMTP id e1so1235313plt.11
        for <linux-block@vger.kernel.org>; Sat, 21 Aug 2021 20:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=40N7JTkN+9UxQHnUzXIBMOf8lkM+yv6fPQhyahzugJ8=;
        b=gkl1wujhGEhIZaesSeBHEgrKRFIkMcaAxf5YmOps2lUQ+RQ84XQj8v+KMByCtEntEk
         9RrKy7T7k/lzuSdobcALmQue5gvt8o/1SQgiBap93hcau/4PqocHZNLf20UwZ4WVNqDf
         KsgTRYyJr5R/3xUcW/Z3wvR47WWuLdKMR5O0zSJ/3UmqCdzaMxtDUCmdI12a/CpMO6qG
         FjSM9Ibw6cLhw6lNxHHBYdtiJmhgGbGf9F5BRvGQBxWOt6YaE1tXHNA4FcGvrFFmuo8+
         fx7zH6sB0BgPiyOsemg9eAqF6HirrMnEElUK4qAYXajxUPyAF1MlTUiqzQPn3XrXcP07
         HKrA==
X-Gm-Message-State: AOAM532Rmsvtol+RBZ2Ljkwrnn8iqMy0W0zYMUvNDAk+55U4EZ5Jf+7a
        f/Pq9tZGraUAQ+yjZdTf+IdDDvO0m/k=
X-Google-Smtp-Source: ABdhPJyv48rGcSYoXopoyG04hUOSHSeKGvJUxthDX2Dkch6eBkTV7gWdHkWPUHfjO11Sk/0ak7oy3A==
X-Received: by 2002:a17:90a:5285:: with SMTP id w5mr12551162pjh.78.1629601263379;
        Sat, 21 Aug 2021 20:01:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:5c14:c983:6add:f6c9? ([2601:647:4000:d7:5c14:c983:6add:f6c9])
        by smtp.gmail.com with ESMTPSA id l6sm11531622pff.74.2021.08.21.20.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 20:01:02 -0700 (PDT)
Subject: Re: slab-out-of-bounds access in bio_integrity_alloc()
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4b6318fb-0008-1747-64d5-b31991324acf@acm.org>
 <7ed9a751-8874-14d1-cbc1-af39768cce95@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4743ad4d-6ec0-9ea8-ded4-a2657329fb80@acm.org>
Date:   Sat, 21 Aug 2021 20:01:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7ed9a751-8874-14d1-cbc1-af39768cce95@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/21 8:06 PM, Jens Axboe wrote:
> On 8/20/21 4:58 PM, Bart Van Assche wrote:
>> Hi,
>>
>> It's been a while since I ran blktests. If I run it against Jens' for-next
>> branch (39916d4054e7 ("Merge branch 'for-5.15/io_uring' into for-next")) a
>> slab-out-of-bounds access complaint appears. Is anyone already looking into
>> this?
> 
> Does this help?
> 
> diff --git a/block/bio.c b/block/bio.c
> index ae9085b97deb..94a0c01465a8 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -282,8 +282,9 @@ void bio_init(struct bio *bio, struct bio_vec *table,
>  	atomic_set(&bio->__bi_remaining, 1);
>  	atomic_set(&bio->__bi_cnt, 1);
>  
> -	bio->bi_io_vec = table;
>  	bio->bi_max_vecs = max_vecs;
> +	bio->bi_io_vec = table;
> +	bio->bi_pool = NULL;
>  }
>  EXPORT_SYMBOL(bio_init);

Hi Jens,

That patch makes the KASAN complaint disappear. Thanks!

Bart.

