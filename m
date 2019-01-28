Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67429C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E84B2177E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E/bt46U5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbfA1V2t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:28:49 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:45665 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfA1V2t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:28:49 -0500
Received: by mail-io1-f42.google.com with SMTP id c2so14754399iom.12
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cwYQVb3fe+wDGaJ48PpHcqy9aXh9E9kwqLpCYWSUGj0=;
        b=E/bt46U5x7fwzDwYRNnrqQgNt/aE9IIPiB23fXS8DNSDcmzDZ/ia/G3nP24xRnIPTa
         LzYCwKHBhQOIha+bYWL0Bx742xP0ITHd2DaaMaZ/Z9wSjzf1RmbGxHEaKMoNSaIOE2Pq
         PIrhYVBAzNBKyY2SGHeawp3jQ3xdqKy8kEYvo6clyHmiKDaPNCLy/j9f4rCPXEGDV1ea
         pAmv4hXn8n0mRRS7QH1ZnZYzfY/dZZE3+4r8DxXwWSxvPEgkUaCUInUx/++eD3S82Eae
         xxCNmSCl/ZcB+dA5kP3+VxEaFt3U8tr3e5wyYNByVV2o6Vwk+8NAPaRUGbDyVA0aIIi6
         5H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cwYQVb3fe+wDGaJ48PpHcqy9aXh9E9kwqLpCYWSUGj0=;
        b=Qkcifxb++hS/HhpzajV0lCG6UNKwgvFTXZCtDkF4g53Hl64rcKCBGXYEdLH9FnvM3s
         aZJv6OMLTJGPzuwZH2b+qQF3r8h2foHiUxarmsFi0Vp2senHMBmmMsCLhfF5lpHELrEB
         T9f3ENqq5ak9oLYlByIyJTlb5HqQdx+B2+2LuIWYhX9FjLfeq/F6Vlqm1nS2K0k/tHsg
         w/Aj/dc2thKYG7OrcrGZAREDPYcXdXrCp26EjCHRXhKssXU9FzEGbt06VDbzQOFX5zZx
         QjIbo+rr4jjpuS7nHp7LZImMoTDjy+Tt9XM+ssNeRD+ZAYX/uPnt00sHVzyK1ZloMncN
         OpPQ==
X-Gm-Message-State: AJcUukdxaB2HH5Yrzq/uc0Fq9KWJkm7m0PJg4cI8+SbyR39TvvP/avsP
        LaKmdv2QpwAwU4h+lDC9tniAGfJJRV8=
X-Google-Smtp-Source: ALg8bN5CnAcmrQVWZOyV94auAXMoojyFs79spAD4T0xT/1yoIbHRwvrMO78/2mMfqLzGJMB0g9Gy4g==
X-Received: by 2002:a5e:924a:: with SMTP id z10mr14003559iop.301.1548710928146;
        Mon, 28 Jan 2019 13:28:48 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f21sm317140itc.14.2019.01.28.13.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:28:47 -0800 (PST)
Subject: Re: [PATCH 09/13] io_uring: add submission polling
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, avi@scylladb.com
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-12-axboe@kernel.dk>
 <x49r2cwwkno.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1fc20715-bdc6-6c36-7a53-58c91458db2b@kernel.dk>
Date:   Mon, 28 Jan 2019 14:28:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <x49r2cwwkno.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 2:13 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> @@ -1270,6 +1445,27 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
>>  	if (!ctx->sqo_files)
>>  		goto err;
>>  
>> +	if (ctx->flags & IORING_SETUP_SQPOLL) {
>> +		if (p->flags & IORING_SETUP_SQ_AFF) {
>> +			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
>> +							ctx, p->sq_thread_cpu,
>> +							"io_uring-sq");
> 
> sq_thread_cpu looks like another candidate for array_index_nospec.
> Following the macros, kthread_create_on_cpu calls cpu_to_node, which
> does:
>         return per_cpu(x86_cpu_to_node_map, cpu);
> 
> #define per_cpu(var, cpu)       (*per_cpu_ptr(&(var), cpu))
> #define per_cpu_ptr(ptr, cpu)                                           \
> ({                                                                      \
>         __verify_pcpu_ptr(ptr);                                         \
>         SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));                 \
> })
> #define per_cpu_offset(x) (__per_cpu_offset[x])
>                            ^^^^^^^^^^^^^^^^^^^
> 
> It also looks like there's no bounds checking there, so we probably want
> to make sure sq_thread_cpu can't overflow the __per_cpu_offset array
> (NR_CPUS).

Added, can't hurt in any case.

-- 
Jens Axboe

