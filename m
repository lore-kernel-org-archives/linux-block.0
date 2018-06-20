Return-Path: <ming.lei@redhat.com>
Date: Wed, 20 Jun 2018 17:12:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Boaz Harrosh <ooo@electrozaur.com>,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	dm-devel@redhat.com
Subject: Re: [RFC] kill bio_clone_kmalloc and bio_clone_bioset
Message-ID: <20180620091204.GA11780@ming.t460p>
References: <20180619045216.21130-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180619045216.21130-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 19, 2018 at 06:52:10AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes all but one users of the traditional deep bio clone,
> and then moves bio_clone_bioset to its only caller so that we get rid
> of the deep bio cloning in the block layer API.
> 
> Patch 1 is already in the device mapper queue for 4.18, so we should
> wait for that to go in before the series is applied.  The series is
> inteded as preparation work for the multi-page biovecs so that it doesn't
> have to deal with the difference between single page or larger bio vecs
> for cloning.

Looks good cleanup:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
