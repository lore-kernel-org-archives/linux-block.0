Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7407C38A2A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D135221655
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgEIDI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 23:08:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33030 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgEIDI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 23:08:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so1593403plr.0
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 20:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n509twqLJUZ77ESsHaCC7D/gLxblTEdty7eYWv7gpgE=;
        b=KioWFhfKm+OQF++QQ5ioSX5fhCiZTgRXyXI+GVZTbL/d15u+hZ/pGck6AtJ8qHKSBf
         niVhKwyb+5KjJED7QipPEsxJx5RTex0FZKnU2W6VLA2KhKgkdrUC/Rgu9yLzulQf5Q+1
         7WH7U9yA8milU8mQWO22+SIGd3zbnBmBu6SnQwwoGHU3LUhcXd56CRwzDH++e63DsYYZ
         h1oNKOEBLxdWlZV9djqrUXYqtsM39naW6+3YC3aWVLIAVl8mLwctzhz18hDXY8fiQRq7
         XOAsNm6s9eG0px3+hwO2qFSKfiI5IEvW5bv4UaJI406pDb35eFwzNPgH9C/R3KVQENPI
         6wHg==
X-Gm-Message-State: AGi0PuYvfLNmAOmObfzqnq7uPoIFzXL89GDsmkbkrTYMSL2D6Azx6MlD
        B4xuLRqjVkurQmHE+omY/BU=
X-Google-Smtp-Source: APiQypJoXOZ/TewccB76ETB+tj8wh83V9piLpOHm7/vV3a2qUQI2wHSjAKqvCgdjy4bCkuf5fmYJyg==
X-Received: by 2002:a17:90a:4814:: with SMTP id a20mr8985272pjh.198.1588993705500;
        Fri, 08 May 2020 20:08:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:1981:d78f:7563:fc3d? ([2601:647:4000:d7:1981:d78f:7563:fc3d])
        by smtp.gmail.com with ESMTPSA id c80sm3146801pfb.82.2020.05.08.20.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 20:08:24 -0700 (PDT)
Subject: Re: [PATCH V10 05/11] blk-mq: support rq filter callback when
 iterating rqs
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-6-ming.lei@redhat.com>
 <8d7a14f8-b36c-4f5c-a4af-d5904d3e9ea1@acm.org>
 <51888b96-1e3b-9810-fb64-47a965b83711@acm.org>
 <20200509020522.GA1392681@T590>
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
Message-ID: <a0d48ad1-a0f2-7b3a-37ac-0dfe7f1740a7@acm.org>
Date:   Fri, 8 May 2020 20:08:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509020522.GA1392681@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-08 19:05, Ming Lei wrote:
> Fine, then we can save one callback, how about the following way?
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 586c9d6e904a..5e9c743d887b 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -257,6 +257,7 @@ struct bt_tags_iter_data {
>  	busy_tag_iter_fn *fn;
>  	void *data;
>  	bool reserved;
> +	bool iterate_all;
>  };
>  
>  static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> @@ -274,8 +275,10 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  	 * test and set the bit before assining ->rqs[].
>  	 */
>  	rq = tags->rqs[bitnr];
> -	if (rq && blk_mq_request_started(rq))
> -		return iter_data->fn(rq, iter_data->data, reserved);
> +	if (rq) {
> +		if (iter_data->iterate_all || blk_mq_request_started(rq))
> +			return iter_data->fn(rq, iter_data->data, reserved);
> +	}

How about combining the two if-statements above in the following single
if-statement:

if (rq && (iter_data->iterate_all || blk_mq_request_started(rq)))
	...

> @@ -321,8 +326,30 @@ static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
>  		busy_tag_iter_fn *fn, void *priv)
>  {
>  	if (tags->nr_reserved_tags)
> -		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
> -	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
> +		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true,
> +				 false);
> +	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false, false);
> +}

How about inserting comments like /*reserved=*/ and /*iterate_all=*/ in
the bt_tags_for_each() call in front of "false" to make these calls
easier to read?

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
> + * It is the caller's responsility to check rq's state in @fn.
                         ^^^^^^^^^^^^
                         responsibility?
> + */
> +void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
> +		void *priv)
> +{
> +	if (tags->nr_reserved_tags)
> +		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true,
> +				 true);
> +	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false, true);
>  }

Same comment here: how about inserting /*reserved=*/ and
/*iterate_all=*/ comments in the bt_tags_for_each() call?

Otherwise this proposal looks good to me.

Thanks,

Bart.
