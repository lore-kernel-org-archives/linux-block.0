Return-Path: <hare@suse.de>
Date: Tue, 10 Apr 2018 08:27:45 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, Bart.VanAssche@wdc.com, willy@infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/7] block: use GFP_NOIO instead of __GFP_DIRECT_RECLAIM
Message-ID: <20180410082745.5b84ef48@pentland.suse.de>
In-Reply-To: <20180409153916.23901-6-hch@lst.de>
References: <20180409153916.23901-1-hch@lst.de>
	<20180409153916.23901-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Mon,  9 Apr 2018 17:39:14 +0200
Christoph Hellwig <hch@lst.de> wrote:

> We just can't do I/O when doing block layer requests allocations,
> so use GFP_NOIO instead of the even more limited __GFP_DIRECT_RECLAIM.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
