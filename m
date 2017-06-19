Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34844 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbdFSS7N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 14:59:13 -0400
Date: Mon, 19 Jun 2017 14:59:05 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 03/12] kernfs: add an API to get kernfs node from
 inode number
Message-ID: <20170619185905.GH12062@htj.duckdns.org>
References: <cover.1497549993.git.shli@fb.com>
 <ceed6e695f009f707ed017a2438e7a2c7456af50.1497549993.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ceed6e695f009f707ed017a2438e7a2c7456af50.1497549993.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Thu, Jun 15, 2017 at 11:17:11AM -0700, Shaohua Li wrote:
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 33f711f..7a4f327 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -508,6 +508,10 @@ void kernfs_put(struct kernfs_node *kn)
>  	struct kernfs_node *parent;
>  	struct kernfs_root *root;
>  
> +	/*
> +	 * kernfs_node is freed with ->count 0, kernfs_find_and_get_node_by_ino
> +	 * depends on this to filter reused stale node
> +	 */
>  	if (!kn || !atomic_dec_and_test(&kn->count))
>  		return;
>  	root = kernfs_root(kn);
> @@ -649,6 +653,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  	kn->ino = ret;
>  	kn->generation = gen;
>  
> +	/* set ino first. */
> +	smp_mb__before_atomic();

Can you please note what this is paired with here too?

> +/*

/**

> + * kernfs_find_and_get_node_by_ino - get kernfs_node from inode number
> + * @root: the kernfs root
> + * @ino: inode number
> + *
> + * RETURNS:
> + * NULL on failure. Return a kernfs node with reference counter incremented
> + */
> +struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
> +						    unsigned int ino)
> +{
> +	struct kernfs_node *kn;
> +
> +	rcu_read_lock();
> +	kn = idr_find(&root->ino_idr, ino);
> +	if (!kn)
> +		goto out;
> +
> +	/*
> +	 * Since kernfs_node is freed in RCU, it's possible an old node for ino
> +	 * is freed, but reused before RCU grace period. But a freed node (see
> +	 * kernfs_put) or an incompletedly initialized node (see
> +	 * __kernfs_new_node) should have 'count' 0. We can use this fact to
> +	 * filter out such node.
> +	 */
> +	if (!atomic_inc_not_zero(&kn->count)) {
> +		kn = NULL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * The node could be a new node or a reused node. If it's a new node,
> +	 * we are ok. If it's reused because of RCU, the __kernfs_new_node
> +	 * always sets its 'ino' before 'count'. So if 'count' is uptodate,
> +	 * 'ino' should be uptodate, hence we can use 'ino' to filter stale
> +	 * node.
> +	 */

Maybe refer to SLAB_TYPESAFE_BY_RCU?  I still have a lingering sense
that we're overdoing the synchronization here.  I'm not sure this path
needs this level of sophisticated optimization.

> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index d5b149a..343dfeb 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -332,5 +332,7 @@ void __init kernfs_init(void)
>  {
>  	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
>  					      sizeof(struct kernfs_node),
> -					      0, SLAB_PANIC, NULL);
> +					      0,
> +					      SLAB_PANIC | SLAB_TYPESAFE_BY_RCU,
> +					      NULL);

Please point to the usage in kernfs_find_and_get_node_by_ino() here.

Thanks.

-- 
tejun
