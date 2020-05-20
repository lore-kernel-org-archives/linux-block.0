Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31391C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 20:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDE120829
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 20:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgETUYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 16:24:06 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33170 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgETUYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 16:24:06 -0400
Received: by mail-pj1-f67.google.com with SMTP id z15so320333pjb.0
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 13:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kCXoRzhpkhU60q6UzXtmduQMzPuPhMrPPUtqYlD/Vy4=;
        b=MmlotIebkAEk4RJV+KkAN7QibtGrEDQXb7N76B9VadUuzN/UCLT5dRba9+gsQK091g
         P5EOH3LcwAJQw9RgCicXGABDvSz7EZID8M5zSElwigfvyRtBe18/Ro4rKp0qG1GzzUQz
         y1ZtHukPb1uYR/WZQLttYUBdbuEqGgKLyygkD99/r0fBZ+p57gNUQ6AMwTHuaRl0BG/q
         /d0IsDs3rO/Kx7bRnkY3UdOVjbPSqdU6KWbLx4SP49vHTjWxQGWrJ81iUt2999YYg0L3
         Xs70413nn0+rN+H6+E4/Ux/+YrKJKCcQqaOlxgYIQI8BAguG5HzdQNkCVS05e2zo36lm
         G+6g==
X-Gm-Message-State: AOAM531gFsvOu9JrdBcZyrrI79cc55cFxEi5H1hE8E1kflMEn+VAeeBc
        IbBxzwhwto9LRa7+GwBcA3U=
X-Google-Smtp-Source: ABdhPJxaCJMUfi76Mg+chVeIUKZWugtL2GaPGSTezulmt7yi0RLFt2sr5Z7nAfdai7t3dgIDuHEPxg==
X-Received: by 2002:a17:90a:bd93:: with SMTP id z19mr7537387pjr.109.1590006245108;
        Wed, 20 May 2020 13:24:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c031:e55:f9a8:4282? ([2601:647:4000:d7:c031:e55:f9a8:4282])
        by smtp.gmail.com with ESMTPSA id o9sm2749891pjp.4.2020.05.20.13.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 13:24:04 -0700 (PDT)
Subject: Re: [PATCH 5/6] blk-mq: add blk_mq_all_tag_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20200520170635.2094101-1-hch@lst.de>
 <20200520170635.2094101-6-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <a9b8686b-e3f8-bbd9-7dc8-fc55bd9b7f14@acm.org>
Date:   Wed, 20 May 2020 13:24:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520170635.2094101-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-20 10:06, Christoph Hellwig wrote:
> @@ -321,8 +324,30 @@ static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
>  		busy_tag_iter_fn *fn, void *priv)
>  {
>  	if (tags->nr_reserved_tags)
> -		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
> -	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
> +		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true,
> +				 false);
> +	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false, false);
> +}

Adding /*reserved=*/ and /*iterate_all=*/ comments in front of the
boolean arguments would make this code easier to read.

> +/**
> + * blk_mq_all_tag_iter - iterate over all requests in a tag map
> + * @tags:	Tag map to iterate over.
> + * @fn:		Pointer to the function that will be called for each
> + *		request. @fn will be called as follows: @fn(rq, @priv,
> + *		reserved) where rq is a pointer to a request. 'reserved'
> + *		indicates whether or not @rq is a reserved request. Return
> + *		true to continue iterating tags, false to stop.
> + * @priv:	Will be passed as second argument to @fn.
> + *
> + * It is the caller's responsibility to check rq's state in @fn.
                ^^^^^^
                @fn?

Not sure how the blk_mq_all_tag_iter() caller can check the request
state ...

> + */
> +void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
> +		void *priv)
> +{
> +	if (tags->nr_reserved_tags)
> +		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true,
> +				 true);
> +	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false, true);
>  }

Same comment here: I think that adding /*reserved=*/ and
/*iterate_all=*/ comments in front of the boolean arguments would make
this code easier to read.

Otherwise this patch looks good to me.

Thanks,

Bart.
