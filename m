Return-Path: <BATV+08041bc46d721c010659+4861+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 14 Dec 2016 09:07:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hoeppner@linux.vnet.ibm.com,
	sebott@linux.vnet.ibm.com
Subject: Re: [RFC] block: check partition alignment
Message-ID: <20161214170719.GA3599@infradead.org>
References: <20161214164706.45543-1-sth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161214164706.45543-1-sth@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

> To prevent partitions that are not aligned to the physical blocksize
> of a device check for the alignment in the blkpg_ioctl.

We'd also need to reject this when reading partitions from disk, right?

> +			/* check if partition is aligned to blocksize */
> +			if (p.start % bdev_physical_block_size(bdev) != 0)

And this should be bdev_logical_block_size, as the logical block size
is the only thing that matters for the OS - exposing the physical block
size is just an optional hint to prevent users from doing stupid
things (like creating unaligned partitions :))
