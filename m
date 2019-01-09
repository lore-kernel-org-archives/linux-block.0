Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CA0C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A002070B
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vsoMBnED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbfAIPxg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:53:36 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34226 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbfAIPxg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 10:53:36 -0500
Received: by mail-io1-f67.google.com with SMTP id b16so6406331ior.1
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 07:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o7rlVV5Zgk+g7ERMS3GwX38vmM0tL+y9ABRqfEc219M=;
        b=vsoMBnEDLiVYKM4d4ljOk0aOGnMBXZc4zZ/tRvgpKBnIFe8turlFFRnhzP4m8SRYUU
         P1L9aAbesDKD6ycld7QmrleCfUc676QTOrbTL1RRW908xWuIB/eYzG6IJRoNzGYVq2qs
         bW57h7+nMJDFZgpnlEhnVFDzJ1TgJUoLsLclB/HKjy90mX7NJ9A6xTon2WcVCA1DW9Q/
         IKJwNZ2rouyi0s+xn9YCJ5aLo+0hyWa6NM7DW2h4paWLAVRtq46SexsjisdrVCT5/nuC
         vVmtmdB/b/1+fHX+2Kzsa+/vTKGbgX+fp0jWdRkfVDr7GIpmStgbrCHvYur2BQW4YFaS
         R6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o7rlVV5Zgk+g7ERMS3GwX38vmM0tL+y9ABRqfEc219M=;
        b=UoSCdGbPn+YA64ly3MT8xQMh7MKJH5KOdNDdBkznuB6QHFQuIKW61PxxDLLLnEmRy7
         btfQVwRENNo2dMcMSB4iWZPqX7ZFDk+2cWWW7rAgpPchp5jO9RzBIDi5qOAZHU8FcG0p
         Dkv8YILPuAq6BbpE5IAOu08ITAm4+V0lwU3gAzpZZoFCq5EUsqzMV3cz7znRkESROWV0
         yVYU2fj/6tEGCSrcIL9a1ouUnVw0BgQ/GCK1WnFIU3NOobGwTcfoNn5yyEXtxO/wIBJm
         YpmVIjC0hgTIwqMai3WMSnhgqHrjwIEh/mVzlZvekbLGFXCi49Pz/B19eS+46R/nWowp
         yxJQ==
X-Gm-Message-State: AJcUukfVnmQyGGl2lnf4bzeaeLX/4U83TR+8UrW0JjryufcmYRukOCzx
        1OpJLn4ngh2S9xlP2oPJygeu9A==
X-Google-Smtp-Source: ALg8bN4a80TCuV66VTeDQuthr7cXB1eJ3GnrM8X4Xhk0vQdUSPB4XM0zwWdoqsztEO+2sIjfoisvYQ==
X-Received: by 2002:a5e:c303:: with SMTP id a3mr4031067iok.53.1547049214958;
        Wed, 09 Jan 2019 07:53:34 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b188sm7846655itc.9.2019.01.09.07.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:53:33 -0800 (PST)
Subject: Re: [PATCH 05/16] Add io_uring IO interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-6-axboe@kernel.dk> <20190109121030.GA13779@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1576557b-a65f-86eb-5fcc-00f332ec2dd5@kernel.dk>
Date:   Wed, 9 Jan 2019 08:53:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109121030.GA13779@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/19 5:10 AM, Christoph Hellwig wrote:
>> index 293733f61594..9ef9987b4192 100644
>> --- a/fs/Makefile
>> +++ b/fs/Makefile
>> @@ -29,7 +29,7 @@ obj-$(CONFIG_SIGNALFD)		+= signalfd.o
>>  obj-$(CONFIG_TIMERFD)		+= timerfd.o
>>  obj-$(CONFIG_EVENTFD)		+= eventfd.o
>>  obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
>> -obj-$(CONFIG_AIO)               += aio.o
>> +obj-$(CONFIG_AIO)               += aio.o io_uring.o
> 
> It is probablt worth adding a new config symbol for the uring as no
> code is shared with aio.

Agreed, done.

