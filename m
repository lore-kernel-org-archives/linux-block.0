Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34926 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbdFLSOu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2017 14:14:50 -0400
Date: Mon, 12 Jun 2017 14:14:47 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 02/11] kernfs: use idr instead of ida to manage inode
 number
Message-ID: <20170612181447.GG19206@htj.duckdns.org>
References: <cover.1496432591.git.shli@fb.com>
 <fc7029252137a4b151857d1d66843ad20c6e85b6.1496432591.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fc7029252137a4b151857d1d66843ad20c6e85b6.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Fri, Jun 02, 2017 at 02:53:55PM -0700, Shaohua Li wrote:
> @@ -630,7 +633,11 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  	if (!kn)
>  		goto err_out1;
>  
> -	ret = ida_simple_get(&root->ino_ida, 1, 0, GFP_KERNEL);
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&kernfs_idr_lock);
> +	ret = idr_alloc(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
> +	spin_unlock(&kernfs_idr_lock);
> +	idr_preload_end();

So, this ends up populating the idr w/ a kn which isn't fully
initialized yet, which can lead to bugs which are difficult to hunt
down as we're gonna allow kn's to be looked up through ino / gen.  We
probably should allocate with NULL here and populate the actual
pointer with idr_replace() after the kn is fully initialized / online.

Thanks.

-- 
tejun
