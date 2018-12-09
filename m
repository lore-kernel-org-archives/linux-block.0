Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DE7C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4952081C
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 10:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="Rds73aYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4952081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeLIKMy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 05:12:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55634 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLIKMy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 05:12:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so8074310wmc.5
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1UwUS2+ImrloBXJXCi+0pVit+wzGO1fzghUWK0hNBu4=;
        b=Rds73aYxcLnjjG2eToY9VNPsnNtGwcD0/RAUN7+ef8uZeAoI2Kjdy5UuUPzo3tBzoi
         O5+i7ZAK2G1ElHs0f53dj2Wz+LgYks0O5K90u9rGNdIVhFeMGmaraDc4D2I5MQGR85tP
         +7TKpvBJ8i8ptaLxbBy8pO/bLXBmU4MO0Uxhly3Swnmk2Zxvl6stEvLcLR6yabPIaO3C
         9iJtoRrMMNLwv+oRFKBD1YWDAABc3st0rX1lrLlqpVgcl6IJGVy12ASFdHJPokhixGas
         DVWSsfts12l0O2eu7qDD9AWJzefkRZWJAXK3OUxi1Yyp0uB9waRiQCV0EqRiWbUWwRtc
         ULZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1UwUS2+ImrloBXJXCi+0pVit+wzGO1fzghUWK0hNBu4=;
        b=UQGYeScJpd/lalOyDd+Ri79H0zrqbJrYMjDffGKUkW9tLh4w51Qy5x3Lz3UZJw7jyg
         OM03yt/rd4mfVGGvUD119eyRnIICp3/PmyOGrBZEhGEHxQXFALJsHgZnSYGNQEfSb0rf
         ZoEz7VjF9KlYI3o/mPWnSLeXsG3GbhY8Kh7ld/jcz/yaK9GsYhKkimN7097UlA1aiasx
         99Ypr3NuOmu7BFKa6QzLVmC0hnkiwdnjGviSlAAnyPHXY3Bmy1AVnUo84P2bm7zadufb
         eJgUzuuDBLrqcQX8ktv/+ATPgJ5KUPDY8R1ZRNyqmBX4MgkGYzR1pMKJ/AxTkOSwl/h+
         fCew==
X-Gm-Message-State: AA+aEWZPAOqJs4SRaBTZgK5byxNPfRR65uTmvwYFY3nxaG8h69geWxSH
        0MIvJcaaP52KxBhNYJQVhqZeXg==
X-Google-Smtp-Source: AFSGD/X7E4MdpWMJxPtrzOzX5JIelBJHceIVmoWc6kAXBJWhTVBpMBrjJyV011juaGLgnT2aHKUEpA==
X-Received: by 2002:a1c:bb42:: with SMTP id l63mr6833436wmf.47.1544350371610;
        Sun, 09 Dec 2018 02:12:51 -0800 (PST)
