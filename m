Return-Path: <hch@lst.de>
Date: Tue, 14 Jun 2016 15:43:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, mst@redhat.com, ooo@electrozaur.com,
	bhalevy@primarydata.com, nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/7] block: ensure bios return from blk_get_request are
	properly initialized
Message-ID: <20160614134312.GA28373@lst.de>
References: <1465831278-23653-1-git-send-email-hch@lst.de> <1465831278-23653-4-git-send-email-hch@lst.de> <575F6942.5060406@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <575F6942.5060406@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 13, 2016 at 08:17:38PM -0600, Jens Axboe wrote:
> It may be awkward, but we have those to avoid doing things like this:
>
> +	rq->__data_len = 0;
> +	rq->__sector = (sector_t) -1;
> +	rq->bio = rq->biotail = NULL;
> +	memset(rq->__cmd, 0, sizeof(rq->__cmd));
>
> for every request we allocate, when we don't use ->cmd at all. Honest, I'd 
> rather have
>
> struct request *blk_get_pc_request();
>
> and similar helpers around this, so we don't have to do extra 
> initialization when we don't need it.

I'm working on resurrecting my patch to remove rq->cmd and friends from
the common request structure, but the full patch is something I'd rather
do after the initial NVMe over Fabrics merge.  If you're fine with the
rest of the series I'll respin it to keep blk_set_block_pc for now which
will only do the zeroing and setting cmd_type.
