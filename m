Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A1EC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9A721841
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHm7VPcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBHWyz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:54:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46832 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHWyz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 17:54:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so8532434otm.13
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IILKkykGS2vraJLN5lqp22FEW9mPI/uWQoIELHXyvvQ=;
        b=iHm7VPcrIWjpqbI0ZjMSdLFPhJFU7dbVbbCDZemGvfDm282ZSXdnlnhvSZimPApuIv
         qtsUxOGKiULYdiO2ZRcLRzCu2KGIoBwMxjSr6m68d/VnpSj3XYAKgvLETgRTeVTDHzPP
         Zj2V4lk/B4ZwgKu5ozK6RLe+5ibiWXSkFpULutaukMGmHpcaADIQsoVGm/kSnVGjlQyY
         qVpa1vAG52+edMFVS9tSQT1Xrkz7YBDiDgFLTYtzumGCL6PmW9hY9CsphBQr5fAvVsKh
         1y11ZzM6Sti9sUQgn+uo1JhSAeTenHDnZjwqXGBujkOwstIah9tDtCdLvkAO3Tol9FKp
         ZQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IILKkykGS2vraJLN5lqp22FEW9mPI/uWQoIELHXyvvQ=;
        b=t7NNX16V+IhSvhFZSFj7dernd7BJsbgWW2beWWg1f8R3OOh/V4dVS7K1E5/NJBdrSc
         Oxgt8LAUhozNqwkcnekcmf2dwSYxiTP8WSo3ka/3TD4pjpveRaK8qQRw2SbKAcyOOS5+
         DjKQGxfCBkPrQhiay+CN+t84solJP3mnu/nOJ14FNQGGvv4k6ktMTfulWuglTuf3Uzm9
         5SXAbvjdF7/CnUnWbU7VgXhpOXhLkGErXXx6MCMHprPuRbhBHeblpDrjMWMNnf1Rxk/+
         NfA//ltnFTYm2hGEkHarnTUyLEJzDGMYv7+eEUjB1IqHI8HWq+fpZxZ8T8gsEWlm5aCk
         Nozg==
X-Gm-Message-State: AHQUAuZhmA/CIKOERUmfTddGzVSewzVKr5wBe5WaffShyyr06S6i/hUl
        SOBWIS1R516DJQaJxJJ8gpNS7WP9fBLFpdCdQgFXjEugpiLjfg==
X-Google-Smtp-Source: AHgI3IbLAhDVcLV5ZI2MVr2m5xX+Kn3+47UKPVgW1w9GT26xHw3Dg2jMOwaG0UoNIDOijndR6ZUlMD2zmmZDCzF2w8k=
X-Received: by 2002:a9d:4549:: with SMTP id p9mr14768908oti.51.1549666494445;
 Fri, 08 Feb 2019 14:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20190208173423.27014-1-axboe@kernel.dk> <20190208173423.27014-13-axboe@kernel.dk>
In-Reply-To: <20190208173423.27014-13-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 8 Feb 2019 23:54:28 +0100
Message-ID: <CAG48ez0uH_muHobzpwFzdyBWCcWDxbnfpuxABntph6Te+tYxGg@mail.gmail.com>
Subject: Re: [PATCH 12/19] io_uring: add support for pre-mapped user IO buffers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 8, 2019 at 6:35 PM Jens Axboe <axboe@kernel.dk> wrote:
> If we have fixed user buffers, we can map them into the kernel when we
> setup the io_uring. That avoids the need to do get_user_pages() for
> each and every IO.
>
> To utilize this feature, the application must call io_uring_register()
> after having setup an io_uring instance, passing in
> IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer to
> an iovec array, and the nr_args should contain how many iovecs the
> application wishes to map.
>
> If successful, these buffers are now mapped into the kernel, eligible
> for IO. To use these fixed buffers, the application must use the
> IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
> set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
> must point to somewhere inside the indexed buffer.
>
> The application may register buffers throughout the lifetime of the
> io_uring instance. It can call io_uring_register() with
> IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
> buffers, and then register a new set. The application need not
> unregister buffers explicitly before shutting down the io_uring
> instance.
>
> It's perfectly valid to setup a larger buffer, and then sometimes only
> use parts of it for an IO. As long as the range is within the originally
> mapped region, it will work just fine.
>
> For now, buffers must not be file backed. If file backed buffers are
> passed in, the registration will fail with -1/EOPNOTSUPP. This
> restriction may be relaxed in the future.
>
> RLIMIT_MEMLOCK is used to check how much memory we can pin. A somewhat
> arbitrary 1G per buffer size is also imposed.
[...]
>  static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
>                            const struct sqe_submit *s, struct iovec **iovec,
>                            struct iov_iter *iter)
> @@ -711,6 +763,15 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
>         const struct io_uring_sqe *sqe = s->sqe;
>         void __user *buf = u64_to_user_ptr(READ_ONCE(sqe->addr));
>         size_t sqe_len = READ_ONCE(sqe->len);
> +       u8 opcode;

