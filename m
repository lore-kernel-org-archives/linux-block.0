Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34541 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdFSTHk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 15:07:40 -0400
Date: Mon, 19 Jun 2017 15:07:33 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 06/12] kernfs: add exportfs operations
Message-ID: <20170619190733.GK12062@htj.duckdns.org>
References: <cover.1497549993.git.shli@fb.com>
 <7051f2ab31a2e970efd64817f2a579634cc5b915.1497549993.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7051f2ab31a2e970efd64817f2a579634cc5b915.1497549993.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Thu, Jun 15, 2017 at 11:17:14AM -0700, Shaohua Li wrote:
> -static int kernfs_fill_super(struct super_block *sb, unsigned long magic)
> +static int kernfs_fill_super(struct super_block *sb, unsigned long magic,
> +			     bool enable_expop)

Hmm... can't we make this a KERNFS_ROOT_* flag?

> @@ -229,7 +287,8 @@ const void *kernfs_super_ns(struct super_block *sb)
>   */
>  struct dentry *kernfs_mount_ns(struct file_system_type *fs_type, int flags,
>  				struct kernfs_root *root, unsigned long magic,
> -				bool *new_sb_created, const void *ns)
> +				bool *new_sb_created, const void *ns,
> +				bool enable_expop)

Ditto for other cases too.

> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -97,6 +97,7 @@ struct kernfs_elem_attr {
>  
>  /* represent a kernfs node */
>  struct kernfs_node_id {
> +	/* the layout must match 'struct fid' */
>  	u32			ino;
>  	u32			generation;
>  } __attribute__((packed));

Can we make it a union between struct fid and u64?

Thanks.

-- 
tejun
