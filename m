Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <2856cdcf-a639-c2c9-5efe-7159fc574467@kernel.dk>
References: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
 <CA+55aFzXDzoMqHic3RxUzyYzxDkHB1sr_oHJTEv2k4V1wjOa=g@mail.gmail.com>
 <20170924130304.GA21904@infradead.org> <CA+55aFx3Pxw+cqRCJY9TmnCCePhKY-x0A74SJ=QvG7nHNV19xw@mail.gmail.com>
 <ab2cab66-4d47-23d0-78f8-ef8450ab4b5b@kernel.dk> <CA+55aFzmyHRXu+zUBdWr3a9Xt_WoJp9OCzV5u6BZoRHKSKdbEQ@mail.gmail.com>
 <2856cdcf-a639-c2c9-5efe-7159fc574467@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Sep 2017 11:32:33 -0700
Message-ID: <CA+55aFzyMoTV5Be1xQeOkgW7PwSu0j=dZFiQ_rDQp7FaQY44-w@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 7:46 AM, Jens Axboe <axboe@kernel.dk> wrote:
>
> Honestly, what I really wanted to do was kill that call completely.

I can understand why you'd want to, but at the same time it is not
entirely clear that is possible.

So the problem is that we need more memory for buffer head
allocations, and we *have* to get it (since we very likely need the
buffer heads for writeout under low-mem cirumstances) - but at the
same time we obviously must not recurse into the filesystem.

The end result being that any synchronous freeing is going to be very
limited (GFP_NOFS really ends up limiting a lot), and so there's a
fairly strong argument that we should then wake up other threads that
*can* do filesystem writeback.

Of course, the problem with _that_ is that it's quite likely that the
flusher threads doing filesystem writeback may in turn get back to
this very same "we need buffer heads".

And that is, I assume, the case that facebook then hits.

So it's kind of "damned in you do, damned if you don't" situation.

But this is very much also why that free_more_memory() code then

 (a) limits the writeout

 (b) has that "yield()" in it

with the logic being to not cause unnecessarily much writeout, and
hopefully avoid huge latency spikes because of the (potential) looping
over the unsiccessful GFP_NOFS allocations.

But yes, a lot has changed over time. For example, originally
filesystems that used buffer heads used them both for reading and
writing, so the act of reading in a page tended to also populate the
buffer heads for that page.

I think most filesystems these days avoid buffer heads entirely, and
the dynamics of bh allocations have likely changed radically.

So I wouldn't remove the "wakeup_flusher_threads()" call, but maybe it
could be moved to be a unusual fallback case if the direct freeing
doesn't work.

But none of this happens unless that alloc_buffer_head() failed, so at
least one GFP_NOFS allocation has already failed miserably, which is
why that "make other threads that _can_ do filesystem IO try to free
things" exists in the first place.

> If you read the free_more_memory() function, it looks like crap.

I really don't see that.

Think of what the preconditions are:

 - a GFP_NOFS allocation has failed

 - we obviously cannot call back into filesystem code

and that function makes a fair amount of sense. It's _supposed_ to be
an unusual nasty case, after all.

Now,

> What I really wanted to do was kill the
> wakeup_flusher_threads() completely, we want to rely on
> try_to_free_pages() starting targeted writeback instead of some magic
> number of pages across devices.

Yes, hopefully the regular memory allocation should already do the
right thing, but the problem here is that we do need to loop over it,
which it isn't really designed for.

But one option might be to just say "_we_ shouldn't loop, the page
allocator should just loop until it gets a successful end result".

So remove _all_ of the fallback code entirely, and just use __GFP_NOFAIL.

That is in fact what some filesystems use for their own metadata:
you'll find that the

    GFP_NOFS | __GFP_NOFAIL

combination is not entirely unheard of, and in fact that buffer code
itself actually uses it for the backing page itself (not the buffer
heads) in grow_dev_page().

So rather than play more games in free_more_memory(), I'd personally
just rather remove that function entirely, and say "the buffer head
allocations simply cannot fail" and leave it to the VM code to do the
right thing.

> But I decided that we should probably
> just keep that random flusher wakeup, and tackle that part in a v2 for
> 4.15.

Oh, absolutely, I'd be more than happy to play with this code, but as
mentioned, I actually would do even more radical surgery on it.

So I'm not at all objecting to changing that function in major ways.

I just don't think that changing the flush count is in any way
obvious. In many ways it's a *much* scarier change than adding
__GFP_NOFAIL, in my opinion.

At least with __GFP_NOFAIL, we have some fairly good reason to believe
that now the memory management code won't be doing enormous flushing
work "just because".

So my only real objection was really the timing, and the "it's
obviously a fix".

> The workload is nothing special. Getting to the point where it's bad
> enough to trigger a softlockup probably requires some serious beating up
> of the box, but getting to a suboptimal state wrt work units pending and
> the flusher threads is pretty trivial.

I'm actually surprised that you have what appears to be a buffer-head
heavy workload at all.

What is it that triggers that many buffer heads in the first place?
Because I thought we'd gotten to the point where all normal file IO
can avoid the buffer heads entirely, and just directly work with
making bio's from the pages.

So I assume this is some metadata writeout (ie either directory
writeback or just the btrfs metadata tree?

                     Linus
