Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69674C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 16:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E51A20756
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 16:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEPQ2Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 12:28:25 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40306 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgEPQ2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 12:28:25 -0400
Received: by mail-pj1-f68.google.com with SMTP id fu13so2483612pjb.5
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 09:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XlYdbbBSmg/+pgJpBBPai7MO3SDDy2viLmvzMkvuZF8=;
        b=GYcB+7iYiElVoSammJL/Ey2kS85bjVZpdJu0642dlkWnftKg2WVnovNegJx2Ac9tBY
         8DBQ0TZERWhXOdYfQ7jhJLspy5yF5tc8YsyBNOyzV8OnxLZRuA6quAaGy7HCmUKbcSkd
         4D6gujyKCJMrtdG/SDAPzn158+szSbY3PDsM15gL5RKBfTLPBICZQafw3YyXg7HnCW5S
         Ol0EOGqeHJIfpFWj2Vxx44hFC4tx33UJCST4slnfLcVLAKI4F4MG/pXlKzQXo3v/CepB
         SPUSVGH9Am4Xoq3FBIPcu8gY1CNVBsr7BsRJ9BvHkbJ51N41JGzYaeMCu9OQO3ext9ZZ
         EG6g==
X-Gm-Message-State: AOAM531/hQxxswvEuVy0JQJJq7FEEFbDjkDZP49uhAlK2N38KTlT29c0
        W75VJofB9JJIyJh3Et3RWi/NB694
X-Google-Smtp-Source: ABdhPJyEaabLUVJaoscwBwCLcYTaIucbqgp2ZuU7+ouK4DL/L+dfN9s4rVuQFphju8ODg8WzLMeIvA==
X-Received: by 2002:a17:90a:b10f:: with SMTP id z15mr9117329pjq.188.1589646503865;
        Sat, 16 May 2020 09:28:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:97a:fd5b:e2c1:c090? ([2601:647:4000:d7:97a:fd5b:e2c1:c090])
        by smtp.gmail.com with ESMTPSA id 14sm4575165pfy.38.2020.05.16.09.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 09:28:23 -0700 (PDT)
Subject: Re: [PATCH 3/4] blk-mq: remove a pointless queue enter pair in
 blk_mq_alloc_request_hctx
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20200516153430.294324-1-hch@lst.de>
 <20200516153430.294324-4-hch@lst.de>
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
Message-ID: <87513e5c-270c-41cf-51d8-9106351449b5@acm.org>
Date:   Sat, 16 May 2020 09:28:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200516153430.294324-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-16 08:34, Christoph Hellwig wrote:
> No need for two queue references.  Also reduce the q_usage_counter
> critical section to just the actual request allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d96d3931f33e6..69e58cc4244c0 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -439,26 +439,20 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	if (hctx_idx >= q->nr_hw_queues)
>  		return ERR_PTR(-EIO);
>  
> -	ret = blk_queue_enter(q, flags);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
>  	/*
>  	 * Check if the hardware context is actually mapped to anything.
>  	 * If not tell the caller that it should skip this queue.
>  	 */
>  	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
> -	if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
> -		blk_queue_exit(q);
> +	if (!blk_mq_hw_queue_mapped(alloc_data.hctx))
>  		return ERR_PTR(-EXDEV);
> -	}
>  	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
>  	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
>  
> -	blk_queue_enter_live(q);
> +	ret = blk_queue_enter(q, flags);
> +	if (ret)
> +		return ERR_PTR(ret);
>  	rq = blk_mq_get_request(q, NULL, &alloc_data);
> -	blk_queue_exit(q);
> -
>  	if (!rq) {
>  		blk_queue_exit(q);
>  		return ERR_PTR(-EWOULDBLOCK);

This change looks wrong to me. blk_mq_update_nr_hw_queues() modifies
q->queue_hw_ctx so q_usage_counter must be incremented before that
pointer is dereferenced.

Bart.


