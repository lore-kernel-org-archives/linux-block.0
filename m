Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8CDC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DA821738
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 19:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v46/rNTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfBSTJE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:09:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33890 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfBSTJD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 14:09:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id 98so36215070oty.1
        for <linux-block@vger.kernel.org>; Tue, 19 Feb 2019 11:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvG6b6XzrUy6ODHrru0E3gxcCFBMenPt77j8iuEmJoo=;
        b=v46/rNTUJAX1smHBa6j6PCuum5GzWv8BdQvrHeuTVBdY6ZGXhTnK+KGocF55XHYbTz
         5p6E1KUs4+Jm6kjfU71GiPVT74GZiGW4MQJ1ZJgcz8qCrwrOS430og0PRqsOTi3rStUd
         TDwUab3syfLV0KoNEeC4qBhwZ305s0xqz3+LRyhPOwuRCe6NbwhEYQYyJzCGfCc5kMrM
         xes9qRFx/ZCE0BuYx3IWv67RAHeVeKO4nwKx2WVVr1KTCbGKzUpUgBCGvoyln/6tr4Ku
         zjAYJ4AZywaY+PPZXrEjwlCv3BaPVj9K/C6TYEHpubJq7uU10igqeEiDEKFH1T1k3fDP
         63cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvG6b6XzrUy6ODHrru0E3gxcCFBMenPt77j8iuEmJoo=;
        b=MZC9UrmyL5ca3TkBXpfW1EGYVgxDyDfklD49E46Vd6S5/2uaGA0t1KsBSLJTMIZB6f
         /jiQ7dKoOX32LswFQv1qjf1vnl8X4X87xH+wFkut2GzDr7ntgUqfdSR4U+/KzNX26uSD
         80FI93n5EKYeNwA3nCjTYWgmOHER4uYrBm3xhh3sNq2bRU/uC+MGuVw7cfp8tbY4SumT
         rO3xNozCYep+UlUE6G6f/+7eIR4JcBw17hzWUpGdznqN7aLSv11+oErjjPIr3hB4ORPM
         c5TMLZ17c3qo/h4rkGjMVvpYVZruxMnD8n2MiWQJkbFnEUGXZ5LXlclnZadV4OxjxmlR
         6RzQ==
X-Gm-Message-State: AHQUAuZQAepbZjVA9n6CLkTbARr1XnX4DheAfi1paZBuuLzDoj1ZJ6sh
        UwAsiPjpPUh6GL7hAUiP3MTcymhAGwPLAv6z7pbDMg==
X-Google-Smtp-Source: AHgI3IaxecYb647wY6dJ6uzEWW1oObGJ3vPaDTyJ9uLLHBk6jt38xKz2wKEDNWVhJKqb04AbDsQx9F1FdiDf7PjgZHg=
X-Received: by 2002:a05:6830:14d6:: with SMTP id t22mr19855488otq.255.1550603342340;
 Tue, 19 Feb 2019 11:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20190211190049.7888-1-axboe@kernel.dk> <20190211190049.7888-14-axboe@kernel.dk>
In-Reply-To: <20190211190049.7888-14-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 19 Feb 2019 20:08:35 +0100
Message-ID: <CAG48ez2jrdFEATYor3-tRUx=LBpXo9581tPCWUgjWf6atMiGzA@mail.gmail.com>
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

