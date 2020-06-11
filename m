Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C0C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 13:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CEA207ED
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 13:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFKNlw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:41:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36355 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgFKNlv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 09:41:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id t7so2556509pgt.3
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 06:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tjbffnqHX7OFxGRB4YdnLNXK/ChZef3Fq50KoV+F2OM=;
        b=NssyAdwpZ6hxtRb41CFMw90ezCJ/Vd1yayHhFj0svt0LAJOMLFN8DzGeoD2Cm0rzm8
         vZ3eSQ6GnFan9iO+JWtSNxGJxiICMBD0G7WFCPd+DfSDG7z8jNrdY7ZV7UaQhmePw8WN
         fyreHTR85gPHhfDULxsduFer3+q8LcajjFQ404BnNX9GjTfDBs0zbmvIIDdUVKX8Iy5i
         SDmUxvhDYxNsePFmohcLzcSdafb+JkhZr9Zyzo8auz2A30rD0PqQhBlH1XT9f0Ix7Nag
         HHcUeFBz3kWU8ymekBB/bBcQVgt3m/vKJzGPnOFDS0ZM1/5tMX1Cr5TNIxT5EyINummh
         Kvyg==
X-Gm-Message-State: AOAM532tDyVzWwX/gCU/DPFtz9mmHwZaJvGOx0jcELheAuT34Yvw+bze
        sWuofxonDLKUt+uYOxUFwyQ=
X-Google-Smtp-Source: ABdhPJyk339OhXjzzYdyXTN/DbSlmE8JRpEwI/wksEZvtZTEvVL00c7+c3LjKjQU1n+czIGpRbcr9g==
X-Received: by 2002:a65:4807:: with SMTP id h7mr7034357pgs.123.1591882910706;
        Thu, 11 Jun 2020 06:41:50 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id c1sm3336507pfo.197.2020.06.11.06.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 06:41:49 -0700 (PDT)
Subject: Re: [PATCH v2] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-block@vger.kernel.org
Cc:     Chaitanya.Kulkarni@wdc.com
References: <20200611013326.218542-1-harshadshirwadkar@gmail.com>
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
Message-ID: <8c37b659-30bd-8308-8697-27868b2a4ac0@acm.org>
Date:   Thu, 11 Jun 2020 06:41:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200611013326.218542-1-harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-06-10 18:33, Harshad Shirwadkar wrote:
> +static struct queue_sysfs_entry queue_blktrace_max_alloc_entry = {
> +	.attr = {.name = "blktrace_max_alloc", .mode = 0644 },
> +	.show = queue_blktrace_max_alloc_show,
> +	.store = queue_blktrace_max_alloc_store,
> +};

I may have sent you in the wrong direction with my comment about
introducing sysfs attributes to control the blktrace_max_alloc limit.
That comment was made before I fully understood the issue this patch
addresses. There is a concern with introducing any limit for the amount
of memory allocated for blktrace, namely that any such limit may be seen
as a regression in the behavior of the BLKTRACESETUP ioctl. How about
not limiting the memory allocated for blktrace buffers at all?

If triggering an out-of-memory complaint is a big concern, how about
modifying relay_open() such that it becomes possible to pass a flag like
__GFP_ACCOUNT to the memory allocations relay_open() performs? From
memory-allocations.rst:

  * Untrusted allocations triggered from userspace should be a subject
    of kmem accounting and must have ``__GFP_ACCOUNT`` bit set. There
    is the handy ``GFP_KERNEL_ACCOUNT`` shortcut for ``GFP_KERNEL``
    allocations that should be accounted.

> @@ -322,6 +326,7 @@ struct queue_limits {
>  	unsigned long		bounce_pfn;
>  	unsigned long		seg_boundary_mask;
>  	unsigned long		virt_boundary_mask;
> +	unsigned long		blktrace_max_alloc;
>  
>  	unsigned int		max_hw_sectors;
>  	unsigned int		max_dev_sectors;

Is this the wrong structure to add a limit like blktrace_max_alloc? As
far as I can see struct queue_limits is only used for limits that are
affected by stacking block devices. My understanding is that the
blktrace_max_alloc limit is not affected by device stacking. See also
blk_stack_limits().

> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index ea47f2084087..de028bdbb148 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -477,11 +477,19 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  {
>  	struct blk_trace *bt = NULL;
>  	struct dentry *dir = NULL;
> +	u32 alloc_siz;
>  	int ret;
>  
>  	if (!buts->buf_size || !buts->buf_nr)
>  		return -EINVAL;
>  
> +	if (check_mul_overflow(buts->buf_size, buts->buf_nr, &alloc_siz))
> +		return -E2BIG;
> +
> +	if (q->limits.blktrace_max_alloc &&
> +	    alloc_siz > q->limits.blktrace_max_alloc)
> +		return -E2BIG;
> +
>  	if (!blk_debugfs_root)
>  		return -ENOENT;

Please add the check_mul_overflow() check in the code that performs the
multiplication, namely relay_open(), such that all relay_open() callers
are protected against multiplication overflows.

Thanks,

Bart.
