Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 1 Sep 2017 07:07:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Shaohua Li <shli@fb.com>,
	linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernfs: checking for IS_ERR() instead of NULL
Message-ID: <20170901050730.GA2584@kroah.com>
References: <20170830140456.7n6sfogqb7mvjmrm@mwanda>
 <20170831165247.GA26219@kroah.com>
 <26406dc8-2bdc-7bd3-7cd9-7e63986a8769@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26406dc8-2bdc-7bd3-7cd9-7e63986a8769@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 31, 2017 at 01:56:40PM -0600, Jens Axboe wrote:
> On 08/31/2017 10:52 AM, Greg Kroah-Hartman wrote:
> > On Wed, Aug 30, 2017 at 05:04:56PM +0300, Dan Carpenter wrote:
> >> The kernfs_get_inode() returns NULL on error, it never returns error
> >> pointers.
> >>
> >> Fixes: aa8188253474 ("kernfs: add exportfs operations")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> Acked-by: Tejun Heo <tj@kernel.org>
> > 
> > Hm, I don't know what tree aa8188253474 is in, but it's not mine, so I
> > can't take this patch :(
> 
> It's in my tree, I'll take it. Can I add your
> acked/reviewed/whatever-by?

Yes:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