On Mon, Feb 11, 2019 at 8:01 PM Jens Axboe <axboe@kernel.dk> wrote:
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
>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
[...]
>  static void io_sq_wq_submit_work(struct work_struct *work)
>  {
>         struct io_kiocb *req = container_of(work, struct io_kiocb, work);
>         struct sqe_submit *s = &req->submit;
>         const struct io_uring_sqe *sqe = s->sqe;
>         struct io_ring_ctx *ctx = req->ctx;
> -       mm_segment_t old_fs = get_fs();
> +       mm_segment_t old_fs;
> +       bool needs_user;
>         int ret;
>
>          /* Ensure we clear previously set forced non-block flag */
>         req->flags &= ~REQ_F_FORCE_NONBLOCK;
>         req->rw.ki_flags &= ~IOCB_NOWAIT;
>
> -       if (!mmget_not_zero(ctx->sqo_mm)) {
> -               ret = -EFAULT;
> -               goto err;
> -       }
> -
> -       use_mm(ctx->sqo_mm);
> -       set_fs(USER_DS);
> -       s->has_user = true;
>         s->needs_lock = true;
> +       s->has_user = false;
> +
> +       /*
> +        * If we're doing IO to fixed buffers, we don't need to get/set
> +        * user context
> +        */
> +       needs_user = io_sqe_needs_user(s->sqe);
> +       if (needs_user) {
> +               if (!mmget_not_zero(ctx->sqo_mm)) {
> +                       ret = -EFAULT;
> +                       goto err;
> +               }
> +               use_mm(ctx->sqo_mm);
> +               old_fs = get_fs();
> +               set_fs(USER_DS);
> +               s->has_user = true;
> +       }
>
>         do {
>                 ret = __io_submit_sqe(ctx, req, s, false, NULL);
> @@ -1011,9 +1110,11 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>                 cond_resched();
>         } while (1);
>
> -       set_fs(old_fs);
> -       unuse_mm(ctx->sqo_mm);
> -       mmput(ctx->sqo_mm);
> +       if (needs_user) {
> +               set_fs(old_fs);
> +               unuse_mm(ctx->sqo_mm);
> +               mmput(ctx->sqo_mm);
> +       }
>  err:
>         if (ret) {
>                 io_cqring_add_event(ctx, sqe->user_data, ret, 0);
> @@ -1308,6 +1409,197 @@ static unsigned long ring_pages(unsigned sq_entries, unsigned cq_entries)
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
> +       for (i = 0; i < ctx->nr_user_bufs; i++) {
> +               struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
> +
> +               for (j = 0; j < imu->nr_bvecs; j++)
> +                       put_page(imu->bvec[j].bv_page);
> +
> +               if (ctx->account_mem)
> +                       io_unaccount_mem(ctx->user, imu->nr_bvecs);
> +               kfree(imu->bvec);
> +               imu->nr_bvecs = 0;
> +       }
> +
> +       kfree(ctx->user_bufs);
> +       ctx->user_bufs = NULL;
> +       ctx->nr_user_bufs = 0;
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
> +               if (ctx->account_mem) {
> +                       ret = io_account_mem(ctx->user, nr_pages);
> +                       if (ret)
> +                               goto err;
> +               }
> +
> +               ret = 0;
> +               if (!pages || nr_pages > got_pages) {

Nit: No need to check for `!pages` as long as `pages` and `got_pages`
are synchronized (which guarantees that `!pages` implies
`got_pages==0`).

> +                       kfree(vmas);
> +                       kfree(pages);
> +                       pages = kmalloc_array(nr_pages, sizeof(struct page *),
> +                                               GFP_KERNEL);
> +                       vmas = kmalloc_array(nr_pages,
> +                                       sizeof(struct vma_area_struct *),

typo: s/vma_area_struct/vm_area_struct/

> +                                       GFP_KERNEL);
> +                       if (!pages || !vmas) {
> +                               ret = -ENOMEM;
> +                               if (ctx->account_mem)
> +                                       io_unaccount_mem(ctx->user, nr_pages);
> +                               goto err;
> +                       }
> +                       got_pages = nr_pages;
> +               }
> +
> +               imu->bvec = kmalloc_array(nr_pages, sizeof(struct bio_vec),
> +                                               GFP_KERNEL);
> +               ret = -ENOMEM;
> +               if (!imu->bvec) {
> +                       if (ctx->account_mem)
> +                               io_unaccount_mem(ctx->user, nr_pages);
> +                       goto err;
> +               }
> +
> +               ret = 0;
> +               down_read(&current->mm->mmap_sem);
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
> +               up_read(&current->mm->mmap_sem);
> +               if (ret) {
> +                       /*
> +                        * if we did partial map, or found file backed vmas,
> +                        * release any pages we did get
> +                        */
> +                       if (pret > 0) {
> +                               for (j = 0; j < pret; j++)
> +                                       put_page(pages[j]);
> +                       }
> +                       if (ctx->account_mem)
> +                               io_unaccount_mem(ctx->user, nr_pages);
> +                       goto err;
> +               }
> +
> +               off = ubuf & ~PAGE_MASK;
> +               size = iov.iov_len;
> +               for (j = 0; j < nr_pages; j++) {
> +                       size_t vec_len;
> +
> +                       vec_len = min_t(size_t, size, PAGE_SIZE - off);
> +                       imu->bvec[j].bv_page = pages[j];
> +                       imu->bvec[j].bv_len = vec_len;
> +                       imu->bvec[j].bv_offset = off;
> +                       off = 0;
> +                       size -= vec_len;
> +               }
> +               /* store original address for later verification */
> +               imu->ubuf = ubuf;
> +               imu->len = iov.iov_len;
> +               imu->nr_bvecs = nr_pages;
> +       }
> +       kfree(pages);
> +       kfree(vmas);
> +       ctx->nr_user_bufs = nr_args;
> +       return 0;
> +err:
> +       kfree(pages);
> +       kfree(vmas);
> +       io_sqe_buffer_unregister(ctx);

io_sqe_buffer_unregister() gets rid of elements up to
ctx->nr_user_bufs, but as far as I can tell, ctx->nr_user_bufs is
always zero here. I think that's going to cause a reference leak.

> +       return ret;
> +}
