Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B839CC433E2
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 17:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF8D2074B
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 17:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbgIHRyY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:54:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37120 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731590AbgIHRyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Sep 2020 13:54:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id 5so93265pgl.4
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2020 10:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cBTvIhJcHXVYn/Psbin1MuPoVps99Y51xyc6PCUNeBs=;
        b=Wk0VJrwN9btLHwzrt4P2ca84Q04k0WsDvmrNDvBFYBd8ycfBVQ67wN8pL0Aj7sy/i8
         STTLrlmKQjpJW/jCudTDSZKvt1EYOMDNoGXgfRncXsSB+pzEIOAwVHKDpmfL/753GWuU
         yVad0cs+SpivDYWAbNC3mkD4EIfEtCObieZKH5oxHl6or/doHTA2X2f/KNmqW0Oxmbci
         4HdQHCXbHObGKCE+lilCvOcG2A1RZmacphYvWEUaUDH0zC+JuvOTA0YZVXdTrTuOo3f7
         MMH8ZoiF+dwlKn8uklvoAFI1Cqw3cz0K//MTwvst/y62Hoz26n0bWLAX8ucEl+zH6ayy
         anLg==
X-Gm-Message-State: AOAM533akq65jkNoFveYDFfW7uqT/NP8Y8YDVlkpXShlXo6VTkxQIpyA
        MlJ9ClWnob1hzZwv19LqxZE=
X-Google-Smtp-Source: ABdhPJzQ5uDDhvKRVEsDZ0KdoJBATv/6i6yPhqxvJhpfUJDybvOcwxCT8S6xUIxR+zI+43JOJhT+NA==
X-Received: by 2002:a63:a54a:: with SMTP id r10mr21415495pgu.5.1599587656769;
        Tue, 08 Sep 2020 10:54:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:fb09:e536:da63:a7cd? ([2601:647:4000:d7:fb09:e536:da63:a7cd])
        by smtp.gmail.com with ESMTPSA id j19sm88376pfi.51.2020.09.08.10.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 10:54:16 -0700 (PDT)
Subject: Re: [PATCH V3 1/4] blk-mq: serialize queue quiesce and unquiesce by
 mutex
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-2-ming.lei@redhat.com>
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
Message-ID: <8e040e37-d1df-ea5f-8a63-f4067d092b72@acm.org>
Date:   Tue, 8 Sep 2020 10:54:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908081538.1434936-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-09-08 01:15, Ming Lei wrote:
>  void blk_mq_unquiesce_queue(struct request_queue *q)
>  {
> +	mutex_lock(&q->mq_quiesce_lock);
> +
>  	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>  
>  	/* dispatch requests which are inserted during quiescing */
>  	blk_mq_run_hw_queues(q, true);
> +
> +	mutex_unlock(&q->mq_quiesce_lock);
>  }
Has the sunvdc driver been retested? It calls blk_mq_unquiesce_queue()
with a spinlock held. As you know calling mutex_lock() while holding a
spinlock is not allowed.

There may be other drivers than the sunvdc driver that do this.

Thanks,

Bart.
