Return-Path: <prvs=2769e1f82=roger.pau@citrix.com>
Date: Thu, 20 Apr 2017 11:00:12 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: NeilBrown <neilb@suse.com>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 08/11] xen-blkfront: remove bio splitting.
Message-ID: <20170420100012.5v7yx3st5cxhrgdx@dhcp-3-128.uk.xensource.com>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672984.27388.11947154313852245586.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <149266672984.27388.11947154313852245586.stgit@noble>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20, 2017 at 03:38:50PM +1000, NeilBrown wrote:
> bios that are re-submitted will pass through blk_queue_split() when
> blk_queue_bio() is called, and this will split the bio if necessary.
> There is no longer any need to do this splitting in xen-blkfront.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Acked-by: Roger Pau Monn� <roger.pau@citrix.com>

> ---
>  drivers/block/xen-blkfront.c |   54 ++----------------------------------------
>  1 file changed, 3 insertions(+), 51 deletions(-)

Nice!
