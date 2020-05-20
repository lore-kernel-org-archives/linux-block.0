Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87F9C433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 21:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB752072C
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 21:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgETVq4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 17:46:56 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:38986 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETVqz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 17:46:55 -0400
Received: by mail-pl1-f180.google.com with SMTP id x18so802623pll.6
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 14:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aiIypwwVH1S1MilSBcYghq/dIeIEj/J7zHQVTDXZLP8=;
        b=NX+NNuTWhbUceupRT2N3RSKYjwvxZ//WcRQqA5EFkyWnYc1jFtAQZ2hnBOKVRbEIOE
         f1Z6kfsxtbTpJasbAttp6Ydf1ZcIfdJKJMSZKj2FTeOKt+gPH79HiZuiboNrKNDLVHuB
         ayTWI44STQCmYb8rx0irpgiss63bzqCChZIc7QxdAjd63Zz/aQpS1HXQq0LViB73em05
         VjJVjkh/zs8LNlBvT7ZYTCmV7Y0domLPEZywVgaimI8t7Lyu6Bjv1Wy23GMGpC9xzthW
         uejqyqs2MRGhE95RUUDEwKHe8wUStIcwhQCc0/I19TJSzqb4j+CJOSkr/oJ8T2R59jJD
         ysKA==
X-Gm-Message-State: AOAM531vf76zV1pSr4S6Wz2wZRBQZ2IdLcVQi03JmaWFi5K9+lM47HNf
        z5+rPPN/lvcxd+QFAtNVvCo=
X-Google-Smtp-Source: ABdhPJyQPZrl3RxUywYbu3HJgNAu1Y80oqjsoUt3CW0AZwAUlmoyccFpdTsK3ke/lOw/swQz5QpuNw==
X-Received: by 2002:a17:902:d208:: with SMTP id t8mr6665336ply.324.1590011214483;
        Wed, 20 May 2020 14:46:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c031:e55:f9a8:4282? ([2601:647:4000:d7:c031:e55:f9a8:4282])
        by smtp.gmail.com with ESMTPSA id d4sm2472679pgk.2.2020.05.20.14.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 14:46:53 -0700 (PDT)
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200520170635.2094101-1-hch@lst.de>
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
Message-ID: <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org>
Date:   Wed, 20 May 2020 14:46:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520170635.2094101-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-20 10:06, Christoph Hellwig wrote:
> this series ensures I/O is quiesced before a cpu and thus the managed
> interrupt handler is shut down.
> 
> This patchset tries to address the issue by the following approach:
> 
>  - before the last cpu in hctx->cpumask is going to offline, mark this
>    hctx as inactive
> 
>  - disable preempt during allocating tag for request, and after tag is
>    allocated, check if this hctx is inactive. If yes, give up the
>    allocation and try remote allocation from online CPUs
> 
>  - before hctx becomes inactive, drain all allocated requests on this
>    hctx

What is not clear to me is which assumptions about the relationship
between interrupts and hardware queues this patch series is based on.
Does this patch series perhaps only support a 1:1 mapping between
interrupts and hardware queues? What if there are more hardware queues
than interrupts? An example of a block driver that allocates multiple
hardware queues is the NVMeOF initiator driver. From the NVMeOF
initiator driver function nvme_rdma_alloc_tagset() and for the code that
refers to I/O queues:

	set->nr_hw_queues = nctrl->queue_count - 1;

From nvme_rdma_alloc_io_queues():

	nr_read_queues = min_t(unsigned int, ibdev->num_comp_vectors,
				min(opts->nr_io_queues,
				    num_online_cpus()));
	nr_default_queues =  min_t(unsigned int,
	 			ibdev->num_comp_vectors,
				min(opts->nr_write_queues,
					 num_online_cpus()));
	nr_poll_queues = min(opts->nr_poll_queues, num_online_cpus());
	nr_io_queues = nr_read_queues + nr_default_queues +
			 nr_poll_queues;
	[ ... ]
	ctrl->ctrl.queue_count = nr_io_queues + 1;

From nvmf_parse_options():

	/* Set defaults */
	opts->nr_io_queues = num_online_cpus();

Can this e.g. result in 16 hardware queues being allocated for I/O even
if the underlying RDMA adapter only supports four interrupt vectors?
Does that mean that four hardware queues will be associated with each
interrupt vector? If the CPU to which one of these interrupt vectors has
been assigned is hotplugged, does that mean that four hardware queues
have to be quiesced instead of only one as is done in patch 6/6?

Thanks,

Bart.
