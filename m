Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33613 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbdFLSUb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2017 14:20:31 -0400
Date: Mon, 12 Jun 2017 14:20:28 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 03/11] kernfs: add an API to get kernfs node from inode
 number
Message-ID: <20170612182028.GH19206@htj.duckdns.org>
References: <cover.1496432591.git.shli@fb.com>
 <41d336f7006d63c6dd5bddf407c16de8064debc3.1496432591.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41d336f7006d63c6dd5bddf407c16de8064debc3.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Fri, Jun 02, 2017 at 02:53:56PM -0700, Shaohua Li wrote:
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -643,6 +643,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  	kn->ino = ret;
>  	kn->generation = atomic_inc_return(&root->next_generation);
>  
> +	/* set ino first. Above atomic_inc_return has a barrier */
>  	atomic_set(&kn->count, 1);
>  	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
>  	RB_CLEAR_NODE(&kn->rb);

Ah, you filter not-fully-alive ones here w/ kn->count.  Hmm... this
definitely can use more documentation including what this is paired
with (the inc_not_zero in kernfs_get_node_by_ino()) and why we need
this.

> +/*
> + * kernfs_get_node_by_ino - get kernfs_node from inode number
> + * @root: the kernfs root
> + * @ino: inode number
> + *
> + * RETURNS:
> + * NULL on failure. Return a kernfs node with reference counter incremented
> + */
> +struct kernfs_node *kernfs_get_node_by_ino(struct kernfs_root *root,
> +					   unsigned int ino)
> +{
> +	struct kernfs_node *kn;
> +
> +	rcu_read_lock();
> +	kn = idr_find(&root->ino_idr, ino);
> +	if (!kn)
> +		goto out;
> +	/* kernfs_put removes the ino after count is 0 */
> +	if (!atomic_inc_not_zero(&kn->count)) {
> +		kn = NULL;
> +		goto out;
> +	}
> +	/* If this node is reused, __kernfs_new_node sets ino before count */
> +	if (kn->ino != ino)
> +		goto out;
> +	rcu_read_unlock();
> +
> +	return kn;
> +out:
> +	rcu_read_unlock();
> +	kernfs_put(kn);
> +	return NULL;
> +}

Yeah, I think this should work.  I think we could have gone with
dumber "use the same lock for lookup" but this isn't too complicated
either and has obvious scalability benefits.  That said, let's please
be more verbose on how the two paths interlock with each other.

Thanks.

-- 
tejun