(You could add a comment here if you want, something like "We're
reading ->opcode for the second time, but the first read doesn't care
whether it's _FIXED or not, so it doesn't matter whether ->opcode
changes concurrently. The first read does care about whether it is a
READ or a WRITE, so we don't trust this read for that purpose and
instead let the caller pass in the read/write flag.")

> +       opcode = READ_ONCE(sqe->opcode);
> +       if (opcode == IORING_OP_READ_FIXED ||
> +           opcode == IORING_OP_WRITE_FIXED) {
> +               ssize_t ret = io_import_fixed(ctx, rw, sqe, iter);
> +               *iovec = NULL;
> +               return ret;
> +       }
>
>         if (!s->has_user)
>                 return EFAULT;
[...]
> @@ -1242,6 +1334,187 @@ static unsigned long ring_pages(unsigned sq_entries, unsigned cq_entries)
>         return (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
>  }
>
> +static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
> +{
> +       int i, j;
> +
> +       if (!ctx->user_bufs)
> +               return -ENXIO;
> +
> +       for (i = 0; i < ctx->sq_entries; i++) {

->sq_entries? Shouldn't this be ->nr_user_bufs?

> +               struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
> +
> +               for (j = 0; j < imu->nr_bvecs; j++)
> +                       put_page(imu->bvec[j].bv_page);
> +
> +               io_unaccount_mem(ctx->user, imu->nr_bvecs);
> +               kfree(imu->bvec);
> +               imu->nr_bvecs = 0;
> +       }
> +
> +       kfree(ctx->user_bufs);
> +       ctx->user_bufs = NULL;

(It isn't really necessary, but you could set nr_user_bufs=0 here.)

> +       return 0;
> +}
[...]
> +static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
> +                                 unsigned nr_args)
> +{
> +       struct vm_area_struct **vmas = NULL;
> +       struct page **pages = NULL;
> +       int i, j, got_pages = 0;
> +       int ret = -EINVAL;
> +
> +       if (ctx->user_bufs)
> +               return -EBUSY;
> +       if (!nr_args || nr_args > UIO_MAXIOV)
> +               return -EINVAL;
> +
> +       ctx->user_bufs = kcalloc(nr_args, sizeof(struct io_mapped_ubuf),
> +                                       GFP_KERNEL);
> +       if (!ctx->user_bufs)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < nr_args; i++) {
> +               struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
> +               unsigned long off, start, end, ubuf;
> +               int pret, nr_pages;
> +               struct iovec iov;
> +               size_t size;
> +
> +               ret = io_copy_iov(ctx, &iov, arg, i);
> +               if (ret)
> +                       break;
> +
> +               /*
> +                * Don't impose further limits on the size and buffer
> +                * constraints here, we'll -EINVAL later when IO is
> +                * submitted if they are wrong.
> +                */
> +               ret = -EFAULT;
> +               if (!iov.iov_base || !iov.iov_len)
> +                       goto err;
> +
> +               /* arbitrary limit, but we need something */
> +               if (iov.iov_len > SZ_1G)
> +                       goto err;
> +
> +               ubuf = (unsigned long) iov.iov_base;
> +               end = (ubuf + iov.iov_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +               start = ubuf >> PAGE_SHIFT;
> +               nr_pages = end - start;
> +
> +               ret = io_account_mem(ctx->user, nr_pages);

Technically, this accounting is probably a bit off; I think if you
pass in a vector of 4K areas from 1G hugepages, you're going to pin
factor 0x40000 more memory than you think you're pinning.
(get_user_pages() counts references against the head page of a
compound page; nothing in the kernel can tell afterwards which part of
the hugepage you're using.) I'm not sure how much of a problem that
is, but it should probably at least be documented. Unless I'm just
missing something?

> +               if (ret)
> +                       goto err;
> +
> +               if (!pages || nr_pages > got_pages) {
> +                       kfree(vmas);
> +                       kfree(pages);
> +                       pages = kmalloc_array(nr_pages, sizeof(struct page *),
> +                                               GFP_KERNEL);
> +                       vmas = kmalloc_array(nr_pages,
> +                                       sizeof(struct vma_area_struct *),
> +                                       GFP_KERNEL);
> +                       if (!pages || !vmas) {
> +                               ret = -ENOMEM;
> +                               io_unaccount_mem(ctx->user, nr_pages);
> +                               goto err;
> +                       }
> +                       got_pages = nr_pages;
> +               }
> +
> +               imu->bvec = kmalloc_array(nr_pages, sizeof(struct bio_vec),
> +                                               GFP_KERNEL);
> +               if (!imu->bvec) {
> +                       io_unaccount_mem(ctx->user, nr_pages);
> +                       goto err;
> +               }
> +
> +               down_write(&current->mm->mmap_sem);

Weren't you planning to make this down_read()?

> +               pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
> +                                               pages, vmas);
> +               if (pret == nr_pages) {
> +                       /* don't support file backed memory */
> +                       for (j = 0; j < nr_pages; j++) {
> +                               struct vm_area_struct *vma = vmas[j];
> +
> +                               if (vma->vm_file &&
> +                                   !is_file_hugepages(vma->vm_file)) {
> +                                       ret = -EOPNOTSUPP;
> +                                       break;
> +                               }
> +                       }
> +               } else {
> +                       ret = pret < 0 ? pret : -EFAULT;
> +               }
> +               up_write(&current->mm->mmap_sem);
[...]
> +}
[...]
> diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
> index 39ad98c09c58..c7b5f86b91a1 100644
> --- a/include/linux/sched/user.h
> +++ b/include/linux/sched/user.h
> @@ -40,7 +40,7 @@ struct user_struct {
>         kuid_t uid;
>
>  #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
> -    defined(CONFIG_NET)
> +    defined(CONFIG_NET) || defined(CONFIG_IO_URING)
>         atomic_long_t locked_vm;
>  #endif

You're already using locked_vm in patch 5, right? I think that means
that from patch 5 up to this patch, some kernel configs will fail to
build.