>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> new file mode 100644
>> index 000000000000..ae2b886282bb
>> --- /dev/null
>> +++ b/fs/io_uring.c
>> @@ -0,0 +1,849 @@
>> +/*
>> + * Shared application/kernel submission and completion ring pairs, for
>> + * supporting fast/efficient IO.
>> + *
>> + * Copyright (C) 2019 Jens Axboe
>> + */
> 
> Add an SPDX header to all new files, please.

Done

>> +struct io_sq_ring {
>> +	struct io_uring		r;
>> +	u32			ring_mask;
>> +	u32			ring_entries;
>> +	u32			dropped;
>> +	u32			flags;
>> +	u32			array[0];
>> +};
> 
> field[0] is a legacy gcc extension, the proper C99+ way is field[].

Fixed

>> +struct io_iocb_ring {
>> +	struct			io_sq_ring *ring;
>> +	unsigned		entries;
>> +	unsigned		ring_mask;
>> +	struct io_uring_iocb	*iocbs;
>> +};
>> +
>> +struct io_event_ring {
>> +	struct io_cq_ring	*ring;
>> +	unsigned		entries;
>> +	unsigned		ring_mask;
>> +};
> 
> Btw, do we really need there structures?  It would seem simpler
> to just embedd them into the containing structure as:
> 
> 	struct io_sq_ring	*sq_ring;
> 	unsigned		sq_ring_entries;
> 	unsigned		sq_ring_mask;
> 	struct io_uring_iocb	*sq_ring_iocbs;
> 
> 	struct io_cq_ring	*cq_ring;
> 	unsigned		cq_ring_entries;
> 	unsigned		cq_ring_mask;

Yeah, I guess we use it directly in so few places that we may as well
just get rid of the structs for these.

> 	
> 
>> +struct io_ring_ctx {
>> +	struct percpu_ref	refs;
>> +
>> +	unsigned int		flags;
>> +	unsigned int		max_reqs;
> 
> max_reqs can probably go away in favour of the sq ring nr_entries
> field.

Indeed, killed.

>> +	struct io_iocb_ring	sq_ring;
>> +	struct io_event_ring	cq_ring;
>> +
>> +	struct work_struct	work;
>> +
>> +	struct {
>> +		struct mutex uring_lock;
>> +	} ____cacheline_aligned_in_smp;
>> +
>> +	struct {
>> +		struct mutex    ring_lock;
>> +		wait_queue_head_t wait;
>> +	} ____cacheline_aligned_in_smp;
>> +
>> +	struct {
>> +		spinlock_t      completion_lock;
>> +	} ____cacheline_aligned_in_smp;
>> +};
> 
> Can you take a deep look if we need to keep all of ring_lock,
> completion_lock and the later added poll locking?  From a quick look
> is isn't entirely clear what the locking strategy on the completion
> side is.  It needs to be documented and can hopefully be simplified.

I think we just need to kill ring_lock, it's actually not even used.
I'll take a closer look at the locking as well.

> 
>> +struct fsync_iocb {
>> +	struct work_struct	work;
>> +	struct file		*file;
>> +	bool			datasync;
>> +};
> 
> Do we actually need this?  Can't we just reuse the later thread
> offload for fsync?  Maybe just add fsync support once everything else
> is done to make that simpler.

We can just use the sq thread, but we don't always have that backing. I
guess we could create it lazily if an fsync comes in. I'll take a look
at adding that as a separate thing.

>> +static const struct file_operations io_scqring_fops;
>> +
>> +static void io_ring_ctx_free(struct work_struct *work);
>> +static void io_ring_ctx_ref_free(struct percpu_ref *ref);
> 
> Can you try to avoid to need the forward delcaration?  (except for the
> fops, where we probably need it).

I got rid of one of them in my current tree already, I'll see if I can
dump the other one.

