Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Mon, 4 Jun 2018 20:34:22 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-block <linux-block@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Shaohua Li <shli@kernel.org>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
Message-ID: <20180605003422.GD30325@kmo-pixel>
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
 <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
 <87efhmp7zw.fsf@notabene.neil.brown.name>
 <20180604212100.GB30325@kmo-pixel>
 <8736y2p3kf.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8736y2p3kf.fsf@notabene.neil.brown.name>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 05, 2018 at 08:52:32AM +1000, NeilBrown wrote:
> On Mon, Jun 04 2018, Kent Overstreet wrote:
> 
> > On Tue, Jun 05, 2018 at 07:16:51AM +1000, NeilBrown wrote:
> >> I really should get back to BIOSET_NEED_RESCUER and see if I can discard
> >> it completely.
> >> Kent - the only remaining user is bcache, and the main reason I haven't
> >> removed it is that I cannot follow the code (or at least, I couldn't
> >> last time I tried).  Are you able to see if it is still needed?
> >
> > Oh man, rescueurs make my head hurt. I remember you changed something so that
> > they weren't needed most of the time, but I can't remember what you did - can
> > you remind me what that was and whatever else you can remember offhand?
> 
> (and closures make my head hurt :-)

Fair enough :)

> There were two closely related changes.
> One is make sure that generic_make_request processed bios strictly
> in a depth-first order.  The other is to ensure that all (stacking)
> block device drivers never block in their make_request_fn waiting
> for something that have themselves submitted.
> 
> Together these mean that a thread in generic_make_request will never
> block waiting for a bio that might be queued in current->bio_list.
> The bio chosen by generic_make_request will be a leaf and won't depend
> on anything else in the list, and the handler for that request won't
> block after submitting a lower-level request.
> 
> The  second property is the important one for drivers and the one we
> need to ensure that bcache follows.
> A common bad pattern is something like:
> 
>  while (too_big(bio)) {
>     split = bio_spilt(bio,...))
>     process(split)
>  }
>  process(bio)
> 
> That needs to be more like
>   if (too_big(bio)) {
>      split = bio_split(bio,...);
>      generic_make_request(bio);
>      bio = split;
>   }
>   process(bio)
> 
> so that generic_make_request() gets to do that while-loop
> and can control the order in which bios are handled.
> 
> I cannot convince myself that bcache doesn't have something similar to
> that while loop (structured with closures).

Oh yeah, it's all coming back to me...

so, the problem isn't really closures, it's that we don't know where we have to
split until after we've already allocated all our state for the request and done
almost all our work for the request - also, the state we allocate is per
_incoming_ bio, not per split we submit.

So for the read side, it looks like
 - allocate a struct search (man, so much of the naming in bcache is crap, it's
   painful going back from bcachefs)
 - traverse the btree to the start of this request
 - iterate over extents, splitting and submitting for each extent the original
   bio overlaps with

so, converting it to your 2nd pattern would mean changing that code so that when
we walk the btree and find an extent we overlap with, if the extent doesn't
cover the whole bio, we split, submit the split, resubmit the original bio - and
then return and _restart the entire btree traversal_, for each split. ouch.

the write path is different, but the problem is roughly the same in that we
don't know where we're going to need to split until we're deep inside the write
path, allocating space for where the write will go - we split if the bucket
we're currently writing to doesn't have enough space. But again, we don't find
that out until well after allocating data structures for that write, taking
locks for space allocation, etc. etc...

So the approach of just resubmitting the rest of the bio just flat out won't
work, we've already allocated our data structures and they're tied to that
bio... it would require massive changes and deep surgery on how the entire
control flow works...

Also unconditionally doing this for every bio split (bailing out and restarting
the btree traversal/write path) would be pretty crappy performance wise, e.g.
when doing big sequential reads of data that was written all with random 4k
writes...

but...

the problem we're trying to avoid is just blocking while allocating memory,
while we've got bios blocked on current->bio_list, right?

So another approach would be to checking when we're allocating a bio split if
that allocation might deadlock - if so, do it with GFP_NOWAIT, and if it fails -
just punt the read or write request to workqueue.

this is something the code can actually do the way it's structured now... making
use of closures :)

cache_lookup() calls bch_btree_map_keys() to walk the extents the request
covers, and restarts itself if cache_lookup_fn() returns -EAGAIN - this is
because the btree lookup might require reading in btree nodes, so we can't block
on a btree node read while running under generic_make_request().

So this (untested!) patch should be sufficient for the read side:

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index ae67f5fa80..9aed34d050 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -538,6 +538,14 @@ static int cache_lookup_fn(struct btree_op *op, struct btree *b, struct bkey *k)
 	if (!KEY_SIZE(k))
 		return MAP_CONTINUE;
 
+	n = bio_next_split(bio, min_t(uint64_t, INT_MAX,
+				      KEY_OFFSET(k) - bio->bi_iter.bi_sector),
+		!current->bio_list || bio_list_empty(current->bio_list)
+		? GFP_NOIO : GFP_NOWAIT,
+		&s->d->bio_split);
+	if (!n)
+		return -EAGAIN;
+
 	/* XXX: figure out best pointer - for multiple cache devices */
 	ptr = 0;
 
@@ -546,10 +554,6 @@ static int cache_lookup_fn(struct btree_op *op, struct btree *b, struct bkey *k)
 	if (KEY_DIRTY(k))
 		s->read_dirty_data = true;
 
-	n = bio_next_split(bio, min_t(uint64_t, INT_MAX,
-				      KEY_OFFSET(k) - bio->bi_iter.bi_sector),
-			   GFP_NOIO, &s->d->bio_split);
-
 	bio_key = &container_of(n, struct bbio, bio)->key;
 	bch_bkey_copy_single_ptr(bio_key, k, ptr);
 

It's a bit more complicated for the write path - right now, we split after
allocating space (bch_data_insert_start() -> bch_alloc_sectors()). To be able to
punt to workqueue if the split fails, bch_alloc_sectors() needs to be broken up
into bch_alloc_sectors_start() to pick and lock a write point and allocate a
bucket if necessary, so that bch_data_insert_start() can find out how much space
there is available and attempt the split before actually consuming that space.

That's how the sector allocator already works in bcachefs though, so it's a
straightforward change...
