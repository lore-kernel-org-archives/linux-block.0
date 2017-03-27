Return-Path: <BATV+c09a500acd4738b53c4f+4964+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 27 Mar 2017 10:14:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
	Shaohua Li <shli@kernel.org>, linux-kernel@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3] block: trace completion of all bios.
Message-ID: <20170327171421.GA464@infradead.org>
References: <877f3iave6.fsf@notabene.neil.brown.name>
 <20170322125149.GA29606@infradead.org>
 <87shm4a4lt.fsf@notabene.neil.brown.name>
 <20170323104331.GA16903@ming.t460p>
 <87fui3a65o.fsf@notabene.neil.brown.name>
 <20170327090308.GA11757@infradead.org>
 <87zig76oca.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87zig76oca.fsf@notabene.neil.brown.name>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 27, 2017 at 08:49:57PM +1100, NeilBrown wrote:
> On Mon, Mar 27 2017, Christoph Hellwig wrote:
> 
> > I don't really like the flag at all.  I'd much prefer a __bio_endio
> > with a 'bool trace' flag.  Also please remove the manual tracing in
> > dm.ċ.  Once that is done I suspect we can also remove the
> > block_bio_complete export.
> 
> Can you say why you don't like it?

It uses up a precious bit in the bio for something that should be state
that can be determined in the caller at compile time.
