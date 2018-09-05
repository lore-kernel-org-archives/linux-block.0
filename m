Return-Path: <hch@lst.de>
Date: Wed, 5 Sep 2018 15:19:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Dmitry Monakhov <dmonakhov@openvz.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] block: remove bio_rewind_iter()
Message-ID: <20180905131915.GB26956@lst.de>
References: <20180905033335.12666-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905033335.12666-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

> +	bio->bi_status = bio_integrity_process(bio, &bip->bio_iter, bi->profile->verify_fn);

Please split the overly long line.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
