Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11109C4360F
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 22:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA5E2075A
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 22:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Jk7wevYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfBVW3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:29:33 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36268 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfBVW3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 17:29:32 -0500
Received: by mail-it1-f194.google.com with SMTP id h6so5582834itl.1
        for <linux-block@vger.kernel.org>; Fri, 22 Feb 2019 14:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vi0zkJlaJFz5yzp6ogp6zd3IbAWAkX2/ndYIQ+kXqQM=;
        b=Jk7wevYQzIM0YSIqRzXb4NN3hkAiWQ0i1l9jDwfBtcdKmm+VFQ8uSrbLuZEQuNLP+Q
         QBMOi3MiLDWgQkLyxKcI6i/lKvnz2vmAjDZCVsO55QUjYT4977EZQcb2TgwHdlAcyr2j
         57Im5ykgpkgvIqPxbWNjpgosTAHaCAwDc3c6KzcMsREfkfomWITey8z2+FDVO7g/qc62
         aEKq33Z91+IfC/nIbyf7MctS+PAjKxs9Rx6h9Q8Z5a9ju8wOX1VpwXv61EvzHY59L91u
         0A/WG3Kc9lASnu8yYI1PSiHiQf9JTYD7WWQUM71O5vrK0KmiOa9LedULjxeMUIxRSlqz
         v7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vi0zkJlaJFz5yzp6ogp6zd3IbAWAkX2/ndYIQ+kXqQM=;
        b=asmKGrB7z+DhqYbzVgUcfTjE//88A513eFmf2IprHWWPFkR9y4eFNhfTmgY1EykyQR
         wU/zTmK0LXrm/bvfBB2Y7IhU+bwfz36DfCDor2Vylxg0/yIQneMdIBn6By6lGt83rOI8
         7fuW0WJxXqHm6fUh2TyGLi/aNH/GkM2RE2ZHXta8hx3nfxlazehNu/AayWy0MFjGmfvv
         NT8O25XbH/y84I5futyBGNVtEnJM2MWSh3KljWQxDWcCAtjgCnlq5ReWDoBuifuSABEQ
         zN5n+1T1m7YTm8Bh8GiEm0bkMVr2KHYaTRcIuKGfvuFHlu1rhQzIJvr/JB+dKx6hfEC8
         rb7A==
X-Gm-Message-State: AHQUAuYK3a7QkBTBhov35yvpEtSTIohTGCgt+nvmz8j/MXh2Y/zrhGgc
        GyEzXsJY1HPNYEGQrGG84X4oAQ==
X-Google-Smtp-Source: AHgI3IbRR4gmafqsFFgbmCWzXaossauy7Q/aC+fwsbBz6EdhDwFs1+G1RByW9pTy43iS0xvoyuGojQ==
X-Received: by 2002:a05:6638:1a4:: with SMTP id b4mr3733852jaq.81.1550874571422;
        Fri, 22 Feb 2019 14:29:31 -0800 (PST)
Received: from [172.19.131.32] ([8.46.76.24])
        by smtp.gmail.com with ESMTPSA id v202sm1340099ita.13.2019.02.22.14.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:29:30 -0800 (PST)
Subject: Re: [PATCH 14/19] io_uring: add file set registration
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190211190049.7888-1-axboe@kernel.dk>
 <20190211190049.7888-16-axboe@kernel.dk>
 <CAG48ez25XYh1-SRw7HG-RXOz9xVZ0EXCumT_Csw0ER62K4Q1qw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ebdd373d-41df-a8c4-9943-37f036d4504f@kernel.dk>
