Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CABC433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 02:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEE52078E
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 02:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgG2Clw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:41:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40538 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgG2Clw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 22:41:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id k18so4919831pfp.7;
        Tue, 28 Jul 2020 19:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Xje8KtqlaEQQPy6/KdcZB6xHoRB7xKpWv/qvhrY3jDY=;
        b=jDdYd1Xi/zZ5OqUlCpcDKyp1AOenR7ForDRhXo7mLYSAyotVNoYTBJZ52pDp0tIP/U
         Ri/I1/3ubOwBWfB9tXXr3uExtGJ2INDw7LA+XC2z90rYPPNG+WQvNvM1CUTVRuDkqLv9
         nsj3ooyvFCCeXjIaxY6/XRbQLKlTEqTWh8A+AI1wHRkFvPN9IFVz7JQQWUV/BgPNYShL
         8r5LFeA4yR54o5jWm+ejkxfBP9bwPFdvmeP+6lshkCG4YLys8rEP5ydZr7/+wZ24EdiA
         S8qRPrMVPfQASvb3qllvXdOurW7FoA4SfBetfvHb/KYrzRoXgacMVB3ws8+N+hkX2oFo
         7hlg==
X-Gm-Message-State: AOAM532ay/0UVVyHtZMcI8pBxgpOl8mjKJvu58ALsDYFkdwfDtRuWQ/y
        TToU4k898A+2TjytUpCss1iLej/s
X-Google-Smtp-Source: ABdhPJxpHnWECdbzA2oIVzphb2Ww++nZqmamFR+xPMXotilldKnaN0b/CfscytsCldwoYU+d28EQxw==
X-Received: by 2002:a63:105:: with SMTP id 5mr4048102pgb.114.1595990511228;
        Tue, 28 Jul 2020 19:41:51 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id i66sm382345pfc.12.2020.07.28.19.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 19:41:50 -0700 (PDT)
Subject: Re: [PATCH] block: fix possible race on blk_get_queue()
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200729015101.31534-1-mcgrof@kernel.org>
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
Message-ID: <74bd5f51-c8bd-a1b8-cf85-d9eeb0a82d16@acm.org>
Date:   Tue, 28 Jul 2020 19:41:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729015101.31534-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-07-28 18:51, Luis Chamberlain wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d9d632639bd1..febdd8e8d409 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -605,12 +605,18 @@ EXPORT_SYMBOL(blk_alloc_queue);
>   */
>  bool blk_get_queue(struct request_queue *q)
>  {
> -	if (likely(!blk_queue_dying(q))) {
> -		__blk_get_queue(q);
> -		return true;
> +	struct kobject *obj;
> +
> +	obj = __blk_get_queue(q);
> +	if (!obj)
> +		return false;
> +
> +	if (unlikely(blk_queue_dying(q))) {
> +		blk_put_queue(q);
> +		return false;
>  	}
>  
> -	return false;
> +	return true;
>  }

This change is not sufficient to prevent that the QUEUE_FLAG_DYING flag
is set immediately after this function returns. I propose not to modify
this function but instead to add a comment that is the responsibility of
the caller to prevent that such a race condition occurs.

> -static inline void __blk_get_queue(struct request_queue *q)
> +static inline struct kobject * __must_check
> +__blk_get_queue(struct request_queue *q)
>  {
> -	kobject_get(&q->kobj);
> +	return kobject_get_unless_zero(&q->kobj);
>  }

If a function passes a queue pointer to another function that calls
blk_get_queue() then the caller should guarantee that 'q' is valid
during the entire duration of the call. In other words, I'm not sure the
above change is an improvement.

Thanks,

Bart.
