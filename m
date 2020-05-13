Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3092C433DF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 15:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1E9207D8
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 15:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbgEMPDS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 11:03:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43868 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbgEMPDR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 11:03:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id y9so4335602plk.10
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 08:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DPfkQVkXzOoJxjROFEyzxUxoB4bbghpedxijTlkN54Y=;
        b=cNS+Kqz/cF6HsZgZ2s+1agH2UxbKG5HNCSsAFnZQ3+mLbYwqxEqI/2olC/Jn/s8xcX
         G8TxJggfLgyB6n+8ROoGaMmf8uSsZrjsNCh5eS/cRNQ5Xoyyk6usS0Q0laDHSzm/JTbO
         vPgQ6ptpq0PiKPV4OH6YCYxiL1U2D7Q88BTuoqc0TwZh8f2vphD3BR5oiqcEyREq+Tll
         6Gd4f+OqvQxyyhqtugPSqQjdX2Z2IBYn3L0uMPbawEn3ZYPxAwB9ELagEXY2EROKefdt
         7WqzRw/I151Esd5BiANKiRI6zLt38AG/6XpjyiYSo7dhM7FFtV4ZBbPNdfQJlfkMhbSh
         XRzg==
X-Gm-Message-State: AGi0PuYPBKcmDNzyRzOx+hNvLj5iw53WNBOKP8vJzPFrjQh4eFKgJ72+
        JTgY8pbxANVJ8hGixTYI3KU=
X-Google-Smtp-Source: APiQypLec/VbtfnGUp4GTn83ywpECbUUcdFrEX0R90+OyfCJpBO3ya7dd2NR1Zp5+r11edNv3QFL1Q==
X-Received: by 2002:a17:902:bd81:: with SMTP id q1mr25640814pls.46.1589382195696;
        Wed, 13 May 2020 08:03:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:e13e:45d5:70d9:c74e? ([2601:647:4000:d7:e13e:45d5:70d9:c74e])
        by smtp.gmail.com with ESMTPSA id d126sm15182250pfc.81.2020.05.13.08.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 08:03:14 -0700 (PDT)
Subject: Re: [PATCH V11 11/12] blk-mq: re-submit IO in case that hctx is
 inactive
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <20200513034803.1844579-12-ming.lei@redhat.com>
 <20200513122147.GF6297@lst.de>
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
Message-ID: <837d3c51-5a14-8c91-7e4a-9ef9b83359b9@acm.org>
Date:   Wed, 13 May 2020 08:03:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513122147.GF6297@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-13 05:21, Christoph Hellwig wrote:
> Use of the BLK_MQ_REQ_FORCE is pretty bogus here..
> 
>> +	if (rq->rq_flags & RQF_PREEMPT)
>> +		flags |= BLK_MQ_REQ_PREEMPT;
>> +	if (reserved)
>> +		flags |= BLK_MQ_REQ_RESERVED;
>> +	/*
>> +	 * Queue freezing might be in-progress, and wait freeze can't be
>> +	 * done now because we have request not completed yet, so mark this
>> +	 * allocation as BLK_MQ_REQ_FORCE for avoiding this allocation &
>> +	 * freeze hung forever.
>> +	 */
>> +	flags |= BLK_MQ_REQ_FORCE;
>> +
>> +	/* avoid allocation failure by clearing NOWAIT */
>> +	nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
>> +	if (!nrq)
>> +		return;
> 
> blk_get_request returns an ERR_PTR.
> 
> But I'd rather avoid the magic new BLK_MQ_REQ_FORCE hack when we can
> just open code it and document what is going on:
> 
> static struct blk_mq_tags *blk_mq_rq_tags(struct request *rq)
> {
> 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> 
> 	if (rq->q->elevator)
> 		return hctx->sched_tags;
> 	return hctx->tags;
> }
> 
> static void blk_mq_resubmit_rq(struct request *rq)
> {
> 	struct blk_mq_alloc_data alloc_data = {
> 		.cmd_flags	= rq->cmd_flags & ~REQ_NOWAIT;
> 	};
> 	struct request *nrq;
> 
> 	if (rq->rq_flags & RQF_PREEMPT)
> 		alloc_data.flags |= BLK_MQ_REQ_PREEMPT;
> 	if (blk_mq_tag_is_reserved(blk_mq_rq_tags(rq), rq->internal_tag))
> 		alloc_data.flags |= BLK_MQ_REQ_RESERVED;
> 
> 	/*
> 	 * We must still be able to finish a resubmission due to a hotplug
> 	 * even even if a queue freeze is in progress.
> 	 */
> 	percpu_ref_get(&q->q_usage_counter);
> 	nrq = blk_mq_get_request(rq->q, NULL, &alloc_data);
> 	blk_queue_exit(q);
> 
> 	if (!nrq)
> 		return; // XXX: warn?
> 	if (nrq->q->mq_ops->initialize_rq_fn)
> 		rq->mq_ops->initialize_rq_fn(nrq);
> 
> 	blk_rq_copy_request(nrq, rq);
> 	...

I don't like this because the above code allows allocation of requests
and tags while a request queue is frozen. I'm concerned that this will
break code that assumes that no tags are allocated while a request queue
is frozen. If a request queue has a single hardware queue with 64 tags,
if the above code allocates tag 40 and if blk_mq_tag_update_depth()
reduces the queue depth to 32, will nrq become a dangling pointer?

Thanks,

Bart.


