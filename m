Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 20 Apr 2017 13:20:39 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: sbates@raithlin.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Damien.LeMoal@wdc.com,
	sagi@grimberg.me
Subject: Re: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
Message-ID: <20170420202039.GB24823@vader.DHCP.thefacebook.com>
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
 <1491567843-26190-3-git-send-email-sbates@raithlin.com>
 <20170420200706.GA24823@vader.DHCP.thefacebook.com>
 <c7543e20-8f3f-03c4-38a2-de185e066aa2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c7543e20-8f3f-03c4-38a2-de185e066aa2@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20, 2017 at 02:16:04PM -0600, Jens Axboe wrote:
> On 04/20/2017 02:07 PM, Omar Sandoval wrote:
> > On Fri, Apr 07, 2017 at 06:24:03AM -0600, sbates@raithlin.com wrote:
> >> From: Stephen Bates <sbates@raithlin.com>
> >>
> >> Rather than bucketing IO statisics based on direction only we also
> >> bucket based on the IO size. This leads to improved polling
> >> performance. Update the bucket callback function and use it in the
> >> polling latency estimation.
> >>
> >> Signed-off-by: Stephen Bates <sbates@raithlin.com>
> > 
> > Hey, Stephen, just taking a look at this now. Comments below.
> > 
> >> ---
> >>  block/blk-mq.c | 45 +++++++++++++++++++++++++++++++++++----------
> >>  1 file changed, 35 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index 061fc2c..5fd376b 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -42,6 +42,25 @@ static LIST_HEAD(all_q_list);
> >>  static void blk_mq_poll_stats_start(struct request_queue *q);
> >>  static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
> >>  
> >> +/* Must be consisitent with function below */
> >> +#define BLK_MQ_POLL_STATS_BKTS 16
> >> +static int blk_mq_poll_stats_bkt(const struct request *rq)
> >> +{
> >> +	int ddir, bytes, bucket;
> >> +
> >> +	ddir = blk_stat_rq_ddir(rq);
> > 
> > No need to call the wrapper function here, we can use rq_data_dir()
> > directly.
> > 
> >> +	bytes = blk_rq_bytes(rq);
> >> +
> >> +	bucket = ddir + 2*(ilog2(bytes) - 9);
> >> +
> >> +	if (bucket < 0)
> >> +		return -1;
> >> +	else if (bucket >= BLK_MQ_POLL_STATS_BKTS)
> >> +		return ddir + BLK_MQ_POLL_STATS_BKTS - 2;
> >> +
> >> +	return bucket;
> >> +}
> > 
> > Nitpicking here, but defining things in terms of the number of size
> > buckets seems more natural to me. How about something like this
> > (untested)? Note that this obviates the need for patch 1.
> > 
> > #define BLK_MQ_POLL_STATS_SIZE_BKTS 8
> > static unsigned int blk_mq_poll_stats_bkt(const struct request *rq)
> > {
> > 	unsigned int size_bucket;
> > 
> > 	size_bucket = clamp(ilog2(blk_rq_bytes(rq)) - 9, 0,
> > 			    BLK_MQ_POLL_STATS_SIZE_BKTS - 1);
> > 	return 2 * size_bucket + rq_data_dir(rq);
> > }
> 
> As I wrote in an earlier reply, it would be a lot cleaner to just have
> the buckets be:
> 
> 	buckets[2][BUCKETS_PER_RW];
> 
> and not have to do weird math based on both size and data direction.
> Just have it return the bucket index based on size, and have the caller
> do:
> 
> 	bucket[rq_data_dir(rq)][bucket_index];

This removes a lot of the flexibility of the interface. Kyber, for one,
has this stats callback:

static unsigned int rq_sched_domain(const struct request *rq)
{
	unsigned int op = rq->cmd_flags;

	if ((op & REQ_OP_MASK) == REQ_OP_READ)
		return KYBER_READ;
	else if ((op & REQ_OP_MASK) == REQ_OP_WRITE && op_is_sync(op))
		return KYBER_SYNC_WRITE;
	else
		return KYBER_OTHER;
}

The buckets aren't subdivisions of read vs. write. We could shoehorn it
in your way if we really wanted to, but that's pointless.
