Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0047C28CBC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 14:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FB721655
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 14:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgEIOH7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 May 2020 10:07:59 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40791 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgEIOH7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 May 2020 10:07:59 -0400
Received: by mail-pj1-f65.google.com with SMTP id fu13so5544569pjb.5
        for <linux-block@vger.kernel.org>; Sat, 09 May 2020 07:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9QT7xe/DnS4GPTWjS/toteF0CI3JaIr6WJUOKdZe0qE=;
        b=Vh2WM+KrLjx+JJuGQTITlITUjgq5wLrezKusCudNt+W4LV42WR9RvPLrxVN+qbAMqd
         mRRhRGqboZE9S782SrqC4rwAyOmVLpu0r7wjruVM6lAiKuCWz1SYetHWdSTocnZZsXmm
         /NCivjv9stqjKUdx1b5u/AOMAmXsarsT3x6SrbMj+dqUGHHA3zrTj911hhGD2WxaGMF9
         rVGGLffM84qSig+z94sSP8u0fsngIIO+dq4RV6SYKzU6RnxdreTnrJBPmez8oHMSx7mg
         aa4crPutAj/Cg5IWnBhMlmMHfSSiRad+4KG4m09zowV/Xuuf/jAIzwzbutwABALTHnnl
         OnHw==
X-Gm-Message-State: AGi0PuZ4c+fa0qWh0WWhd3wMKmyu/o+2yqFGJEDHNsAyQdQPuTq6XleM
        nHmiSIMZOx43RYu13eLVO1k=
X-Google-Smtp-Source: APiQypKv9D+/H4KeRckdcYgUDPG17eQXTWC8jx7OWUz19s0HOAuDmCviaWA1RutZxx7EG1n/pKL06g==
X-Received: by 2002:a17:90a:8d12:: with SMTP id c18mr11493692pjo.144.1589033278104;
        Sat, 09 May 2020 07:07:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8ef:746a:4fe7:1df? ([2601:647:4000:d7:8ef:746a:4fe7:1df])
        by smtp.gmail.com with ESMTPSA id j14sm5054162pjm.27.2020.05.09.07.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 07:07:57 -0700 (PDT)
Subject: Re: [PATCH V10 11/11] block: deactivate hctx when the hctx is
 actually inactive
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hannes Reinecke <hare@suse.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-12-ming.lei@redhat.com>
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
Message-ID: <954b942e-3b06-4be7-9f2f-23f87ff514f0@acm.org>
Date:   Sat, 9 May 2020 07:07:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505020930.1146281-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-04 19:09, Ming Lei wrote:
> @@ -1373,28 +1375,16 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>  	int srcu_idx;
>  
[ ... ]
>  	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> -		cpu_online(hctx->next_cpu)) {
> -		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
> -			raw_smp_processor_id(),
> -			cpumask_empty(hctx->cpumask) ? "inactive": "active");
> -		dump_stack();
> +	    cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) >=
> +	    nr_cpu_ids) {
> +		blk_mq_hctx_deactivate(hctx);
> +		return;
>  	}

The blk_mq_hctx_deactivate() function calls blk_mq_resubmit_rq()
indirectly. From blk_mq_resubmit_rq():

+  /* avoid allocation failure by clearing NOWAIT */
+  nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);

blk_get_request() calls blk_mq_alloc_request(). blk_mq_alloc_request()
calls blk_queue_enter(). blk_queue_enter() waits until a queue is
unfrozen if freezing of a queue has started. As one can see freezing a
queue triggers a queue run:

void blk_freeze_queue_start(struct request_queue *q)
{
	mutex_lock(&q->mq_freeze_lock);
	if (++q->mq_freeze_depth == 1) {
		percpu_ref_kill(&q->q_usage_counter);
		mutex_unlock(&q->mq_freeze_lock);
		if (queue_is_mq(q))
			blk_mq_run_hw_queues(q, false);
	} else {
		mutex_unlock(&q->mq_freeze_lock);
	}
}

Does this mean that if queue freezing happens after hot unplugging
started that a deadlock will occur because the blk_mq_run_hw_queues()
call in blk_freeze_queue_start() will wait forever?

Bart.
