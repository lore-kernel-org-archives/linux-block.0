Return-Path: <BATV+bd2cc6fb32ca617cb22a+5026+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 28 May 2017 02:31:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	axboe@kernel.dk, linux-api@vger.kernel.org, adam.manzanares@wdc.com,
	viro@zeniv.linux.org.uk, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 09/10] xfs: nowait aio support
Message-ID: <20170528093113.GB14519@infradead.org>
References: <20170524164150.9492-1-rgoldwyn@suse.de>
 <20170524164150.9492-10-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170524164150.9492-10-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

Despite my previous reviewed-by tag this will need another fix:

xfs_file_iomap_begin needs to return EAGAIN if we don't have the extent
list in memoery already.  E.g. something like this:

	if ((flags & IOMAP_NOWAIT) && !(ip->i_d.if_flags & XFS_IFEXTENTS)) {
		error = -EAGAIN;
		goto out_unlock;
	}

right after locking the ilock.
