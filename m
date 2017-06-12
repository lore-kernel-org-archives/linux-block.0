Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34714 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbdFLS3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2017 14:29:33 -0400
Date: Mon, 12 Jun 2017 14:29:31 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 04/11] kernfs: don't set dentry->d_fsdata
Message-ID: <20170612182931.GI19206@htj.duckdns.org>
References: <cover.1496432591.git.shli@fb.com>
 <fbb39a1220cf88687ed3a05f4cd4ad7ed56ffdf0.1496432591.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fbb39a1220cf88687ed3a05f4cd4ad7ed56ffdf0.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Fri, Jun 02, 2017 at 02:53:57PM -0700, Shaohua Li wrote:
> @@ -570,7 +570,8 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>  		goto out_bad;
>  
>  	/* The kernfs node has been moved? */
> -	if (dentry->d_parent->d_fsdata != kn->parent)
> +	if (d_really_is_negative(dentry->d_parent) ||
> +	    kernfs_dentry_node(dentry->d_parent) != kn->parent)
>  		goto out_bad;

Can we move d_really_is_negative() into kernfs_dentry_node()?  That
might add an additional NULL test to some paths but I don't think that
will ever show up anywhere.

> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 3534cfe..82e11fa 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -70,6 +70,8 @@ struct kernfs_super_info {
>  };
>  #define kernfs_info(SB) ((struct kernfs_super_info *)(SB->s_fs_info))
>  
> +#define kernfs_dentry_node(d)  ((d_inode(d))->i_private)

I know the prev one is a macro but let's make the new one an inline
function.

Thnaks.

-- 
tejun