Date:   Fri, 22 Feb 2019 15:29:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez25XYh1-SRw7HG-RXOz9xVZ0EXCumT_Csw0ER62K4Q1qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/19/19 9:12 AM, Jann Horn wrote:
> On Mon, Feb 11, 2019 at 8:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>> We normally have to fget/fput for each IO we do on a file. Even with
>> the batching we do, the cost of the atomic inc/dec of the file usage
>> count adds up.
>>
>> This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
>> for the io_uring_register(2) system call. The arguments passed in must
>> be an array of __s32 holding file descriptors, and nr_args should hold
>> the number of file descriptors the application wishes to pin for the
>> duration of the io_uring instance (or until IORING_UNREGISTER_FILES is
>> called).
>>
>> When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
>> member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
>> to the index in the array passed in to IORING_REGISTER_FILES.
>>
>> Files are automatically unregistered when the io_uring instance is torn
>> down. An application need only unregister if it wishes to register a new
>> set of fds.
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
> [...]
>> @@ -1335,6 +1379,161 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>>         return READ_ONCE(ring->r.head) == READ_ONCE(ring->r.tail) ? ret : 0;
>>  }
>>
>> +static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
>> +{
>> +#if defined(CONFIG_UNIX)
>> +       if (ctx->ring_sock) {
>> +               struct sock *sock = ctx->ring_sock->sk;
>> +               struct sk_buff *skb;
>> +
>> +               while ((skb = skb_dequeue(&sock->sk_receive_queue)) != NULL)
>> +                       kfree_skb(skb);
>> +       }
>> +#else
>> +       int i;
>> +
>> +       for (i = 0; i < ctx->nr_user_files; i++)
>> +               fput(ctx->user_files[i]);
>> +#endif
>> +}
>> +
>> +static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
>> +{
>> +       if (!ctx->user_files)
>> +               return -ENXIO;
>> +
>> +       __io_sqe_files_unregister(ctx);
>> +       kfree(ctx->user_files);
>> +       ctx->user_files = NULL;
>> +       return 0;
>> +}
>> +
>> +#if defined(CONFIG_UNIX)
>> +/*
>> + * Ensure the UNIX gc is aware of our file set, so we are certain that
>> + * the io_uring can be safely unregistered on process exit, even if we have
>> + * loops in the file referencing.
>> + */
> 
> I still don't get how this is supposed to work. Quoting from an
> earlier version of the patch:
> 
> |> I think the overall concept here is still broken: You're giving the
> |> user_files to the GC, and I think the GC can drop their refcounts, but
> |> I don't see you actually getting feedback from the GC anywhere that
> |> would let the GC break your references? E.g. in io_prep_rw() you grab
> |> file pointers from ctx->user_files after simply checking
> |> ctx->nr_user_files, and there is no path from the GC that touches
> |> those fields. As far as I can tell, the GC is just going to go through
> |> unix_destruct_scm() and drop references on your files, causing
> |> use-after-free.
> |>
> |> But the unix GC is complicated, and maybe I'm just missing something...
> |
> | Only when the skb is released, which is either done when the io_uring
> | is torn down (and then definitely safe), or if the socket is released,
> | which is again also at a safe time.
> 
> I'll try to add inline comments on my understanding of the code, maybe
> you can point out where exactly we're understanding it differently...
> 
>> +static int __io_sqe_files_scm(struct io_ring_ctx *ctx, int nr, int offset)
>> +{
>> +       struct sock *sk = ctx->ring_sock->sk;
>> +       struct scm_fp_list *fpl;
>> +       struct sk_buff *skb;
>> +       int i;
>> +
>> +       fpl = kzalloc(sizeof(*fpl), GFP_KERNEL);
>> +       if (!fpl)
>> +               return -ENOMEM;
>> +
>             // here we allocate a new `skb` with ->users==1
>> +       skb = alloc_skb(0, GFP_KERNEL);
>> +       if (!skb) {
>> +               kfree(fpl);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       skb->sk = sk;
>             // set the skb's destructor, invoked when ->users drops to 0;
>             // destructor drops file refcounts
>> +       skb->destructor = unix_destruct_scm;
>> +
>> +       fpl->user = get_uid(ctx->user);
>> +       for (i = 0; i < nr; i++) {
>                     // grab a reference to each file for the skb
>> +               fpl->fp[i] = get_file(ctx->user_files[i + offset]);
>> +               unix_inflight(fpl->user, fpl->fp[i]);
>> +       }
>> +
>> +       fpl->max = fpl->count = nr;
>> +       UNIXCB(skb).fp = fpl;
>> +       refcount_add(skb->truesize, &sk->sk_wmem_alloc);
>             // put the skb in the sk_receive_queue, still with a refcount of 1.
>> +       skb_queue_head(&sk->sk_receive_queue, skb);
>> +
>             // drop a reference from each file; after this, only the
> skb owns references to files;
>             // the ctx->user_files entries borrow their lifetime from the skb
>> +       for (i = 0; i < nr; i++)
>> +               fput(fpl->fp[i]);
>> +
>> +       return 0;
>> +}
> 
> So let's say you have a cyclic dependency where an io_uring points to
> a unix domain socket, and the unix domain socket points back at the
> uring. The last reference from outside the loop goes away when the
> user closes the uring's fd, but the uring's busypolling kernel thread
> is still running and busypolling for new submission queue entries.
> 
> The GC can then come along and run scan_inflight(), detect that
> ctx->ring_sock->sk->sk_receive_queue contains a reference to a unix
> domain socket, and steal the skb (unlinking it from the ring_sock and
> linking it into the hitlist):
> 
> __skb_unlink(skb, &x->sk_receive_queue);
> __skb_queue_tail(hitlist, skb);
> 
> And then the hitlist will be processed by __skb_queue_purge(),
> dropping the refcount of the skb from 1 to 0. At that point, the unix
> domain socket can be freed, and you still have a pointer to it in
> ctx->user_files.

I've fixed this for the sq offload case.

>> +
>> +/*
>> + * If UNIX sockets are enabled, fd passing can cause a reference cycle which
>> + * causes regular reference counting to break down. We rely on the UNIX
>> + * garbage collection to take care of this problem for us.
>> + */
>> +static int io_sqe_files_scm(struct io_ring_ctx *ctx)
>> +{
>> +       unsigned left, total;
>> +       int ret = 0;
>> +
>> +       total = 0;
>> +       left = ctx->nr_user_files;
>> +       while (left) {
>> +               unsigned this_files = min_t(unsigned, left, SCM_MAX_FD);
>> +               int ret;
>> +
>> +               ret = __io_sqe_files_scm(ctx, this_files, total);
>> +               if (ret)
>> +                       break;
> 
> If we bail out in the middle of translating the ->user_files here, we
> have to make sure that we both destroy the already-created SKBs and
> drop our references on the files we haven't dealt with yet.

Good catch, fixed.

>> +               left -= this_files;
>> +               total += this_files;
>> +       }
>> +
>> +       return ret;
>> +}
>> +#else
>> +static int io_sqe_files_scm(struct io_ring_ctx *ctx)
>> +{
>> +       return 0;
>> +}
>> +#endif
>> +
>> +static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
>> +                                unsigned nr_args)
>> +{
>> +       __s32 __user *fds = (__s32 __user *) arg;
>> +       int fd, ret = 0;
>> +       unsigned i;
>> +
>> +       if (ctx->user_files)
>> +               return -EBUSY;
>> +       if (!nr_args)
>> +               return -EINVAL;
>> +       if (nr_args > IORING_MAX_FIXED_FILES)
>> +               return -EMFILE;
>> +
>> +       ctx->user_files = kcalloc(nr_args, sizeof(struct file *), GFP_KERNEL);
>> +       if (!ctx->user_files)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < nr_args; i++) {
>> +               ret = -EFAULT;
>> +               if (copy_from_user(&fd, &fds[i], sizeof(fd)))
>> +                       break;
>> +
>> +               ctx->user_files[i] = fget(fd);
>> +
>> +               ret = -EBADF;
>> +               if (!ctx->user_files[i])
>> +                       break;
> 
> Let's say we hit this error condition after N successful loop
> iterations, on a kernel with CONFIG_UNIX. At that point, we've filled
> N file pointers into ctx->user_files[], and we've incremented
> ctx->nr_user_files up to N. Now we jump to the `if (ret)` branch,
> which goes into io_sqe_files_unregister(); but that's going to attempt
> to dequeue inflight files from ctx->ring_sock, so that's not going to
> work.

Fixed, thanks.

>> +               /*
>> +                * Don't allow io_uring instances to be registered. If UNIX
>> +                * isn't enabled, then this causes a reference cycle and this
>> +                * instance can never get freed. If UNIX is enabled we'll
>> +                * handle it just fine, but there's still no point in allowing
>> +                * a ring fd as it doesn't support regular read/write anyway.
>> +                */
>> +               if (ctx->user_files[i]->f_op == &io_uring_fops) {
>> +                       fput(ctx->user_files[i]);
>> +                       break;
>> +               }
>> +               ctx->nr_user_files++;
> 
> I don't see anything that can set ctx->nr_user_files back down to
> zero; as far as I can tell, if you repeatedly register and unregister
> a set of files, ctx->nr_user_files will just grow, and since it's used
> as an upper bound for array accesses, that's bad.

Fixed that one earlier.

-- 
Jens Axboe

