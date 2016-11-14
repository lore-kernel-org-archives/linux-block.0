Subject: Re: [PATCH] bsg: Add sparse annotations to bsg_request_fn()
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <6dfb1793-ca6a-c3b6-b3fc-272e68ca6880@sandisk.com>
 <b8f96aed-5cd5-26f0-5c14-4f1ace05dd51@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <7440c159-3f7f-816a-1996-d5e170a87fb3@fb.com>
Date: Mon, 14 Nov 2016 09:56:31 -0700
MIME-Version: 1.0
In-Reply-To: <b8f96aed-5cd5-26f0-5c14-4f1ace05dd51@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/14/2016 09:55 AM, Bart Van Assche wrote:
> On 09/25/2016 07:54 PM, Bart Van Assche wrote:
>> Avoid that sparse complains about unbalanced lock actions.
>>
>> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
>> ---
>>  block/bsg-lib.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
>> index 650f427..b2a61e3 100644
>> --- a/block/bsg-lib.c
>> +++ b/block/bsg-lib.c
>> @@ -161,6 +161,8 @@ failjob_rls_job:
>>   * Drivers/subsys should pass this to the queue init function.
>>   */
>>  void bsg_request_fn(struct request_queue *q)
>> +    __releases(q->queue_lock)
>> +    __acquires(q->queue_lock)
>>  {
>>      struct device *dev = q->queuedata;
>>      struct request *req;
>>
>
> Hi Jens,
>
> Do you agree with this patch? If so, can you queue it for kernel v4.10?

Yep, I'll add it for 4.10, thanks Bart.

-- 
Jens Axboe
