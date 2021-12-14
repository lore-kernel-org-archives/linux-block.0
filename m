Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD88C433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Dec 2021 15:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhLNPwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 10:52:25 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42386 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhLNPwZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 10:52:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3C2631F37C;
        Tue, 14 Dec 2021 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639497144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuAQFf4t6Y3pSN4N2pb0kSlv1NgO/kfpoqwSSv560Hw=;
        b=b0tkdpD+ZBwZUvI5ZKiRvZBk0y9XvnEaTa7qBWOZcpyZoBrIrwqij9YhEKUjE3EKOUfzlL
        /+3WUJgh1luT9f3C233FzHSlTi0LdKn4MA+kmxmxBzimvGJT5IjaGWlRzR1OlMX1YYPWBX
        g70SDhyZL0DXWjTGqreG0OwgpMOmKd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639497144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuAQFf4t6Y3pSN4N2pb0kSlv1NgO/kfpoqwSSv560Hw=;
        b=Eb9s0P4aG3dJ6Kf2zBgnOZwFTzt/MTDgHCLZOv6MVL2SZt2a1SjTAbNcj7JqHQzPeK+7ks
        uZaKqKYJr6BHmQBA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 2FAA7A3B85;
        Tue, 14 Dec 2021 15:52:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 05C3C1F2C7E; Tue, 14 Dec 2021 16:52:24 +0100 (CET)
Date:   Tue, 14 Dec 2021 16:52:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/11] block: move set_task_ioprio to blk-ioc.c
Message-ID: <20211214155223.GH14044@quack2.suse.cz>
References: <20211209063131.18537-1-hch@lst.de>
 <20211209063131.18537-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209063131.18537-8-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 09-12-21 07:31:27, Christoph Hellwig wrote:
> Keep set_task_ioprio with the other low-level code that accesses the
> io_context structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>


								Honza

> ---
>  block/blk-ioc.c           | 34 ++++++++++++++++++++++++++++++++--
>  block/ioprio.c            | 32 --------------------------------
>  include/linux/iocontext.h |  2 --
>  3 files changed, 32 insertions(+), 36 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index f98a29ee8f362..c25ce2f3eb191 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -8,6 +8,7 @@
>  #include <linux/bio.h>
>  #include <linux/blkdev.h>
>  #include <linux/slab.h>
> +#include <linux/security.h>
>  #include <linux/sched/task.h>
>  
>  #include "blk.h"
> @@ -280,8 +281,8 @@ static struct io_context *create_task_io_context(struct task_struct *task,
>   * This function always goes through task_lock() and it's better to use
>   * %current->io_context + get_io_context() for %current.
>   */
> -struct io_context *get_task_io_context(struct task_struct *task,
> -				       gfp_t gfp_flags, int node)
> +static struct io_context *get_task_io_context(struct task_struct *task,
> +		gfp_t gfp_flags, int node)
>  {
>  	struct io_context *ioc;
>  
> @@ -298,6 +299,35 @@ struct io_context *get_task_io_context(struct task_struct *task,
>  	return ioc;
>  }
>  
> +int set_task_ioprio(struct task_struct *task, int ioprio)
> +{
> +	int err;
> +	struct io_context *ioc;
> +	const struct cred *cred = current_cred(), *tcred;
> +
> +	rcu_read_lock();
> +	tcred = __task_cred(task);
> +	if (!uid_eq(tcred->uid, cred->euid) &&
> +	    !uid_eq(tcred->uid, cred->uid) && !capable(CAP_SYS_NICE)) {
> +		rcu_read_unlock();
> +		return -EPERM;
> +	}
> +	rcu_read_unlock();
> +
> +	err = security_task_setioprio(task, ioprio);
> +	if (err)
> +		return err;
> +
> +	ioc = get_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
> +	if (ioc) {
> +		ioc->ioprio = ioprio;
> +		put_io_context(ioc);
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(set_task_ioprio);
> +
>  int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
>  {
>  	struct io_context *ioc = current->io_context;
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 313c14a70bbd3..e118f4bf2dc65 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -22,46 +22,14 @@
>   */
>  #include <linux/gfp.h>
>  #include <linux/kernel.h>
> -#include <linux/export.h>
>  #include <linux/ioprio.h>
>  #include <linux/cred.h>
>  #include <linux/blkdev.h>
>  #include <linux/capability.h>
> -#include <linux/sched/user.h>
> -#include <linux/sched/task.h>
>  #include <linux/syscalls.h>
>  #include <linux/security.h>
>  #include <linux/pid_namespace.h>
>  
> -int set_task_ioprio(struct task_struct *task, int ioprio)
> -{
> -	int err;
> -	struct io_context *ioc;
> -	const struct cred *cred = current_cred(), *tcred;
> -
> -	rcu_read_lock();
> -	tcred = __task_cred(task);
> -	if (!uid_eq(tcred->uid, cred->euid) &&
> -	    !uid_eq(tcred->uid, cred->uid) && !capable(CAP_SYS_NICE)) {
> -		rcu_read_unlock();
> -		return -EPERM;
> -	}
> -	rcu_read_unlock();
> -
> -	err = security_task_setioprio(task, ioprio);
> -	if (err)
> -		return err;
> -
> -	ioc = get_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
> -	if (ioc) {
> -		ioc->ioprio = ioprio;
> -		put_io_context(ioc);
> -	}
> -
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(set_task_ioprio);
> -
>  int ioprio_check_cap(int ioprio)
>  {
>  	int class = IOPRIO_PRIO_CLASS(ioprio);
> diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
> index 82c7f4f5f4f59..648331f35fc66 100644
> --- a/include/linux/iocontext.h
> +++ b/include/linux/iocontext.h
> @@ -116,8 +116,6 @@ struct task_struct;
>  #ifdef CONFIG_BLOCK
>  void put_io_context(struct io_context *ioc);
>  void exit_io_context(struct task_struct *task);
> -struct io_context *get_task_io_context(struct task_struct *task,
> -				       gfp_t gfp_flags, int node);
>  int __copy_io(unsigned long clone_flags, struct task_struct *tsk);
>  static inline int copy_io(unsigned long clone_flags, struct task_struct *tsk)
>  {
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
