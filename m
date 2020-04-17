Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61C5C38A2B
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 14:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C08920857
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 14:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDQO0Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:26:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36481 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgDQO0X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 10:26:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2so1027930plo.3;
        Fri, 17 Apr 2020 07:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j1VzqJjAD8ib6piUd8Mj5xPhAMzaoVEfMnezftKictg=;
        b=uEEUWIs+pwniPf9e0q2b4wSVigR2g2vZpPqulaOIiibn7dp2zEVIkaNdzxhqj71M4M
         a49kH8TC3W2IDzOgPyrVsGNQyEiQVwlrSjTtAA5uYIM0t+hsJCqdlXJr09BjMOS0lCxQ
         aSNtjPmUdDvKdg2dPEPPPPgWH+Cfs2nVcAGG+eFtQAAo09adTU/Zxom76QPx2Pc8wxOT
         /ZEB5F/dlxUSLBQQRIhmWxTH7Sre6QvB1FyRUZthzUdM3YeSp7dPVJaZcUDuube6BmXL
         fNl0kN5zvAq9zAZXXLAJBzFeAxnEGwn1LOaI1L+ULDpJqFpTMIWDc1M2BqqgwpzpmnGY
         buKw==
X-Gm-Message-State: AGi0PuZSXsTUTP+q71y+ybmL+Zn+sjH9X43zOiQlsxsOB3lX1zyRCnFQ
        JCj9rtZYFs8txxrGxT7/SHvxc2ja68I=
X-Google-Smtp-Source: APiQypJujqyE7XAHRsm/wgNCaK7jUA8TZP08MjLKRGOCBHKzUefM/s2/UZOZ71l9wI+3wTnjEPrMOw==
X-Received: by 2002:a17:902:b909:: with SMTP id bf9mr3827927plb.322.1587133581871;
        Fri, 17 Apr 2020 07:26:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:54eb:5dc7:79c2:2fa2? ([2601:647:4000:d7:54eb:5dc7:79c2:2fa2])
        by smtp.gmail.com with ESMTPSA id 1sm5837009pjc.32.2020.04.17.07.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 07:26:21 -0700 (PDT)
Subject: Re: [RFC] block: fix access of uninitialized pointer address in
 bt_for_each()
To:     yu kuai <yukuai3@huawei.com>, axboe@kernel.dk, ming.lei@redhat.com
Cc:     yi.zhang@huawei.com, yuyufen@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200417125134.45117-1-yukuai3@huawei.com>
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
Message-ID: <340bed9b-e14d-5a22-1601-8fb7aad4ce7f@acm.org>
Date:   Fri, 17 Apr 2020 07:26:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417125134.45117-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-17 05:51, yu kuai wrote:
> I recently got a KASAN warning like this in our 4.19 kernel:
> 
>  ==================================================================
>  BUG: KASAN: slab-out-of-bounds in bt_for_each+0x1dc/0x2c0
>  Read of size 8 at addr ffff8000c0865000 by task sh/2023305
> 
>  Call trace:
>  dump_backtrace+0x0/0x310
>  show_stack+0x28/0x38
>  dump_stack+0xd8/0x108
>  print_address_description+0x68/0x2d0
>  kasan_report+0x124/0x2e0
>  __asan_load8+0x88/0xb0
>  bt_for_each+0x1dc/0x2c0
>  blk_mq_queue_tag_busy_iter+0x1f0/0x3e8
>  blk_mq_in_flight+0xb4/0xe0
>  part_in_flight+0x124/0x178
>  part_round_stats+0x128/0x3b0
>  blk_account_io_start+0x2b4/0x3f0
>  blk_mq_bio_to_request+0x170/0x258
>  blk_mq_make_request+0x734/0xdd8
>  generic_make_request+0x388/0x740
>  submit_bio+0xd8/0x3d0
>  ext4_io_submit+0xb4/0xe0 [ext4]
>  ext4_writepages+0xb44/0x1c00 [ext4]
>  do_writepages+0xc8/0x1f8
>  __filemap_fdatawrite_range+0x200/0x2a0
>  filemap_flush+0x30/0x40
>  ext4_alloc_da_blocks+0x54/0x200 [ext4]
>  ext4_release_file+0xfc/0x150 [ext4]
>  __fput+0x15c/0x3a8
>  ____fput+0x24/0x30
>  task_work_run+0x1a4/0x208
>  do_notify_resume+0x1a8/0x1c0
>  work_pending+0x8/0x10
> 
>  Allocated by task 3515778:
>  kasan_kmalloc+0xe0/0x190
>  kmem_cache_alloc_trace+0x18c/0x418
>  alloc_pipe_info+0x74/0x240
>  create_pipe_files+0x74/0x2f8
>  __do_pipe_flags+0x48/0x168
>  do_pipe2+0xa0/0x1d0
>  __arm64_sys_pipe2+0x3c/0x50
>  el0_svc_common+0xb4/0x1d8
>  el0_svc_handler+0x50/0xa8
>  el0_svc+0x8/0xc
> 
>  Freed by task 3515778:
>  __kasan_slab_free+0x120/0x228
>  kasan_slab_free+0x10/0x18
>  kfree+0x88/0x3d8
>  free_pipe_info+0x150/0x178
>  put_pipe_info+0x138/0x1c0
>  pipe_release+0xe8/0x120
>  __fput+0x15c/0x3a8
>  ____fput+0x24/0x30
>  task_work_run+0x1a4/0x208
>  do_notify_resume+0x1a8/0x1c0
>  work_pending+0x8/0x10

The alloc/free info refers to a data structure owned by the pipe
implementation. The use-after-free report refers to a data structure
owned by the block layer. How can that report make sense?

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7ed16ed13976..48b74d0085c7 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -485,6 +485,7 @@ static void __blk_mq_free_request(struct request *rq)
>  	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
>  	const int sched_tag = rq->internal_tag;
>  
> +	hctx->tags->rqs[rq->tag] = NULL;
>  	if (rq->tag != -1)
>  		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
>  	if (sched_tag != -1)

Can the above change trigger the following assignment?

hctx->tags->rqs[-1] = NULL?

> @@ -1999,7 +2000,7 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
>  	if (!tags)
>  		return NULL;
>  
> -	tags->rqs = kcalloc_node(nr_tags, sizeof(struct request *),
> +	tags->rqs = kzalloc_node(nr_tags, sizeof(struct request *),
>  				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
>  				 node);

From include/linux/slab.h:

static inline void *kcalloc_node(size_t n, size_t size, gfp_t flags,
                                 int node)
{
	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
}

I think this means that kcalloc_node() already zeroes the allocated
memory and hence that changing kcalloc() into kzalloc() is not necessary.

>  	if (!tags->rqs) {
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index a6094c27b827..2a55292d3d51 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -196,6 +196,7 @@ static inline void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
>  	if (rq->tag == -1 || rq->internal_tag == -1)
>  		return;
>  
> +	hctx->tags->rqs[rq->tag] = NULL;
>  	__blk_mq_put_driver_tag(hctx, rq);
>  }
>  
> @@ -207,6 +208,7 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
>  		return;
>  
>  	hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu);
> +	hctx->tags->rqs[rq->tag] = NULL;
>  	__blk_mq_put_driver_tag(hctx, rq);
>  }

I don't think the above changes are sufficient to fix the
use-after-free. Has it been considered to free the memory that backs
tags->bitmap_tags only after an RCU grace period has expired? See also
blk_mq_free_tags().

Thanks,

Bart.
