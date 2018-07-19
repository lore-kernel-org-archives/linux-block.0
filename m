Return-Path: <hare@suse.de>
Subject: Re: [PATCH 1/2] block: bio_iov_iter_get_pages: fix size of last iovec
To: Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org
References: <20180718075440.GA15254@ming.t460p>
 <20180719093918.28876-1-mwilck@suse.com>
 <20180719093918.28876-2-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9084ecb6-c5ae-4be1-da5e-187f041f33bf@suse.de>
Date: Thu, 19 Jul 2018 12:05:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180719093918.28876-2-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/19/2018 11:39 AM, Martin Wilck wrote:
> If the last page of the bio is not "full", the length of the last
> vector slot needs to be corrected. This slot has the index
> (bio->bi_vcnt - 1), but only in bio->bi_io_vec. In the "bv" helper
> array, which is shifted by the value of bio->bi_vcnt at function
> invocation, the correct index is (nr_pages - 1).
> 
> V2: improved readability following suggestions from Ming Lei.
> 
> Fixes: 2cefe4dbaadf ("block: add bio_iov_iter_get_pages()")
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  block/bio.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
