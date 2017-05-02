Return-Path: <jack@suse.cz>
Date: Tue, 2 May 2017 17:15:58 +0200
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Treat REQ_FUA and REQ_PREFLUSH as synchronous
Message-ID: <20170502151558.GL13916@quack2.suse.cz>
References: <20170502102123.GE13916@quack2.suse.cz>
 <20170502144505.GA29623@infradead.org>
 <f4bedc20-7b27-bfa9-76c6-c34c8c3e816b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f4bedc20-7b27-bfa9-76c6-c34c8c3e816b@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue 02-05-17 08:49:14, Jens Axboe wrote:
> On 05/02/2017 08:45 AM, Christoph Hellwig wrote:
> > On Tue, May 02, 2017 at 12:21:23PM +0200, Jan Kara wrote:
> >> it makes sense to treat REQ_FUA and REQ_PREFLUSH ops as synchronous in
> >> op_is_sync() since callers cannot rely on this anyway... Thoughts?
> > 
> > I'm fine with treating them as sync.
> 
> Yes me too. It makes sense to do so implicitly, and it avoids having
> to go and add REQ_SYNC in a bunch of places. That will also be more
> error proof in the future.
> 
> Jan, will you send a patch for that?

Hum, so I've just sent out fixes to individual filesystems to set REQ_SYNC
explicitely :-|. So would you prefer to do something like:

        if (op_is_flush(bio->bi_opf) &&
            !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
                bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
+		bio->bi_opf |= REQ_SYNC;
                if (!nr_sectors) {
                        err = 0;
                        goto end_io;
                }
        }

in generic_make_request_checks()? Or just set it unconditionally in that
function if we see REQ_FUA | REQ_PREFLUSH set? Because we cannot just add
REQ_SYNC into REQ_FUA and REQ_PREFLUSH definitions as it used to be with
WRITE_FUA & co. definitions...

In the end I think that modifying filesystems (and drivers/md) to set REQ_SYNC
was the cleanest way to go as much as it was annoying...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
