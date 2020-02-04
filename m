Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEFBC3524A
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 03:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76E92080D
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 03:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBDDrF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 22:47:05 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51685 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgBDDrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 22:47:05 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so731665pjb.1;
        Mon, 03 Feb 2020 19:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zm95E5W3qylf1xofGmZybtsQrBmHFZgpDMArHsN2yOI=;
        b=B36baNmjHONSyq7KggayB6n8rWy5kiDAocDWePLNQaSu4G2IvGB5PXDyn1y7zanHIP
         aokNiLrKS1U+b2XRnHZL6JY4q+/CorkCBAmMMScKGPYijlpsvDbAeCdI+r4yvZC5RGTp
         tQii2j/Uuce126O2xlYGCS/To4KO7DxjPj0zMR9ahoPulQ7bNfVdSlf0+r5DuH0zmb9e
         9F/Vxo67gW1tc30u3hN2z84vWkM403gvKX733am/1m8XBh+NzODTiAz4/fYFh4Mwu6jU
         JBaf2lOdDn33LGnrGpsvXRRnYpfXqRjoPRFQTQ8gLSHQjEypTkhecC1vssBPd4YcIidC
         JGgg==
X-Gm-Message-State: APjAAAUur9avbeFqIHN8M8/9TVsqC3Rc68HuXCWNllv/1uSwTwJUcmmz
        l5lpGfdxHbGP1Qk4Xr9Wo7kWc4ou
X-Google-Smtp-Source: APXvYqw0Qc9XYi7lldzBn5XRHmkjwM1P7xUlWRjEptadKkJ0RvENoQHOjNpNijW2wz6FE4zDeAGpHA==
X-Received: by 2002:a17:90b:f0f:: with SMTP id br15mr3316479pjb.138.1580788024303;
        Mon, 03 Feb 2020 19:47:04 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:39ff:b3e1:a9e7:4382? ([2601:647:4000:d7:39ff:b3e1:a9e7:4382])
        by smtp.gmail.com with ESMTPSA id 133sm21996869pfy.14.2020.02.03.19.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 19:47:03 -0800 (PST)
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Salman Qazi <sqazi@google.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>
References: <CAKUOC8U03G27b6E7Z6mBo6RB=D7bKS_MQPwexEZiA7SOt_Lyvw@mail.gmail.com>
 <20200203205950.127629-1-sqazi@google.com>
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
Message-ID: <6499bf21-df25-3881-4252-8c51a9785bb7@acm.org>
Date:   Mon, 3 Feb 2020 19:47:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203205950.127629-1-sqazi@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-03 12:59, Salman Qazi wrote:
> We observed that it is possible for a flush to bypass the I/O
> scheduler and get added to hctx->dispatch in blk_mq_sched_bypass_insert.
> This can happen while a kworker is running blk_mq_do_dispatch_sched call
> in blk_mq_sched_dispatch_requests.
> 
> However, the blk_mq_do_dispatch_sched call doesn't end in bounded time.
> As a result, the flush can sit there indefinitely, as the I/O scheduler
> feeds an arbitrary number of requests to the hardware.
> 
> The solution is to periodically poll hctx->dispatch in
> blk_mq_do_dispatch_sched, to put a bound on the latency of the commands
> sitting there.

(added Christoph, Ming and Hannes to the Cc-list)

Thank you for having posted a patch; that really helps.

I see that my name occurs first in the "To:" list. Since Jens is the
block layer maintainer I think Jens should have been mentioned first.

In version v4.20 of the Linux kernel I found the following in the legacy
block layer code:
* From blk_insert_flush():
	list_add_tail(&rq->queuelist, &q->queue_head);
* From elv_next_request():
	list_for_each_entry(rq, &q->queue_head, queuelist)

I think this means that the legacy block layer sent flush requests to
the scheduler instead of directly to the block driver. How about
modifying the blk-mq code such that it mimics that approach? I'm asking
this because this patch, although the code looks clean, doesn't seem the
best solution to me.

> +		if (count > 0 && count % q->max_sched_batch == 0 &&
> +		    !list_empty_careful(&hctx->dispatch))
> +			break;

A modulo operation in the hot path? Please don't do that.

> +static ssize_t queue_max_sched_batch_store(struct request_queue *q,
> +					   const char *page,
> +					   size_t count)
> +{
> +	int err, val;
> +
> +	if (!q->mq_ops)
> +		return -EINVAL;
> +
> +	err = kstrtoint(page, 10, &val);
> +	if (err < 0)
> +		return err;
> +
> +	if (val <= 0)
> +		return -EINVAL;
> +
> +	q->max_sched_batch = val;
> +
> +	return count;
> +}

Has it been considered to use kstrtouint() instead of checking whether
the value returned by kstrtoint() is positive?

> +	int			max_sched_batch;

unsigned int?

Thanks,

Bart.
