Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F6C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 23:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06870218DA
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 23:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OD3acEXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfBHXiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:38:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36494 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHXiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 18:38:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so2417549plo.3
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 15:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jA8/sA5jN/ZwQrr5ig5DCuBWnt6hLB+qjXrz6OM615o=;
        b=OD3acEXThwesnTmcfGP3y+JLiIT9L2j6NzzOrYQzugrVtmVARpu4n2Hr5dXn6GKVUB
         ZUyDpNqeXeuj08zJDZ1qcb+7+cYmgvZWmX/phhbtmWR8jQz/OkFdGk1MWckmVzrl4XKq
         f//82WFWQ0t4JVqEGXzLNfHG7pknwXG2uwcilFClRfjBSxW2vZHOIkX8w8AtH8RUUHvF
         iFftQrYu6v5OjISZJIpFj2fAxs8XDr4lxqJzEE4K2U6hY6FCQ4l6Zn/qhg4Yv8lwsSD+
         ytoo+rzqYTzNjuRSPtNqN3wsnrTgt6xXgdIt9Yg9OuDuJyI2ChnSF37iHsSL8q+6c8me
         jESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jA8/sA5jN/ZwQrr5ig5DCuBWnt6hLB+qjXrz6OM615o=;
        b=Rd2rYAQdzc7TY5J9lTk40uxF3L5ES+YrSWuTGYSztZg7BzoSKiHIkm/2gs2/50XcBJ
         fuNgx9Ub7i1QAjmAJIklHzJB8OBWlVZhxtDZqRnOwJmd7s+EBmnDmFeDRRmZAKfc3W3z
         c+f5uqPdiqiK2TrqT6a2oUIcwwJIYCeSAXQaQoEgUjkfTARJOCZKoPN4gnl8km9z+EV6
         2qM6wcQDLcHCkHS4000dOHTBybG7/QMZ4CdMfQsjlE/hqxCyyGeRmAhT/NatMjYtC8KY
         MIjEGroR0sPmrGXku7mSktyRi0Q//X5sFa1Wn4lF+vlKd58k/CSKX+KlVmMgDgu8tQ0Z
         qkHg==
X-Gm-Message-State: AHQUAuYzNnb0MRG0ScBoQq6kF9P5tifA5y0xtWLemdyG0SUW3FFff5qh
        1QDShLcCcpxtlDgcNtUNQbbM/g==
X-Google-Smtp-Source: AHgI3IZr+IIKELkKE0VbguWn7bJNvXuqtlTm1+wCM2xnCkNE0qreO+m8C9GA4Iv6j4Kqg4MPA8ZO0A==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37mr25691240pla.129.1549669102253;
        Fri, 08 Feb 2019 15:38:22 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e65sm4938229pfc.184.2019.02.08.15.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 15:38:20 -0800 (PST)
Subject: Re: [PATCH 12/19] io_uring: add support for pre-mapped user IO
 buffers
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-13-axboe@kernel.dk>
 <CAG48ez0uH_muHobzpwFzdyBWCcWDxbnfpuxABntph6Te+tYxGg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ef04b12-6a4b-af25-cbf8-9dde79b0ec1e@kernel.dk>
