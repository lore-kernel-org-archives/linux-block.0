Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Tue, 28 Aug 2018 19:33:25 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.com>, linux-block@vger.kernel.org
Subject: bvec_iter rewind API
Message-ID: <20180828233325.GA32495@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

I just came across bi_done and your patch that added it -
f9df1cd99e bio: add bvec_iter rewind API

I invite you to think through what happens to a bio that gets split by something
further down the stack, and then rewound after completion:

To create the first half of the split, you just truncate the iterator by setting
bio->bi_iter.bi_size to be the length you want. So if the original bio becomes
the first half of the split, we've lost the original value for bi_size. After
completion, bio_rewind_iter will rewind the bio to the start position the
original code expects, but the bio will _not_ have the same size as it did when
that code submitted it.

So if bio_rewind_iter() is being used because we want to restore the bio to what
it was when we submitted it, this is bogus.

To create the second half of the split, we just advance the bio's iterator up to
where we want the split to start. So this shouldn't prevent us from restoring
the bio to the state it was in when it was created by rewinding it.

Except if you look at bio_split(), it sets bi_done to 0, and git blame reveals
an interesting commit message...

    block: reset bi_iter.bi_done after splitting bio
    
    After the bio has been updated to represent the remaining sectors, reset
    bi_done so bio_rewind_iter() does not rewind further than it should.
    
    This resolves a bio_integrity_process() failure on reads where the
    original request was split.

*sigh*

The original code was bogus, and so was the fix. If a bio is split _AFTER_ a
chunk of code in the stack sees it - and wants to restore it to the state it was
it when it saw it after it completes - then not touching bi_done gives us the
result we want. But if the bio was split _BEFORE_ that chunk of code sees it,
rewinding it without ever touching bi_done will rewind it to be _LARGER_ than
the bio that chunk of code saw.

So what should bi_done be? There is no correct answer - fundamentally, bi_done
_cannot_ do what you're trying to do with it. Advancing or truncating an
iterator destroys information, and stacked layers can manipulate bio iterators
in arbitrary ways.

The correct way, the ONLY way, to restore a bio's iterator to a previous state
after it's been submitted and other code has messed with it, is to save the
entire iterator state: before you submit the bio, you save a copy of
bio->bi_iter in your driver's private state, and then you restore it after
completion.

I know you want to "save memory" and avoid the hassle of having to allocate
state for your layer of the stack, but fundamentally what you're trying to do
_does not work_. You have to save the iterator, you cannot play games and assume
you can restore it.

Jens, can you please make sure I get CC'd on patches that touch bio/bvec
iterators in the future? This is not the first time I've seen people make this
mistake...
