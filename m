Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA017C433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4812084C
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 22:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgE0Wws (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 18:52:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42885 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0Wws (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 18:52:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id x11so9742988plv.9
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 15:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/EgT6JLYV4/szy3xpKpygU2i1QsH8y8xW5bMYvlmouc=;
        b=Bk4vjxwph6UDg3+tQoNfKh4FXx3ZoMUBqEzDZ/K4P3qJ02i2wqaW4CL/WAs71JOon1
         zjPvI4Fw4f7KSfiqtNdnuLW+rALER2gbt8yyR3trSw1f0Q5HKDNQLNrc45VS/vpzXnyE
         3YUzRWRyZpBw8S0tuk7u98z1Wm/X7C2kp/uH41FLHYQyv5wsMdMJ/4pgdEjab4G68Wn9
         NvU6EFutUEC/ucOzcb2mRyb2It06QA37YPtitGKIaY3IhNRIh+c9dWMux545tw+t5EAq
         mZfm+WlzcyizMDcfzewo5hvffQl2Aw0ztd8lOFUij7zUqCBWn6XEjfUlS7KRxR7eAPbE
         aM0g==
X-Gm-Message-State: AOAM531oW9/HY5dE5tqdAYWru6W0YSy+QWVp9i2X09RdTVKzPQbLWjG2
        7G0EWlk3YNRBHO5VgMmZctE=
X-Google-Smtp-Source: ABdhPJzg3ltNUDaCNxvd63S0HGwdewVZFYic+rQMYRnMoJ9uxGHpNnDh6AEU2KWZzQqHsbBM7vFFUw==
X-Received: by 2002:a17:902:9342:: with SMTP id g2mr639631plp.326.1590619967459;
        Wed, 27 May 2020 15:52:47 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id w190sm2845598pfw.35.2020.05.27.15.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 15:52:46 -0700 (PDT)
Subject: Re: [PATCH 7/8] blk-mq: add blk_mq_all_tag_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-8-hch@lst.de>
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
Message-ID: <413f73b7-436b-9319-b589-e6fef370fb39@acm.org>
Date:   Wed, 27 May 2020 15:52:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-27 11:06, Christoph Hellwig wrote:
> @@ -308,21 +312,28 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
>  }
>  
>  /**
> - * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
> + * blk_mq_all_tag_iter - iterate over all requests in a tag map
>   * @tags:	Tag map to iterate over.
> - * @fn:		Pointer to the function that will be called for each started
> + * @fn:		Pointer to the function that will be called for each
>   *		request. @fn will be called as follows: @fn(rq, @priv,
>   *		reserved) where rq is a pointer to a request. 'reserved'
>   *		indicates whether or not @rq is a reserved request. Return
>   *		true to continue iterating tags, false to stop.
>   * @priv:	Will be passed as second argument to @fn.
>   */

Please document the new 'flags' argument in the kernel-doc header.

> -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> -		busy_tag_iter_fn *fn, void *priv)
> +static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
> +		busy_tag_iter_fn *fn, void *priv, unsigned int flags)
>  {
>  	if (tags->nr_reserved_tags)
> -		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
> -	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
> +		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv,
> +				 flags | BT_TAG_ITER_RESERVED);
> +	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, flags);
> +}

The meaning of the 'reserved' argument passed to bt_for_each() and also
to busy_iter_fn is 'the request argument is a reserved request'. If
BT_TAG_ITER_RESERVED would be set in the 'flags' argument then the wrong
value will be passed for the 'reserved' argument in the second
bt_tags_for_each() call. So I think we need something like the following
at the start of __blk_mq_all_tag_iter():

	WARN_ON_ONCE(flags & BT_TAG_ITER_RESERVED)

Otherwise this patch looks good to me.

Thanks,

Bart.
