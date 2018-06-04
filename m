Return-Path: <hch@lst.de>
Date: Mon, 4 Jun 2018 15:42:45 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"tj@kernel.org" <tj@kernel.org>,
	"lduncan@suse.com" <lduncan@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"cleech@redhat.com" <cleech@redhat.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 03/14] blk-mq: Remove generation seqeunce
Message-ID: <20180604134245.GA31895@lst.de>
References: <20180529135239.27005-1-hch@lst.de> <20180529135239.27005-4-hch@lst.de> <fe09917b6159988b168a9ef25240e0082c7c352f.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fe09917b6159988b168a9ef25240e0082c7c352f.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 04, 2018 at 06:56:22AM +0000, Bart Van Assche wrote:
> Can you explain why you prefer this approach? I think this patch introduces
> more new atomic operations in the hot path than the approach I had proposed
> ("blk-mq: Rework blk-mq timeout handling again"). In other words, I think the
> patch that I had proposed will yield better performance.

Primarily because the generation counter is fundamentally the wrong
thing to do.  If we know the tag has some pending action on it we
should not reuse it insted of working around races that stem from the
fact that we reuse it.

We can look at the performance numbers and tune as needed, but for now
we need to get the high level approach right first.  I think once
we've done a proper audit of the SCSI EH code and blk_abort_request
users we can probably drop the cmpxchg and only have a single
atomic_dec_and_test left, which in terms of atomic operations isn't
the world.
