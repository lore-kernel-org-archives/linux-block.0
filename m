Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF8CC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 12:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7631D217D8
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 12:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXvrkttb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBHMRj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:17:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45774 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfBHMRj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 07:17:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id q15so3285515wro.12;
        Fri, 08 Feb 2019 04:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LlNwNAmhKe08G1jsa/QsMcBi+Gu/c39Dm2m2kCz6zWE=;
        b=JXvrkttb0tMewAF0OEzpZGl+x9EcRpdf3DfXAT5KNCXWP+LGBHtBNFC/gz65BLo9vR
         9Y7Ra9KhjiAFAGPTmkecW94dOczdMC9as+yLu+CMfhAcu5JXdywcLCMQzLNHcOaRjyQT
         an50cD8X/gF2WcN5bsJ3Rmsl1EWa5Ow+2n8WCZHp6M6rUWvIQGvvaSSlr/tc05DDHMM+
         rYNjNaY7htLwOwuVY4z3xJucqCS8lyy3XG4WnGohGpgfoXG1JchZ3BFnzxjTYUHS05r7
         H1xV7UqjQVLxjM1YeazZn5t1kYN8Ct5KN239MSIEIAIjPS6+24FheEf5xlRcZifSN6zS
         v3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LlNwNAmhKe08G1jsa/QsMcBi+Gu/c39Dm2m2kCz6zWE=;
        b=P6Fkqq7tsJgEyjfFNH+nAo00JnTGP4VWl+z/wOA9LtlxQ2adgXR5ITipzIwdZGF1vS
         BdbkdAmc/lJzncmu+5uJTL2BSTGFl36bCac9ojcA1Nux5OOEZdA/Md0jI14pdR40cvzi
         wZb738YERGixbJ5yJflA1nGzoRfocIWCygZIEbspHbC/2+tRbMuvzkQpE9MnhR4pQMbE
         BaQQ7w50zS5Wf5ik7b8jIohIZTU6pcbcorrJ2KhnfREgQKFsXeuiMhHOKjuPMYRnQ9sU
         hhTRUfIlmAo1AWodvIZ7KO6uVd5Y/xMjNh0cAewY9zb/H9QN4GUX85sHOgof2J4N41P6
         bXIA==
X-Gm-Message-State: AHQUAubofiS95+04GVIVebTcxhHwyozb6DF4yRmR6ELWyyY2y+Y0+HqV
        rgCTJ9jrpN0nLXnW5S5KuHM=
X-Google-Smtp-Source: AHgI3IbAATaRdBxGmRC2NVbhPdSN6gP3UNvldvSbVL8qm8BUbhVQk/w/0HFMi305Jdn+uEbxEXNqTw==
X-Received: by 2002:a5d:4d11:: with SMTP id z17mr15723668wrt.209.1549628257037;
        Fri, 08 Feb 2019 04:17:37 -0800 (PST)
Received: from [172.16.8.139] (host-89-243-172-104.as13285.net. [89.243.172.104])
        by smtp.gmail.com with ESMTPSA id w3sm2294482wru.20.2019.02.08.04.17.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 04:17:36 -0800 (PST)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190207195552.22770-1-axboe@kernel.dk>
 <20190207195552.22770-14-axboe@kernel.dk>
