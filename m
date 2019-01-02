Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC0AC43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 16:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A977A21871
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 16:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fNTqJ8Z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfABQ20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:28:26 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43757 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfABQ20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 11:28:26 -0500
Received: by mail-io1-f68.google.com with SMTP id b23so3978695ios.10
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 08:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3vUH8iEtfO0FVc1MuAmVN5Cr/ySbNMGFIjuBn7JkDMM=;
        b=fNTqJ8Z1KA/Tc1AlO4a+nvFm5f1W5mw3wVFIH1z5BRhw+sUJ+GsJMp0gK8opaywG9J
         E4RqGmp5NRTTML3HwfAD6vcf3igptvH7A7k9+QG8uz93j6i/WeDFPoKKBfZsKLc+2RbX
         +CKG6NvEqsnA0bTxFLiikNMVHHPYTPVbjJgJl1mQDm44lGp/pOvHKGGMxDNEFHMUOYV6
         0gsMapw6WSBs5T7qcuU0sksRlcV1hFot2VfUVXGNCDqkbwKkP7Fo2bgX+6+kD5vL1BGY
         zVe5To6nICXVRgAmtPHy9gyzri3M3AqILhLZCOXyoQSyhg4UJ6i797eVwdyDdFtWlyJY
         ikHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3vUH8iEtfO0FVc1MuAmVN5Cr/ySbNMGFIjuBn7JkDMM=;
        b=NVwIh4sRh7Vy4TqvkPFCsDWctwelThdSAzTy5wBqWNQW6VhLW/Y71G0va9OXKaMRZF
         10UNEFXc3zVITWGX6/oS9jvKolv3k7996wKA8DjMvOzoMbguERCgDtqybRw2whK+M47L
         AY1HomXLQFDDQUx+2IEsNblS68elBxgLirLzMvIE+YC5mAYGrrUPb3YSjBGewLcLUS7m
         vdtEGo7ga0jrfY/pgw6q56J8ZqIkgwbL78y4pnzAbaGtNGpOtgpazAZNCUxF5SfhL/zz
         crEVINa0rlBvoBganttA/avR1lor1TM9jObFKSnVnXPrX1d98vP2zmAF1EGiQj2H2Sbb
         6Xhg==
X-Gm-Message-State: AJcUukeH22ZUaTrVqWkUGHkeADjnaJGXdj9kdoitM618+ytFkwPoC4k5
        uHymoi5gsdUMn0lSU+Sh+pPPFg==
X-Google-Smtp-Source: ALg8bN6ipQidjwscyO7oOfp9i/WVhBnfRJI7cErQVpw07b7UOFSJmTdJBHcnpwtu6PVGYsCyTLIQSQ==
X-Received: by 2002:a6b:91d4:: with SMTP id t203mr31635024iod.267.1546446505340;
        Wed, 02 Jan 2019 08:28:25 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y21sm24366895iof.51.2019.01.02.08.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 08:28:24 -0800 (PST)
Subject: Re: [PATCH 16/22] aio: add support for submission/completion rings
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-17-axboe@kernel.dk>
 <20181227134737.GA24160@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <91c8d717-37ab-9696-ff41-700f339a1960@kernel.dk>
Date:   Wed, 2 Jan 2019 09:28:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181227134737.GA24160@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/27/18 6:47 AM, Christoph Hellwig wrote:
> On Fri, Dec 21, 2018 at 12:22:30PM -0700, Jens Axboe wrote:
>> The submission queue (SQ) and completion queue (CQ) rings are shared
>> between the application and the kernel. This eliminates the need to
>> copy data back and forth to submit and complete IO. We use the same
>> structures as the old aio interface. The SQ rings are indexes into a
>> struct iocb array, like we would submit through io_submit(), and the
>> CQ rings are struct io_event, like we would pass in (and copy back)
>> from io_getevents().
>>
>> A new system call is added for this, io_ring_enter(). This system call
>> submits IO that is stored in the SQ ring, and/or completes IO and stores
>> the results in the CQ ring. Hence it's possible to both complete and
>> submit IO in a single system call.
> 
> So this still reuses the aio interface, but I think that is a really
> bad idea.  For one the aio_context_t which really is a chunk of memory
> mapped into the user address space really make no sense at all here.

I don't think that's a big deal at all, the new ring interface just ends
up being a subset of it. We don't map the old user ring, for instance.

> We'd much rather allocate a file descriptor using anon_inode_getfd
> and operate on that.  That also means we can just close that fd
> instead of needing the magic io_destroy, and save all the checks for
> which kind of FD we operate on.

I'm not against doing something else for setup, but we still need some
way of passing in information about what we want. Things like ring
sizing. The actual rings we could mmap from known offsets if we went the
anon route. 

> The big question to me is if we really need the polled version of
> 'classic aio'.  If not we could save io_setup2 and would just need
> io_ring_setup and io_ring_enter as the new syscalls, and basically
> avoid touching the old aio code entirely.

Don't feel strongly about that part. I do like to continue using the aio
infrastructure instead of rewriting everything. And that means that
regular aio gets polling for free, essentially. So seems kind of silly
NOT to offer it as an option.

> Also as another potential interface enhancement I think we should
> consider pre-registering the files we want to do I/O to in the
> io_ring_setup system call, thus avoiding fget/fput entirely
> in io_ring_enter.  In general the set of files used for aio-like
> operations is rather static and should be known at setup time,
> in the worst case we might have to have a version of the setup
> call that can modify the set up files (similar to how say
> epoll works).

I agree, that would be a nice improvement to not have to get/put files
all the time.

> Also this whole API needs a better description, and a CC to the
> linux-api list.

Yep

>> +static void aio_commit_cqring(struct kioctx *ctx, unsigned next_tail)
>> +{
>> +	struct aio_cq_ring *ring = page_address(ctx->cq_ring.pages[0]);
> 
> I don't think we can use page_address here as the memory might be
> highmem.  Same for all the other uses of page_address.

Made changes to support that.

>> +	range->pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
> 
> This should use kcalloc.  Same for a few other instances.

Done

>> +static int __io_ring_enter(struct kioctx *ctx, unsigned int to_submit,
>> +			   unsigned int min_complete, unsigned int flags)
>> +{
>> +	int ret = 0;
>> +
>> +	if (flags & IORING_FLAG_SUBMIT) {
>> +		ret = aio_ring_submit(ctx, to_submit);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
> 
> I don't think we need the IORING_FLAG_SUBMIT flag - a non-zero
> to_submit argument should be a good enough indicator.

Made that change.

> Also this interface will need some cache flushing help, othewise
> it won't work at all for architectures with VIVT caches.

Fixed this up too.

-- 
Jens Axboe