Received: from bhalevy-lt (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id e142sm23749059wmf.46.2018.12.09.02.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 02:12:50 -0800 (PST)
Message-ID: <a3a53e7fad297a71149efd718f1fdaaf852c0f28.camel@scylladb.com>
Subject: Re: [PATCH 13/26] aio: add io_setup2() system call
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
Date:   Sun, 09 Dec 2018 12:12:49 +0200
In-Reply-To: <20181207222016.29387-14-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
         <20181207222016.29387-14-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2018-12-07 at 15:20 -0700, Jens Axboe wrote:
> This is just like io_setup(), except add a flags argument to let the
> caller control/define some of the io_context behavior.
> 
> Outside of the flags, we add an iocb array and two user pointers for
> future use.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  fs/aio.c                               | 69 ++++++++++++++++----------
>  include/linux/syscalls.h               |  3 ++
>  include/uapi/asm-generic/unistd.h      |  4 +-
>  kernel/sys_ni.c                        |  1 +
>  5 files changed, 52 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index f0b1709a5ffb..67c357225fb0 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -343,6 +343,7 @@
>  332	common	statx			__x64_sys_statx
>  333	common	io_pgetevents		__x64_sys_io_pgetevents
>  334	common	rseq			__x64_sys_rseq
> +335	common	io_setup2		__x64_sys_io_setup2
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/fs/aio.c b/fs/aio.c
> index 173f1f79dc8f..26631d6872d2 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -100,6 +100,8 @@ struct kioctx {
>  
>  	unsigned long		user_id;
>  
> +	unsigned int		flags;
> +
>  	struct __percpu kioctx_cpu *cpu;
>  
>  	/*
> @@ -686,10 +688,8 @@ static void aio_nr_sub(unsigned nr)
>  	spin_unlock(&aio_nr_lock);
>  }
>  
> -/* ioctx_alloc
> - *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
> - */
> -static struct kioctx *ioctx_alloc(unsigned nr_events)
> +static struct kioctx *io_setup_flags(unsigned long ctxid,
> +				     unsigned int nr_events, unsigned int flags)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct kioctx *ctx;
> @@ -701,6 +701,12 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
>  	 */
>  	unsigned int max_reqs = nr_events;
>  
> +	if (unlikely(ctxid || nr_events == 0)) {
> +		pr_debug("EINVAL: ctx %lu nr_events %u\n",
> +		         ctxid, nr_events);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	/*
>  	 * We keep track of the number of available ringbuffer slots, to prevent
>  	 * overflow (reqs_available), and we also use percpu counters for this.
> @@ -726,6 +732,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
>  	if (!ctx)
>  		return ERR_PTR(-ENOMEM);
>  
> +	ctx->flags = flags;
>  	ctx->max_reqs = max_reqs;
>  
>  	spin_lock_init(&ctx->ctx_lock);
> @@ -1281,6 +1288,34 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
>  	return ret;
>  }
>  

How about adding a comment similar to io_setup's below?

And would you like to mention also io_setup2 in
Documentation/sysctl/fs.txt?

> +SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
> +		iocbs, void __user *, user1, void __user *, user2,
> +		aio_context_t __user *, ctxp)
> +{
> +	struct kioctx *ioctx;
> +	unsigned long ctx;
> +	long ret;
> +
> +	if (flags || user1 || user2)
> +		return -EINVAL;
> +
> +	ret = get_user(ctx, ctxp);
> +	if (unlikely(ret))
> +		goto out;
> +
> +	ioctx = io_setup_flags(ctx, nr_events, flags);
> +	ret = PTR_ERR(ioctx);
> +	if (IS_ERR(ioctx))
> +		goto out;
> +
> +	ret = put_user(ioctx->user_id, ctxp);
> +	if (ret)
> +		kill_ioctx(current->mm, ioctx, NULL);
> +	percpu_ref_put(&ioctx->users);
> +out:
> +	return ret;
> +}
> +
>  /* sys_io_setup:
>   *	Create an aio_context capable of receiving at least nr_events.
>   *	ctxp must not point to an aio_context that already exists, and
> @@ -1296,7 +1331,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
>   */
>  SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
>  {
> -	struct kioctx *ioctx = NULL;
> +	struct kioctx *ioctx;
>  	unsigned long ctx;
>  	long ret;
>  
> @@ -1304,14 +1339,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
>  	if (unlikely(ret))
>  		goto out;
>  
> -	ret = -EINVAL;
> -	if (unlikely(ctx || nr_events == 0)) {
> -		pr_debug("EINVAL: ctx %lu nr_events %u\n",
> -		         ctx, nr_events);
> -		goto out;
> -	}
> -
> -	ioctx = ioctx_alloc(nr_events);
> +	ioctx = io_setup_flags(ctx, nr_events, 0);
>  	ret = PTR_ERR(ioctx);
>  	if (!IS_ERR(ioctx)) {
>  		ret = put_user(ioctx->user_id, ctxp);
> @@ -1327,7 +1355,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
>  {
> -	struct kioctx *ioctx = NULL;
> +	struct kioctx *ioctx;
>  	unsigned long ctx;
>  	long ret;
>  
> @@ -1335,23 +1363,14 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
>  	if (unlikely(ret))
>  		goto out;
>  
> -	ret = -EINVAL;
> -	if (unlikely(ctx || nr_events == 0)) {
> -		pr_debug("EINVAL: ctx %lu nr_events %u\n",
> -		         ctx, nr_events);
> -		goto out;
> -	}
> -
> -	ioctx = ioctx_alloc(nr_events);
> +	ioctx = io_setup_flags(ctx, nr_events, 0);
>  	ret = PTR_ERR(ioctx);
>  	if (!IS_ERR(ioctx)) {
> -		/* truncating is ok because it's a user address */
> -		ret = put_user((u32)ioctx->user_id, ctx32p);
> +		ret = put_user(ioctx->user_id, ctx32p);
>  		if (ret)
>  			kill_ioctx(current->mm, ioctx, NULL);
>  		percpu_ref_put(&ioctx->users);
>  	}
> -
>  out:
>  	return ret;
>  }
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 2ac3d13a915b..a20a663d583f 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -287,6 +287,9 @@ static inline void addr_limit_user_check(void)
>   */
>  #ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
>  asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t __user *ctx);
> +asmlinkage long sys_io_setup2(unsigned, unsigned, struct iocb __user *,
> +				void __user *, void __user *,
> +				aio_context_t __user *);
>  asmlinkage long sys_io_destroy(aio_context_t ctx);
>  asmlinkage long sys_io_submit(aio_context_t, long,
>  			struct iocb __user * __user *);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 538546edbfbd..b4527ed373b0 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -738,9 +738,11 @@ __SYSCALL(__NR_statx,     sys_statx)
>  __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
>  #define __NR_rseq 293
>  __SYSCALL(__NR_rseq, sys_rseq)
> +#define __NR_io_setup2 294
> +__SYSCALL(__NR_io_setup2, sys_io_setup2)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 294
> +#define __NR_syscalls 295
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index df556175be50..17c8b4393669 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -37,6 +37,7 @@ asmlinkage long sys_ni_syscall(void)
>   */
>  
>  COND_SYSCALL(io_setup);
> +COND_SYSCALL(io_setup2);
>  COND_SYSCALL_COMPAT(io_setup);
>  COND_SYSCALL(io_destroy);
>  COND_SYSCALL(io_submit);

