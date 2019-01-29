Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC03C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 22:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FAA21848
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 22:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JzlK3OHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfA2W4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:56:34 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35621 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfA2W4e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 17:56:34 -0500
Received: by mail-io1-f68.google.com with SMTP id f4so17769487ion.2
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 14:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rXNoyyaCTBd2wSOJEs/OVVHxwgTCet0nmAWUGPTbcPs=;
        b=JzlK3OHlaHIVgVM181rQ11y17lKMeZFDhsc4PF59TA0mKguKp0ZUtgpenlkkScajrs
         hZh4/CZO0KaEixr/zYVIIneIyKXD8SxtI7btsBZ/Vt2fZbh5AfXIRz7N3zaPm3Nu2mcl
         6vsU5rrzuMSCuNgfDxXkztodX2PoiBxUxGvK5/vQSmAZ4iPZSrpQMqKZCrr7oWukPeok
         fRTrA4Hy/LagwOd90s5lXGPDMWC2Ipl+mcfR6W8neJiXUU/aBcR8Nr8mKex9BTr/pATS
         4iE1ovl8qGf/9EbJki6PLRLzfz5ofpN6RwYIjGz9xS4EN3OCFtVCW2T30czXjvHO/TDY
         D2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rXNoyyaCTBd2wSOJEs/OVVHxwgTCet0nmAWUGPTbcPs=;
        b=Dha1P2/9yU0v7oI5eYKGDFy12115yfPh3qTCvWKnnqHZX1BdDcuDN3TxyKDaq5bjir
         SI9pfkHOC7g7rlppLwFyRaLVcXZysCDS7Ao+YpQhYRmweZcbi8O3ysdjiH7wNSGVxcat
         FUYk/oPz/hchVkwJZLB0LR7RJOmCySWm+cmZ78CbobF9Xhkjf6sGLZWX+b2ljP+fLADk
         J7v0DVy2z84KsfRnGxLzTmwf2dI0aOgaOYpjTsFEs591HFw4Sr3epfNMJK8nK3sbGMUw
         NTBF+98smSrQSP5jGoYF5VvNW0ogap9phca1y0X858LaO/kCHEl6vUm4stIIjFicnHC2
         Bbxw==
X-Gm-Message-State: AHQUAuY7WqQv9Px5fHV3jAubBbLXCEepoYbu3py99zHCatVQuB7Eths+
        zip4wD8Kns+5R8PcxTBluBwHtQ==
X-Google-Smtp-Source: ALg8bN7nlohrPdlRqXmFD25DL3RHEMos1mSjIQKHEVopAMFdhb69qgL8d4/Y4MmTMFW3oeIa6O5lnw==
X-Received: by 2002:a5e:da49:: with SMTP id o9mr16185347iop.246.1548802591957;
        Tue, 29 Jan 2019 14:56:31 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z124sm103505itz.42.2019.01.29.14.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 14:56:30 -0800 (PST)
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO
 buffers
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-13-axboe@kernel.dk>
 <CAG48ez2VkeSEZA+9H4UAcg86uC77gU=UkTG8L1V58TuR9pDEqg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dd366179-c003-752f-743d-2bea4f6b796c@kernel.dk>
