Return-Path: <hare@suse.de>
Date: Tue, 10 Apr 2018 08:27:10 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, Bart.VanAssche@wdc.com, willy@infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/7] block: pass explicit gfp_t to get_request
Message-ID: <20180410082710.7a9ddeb9@pentland.suse.de>
In-Reply-To: <20180409153916.23901-5-hch@lst.de>
References: <20180409153916.23901-1-hch@lst.de>
	<20180409153916.23901-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Mon,  9 Apr 2018 17:39:13 +0200
Christoph Hellwig <hch@lst.de> wrote:

> blk_old_get_request already has it at hand, and in blk_queue_bio,
> which is the fast path, it is constant.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c          | 14 +++++++-------
>  drivers/scsi/scsi_error.c |  4 ----
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
