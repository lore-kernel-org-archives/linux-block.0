Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34357 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdCMIPS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2017 04:15:18 -0400
Subject: Re: [PATCH rfc 04/10] block: Add a non-selective polling interface
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-5-git-send-email-sagi@grimberg.me>
 <1489076712.2597.1.camel@sandisk.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b8124df3-bd09-2eb2-9899-3c9195605510@grimberg.me>
Date: Mon, 13 Mar 2017 10:15:13 +0200
MIME-Version: 1.0
In-Reply-To: <1489076712.2597.1.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> +int blk_mq_poll_batch(struct request_queue *q, unsigned int batch)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +
>> +	if (!q->mq_ops || !q->mq_ops->poll_batch)
>> +		return 0;
>> +
>> +	hctx = blk_mq_map_queue(q, smp_processor_id());
>> +	return q->mq_ops->poll_batch(hctx, batch);
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_poll_batch);
>
> A new exported function without any documentation? Wow.

I just copied blk_mq_poll export...

> Please add a header
> above this function that documents at least which other completion processing
> code can execute concurrently with this function and from which contexts the
> other completion processing code can be called (e.g. blk_mq_poll() and
> .complete()).

I can do that, I'll document blk_mq_poll too..

> Why to return if (!q->mq_ops || !q->mq_ops->poll_batch)? Shouldn't that be a
> WARN_ON_ONCE() instead? I think it is an error to calling blk_mq_poll_batch()
> against a queue that does not define .poll_batch().

Not really, we don't know if the block driver actually supports 
poll_batch (or poll for that matter). Instead of conditioning in the
call-site, we condition within the call.

Its not really a bug, its harmless.

> Additionally, I think making the hardware context an argument of this function
> instead of using blk_mq_map_queue(q, smp_processor_id()) would make this
> function much more versatile.

What do you mean? remember that the callers interface to the device is
a request queue, it doesn't even know if its a blk-mq device. Can you
explain in more details what you would like to see?
