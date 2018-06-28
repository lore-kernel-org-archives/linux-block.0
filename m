Return-Path: <ming.lei@redhat.com>
Date: Fri, 29 Jun 2018 06:53:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] block: Make __bio_clone_fast() copy bi_vcnt
Message-ID: <20180628225350.GA25556@ming.t460p>
References: <20180627201231.15641-1-bart.vanassche@wdc.com>
 <0581d9cb-87c7-9ef9-1c65-33b0742b3dcf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0581d9cb-87c7-9ef9-1c65-33b0742b3dcf@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 28, 2018 at 09:53:23AM -0600, Jens Axboe wrote:
> On 6/27/18 2:12 PM, Bart Van Assche wrote:
> > Although __bio_clone_fast() copies bi_io_vec, it does not copy bi_vcnt,
> > the number of elements in bi_io_vec[] that contains data. Copy bi_vcnt
> > such that code that needs this member behaves identically for original
> > and for cloned requests.
> 
> Applied - it's correct for the current base.
> 

Any users of cloned bio shouldn't use this bio's .bi_vcnt directly,
since this counter represents the original bio's actual io vector
number, nothing related with the cloned bio.

So I don't understand why we need to copy it.

Thanks,
Ming
