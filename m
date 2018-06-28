Return-Path: <ming.lei@redhat.com>
Date: Thu, 28 Jun 2018 08:30:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] block: Make __bio_clone_fast() copy bi_vcnt
Message-ID: <20180628003007.GG7583@ming.t460p>
References: <20180627201231.15641-1-bart.vanassche@wdc.com>
 <20180627235005.GE7583@ming.t460p>
 <4995fc0c-e9d7-d747-7331-67396827a596@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4995fc0c-e9d7-d747-7331-67396827a596@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 27, 2018 at 04:59:41PM -0700, Bart Van Assche wrote:
> On 06/27/18 16:50, Ming Lei wrote:
> > On Wed, Jun 27, 2018 at 01:12:31PM -0700, Bart Van Assche wrote:
> > > Although __bio_clone_fast() copies bi_io_vec, it does not copy bi_vcnt,
> > > the number of elements in bi_io_vec[] that contains data. Copy bi_vcnt
> > > such that code that needs this member behaves identically for original
> > > and for cloned requests.
> > > 
> > > Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Mike Snitzer <snitzer@redhat.com>
> > > Cc: Ming Lei <ming.lei@redhat.com>
> > > Cc: Hannes Reinecke <hare@suse.com>
> > > Cc: Johannes Thumshirn <jthumshirn@suse.de>
> > > ---
> > >   block/bio.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/block/bio.c b/block/bio.c
> > > index f7e3d88bd0b6..55f8e0dedd69 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -605,6 +605,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
> > >   	bio->bi_opf = bio_src->bi_opf;
> > >   	bio->bi_write_hint = bio_src->bi_write_hint;
> > >   	bio->bi_iter = bio_src->bi_iter;
> > > +	bio->bi_vcnt = bio_src->bi_vcnt;
> > >   	bio->bi_io_vec = bio_src->bi_io_vec;
> > 
> > No, don't do that.
> 
> Why not? I think it's a huge booby trap that cloned bio's have a bi_io_vec
> but zero bi_vcnt.

One core idea of immutable bvec is to use bio->bi_iter and the original
bvec table to iterate over anywhere in the bio. That is why .bi_io_vec
needs to copy, but not see any reason why .bi_vcnt needs to do.

Do you have use cases on .bi_vcnt for cloned bio?

Thanks,
Ming