Date:   Tue, 29 Jan 2019 15:56:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2VkeSEZA+9H4UAcg86uC77gU=UkTG8L1V58TuR9pDEqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 3:44 PM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
>> If we have fixed user buffers, we can map them into the kernel when we
>> setup the io_context. That avoids the need to do get_user_pages() for
>> each and every IO.
>>
>> To utilize this feature, the application must call io_uring_register()
>> after having setup an io_uring context, passing in
>> IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer
>> to an iovec array, and the nr_args should contain how many iovecs the
>> application wishes to map.
>>
>> If successful, these buffers are now mapped into the kernel, eligible
>> for IO. To use these fixed buffers, the application must use the
>> IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
>> set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
>> must point to somewhere inside the indexed buffer.
>>
>> The application may register buffers throughout the lifetime of the
>> io_uring context. It can call io_uring_register() with
>> IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
>> buffers, and then register a new set. The application need not
>> unregister buffers explicitly before shutting down the io_uring context.
> [...]
>> +static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
>> +                          const struct io_uring_sqe *sqe,
>> +                          struct iov_iter *iter)
>> +{
>> +       size_t len = READ_ONCE(sqe->len);
>> +       struct io_mapped_ubuf *imu;
>> +       int buf_index, index;
>> +       size_t offset;
>> +       u64 buf_addr;
>> +
>> +       /* attempt to use fixed buffers without having provided iovecs */
>> +       if (unlikely(!ctx->user_bufs))
>> +               return -EFAULT;
>> +
>> +       buf_index = READ_ONCE(sqe->buf_index);
>> +       if (unlikely(buf_index >= ctx->nr_user_bufs))
>> +               return -EFAULT;
> 
> Nit: If you make the local copy of buf_index unsigned, it is slightly
> easier to see that this code is correct. (I know, it has to be
> positive anyway because the value in shared memory is a u16.)

I'll definitely fit, but I can make it unsigned.

>> +       index = array_index_nospec(buf_index, ctx->sq_entries);
> 
> This looks weird. Did you mean s/ctx->sq_entries/ctx->nr_user_bufs/?

I did, too much copy/paste for that one. Fixed.

>> +       imu = &ctx->user_bufs[index];
>> +       buf_addr = READ_ONCE(sqe->addr);
>> +       if (buf_addr < imu->ubuf || buf_addr + len > imu->ubuf + imu->len)
> 
> This can wrap around if `buf_addr` or `len` is very big, right? Then
> you e.g. get past the first check because `buf_addr` is sufficiently
> big, and get past the second check because `buf_addr + len` wraps
> around and becomes small.

Good point. I wonder if we have a verification helper for something like
this?

>> +               return -EFAULT;
>> +
>> +       /*
>> +        * May not be a start of buffer, set size appropriately
>> +        * and advance us to the beginning.
>> +        */
>> +       offset = buf_addr - imu->ubuf;
>> +       iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
>> +       if (offset)
>> +               iov_iter_advance(iter, offset);
>> +       return 0;
>> +}
>> +
>>  static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
>>                            const struct io_uring_sqe *sqe, struct iovec **iovec,
>>                            struct iov_iter *iter)
>>  {
>>         void __user *buf = u64_to_user_ptr(READ_ONCE(sqe->addr));
>>         size_t sqe_len = READ_ONCE(sqe->len);
>> +       int opcode;
>> +
>> +       opcode = READ_ONCE(sqe->opcode);
>> +       if (opcode == IORING_OP_READ_FIXED ||
>> +           opcode == IORING_OP_WRITE_FIXED) {
>> +               ssize_t ret = io_import_fixed(ctx, rw, sqe, iter);
>> +               *iovec = NULL;
>> +               return ret;
>> +       }
> [...]
>>
>> +static inline bool io_sqe_needs_user(const struct io_uring_sqe *sqe)
>> +{
>> +       return !(sqe->opcode == IORING_OP_READ_FIXED ||
>> +                sqe->opcode == IORING_OP_WRITE_FIXED);
>> +}
> 
> This still looks racy to me?

I didn't change it because the below one you quoted below
(io_sq_wq_submit_work()) is using a local copy, but we do need it for
for the SQPOLL io_sq_thread() case. I'll get that one fixed up.

I suspect the easiest fix is to ensure that io_sq_thread() copies the
sqe.

>> +static int io_copy_iov(struct io_ring_ctx *ctx, struct iovec *dst,
>> +                      void __user *arg, unsigned index)
>> +{
> 
> This function doesn't actually use the "ctx" parameter, right? You
> might want to remove it.

It should just use ctx->compat for this check, we're now only calling
in_compat_syscall() when we setup the ctx. This keeps it all in one
spot.

>> +       struct iovec __user *src;
>> +
>> +#ifdef CONFIG_COMPAT
>> +       if (in_compat_syscall()) {
>> +               struct compat_iovec __user *ciovs;
>> +               struct compat_iovec ciov;
>> +
>> +               ciovs = (struct compat_iovec __user *) arg;
>> +               if (copy_from_user(&ciov, &ciovs[index], sizeof(ciov)))
>> +                       return -EFAULT;
>> +
>> +               dst->iov_base = (void __user *) (unsigned long) ciov.iov_base;
>> +               dst->iov_len = ciov.iov_len;
>> +               return 0;
>> +       }
>> +#endif
>> +       src = (struct iovec __user *) arg;
>> +       if (copy_from_user(dst, &src[index], sizeof(*dst)))
>> +               return -EFAULT;
>> +       return 0;
>> +}
>> +
>> +static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
>> +                                 unsigned nr_args)
>> +{
>> +       struct vm_area_struct **vmas = NULL;
>> +       struct page **pages = NULL;
>> +       int i, j, got_pages = 0;
>> +       int ret = -EINVAL;
>> +
>> +       if (ctx->user_bufs)
>> +               return -EBUSY;
>> +       if (!nr_args || nr_args > UIO_MAXIOV)
>> +               return -EINVAL;
>> +
>> +       ctx->user_bufs = kcalloc(nr_args, sizeof(struct io_mapped_ubuf),
>> +                                       GFP_KERNEL);
>> +       if (!ctx->user_bufs)
>> +               return -ENOMEM;
>> +
>> +       if (!capable(CAP_IPC_LOCK))
>> +               ctx->user = get_uid(current_user());
>> +
>> +       for (i = 0; i < nr_args; i++) {
>> +               struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
>> +               unsigned long off, start, end, ubuf;
>> +               int pret, nr_pages;
>> +               struct iovec iov;
>> +               size_t size;
>> +
>> +               ret = io_copy_iov(ctx, &iov, arg, i);
>> +               if (ret)
>> +                       break;
>> +
>> +               /*
>> +                * Don't impose further limits on the size and buffer
>> +                * constraints here, we'll -EINVAL later when IO is
>> +                * submitted if they are wrong.
>> +                */
>> +               ret = -EFAULT;
>> +               if (!iov.iov_base)
>> +                       goto err;
>> +
>> +               /* arbitrary limit, but we need something */
>> +               if (iov.iov_len > SZ_1G)
>> +                       goto err;
> 
> You might also want to check for iov_len==0? Otherwise, if iov_base
> isn't page-aligned, the following code might grab a reference to one
> page even though the iov covers zero pages, that'd be kinda weird.

Good catch, will do.

> 
>> +               ubuf = (unsigned long) iov.iov_base;
>> +               end = (ubuf + iov.iov_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>> +               start = ubuf >> PAGE_SHIFT;
>> +               nr_pages = end - start;
>> +
>> +               ret = io_account_mem(ctx, nr_pages);
>> +               if (ret)
>> +                       goto err;
>> +
>> +               if (!pages || nr_pages > got_pages) {
>> +                       kfree(vmas);
>> +                       kfree(pages);
>> +                       pages = kmalloc_array(nr_pages, sizeof(struct page *),
>> +                                               GFP_KERNEL);
>> +                       vmas = kmalloc_array(nr_pages,
>> +                                       sizeof(struct vma_area_struct *),
>> +                                       GFP_KERNEL);
>> +                       if (!pages || !vmas) {
>> +                               io_unaccount_mem(ctx, nr_pages);
>> +                               goto err;
>> +                       }
>> +                       got_pages = nr_pages;
>> +               }
>> +
>> +               imu->bvec = kmalloc_array(nr_pages, sizeof(struct bio_vec),
>> +                                               GFP_KERNEL);
>> +               if (!imu->bvec) {
>> +                       io_unaccount_mem(ctx, nr_pages);
>> +                       goto err;
>> +               }
>> +
>> +               down_write(&current->mm->mmap_sem);
> 
> Is there a reason why you're using down_write() and not down_read()?
> As far as I can tell, down_read() is all you need...

Looks like you are right, I'll change that.

>> +               pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
>> +                                               pages, vmas);
>> +               if (pret == nr_pages) {
>> +                       /* don't support file backed memory */
>> +                       for (j = 0; j < nr_pages; j++) {
>> +                               struct vm_area_struct *vma = vmas[j];
>> +
>> +                               if (vma->vm_file) {
>> +                                       ret = -EOPNOTSUPP;
>> +                                       break;
>> +                               }
>> +                       }
> 
> Are you intentionally doing the check for vma->vm_file instead of
> calling GUP with FOLL_ANON, which would automatically verify
> vma->vm_ops==NULL for you using vma_is_anonymous()? FOLL_ANON is what
> procfs uses to avoid blocking on page faults when reading remote
> process memory via /proc/*/{cmdline,environ}. I don't entirely
> understand the motivation for this check, so I can't really tell
> whether FOLL_ANON would do the job.

I wasn't aware of FOLL_ANON, it looks exactly like what I need. All I
care about is the mapping being anon, and not file backed. If FOLL_ANON
ensures me that (or fails), then that'll kill this vma checking code.
Thanks!

-- 
Jens Axboe

