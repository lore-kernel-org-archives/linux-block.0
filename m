Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] elevator: lookup mq vs non-mq elevators
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org
References: <1508954687-3204-1-git-send-email-axboe@kernel.dk>
 <1508954687-3204-2-git-send-email-axboe@kernel.dk>
 <20171025182708.GA9160@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <48fd922c-d675-cd6f-bcec-c2e83879f130@kernel.dk>
Date: Wed, 25 Oct 2017 11:31:59 -0700
MIME-Version: 1.0
In-Reply-To: <20171025182708.GA9160@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/2017 11:27 AM, Omar Sandoval wrote:
> On Wed, Oct 25, 2017 at 12:04:45PM -0600, Jens Axboe wrote:
>> If an IO scheduler is selected via elevator= and it doesn't match
>> the driver in question wrt blk-mq support, then we fail to boot.
>>
>> The elevator= parameter is deprecated and only supported for
>> non-mq devices. Augment the elevator lookup API so that we
>> pass in if we're looking for an mq capable scheduler or not,
>> so that we only ever return a valid type for the queue in
>> question.
>>
>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=196695
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/elevator.c | 44 +++++++++++++++++++++-----------------------
>>  1 file changed, 21 insertions(+), 23 deletions(-)
>>
>> diff --git a/block/elevator.c b/block/elevator.c
>> index 7ae50eb2732b..b70e69f795db 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -83,12 +83,15 @@ bool elv_bio_merge_ok(struct request *rq, struct bio *bio)
>>  }
>>  EXPORT_SYMBOL(elv_bio_merge_ok);
>>  
>> -static struct elevator_type *elevator_find(const char *name)
>> +/*
>> + * Return scheduler with name 'name' and with matching 'mq capability
>> + */
>> +static struct elevator_type *elevator_find(const char *name, bool mq)
>>  {
>>  	struct elevator_type *e;
>>  
>>  	list_for_each_entry(e, &elv_list, list) {
>> -		if (!strcmp(e->elevator_name, name))
>> +		if (!strcmp(e->elevator_name, name) && !(mq ^ e->uses_mq))
> 
> 
> How about just (mq == e->uses_mq)?

That is simpler/cleaner, I'll make that adjustment. Not sure where the XOR
temptation came from.

-- 
Jens Axboe