Message-ID: <bfd383aa-24fb-35ae-eef5-545ab0f493c7@gmail.com>
Date:   Fri, 8 Feb 2019 12:17:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207195552.22770-14-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/02/2019 19:55, Jens Axboe wrote:
> We normally have to fget/fput for each IO we do on a file. Even with
> the batching we do, the cost of the atomic inc/dec of the file usage
> count adds up.
>
> This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
> for the io_uring_register(2) system call. The arguments passed in must
> be an array of __s32 holding file descriptors, and nr_args should hold
> the number of file descriptors the application wishes to pin for the
> duration of the io_uring context (or until IORING_UNREGISTER_FILES is
> called).
>
> When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
> member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
> to the index in the array passed in to IORING_REGISTER_FILES.
>
> Files are automatically unregistered when the io_uring context is
> torn down. An application need only unregister if it wishes to
> register a new set of fds.
>
> Signed-off-by: Jens Axboe<axboe@kernel.dk>
> ---
>   fs/io_uring.c                 | 207 +++++++++++++++++++++++++++++-----
>   include/net/af_unix.h         |   1 +
>   include/uapi/linux/io_uring.h |   9 +-
>   net/unix/af_unix.c            |   2 +-
>   4 files changed, 188 insertions(+), 31 deletions(-)
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 9d6233dc35ca..f2550efec60d 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -29,6 +29,7 @@
>   #include <linux/net.h>
>   #include <net/sock.h>
>   #include <net/af_unix.h>
> +#include <net/scm.h>
>   #include <linux/anon_inodes.h>
>   #include <linux/sched/mm.h>
>   #include <linux/uaccess.h>
> @@ -101,6 +102,13 @@ struct io_ring_ctx {
>   		struct fasync_struct	*cq_fasync;
>   	} ____cacheline_aligned_in_smp;
>   
> +	/*
> +	 * If used, fixed file set. Writers must ensure that ->refs is dead,
> +	 * readers must ensure that ->refs is alive as long as the file* is
> +	 * used. Only updated through io_uring_register(2).
> +	 */
> +	struct scm_fp_list	*user_files;
> +
>   	/* if used, fixed mapped user buffers */
>   	unsigned		nr_user_bufs;
>   	struct io_mapped_ubuf	*user_bufs;
> @@ -148,6 +156,7 @@ struct io_kiocb {
>   	unsigned int		flags;
>   #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
>   #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
> +#define REQ_F_FIXED_FILE	4	/* ctx owns file */
>   	u64			user_data;
>   	u64			error;
>   

> +static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
> +{
> +#if defined(CONFIG_NET)
> +	if (ctx->ring_sock) {
> +		struct sock *sock = ctx->ring_sock->sk;
> +		struct sk_buff *skb;
> +
> +		while ((skb = skb_dequeue(&sock->sk_receive_queue)) != NULL)
> +			kfree_skb(skb);
> +	}
> +#else
> +	int i;
> +
> +	for (i = 0; i < ctx->user_files->count; i++)
> +		fput(ctx->user_files->fp[i]);
> +
> +	kfree(ctx->user_files);
> +#endif
> +}
> +
> +static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
> +{
> +	if (!ctx->user_files)
> +		return -ENXIO;
> +
> +	__io_sqe_files_unregister(ctx);
> +	ctx->user_files = NULL;
> +	return 0;
> +}
> +
> +static int io_sqe_files_scm(struct io_ring_ctx *ctx)
> +{
> +#if defined(CONFIG_NET)
> +	struct scm_fp_list *fpl = ctx->user_files;
> +	struct sk_buff *skb;
> +	int i;
> +
> +	skb =  __alloc_skb(0, GFP_KERNEL, 0, NUMA_NO_NODE);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	skb->sk = ctx->ring_sock->sk;
> +	skb->destructor = unix_destruct_scm;
> +
> +	fpl->user = get_uid(ctx->user);
> +	for (i = 0; i < fpl->count; i++) {
> +		get_file(fpl->fp[i]);
> +		unix_inflight(fpl->user, fpl->fp[i]);
> +		fput(fpl->fp[i]);
> +	}
> +
> +	UNIXCB(skb).fp = fpl;
> +	skb_queue_head(&ctx->ring_sock->sk->sk_receive_queue, skb);

This code sounds elegant if you know about the existence of unix_gc(), 
but quite mysterious if you don't.  (E.g. why "inflight"?)  Could we 
have a brief comment, to comfort mortal readers on their journey?

/* A message on a unix socket can hold a reference to a file. This can 
cause a reference cycle. So there is a garbage collector for unix 
sockets, which we hook into here. */

I think this is bypassing too_many_unix_fds() though?  I understood that 
was intended to bound kernel memory allocation, at least in principle.

> +#endif

Also, this code relies on CONFIG_NET.  To handle the case where 
CONFIG_NET is not enabled, don't you still need to forbid registering an 
io_uring fd ?

> +	return 0;
> +}
> +
> +static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
> +				 unsigned nr_args)
> +{
> +	__s32 __user *fds = (__s32 __user *) arg;
> +	struct scm_fp_list *fpl;
> +	int fd, ret = 0;
> +	unsigned i;
> +
> +	if (ctx->user_files)
> +		return -EBUSY;
> +	if (!nr_args || nr_args > SCM_MAX_FD)
> +		return -EINVAL;
> +
> +	fpl = kzalloc(sizeof(*ctx->user_files), GFP_KERNEL);
> +	if (!fpl)
> +		return -ENOMEM;
> +	fpl->max = nr_args;
> +
> +	for (i = 0; i < nr_args; i++) {
> +		ret = -EFAULT;
> +		if (copy_from_user(&fd, &fds[i], sizeof(fd)))
> +			break;
> +
> +		fpl->fp[i] = fget(fd);
> +
> +		ret = -EBADF;
> +		if (!fpl->fp[i])
> +			break;
> +		fpl->count++;
> +		ret = 0;
> +	}
> +
> +	ctx->user_files = fpl;
> +	if (!ret)
> +		ret = io_sqe_files_scm(ctx);
> +	if (ret)
> +		io_sqe_files_unregister(ctx);
> +
> +	return ret;
> +}
> +
>   static int io_sq_offload_start(struct io_ring_ctx *ctx)
>   {
>   	int ret;
> @@ -1520,14 +1658,16 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
>   		destroy_workqueue(ctx->sqo_wq);
>   	if (ctx->sqo_mm)
>   		mmdrop(ctx->sqo_mm);
> +
> +	io_iopoll_reap_events(ctx);
> +	io_sqe_buffer_unregister(ctx);
> +	io_sqe_files_unregister(ctx);
> +
>   #if defined(CONFIG_NET)
>   	if (ctx->ring_sock)
>   		sock_release(ctx->ring_sock);
>   #endif
>   
> -	io_iopoll_reap_events(ctx);
> -	io_sqe_buffer_unregister(ctx);
> -
>   	io_mem_free(ctx->sq_ring);
>   	io_mem_free(ctx->sq_sqes);
>   	io_mem_free(ctx->cq_ring);
> @@ -1885,6 +2025,15 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
>   			break;
>   		ret = io_sqe_buffer_unregister(ctx);
>   		break;
> +	case IORING_REGISTER_FILES:
> +		ret = io_sqe_files_register(ctx, arg, nr_args);
> +		break;
> +	case IORING_UNREGISTER_FILES:
> +		ret = -EINVAL;
> +		if (arg || nr_args)
> +			break;
> +		ret = io_sqe_files_unregister(ctx);
> +		break;
>   	default:
>   		ret = -EINVAL;
>   		break;
