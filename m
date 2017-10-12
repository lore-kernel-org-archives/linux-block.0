Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
Subject: Re: [PATCH] blk-throttle: track read and write request individually
To: Shaohua Li <shli@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Shaohua Li <shli@fb.com>, boyu.mt@taobao.com, wenqing.lz@taobao.com
References: <2fd5bacc-a946-7291-58ad-b03b8ba63d1a@gmail.com>
 <20171011192105.nbs7mftneycptwjg@kernel.org>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <d6d02e55-9aac-763a-bb41-28b492c001b1@gmail.com>
Date: Thu, 12 Oct 2017 09:09:06 +0800
MIME-Version: 1.0
In-Reply-To: <20171011192105.nbs7mftneycptwjg@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 17/10/12 03:21, Shaohua Li wrote:
> On Wed, Oct 11, 2017 at 05:53:34PM +0800, Joseph Qi wrote:
>> From: Joseph Qi <qijiang.qj@alibaba-inc.com>
>>
>> In mixed read/write workload on SSD, write latency is much lower than
>> read. But now we only track and record read latency and then use it as
>> threshold base for both read and write io latency accounting. As a
>> result, write io latency will always be considered as good and
>> bad_bio_cnt is much smaller than 20% of bio_cnt. That is to mean, the
>> tg to be checked will be treated as idle most of the time and still let
>> others dispatch more ios, even it is truly running under low limit and
>> wants its low limit to be guaranteed, which is not we expected in fact.
>> So track read and write request individually, which can bring more
>> precise latency control for low limit idle detection.
> 
> Looks good. Originally I thought we don't need very precise latency control, so
> the read/write base latency difference doesn't matter too much, but tracking
> write base latency shouldn't harm.
>  
>> Signed-off-by: Joseph Qi <qijiang.qj@alibaba-inc.com>
>> ---
>>  block/blk-throttle.c | 134 ++++++++++++++++++++++++++++++---------------------
>>  1 file changed, 79 insertions(+), 55 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 17816a0..0897378 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -215,9 +215,9 @@ struct throtl_data
>>  
>>  	unsigned int scale;
>>  
>> -	struct latency_bucket tmp_buckets[LATENCY_BUCKET_SIZE];
>> -	struct avg_latency_bucket avg_buckets[LATENCY_BUCKET_SIZE];
>> -	struct latency_bucket __percpu *latency_buckets;
>> +	struct latency_bucket tmp_buckets[2][LATENCY_BUCKET_SIZE];
>> +	struct avg_latency_bucket avg_buckets[2][LATENCY_BUCKET_SIZE];
>> +	struct latency_bucket __percpu *latency_buckets[2];
>>  	unsigned long last_calculate_time;
>>  	unsigned long filtered_latency;
>>  
>> @@ -2040,10 +2040,10 @@ static void blk_throtl_update_idletime(struct throtl_grp *tg)
>>  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>>  static void throtl_update_latency_buckets(struct throtl_data *td)
>>  {
>> -	struct avg_latency_bucket avg_latency[LATENCY_BUCKET_SIZE];
>> -	int i, cpu;
>> -	unsigned long last_latency = 0;
>> -	unsigned long latency;
>> +	struct avg_latency_bucket avg_latency[2][LATENCY_BUCKET_SIZE];
>> +	int i, cpu, rw;
>> +	unsigned long last_latency[2] = { 0 };
>> +	unsigned long latency[2];
>>  
>>  	if (!blk_queue_nonrot(td->queue))
>>  		return;
>> @@ -2052,56 +2052,67 @@ static void throtl_update_latency_buckets(struct throtl_data *td)
>>  	td->last_calculate_time = jiffies;
>>  
>>  	memset(avg_latency, 0, sizeof(avg_latency));
>> -	for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
>> -		struct latency_bucket *tmp = &td->tmp_buckets[i];
>> -
>> -		for_each_possible_cpu(cpu) {
>> -			struct latency_bucket *bucket;
>> -
>> -			/* this isn't race free, but ok in practice */
>> -			bucket = per_cpu_ptr(td->latency_buckets, cpu);
>> -			tmp->total_latency += bucket[i].total_latency;
>> -			tmp->samples += bucket[i].samples;
>> -			bucket[i].total_latency = 0;
>> -			bucket[i].samples = 0;
>> -		}
>> +	for (rw = READ; rw <= WRITE; rw++) {
>> +		for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
>> +			struct latency_bucket *tmp = &td->tmp_buckets[rw][i];
>> +
>> +			for_each_possible_cpu(cpu) {
>> +				struct latency_bucket *bucket;
>> +
>> +				/* this isn't race free, but ok in practice */
>> +				bucket = per_cpu_ptr(td->latency_buckets[rw],
>> +					cpu);
>> +				tmp->total_latency += bucket[i].total_latency;
>> +				tmp->samples += bucket[i].samples;
>> +				bucket[i].total_latency = 0;
>> +				bucket[i].samples = 0;
>> +			}
>>  
>> -		if (tmp->samples >= 32) {
>> -			int samples = tmp->samples;
>> +			if (tmp->samples >= 32) {
>> +				int samples = tmp->samples;
>>  
>> -			latency = tmp->total_latency;
>> +				latency[rw] = tmp->total_latency;
>>  
>> -			tmp->total_latency = 0;
>> -			tmp->samples = 0;
>> -			latency /= samples;
>> -			if (latency == 0)
>> -				continue;
>> -			avg_latency[i].latency = latency;
>> +				tmp->total_latency = 0;
>> +				tmp->samples = 0;
>> +				latency[rw] /= samples;
>> +				if (latency[rw] == 0)
>> +					continue;
>> +				avg_latency[rw][i].latency = latency[rw];
>> +			}
>>  		}
>>  	}
>>  
>> -	for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
>> -		if (!avg_latency[i].latency) {
>> -			if (td->avg_buckets[i].latency < last_latency)
>> -				td->avg_buckets[i].latency = last_latency;
>> -			continue;
>> -		}
>> +	for (rw = READ; rw <= WRITE; rw++) {
>> +		for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
>> +			if (!avg_latency[rw][i].latency) {
>> +				if (td->avg_buckets[rw][i].latency < last_latency[rw])
>> +					td->avg_buckets[rw][i].latency =
>> +						last_latency[rw];
>> +				continue;
>> +			}
>>  
>> -		if (!td->avg_buckets[i].valid)
>> -			latency = avg_latency[i].latency;
>> -		else
>> -			latency = (td->avg_buckets[i].latency * 7 +
>> -				avg_latency[i].latency) >> 3;
>> +			if (!td->avg_buckets[rw][i].valid)
>> +				latency[rw] = avg_latency[rw][i].latency;
>> +			else
>> +				latency[rw] = (td->avg_buckets[rw][i].latency * 7 +
>> +					avg_latency[rw][i].latency) >> 3;
>>  
>> -		td->avg_buckets[i].latency = max(latency, last_latency);
>> -		td->avg_buckets[i].valid = true;
>> -		last_latency = td->avg_buckets[i].latency;
>> +			td->avg_buckets[rw][i].latency = max(latency[rw],
>> +				last_latency[rw]);
>> +			td->avg_buckets[rw][i].valid = true;
>> +			last_latency[rw] = td->avg_buckets[rw][i].latency;
>> +		}
>>  	}
>>  
>>  	for (i = 0; i < LATENCY_BUCKET_SIZE; i++)
>>  		throtl_log(&td->service_queue,
>> -			"Latency bucket %d: latency=%ld, valid=%d", i,
>> -			td->avg_buckets[i].latency, td->avg_buckets[i].valid);
>> +			"Latency bucket %d: read latency=%ld, read valid=%d, "
>> +			"write latency=%ld, write valid=%d", i,
>> +			td->avg_buckets[READ][i].latency,
>> +			td->avg_buckets[READ][i].valid,
>> +			td->avg_buckets[WRITE][i].latency,
>> +			td->avg_buckets[WRITE][i].valid);
>>  }
>>  #else
>>  static inline void throtl_update_latency_buckets(struct throtl_data *td)
>> @@ -2244,16 +2255,17 @@ static void throtl_track_latency(struct throtl_data *td, sector_t size,
>>  	struct latency_bucket *latency;
>>  	int index;
>>  
>> -	if (!td || td->limit_index != LIMIT_LOW || op != REQ_OP_READ ||
>> +	if (!td || td->limit_index != LIMIT_LOW ||
>> +	    !(op & (REQ_OP_READ | REQ_OP_WRITE)) ||
> 
> probably check op == REQ_OP_READ || op == REQ_OP_WRITE, discard also includes
> the REQ_OP_WRITE bit for example. It doesn't make sense to include discard here.
> 
Thanks for your advice.
I will update this check and send v2.

Thanks,
Joseph
