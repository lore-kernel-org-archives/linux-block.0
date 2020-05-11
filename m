Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48DAC47255
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 20:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3E6206D7
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 20:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgEKUwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 16:52:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44494 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUwR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 16:52:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id b8so4421161plm.11
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 13:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wpq+eLjryfkksZnP1AfH9y18DVeQNadA/AXUeJKbrOU=;
        b=r98sag3Vj1I4raeMr5heCp+dZWZGjspxS6qbQckQfovEKM/xbQ6NsLZ1PP/uRe3umr
         aPPATwwLuGMQc5lG/QZaCdJQclkFRVKXTHRdHinRZl8m/xPk+1NagM2YxX1WGorjf0e8
         fqt8/U64OjRMErwIjEdQO5yFIXlRly8UDmPuL27UQgXDxLDgFJR9r+ZxIo9tw+RJs8Db
         QH/83Bk2yLcD/ILpazi7ERhdrMPtWuoFfQ73Uhaog1P9QAtJw9b3oPz9dGfMth9mqFsB
         4pB0t/s4fFWTqLIIlI1mz07ry31I28vLde+B5sHt5MmfTFQY5HxHkYd/Hmz3DMsbYyNN
         dfoQ==
X-Gm-Message-State: AGi0PuaqwtN9jfAP3M+casjNquHk+GRMkTsYDJCGLPpEw4a3Jeqg9xMw
        2AjcJgpuRow5VYSN8TzEvBhdmWxKXIQ=
X-Google-Smtp-Source: APiQypKoYjlDJZQz/HVpW+mfdf7zvO+TsoKwWbnU00/2AFGsPkn61i091KscI3pyEA6z6FG7j8B+cg==
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr24848168pjh.65.1589230336372;
        Mon, 11 May 2020 13:52:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c4e5:b27b:830d:5d6e? ([2601:647:4000:d7:c4e5:b27b:830d:5d6e])
        by smtp.gmail.com with ESMTPSA id v133sm9975375pfc.113.2020.05.11.13.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 13:52:15 -0700 (PDT)
Subject: Re: [PATCH V10 11/11] block: deactivate hctx when the hctx is
 actually inactive
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hannes Reinecke <hare@suse.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-12-ming.lei@redhat.com>
 <954b942e-3b06-4be7-9f2f-23f87ff514f0@acm.org>
 <20200511021133.GC1418834@T590>
 <73702cd9-6dcc-a757-be3b-c250e050692c@acm.org>
 <20200511040841.GE1418834@T590>
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
Message-ID: <c4d78e75-91e1-1521-1ba0-d30bf3716f83@acm.org>
Date:   Mon, 11 May 2020 13:52:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511040841.GE1418834@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-10 21:08, Ming Lei wrote:
> OK, just forgot the whole story, but the issue can be fixed quite easily
> by adding a new request allocation flag in slow path, see the following
> patch:
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ec50d7e6be21..d743be1b45a2 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -418,6 +418,11 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>  		if (success)
>  			return 0;
>  
> +		if (flags & BLK_MQ_REQ_FORCE) {
> +			percpu_ref_get(ref);
> +			return 0;
> +		}
> +
>  		if (flags & BLK_MQ_REQ_NOWAIT)
>  			return -EBUSY;
>  
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index c2ea0a6e5b56..2816886d0bea 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -448,6 +448,13 @@ enum {
>  	BLK_MQ_REQ_INTERNAL	= (__force blk_mq_req_flags_t)(1 << 2),
>  	/* set RQF_PREEMPT */
>  	BLK_MQ_REQ_PREEMPT	= (__force blk_mq_req_flags_t)(1 << 3),
> +
> +	/*
> +	 * force to allocate request and caller has to make sure queue
> +	 * won't be forzen completely during allocation, and this flag
> +	 * is only applied after queue freeze is started
> +	 */
> +	BLK_MQ_REQ_FORCE	= (__force blk_mq_req_flags_t)(1 << 4),
>  };
>  
>  struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,

I'm not sure that introducing such a flag is a good idea. After
blk_mq_freeze_queue() has made it clear that a request queue must be
frozen and before the request queue is really frozen, an RCU grace
period must expire. Otherwise it cannot be guaranteed that the intention
to freeze a request queue (by calling percpu_ref_kill()) has been
observed by all potential blk_queue_enter() callers (blk_queue_enter()
calls percpu_ref_tryget_live()). Not introducing any new race conditions
would either require to introduce an smp_mb() call in blk_queue_enter()
or to let another RCU grace period expire after the last allocation of a
request with BLK_MQ_REQ_FORCE and before the request queue is really frozen.

Serializing hardware queue quiescing and request queue freezing is
probably a much simpler solution. I'm not sure of this but maybe holding
the mq_freeze_lock mutex around hardware queue quiescing is sufficient.

Thanks,

Bart.
