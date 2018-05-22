Return-Path: <BATV+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 22 May 2018 03:10:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, hch@infradead.org, colyli@suse.de,
	snitzer@redhat.com, darrick.wong@oracle.com, clm@fb.com,
	bacik@fb.com, linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org,
	neilb@suse.com
Subject: Re: [PATCH 11/12] xfs: convert to bioset_init()/mempool_init()
Message-ID: <20180522101016.GD4477@infradead.org>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
 <20180520222558.7053-12-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180520222558.7053-12-kent.overstreet@gmail.com>
List-ID: <linux-block@vger.kernel.org>

This creates a minor conflict with my iomap series, but that should
be easy to merge if needed.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
