Return-Path: <hch@lst.de>
Date: Tue, 27 Feb 2018 01:09:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hou Tao <houtao1@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] genhd: Fix leaked module reference for NVME devices
Message-ID: <20180227000948.GA5249@lst.de>
References: <20180226120142.25786-1-jack@suse.cz> <20180226120142.25786-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180226120142.25786-2-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 26, 2018 at 01:01:37PM +0100, Jan Kara wrote:
> Commit 8ddcd653257c "block: introduce GENHD_FL_HIDDEN" added handling of
> hidden devices to get_gendisk() but forgot to drop module reference
> which is also acquired by get_disk(). Drop the reference as necessary.
> 
> Arguably the function naming here is misleading as put_disk() is *not*
> the counterpart of get_disk() but let's fix that in the follow up
> commit since that will be more intrusive.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
