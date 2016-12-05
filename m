Subject: Re: [PATCH 2/7] cfq-iosched: use appropriate run queue function
To: Johannes Thumshirn <jthumshirn@suse.de>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
 <1480734921-23701-3-git-send-email-axboe@fb.com>
 <20161205084826.GA8481@linux-x5ow.site>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, paolo.valente@linaro.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <d7717e7a-b1eb-693e-145b-a165f1e446f0@fb.com>
Date: Mon, 5 Dec 2016 08:12:16 -0700
MIME-Version: 1.0
In-Reply-To: <20161205084826.GA8481@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/05/2016 01:48 AM, Johannes Thumshirn wrote:
> On Fri, Dec 02, 2016 at 08:15:16PM -0700, Jens Axboe wrote:
>> For MQ devices, we have to use other functions to run the queue.
>> No functional changes in this patch, just a prep patch for
>> support legacy schedulers on blk-mq.
>>
>> Signed-off-by: Jens Axboe <axboe@fb.com>
>> ---
>>  block/cfq-iosched.c | 22 +++++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
>> index c73a6fcaeb9d..d6d454a72bd4 100644
>> --- a/block/cfq-iosched.c
>> +++ b/block/cfq-iosched.c
>> @@ -919,8 +919,14 @@ static inline struct cfq_data *cic_to_cfqd(struct cfq_io_cq *cic)
>>  static inline void cfq_schedule_dispatch(struct cfq_data *cfqd)
>>  {
>>  	if (cfqd->busy_queues) {
>> +		struct request_queue *q = cfqd->queue;
>> +
>>  		cfq_log(cfqd, "schedule dispatch");
>> -		kblockd_schedule_work(&cfqd->unplug_work);
>> +
>> +		if (q->mq_ops)
> 
> You've introduced blk_use_mq_path() in patch 1, so why don't you use it here
> as well?

There's a difference. q->mq_ops means "this driver is blk-mq",
blk_use_mq_path() checks for ->elevator as well, which means "for this
driver, allocate and insert requests via the legacy IO scheduler path".

-- 
Jens Axboe
