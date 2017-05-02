Return-Path: <ming.lei@redhat.com>
Date: Tue, 2 May 2017 17:40:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] blk: replace bioset_create_nobvec() with a flags
 arg to bioset_create()
Message-ID: <20170502094019.GA1803@ming.t460p>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654407.5146.12779672368228096310.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149369654407.5146.12779672368228096310.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 02, 2017 at 01:42:24PM +1000, NeilBrown wrote:
> "flags" arguments are often seen as good API design as they allow
> easy extensibility.
> bioset_create_nobvec() is implemented internally as a variation in
> flags passed to __bioset_create().

>From driver's view, this flag has document benifit too.

> 
> To support future extension, make the internal structure part of the
> API.
> i.e. add a 'flags' argument to bioset_create() and discard
> bioset_create_nobvec().
> 
> Note that the bio_split allocations in drivers/md/raid* do not need
> the bvec mempool - they should have used bioset_create_nobvec().
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
