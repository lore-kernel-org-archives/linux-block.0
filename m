Return-Path: <ming.lei@redhat.com>
Date: Wed, 3 May 2017 07:50:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] block: don't check for BIO_MAX_PAGES in
 blk_bio_segment_split()
Message-ID: <20170502235033.GA18771@ming.t460p>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654638.5146.3067734913419940612.stgit@noble>
 <20170502102223.GB1803@ming.t460p>
 <87tw52q37k.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87tw52q37k.fsf@notabene.neil.brown.name>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 03, 2017 at 08:54:55AM +1000, NeilBrown wrote:
> On Tue, May 02 2017, Ming Lei wrote:
> 
> > On Tue, May 02, 2017 at 01:42:26PM +1000, NeilBrown wrote:
> >> blk_bio_segment_split() makes sure bios have no more than
> >> BIO_MAX_PAGES entries in the bi_io_vec.
> >> This was done because bio_clone_bioset() (when given a
> >> mempool bioset) could not handle larger io_vecs.
> >> 
> >> No driver uses bio_clone_bioset() any more, they all
> >> use bio_clone_fast() if anything, and bio_clone_fast()
> >> doesn't clone the bi_io_vec.
> >
> > Maybe in future, some drivers still may try to use 
> > bio_clone_bioset() again, I suggest to add some comments
> > on bio_clone_bioset() to make this usage explicitly. Also
> > better to trigger a warning if a big src bio is passed to
> > bio_clone_bioset().
> 
> There are now just two users for bio_clone_bioset(): bounce.c and btrfs.
> 
> Christoph wants to get rid of bounce.c, which would leave one.
> 
> I'd have to drill into the btrfs code to be sure, but it might be that
> btrfs only needs bio_clone_fast().  That would leave zero users.
> Then we wouldn't need a warning at all.
> 
> So I agree that we need to guard against future incorrect usage.  I'm not
> yet sure what the best approach is.

I think it is helpful to simply comment this function as obsolete.


Thanks,
Ming
