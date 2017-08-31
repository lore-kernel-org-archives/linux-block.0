Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 30 Aug 2017 17:39:17 -0700
From: Tejun Heo <tj@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernfs: checking for IS_ERR() instead of NULL
Message-ID: <20170831003917.GY491396@devbig577.frc2.facebook.com>
References: <20170830140456.7n6sfogqb7mvjmrm@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170830140456.7n6sfogqb7mvjmrm@mwanda>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 30, 2017 at 05:04:56PM +0300, Dan Carpenter wrote:
> The kernfs_get_inode() returns NULL on error, it never returns error
> pointers.
> 
> Fixes: aa8188253474 ("kernfs: add exportfs operations")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Tejun Heo <tj@kernel.org>

Greg, can you please route this patch?

Thanks.

-- 
tejun