Date:   Fri, 8 Feb 2019 16:38:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0uH_muHobzpwFzdyBWCcWDxbnfpuxABntph6Te+tYxGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 3:54 PM, Jann Horn wrote:
> On Fri, Feb 8, 2019 at 6:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>> If we have fixed user buffers, we can map them into the kernel when we
>> setup the io_uring. That avoids the need to do get_user_pages() for
>> each and every IO.
>>
>> To utilize this feature, the application must call io_uring_register()
>> after having setup an io_uring instance, passing in
>> IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer to
>> an iovec array, and the nr_args should contain how many iovecs the
>> application wishes to map.
>>
>> If successful, these buffers are now mapped into the kernel, eligible
>> for IO. To use these fixed buffers, the application must use the
>> IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
>> set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
>> must point to somewhere inside the indexed buffer.
>>
>> The application may register buffers throughout the lifetime of the
>> io_uring instance. It can call io_uring_register() with
>> IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
>> buffers, and then register a new set. The application need not
>> unregister buffers explicitly before shutting down the io_uring
>> instance.
>>
>> It's perfectly valid to setup a larger buffer, and then sometimes only
>> use parts of it for an IO. As long as the range is within the originally
>> mapped region, it will work just fine.
>>
>> For now, buffers must not be file backed. If file backed buffers are
>> passed in, the registration will fail with -1/EOPNOTSUPP. This
>> restriction may be relaxed in the future.
>>
>> RLIMIT_MEMLOCK is used to check how much memory we can pin. A somewhat
>> arbitrary 1G per buffer size is also imposed.
> [...]
>>  static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
>>                            const struct sqe_submit *s, struct iovec **iovec,
>>                            struct iov_iter *iter)
>> @@ -711,6 +763,15 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
>>         const struct io_uring_sqe *sqe = s->sqe;
>>         void __user *buf = u64_to_user_ptr(READ_ONCE(sqe->addr));
>>         size_t sqe_len = READ_ONCE(sqe->len);
>> +       u8 opcode;
> 
> (You could add a comment here if you want, something like "We're
> reading ->opcode for the second time, but the first read doesn't care
> whether it's _FIXED or not, so it doesn't matter whether ->opcode
> changes concurrently. The first read does care about whether it is a
> READ or a WRITE, so we don't trust this read for that purpose and
> instead let the caller pass in the read/write flag.")

Sure, I can add that.

>> +static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
>> +{
>> +       int i, j;
>> +
>> +       if (!ctx->user_bufs)
>> +               return -ENXIO;
>> +
>> +       for (i = 0; i < ctx->sq_entries; i++) {
> 
> ->sq_entries? Shouldn't this be ->nr_user_bufs?

It should! I swear I already fixed that, odd. Maybe that was somewhere
else...

>> +               struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
>> +
>> +               for (j = 0; j < imu->nr_bvecs; j++)
>> +                       put_page(imu->bvec[j].bv_page);
>> +
>> +               io_unaccount_mem(ctx->user, imu->nr_bvecs);
>> +               kfree(imu->bvec);
>> +               imu->nr_bvecs = 0;
>> +       }
>> +
>> +       kfree(ctx->user_bufs);
>> +       ctx->user_bufs = NULL;
> 
> (It isn't really necessary, but you could set nr_user_bufs=0 here.)

Doesn't hurt to be defensive.

>> +       return 0;
>> +}
> [...]
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
>> +               if (!iov.iov_base || !iov.iov_len)
>> +                       goto err;
>> +
>> +               /* arbitrary limit, but we need something */
>> +               if (iov.iov_len > SZ_1G)
>> +                       goto err;
>> +
>> +               ubuf = (unsigned long) iov.iov_base;
>> +               end = (ubuf + iov.iov_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>> +               start = ubuf >> PAGE_SHIFT;
>> +               nr_pages = end - start;
>> +
>> +               ret = io_account_mem(ctx->user, nr_pages);
> 
> Technically, this accounting is probably a bit off; I think if you
> pass in a vector of 4K areas from 1G hugepages, you're going to pin
> factor 0x40000 more memory than you think you're pinning.
> (get_user_pages() counts references against the head page of a
> compound page; nothing in the kernel can tell afterwards which part of
> the hugepage you're using.) I'm not sure how much of a problem that
> is, but it should probably at least be documented. Unless I'm just
> missing something?

No I think you are right, it doesn't account for the hugepage size if
you pass in huge pages. I'll fix that up.

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
>> +                               ret = -ENOMEM;
>> +                               io_unaccount_mem(ctx->user, nr_pages);
>> +                               goto err;
>> +                       }
>> +                       got_pages = nr_pages;
>> +               }
>> +
>> +               imu->bvec = kmalloc_array(nr_pages, sizeof(struct bio_vec),
>> +                                               GFP_KERNEL);
>> +               if (!imu->bvec) {
>> +                       io_unaccount_mem(ctx->user, nr_pages);
>> +                       goto err;
>> +               }
>> +
>> +               down_write(&current->mm->mmap_sem);
> 
> Weren't you planning to make this down_read()?

I think I accidentally messed that up when going back to not using
FOLL_ANON. Fixed (again), thanks.

>> +               pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
>> +                                               pages, vmas);
>> +               if (pret == nr_pages) {
>> +                       /* don't support file backed memory */
>> +                       for (j = 0; j < nr_pages; j++) {
>> +                               struct vm_area_struct *vma = vmas[j];
>> +
>> +                               if (vma->vm_file &&
>> +                                   !is_file_hugepages(vma->vm_file)) {
>> +                                       ret = -EOPNOTSUPP;
>> +                                       break;
>> +                               }
>> +                       }
>> +               } else {
>> +                       ret = pret < 0 ? pret : -EFAULT;
>> +               }
>> +               up_write(&current->mm->mmap_sem);
> [...]
>> +}
> [...]
>> diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
>> index 39ad98c09c58..c7b5f86b91a1 100644
>> --- a/include/linux/sched/user.h
>> +++ b/include/linux/sched/user.h
>> @@ -40,7 +40,7 @@ struct user_struct {
>>         kuid_t uid;
>>
>>  #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
>> -    defined(CONFIG_NET)
>> +    defined(CONFIG_NET) || defined(CONFIG_IO_URING)
>>         atomic_long_t locked_vm;
>>  #endif
> 
> You're already using locked_vm in patch 5, right? I think that means
> that from patch 5 up to this patch, some kernel configs will fail to
> build.

Good point, I need to do this earlier now.

-- 
Jens Axboe

