Return-Path: <BATV+20fadfe1c4e01d3c2e43+5009+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 11 May 2017 00:40:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	sagi@grimberg.me, avi@scylladb.com, axboe@kernel.dk,
	linux-api@vger.kernel.org, willy@infradead.org,
	tom.leiming@gmail.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/8] Use RWF_* flags for AIO operations
Message-ID: <20170511074035.GA15626@infradead.org>
References: <20170509122219.31756-1-rgoldwyn@suse.de>
 <20170509122219.31756-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170509122219.31756-2-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

Please add subsystem prefixes to your subject lines, e.g.

fs:

for all the generic fs ones,

xfs:

for XFS,

block:

for block layer changes, etc.

>  
> -	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC))
> -		return -EOPNOTSUPP;
> -
>  	init_sync_kiocb(&kiocb, filp);
> -	if (flags & RWF_HIPRI)
> -		kiocb.ki_flags |= IOCB_HIPRI;
> -	if (flags & RWF_DSYNC)
> -		kiocb.ki_flags |= IOCB_DSYNC;
> -	if (flags & RWF_SYNC)
> -		kiocb.ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> +	ret = kiocb_set_rw_flags(&kiocb, flags);
> +	if (ret)
> +		return ret;

And please split factoring out kiocb_set_rw_flags into a separate
prep patch.

Otherwise these changes look fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
