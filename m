Return-Path: <ming.lei@redhat.com>
Date: Mon, 29 Oct 2018 10:42:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>, stable@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>, Xiao Ni <xni@redhat.com>,
	Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Subject: Re: [PATCH 1/3] block: make sure discard bio is aligned with logical
 block size
Message-ID: <20181029024239.GB32606@ming.t460p>
References: <20181026062435.21398-1-ming.lei@redhat.com>
 <20181026062435.21398-2-ming.lei@redhat.com>
 <20181026074415.GA4660@lst.de>
 <20181028005130.GA26731@ming.t460p>
 <20181028154947.GB3061@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181028154947.GB3061@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Sun, Oct 28, 2018 at 04:49:47PM +0100, Christoph Hellwig wrote:
> On Sun, Oct 28, 2018 at 08:51:31AM +0800, Ming Lei wrote:
> > On Fri, Oct 26, 2018 at 09:44:15AM +0200, Christoph Hellwig wrote:
> > > >  		if (req_sects > UINT_MAX >> 9)
> > > > -			req_sects = UINT_MAX >> 9;
> > > > +			req_sects = (UINT_MAX >> 9) & ~bs_mask;
> > > 
> > > Given that we have this same thing duplicated in write zeroes
> > > what about a documented helper?
> > 
> > IMO, using UINT_MAX & bs_mask is better because it is self-explanatory
> > in the context.
> 
> I don't think it is in any way.  I understand it because I know the
> code, but there is nothing that documents why we do that.

Then how about introducing this helper?

 /*
+ * The max sectors one bio can handle is 'UINT_MAX >> 9' becasue
+ * bvec_iter.bi_size is defined as 'unsigned int', also it has to aligned
+ * to with logical block size which is minimum accepted unit by hardware.
+ */
+static inline unsigned int blk_max_allowed_max_secotrs(struct request_queue *q)
+{
+       return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
+}
+
+/*

Thanks,
Ming