>> +static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>> +{
>> +	struct io_ring_ctx *ctx;
>> +
>> +	ctx = kmem_cache_zalloc(ioctx_cachep, GFP_KERNEL);
>> +	if (!ctx)
>> +		return NULL;
> 
> Do we really need an explicit slab for the contexts?

Not sure, guess it depends on the frequency of them. But I suspect that
it won't matter one bit, I'll kill this slab.

> 
>> +static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
> 
> Maybe replace the req name with something matching the structure
> name?  (and more on the structure name later).

Make sense.

>> +{
>> +	struct io_kiocb *req;
>> +
>> +	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
>> +	if (!req)
>> +		return NULL;
>> +
>> +	percpu_ref_get(&ctx->refs);
>> +	req->ki_ctx = ctx;
>> +	INIT_LIST_HEAD(&req->ki_list);
> 
> We never do a list_empty ceck on ki_list, so there should be no need
> to initialize it.

Killed

>> +static void io_fill_event(struct io_uring_event *ev, struct io_kiocb *kiocb,
>> +			  long res, unsigned flags)
>> +{
>> +	ev->index = kiocb->ki_index;
>> +	ev->res = res;
>> +	ev->flags = flags;
>> +}
> 
> Probably no need for this helper.

Killed. Also realized that we're missing a store ordering barrier after
filling in 'ev', but before incrementing the ring.

>> +static void io_complete_scqring(struct io_kiocb *iocb, long res, unsigned flags)
>> +{
>> +	io_cqring_fill_event(iocb, res, flags);
>> +	io_complete_iocb(iocb->ki_ctx, iocb);
>> +}
> 
> Probably no need for this helper either.

Killed

> 
>> +	ret = kiocb_set_rw_flags(req, iocb->rw_flags);
>> +	if (unlikely(ret))
>> +		goto out_fput;
>> +
>> +	/* no one is going to poll for this I/O */
>> +	req->ki_flags &= ~IOCB_HIPRI;
> 
> Now that we don't have the aio legacy to deal with should we just
> reject IOCB_HIPRI on a non-polled context?

Yes I think so, we don't have any legacy behavior to adhere to.

> 
>> +static int io_setup_rw(int rw, const struct io_uring_iocb *iocb,
>> +		       struct iovec **iovec, struct iov_iter *iter)
>> +{
>> +	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
>> +	size_t ret;
>> +
>> +	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
>> +	*iovec = NULL;
>> +	return ret;
>> +}
> 
> Is there any point in supporting non-vectored operations here?

Not sure I follow?

>> +		if (S_ISREG(file_inode(file)->i_mode)) {
>> +			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
>> +			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
>> +		}
> 
> Overly long lines.

Fixed

>> +static int __io_submit_one(struct io_ring_ctx *ctx,
>> +			   const struct io_uring_iocb *iocb,
>> +			   unsigned long ki_index)
> 
> Maybe calls this io_ring_submit_one?  Or generally find a nice prefix
> for all the functions in this file?

Agree, some of this is leftover cruft from the aio side. I'll clean it
up.

>> +	f = fdget(fd);
>> +	if (f.file) {
>> +		struct io_ring_ctx *ctx;
> 
> Please just return early on fialure instead of forcing another level
> of indentation.

Sure, done.

> 
>> +
>> +	ctx->sq_ring.iocbs = io_mem_alloc(sizeof(struct io_uring_iocb) *
>> +						p->sq_entries);
> 
> Use array_size().

Done

>> +/*
>> + * sys_io_uring_setup:
>> + *	Sets up an aio uring context, and returns the fd. Applications asks
>> + *	for a ring size, we return the actual sq/cq ring sizes (among other
>> + *	things) in the params structure passed in.
>> + */
> 
> Can we drop this odd aio-style comment format?  In fact the syscall
> documentation probably just belongs into the man page only anyway.
> 
> Same for the uring_enter syscall.

Sure, not a big deal to me, dropped.

>> +struct io_uring_iocb {
> 
> Should we just call this io_uring_sqe?
> 
>> +/*
>> + * IO completion data structure
>> + */
>> +struct io_uring_event {
>> +	__u64	index;		/* what iocb this event came from */
>> +	__s32	res;		/* result code for this event */
>> +	__u32	flags;
>> +};
> 
> io_uring_cqe?

I'm fine with that, I like the symmetry of the names.

-- 
Jens Axboe

