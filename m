Subject: Re: [PATCH 4/5] blk-mq-sched: fix starvation for multiple hardware
 queues and shared tags
To: Omar Sandoval <osandov@osandov.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
 <1485460098-16608-5-git-send-email-axboe@fb.com>
 <20170126202500.GD21449@vader.DHCP.thefacebook.com>
Cc: linux-block@vger.kernel.org, bart.vanassche@sandisk.com, hch@lst.de,
 osandov@fb.com, paolo.valente@linaro.org, hare@suse.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <0d1d511c-41ea-4677-878a-97cff4fe1956@fb.com>
Date: Thu, 26 Jan 2017 13:26:31 -0700
MIME-Version: 1.0
In-Reply-To: <20170126202500.GD21449@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/26/2017 01:25 PM, Omar Sandoval wrote:
> On Thu, Jan 26, 2017 at 12:48:17PM -0700, Jens Axboe wrote:
>> If we have both multiple hardware queues and shared tag map between
>> devices, we need to ensure that we propagate the hardware queue
>> restart bit higher up. This is because we can get into a situation
>> where we don't have any IO pending on a hardware queue, yet we fail
>> getting a tag to start new IO. If that happens, it's not enough to
>> mark the hardware queue as needing a restart, we need to bubble
>> that up to the higher level queue as well.
> 
> One minor nit below. Otherwise, makes sense.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
>> Signed-off-by: Jens Axboe <axboe@fb.com>
>> ---
>>  block/blk-mq-sched.c   | 28 ++++++++++++++++++++++++++++
>>  block/blk-mq-sched.h   | 15 +++++++++------
>>  block/blk-mq.c         |  3 ++-
>>  block/blk-mq.h         |  1 +
>>  include/linux/blkdev.h |  1 +
>>  5 files changed, 41 insertions(+), 7 deletions(-)
> 
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 25564857f5f8..73bcd201a9b7 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -602,6 +602,7 @@ struct request_queue {
>>  #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
>>  #define QUEUE_FLAG_DAX         26	/* device supports DAX */
>>  #define QUEUE_FLAG_STATS       27	/* track rq completion times */
>> +#define QUEUE_FLAG_RESTART     28
> 
> All of the other queue flags have a comment, could you add one here,
> too?

Definitely, I'll add an appropriate comment.

-- 
Jens Axboe
