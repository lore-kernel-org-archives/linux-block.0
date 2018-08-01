Return-Path: <hch@lst.de>
Date: Wed, 1 Aug 2018 16:54:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 2/3] block: kill QUEUE_FLAG_NO_SG_MERGE
Message-ID: <20180801145402.GB28668@lst.de>
References: <20180731104914.17249-1-ming.lei@redhat.com> <20180731104914.17249-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180731104914.17249-3-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

We still hit __blk_recalc_rq_segments at least once per submission,
don't we?  Either rather wait with this until we have multi-page bvecs.
