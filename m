Return-Path: <ming.lei@redhat.com>
Date: Thu, 28 Jun 2018 07:20:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Simplify the bio cloning implementation
Message-ID: <20180627232039.GA7583@ming.t460p>
References: <20180626222624.11739-1-bart.vanassche@wdc.com>
 <20180627011259.GC9970@ming.t460p>
 <5766ea06-4016-6ad1-a18a-b2c9f31788cf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5766ea06-4016-6ad1-a18a-b2c9f31788cf@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 27, 2018 at 10:48:06AM -0700, Bart Van Assche wrote:
> On 06/26/18 18:13, Ming Lei wrote:
> > On Tue, Jun 26, 2018 at 03:26:24PM -0700, Bart Van Assche wrote:
> > > There is no good reason to use different code paths for different
> > > request operations. Hence remove the switch/case statement from
> > > bio_clone_bioset().
> > > 
> > > Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >   block/bio.c | 15 ++-------------
> > >   1 file changed, 2 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/block/bio.c b/block/bio.c
> > > index f7e3d88bd0b6..4c27cc9ea55e 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -691,19 +691,8 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
> > >   	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
> > >   	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
> > > -	switch (bio_op(bio)) {
> > > -	case REQ_OP_DISCARD:
> > > -	case REQ_OP_SECURE_ERASE:
> > > -	case REQ_OP_WRITE_ZEROES:
> > > -		break;
> > > -	case REQ_OP_WRITE_SAME:
> > > -		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
> > > -		break;
> > > -	default:
> > > -		bio_for_each_segment(bv, bio_src, iter)
> > > -			bio->bi_io_vec[bio->bi_vcnt++] = bv;
> > > -		break;
> > > -	}
> > > +	bio_for_each_segment(bv, bio_src, iter)
> > > +		bio->bi_io_vec[bio->bi_vcnt++] = bv;
> > 
> > The above change may not be correct for WRITE_SAME, since
> > bio_src->bi_iter.bi_size should be the actual bytes to write by drive.
> 
> Since bio_for_each_segment() neither modifies bio_src->bi_iter nor
> bio->bi_iter, the above patch retains the value copied into
> bio->bi_iter.bi_size before bio_for_each_segment() was called. In other

Yes.

> words, bio_src->bi_iter.bi_size is not modified and the resulting
> bio->bi_iter.bi_size should be identical with or without this patch.

That is true too.

But,

What we need to do is to only copy the 1st bvec for WRITE_SAME, your patch
changes to copy (bio->bi_iter.bi_size / block size) bvecs, then memory corruption
may be triggered. So bio_for_each_segment() can't be used here.

Thanks,
Ming
