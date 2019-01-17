Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362B0C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 20:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004B52087E
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 20:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pxf6lzfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfAQUJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:09:10 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44305 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbfAQUJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 15:09:09 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so8825860iod.11
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 12:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bvxVNUAYWyLoUyeunpdxw6P0oEtJCoMzB0zB+HG7fAY=;
        b=pxf6lzfd87yR3ogkhI/R1LD6BBG9WkwYPO9N4xnD0+4NCAgI0xrr+v+0R8LOCpEwKO
         6TfvYDAlKffO5RgSUvCT82f0gc8H6aE1Tyex1RU1UZJ6pwTdRYumcmzDqHS/CKKNStfC
         XFz7fHbp3GmP3ZqOBv4oYWMTZ7ivnGgPoSZfYLwk7WagQr0k2xTOsACgw+XUtMBrdwBg
         wS+KSGFPPt9ULKg+DvjoqNTqIOnpZLRyOoTj6dQ3VYvE95Amv5WAPuJsWmX4HEOeK+bJ
         +DUrJz7ylDFyzwTsbnqXCnoj5Hmo753/Os2Gq8s4EvVV82gXFz7rvbKwGeXSlX68glgx
         tlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bvxVNUAYWyLoUyeunpdxw6P0oEtJCoMzB0zB+HG7fAY=;
        b=YfvAnhOG836hC3RPoSRD59UeI/QZ4L8NJ4qjcdKgHJHmZowXnDnHnN3LqGaNA6YXu4
         7E/K+j+Gls47xjb29X5JjcN5MA57ygXTsquVU4V6C9P1btexaIP7UJDaAKYZQPPrjof9
         Cia3or3vEgE8PCC6jveddjeR3wZBHVwd3feKeBdOcVba/TUjrvnQoUJxQbCPVmSKnzm0
         2PEVkZNagKAlkos1Qctx2k0MkUWPQ+cS/MkwRgEUwOle8CVYcV7FTGtdgMdxVnWXvB8o
         YAU/GF24s3oAEvMsqhGOkOZxgJdPhcSNGWFmRI6UQrXb7NNdGUNLbjlHgdGMoqSQnv2P
         3cBw==
X-Gm-Message-State: AJcUukcikyePRtdP5KLGXviUS8URZiSj/dJQRy7h4BEErFB3kleVf7AF
        /bpaYFfNmxnH3jcZ68TfORUKpg==
X-Google-Smtp-Source: ALg8bN57eBZD6lbL4f35ZAHXCME4dh8TMMf6EB/H3JpRiA+bpKqmGyaUBQDZnnl54n5Xu1gQeYqiPA==
X-Received: by 2002:a6b:ca04:: with SMTP id a4mr9190922iog.254.1547755748598;
        Thu, 17 Jan 2019 12:09:08 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i201sm953899ioa.1.2019.01.17.12.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 12:09:07 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
 <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
 <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
Date:   Thu, 17 Jan 2019 13:09:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 1:03 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 1/17/19 5:48 AM, Roman Penyaev wrote:
>>> On 2019-01-16 18:49, Jens Axboe wrote:
>>>
>>> [...]
>>>
>>>> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>>>> +				  struct io_uring_params *p)
>>>> +{
>>>> +	struct io_sq_ring *sq_ring;
>>>> +	struct io_cq_ring *cq_ring;
>>>> +	size_t size;
>>>> +	int ret;
>>>> +
>>>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
>>>
>>> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
>>> app consume a lot of kernel pages calling io_setup_uring() from a loop
>>> passing random entries number? (or even better: decreasing entries 
>>> number,
>>> in order to consume all pages orders with min number of loops).
>>
>> Yes, that's an oversight, we should have a limit in place. I'll add that.
> 
> Can we charge the ring memory to the RLIMIT_MEMLOCK as well?  I'd prefer
> not to repeat the mistake of fs.aio-max-nr.

Sure, we can do that. With the ring limited in size (it's now 4k entries
at most), the amount of memory gobbled up by that is much smaller than
the fixed buffers. A max sized ring is about 256k of memory.

-- 
Jens Axboe

