Return-Path: <msnitzer@redhat.com>
Date: Thu, 28 Jun 2018 11:32:12 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: block: Make __bio_clone_fast() copy bi_vcnt
Message-ID: <20180628153211.GA17723@redhat.com>
References: <20180627201231.15641-1-bart.vanassche@wdc.com>
 <20180627235005.GE7583@ming.t460p>
 <4995fc0c-e9d7-d747-7331-67396827a596@wdc.com>
 <20180628003007.GG7583@ming.t460p>
 <5e78949d-6169-5a5a-869b-731a3468e2de@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5e78949d-6169-5a5a-869b-731a3468e2de@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 28 2018 at 11:21am -0400,
Bart Van Assche <bart.vanassche@wdc.com> wrote:

> On 06/27/18 17:30, Ming Lei wrote:
> >One core idea of immutable bvec is to use bio->bi_iter and the original
> >bvec table to iterate over anywhere in the bio. That is why .bi_io_vec
> >needs to copy, but not see any reason why .bi_vcnt needs to do.
> >
> >Do you have use cases on .bi_vcnt for cloned bio?
> 
> So far this is only a theoretical concern. There are many functions
> in the block layer that use .bi_vcnt, and it is a lot of work to
> figure out all the callers of all these functions.

No point wasting time with that.  I don't understand why Ming cares.
Your change is obviously correct.  The state should get transfered over
to reflect reality.

This patch doesn't harm anything, it just prevents some clone-specific
failure in the future.

Acked-by: Mike Snitzer <snitzer@redhat.com>
