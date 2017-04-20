Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
To: Omar Sandoval <osandov@osandov.com>, sbates@raithlin.com
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
 <1491567843-26190-3-git-send-email-sbates@raithlin.com>
 <20170420200706.GA24823@vader.DHCP.thefacebook.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Damien.LeMoal@wdc.com, sagi@grimberg.me
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c7543e20-8f3f-03c4-38a2-de185e066aa2@kernel.dk>
Date: Thu, 20 Apr 2017 14:16:04 -0600
MIME-Version: 1.0
In-Reply-To: <20170420200706.GA24823@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/20/2017 02:07 PM, Omar Sandoval wrote:
> On Fri, Apr 07, 2017 at 06:24:03AM -0600, sbates@raithlin.com wrote:
>> From: Stephen Bates <sbates@raithlin.com>
>>
>> Rather than bucketing IO statisics based on direction only we also
>> bucket based on the IO size. This leads to improved polling
>> performance. Update the bucket callback function and use it in the
>> polling latency estimation.
>>
>> Signed-off-by: Stephen Bates <sbates@raithlin.com>
> 
> Hey, Stephen, just taking a look at this now. Comments below.
> 
>> ---
>>  block/blk-mq.c | 45 +++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 35 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 061fc2c..5fd376b 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -42,6 +42,25 @@ static LIST_HEAD(all_q_list);
>>  static void blk_mq_poll_stats_start(struct request_queue *q);
>>  static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
>>  
>> +/* Must be consisitent with function below */
>> +#define BLK_MQ_POLL_STATS_BKTS 16
>> +static int blk_mq_poll_stats_bkt(const struct request *rq)
>> +{
>> +	int ddir, bytes, bucket;
>> +
>> +	ddir = blk_stat_rq_ddir(rq);
> 
> No need to call the wrapper function here, we can use rq_data_dir()
> directly.
> 
>> +	bytes = blk_rq_bytes(rq);
>> +
>> +	bucket = ddir + 2*(ilog2(bytes) - 9);
>> +
>> +	if (bucket < 0)
>> +		return -1;
>> +	else if (bucket >= BLK_MQ_POLL_STATS_BKTS)
>> +		return ddir + BLK_MQ_POLL_STATS_BKTS - 2;
>> +
>> +	return bucket;
>> +}
> 
> Nitpicking here, but defining things in terms of the number of size
> buckets seems more natural to me. How about something like this
> (untested)? Note that this obviates the need for patch 1.
> 
> #define BLK_MQ_POLL_STATS_SIZE_BKTS 8
> static unsigned int blk_mq_poll_stats_bkt(const struct request *rq)
> {
> 	unsigned int size_bucket;
> 
> 	size_bucket = clamp(ilog2(blk_rq_bytes(rq)) - 9, 0,
> 			    BLK_MQ_POLL_STATS_SIZE_BKTS - 1);
> 	return 2 * size_bucket + rq_data_dir(rq);
> }

As I wrote in an earlier reply, it would be a lot cleaner to just have
the buckets be:

	buckets[2][BUCKETS_PER_RW];

and not have to do weird math based on both size and data direction.
Just have it return the bucket index based on size, and have the caller
do:

	bucket[rq_data_dir(rq)][bucket_index];

-- 
Jens Axboe
