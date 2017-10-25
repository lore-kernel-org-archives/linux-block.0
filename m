Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] elevator: allow name aliases
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org
References: <1508954687-3204-1-git-send-email-axboe@kernel.dk>
 <1508954687-3204-3-git-send-email-axboe@kernel.dk>
 <20171025183206.GB9160@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a12b081b-f7f0-0d60-52b9-8435fc7b36d5@kernel.dk>
Date: Wed, 25 Oct 2017 11:32:46 -0700
MIME-Version: 1.0
In-Reply-To: <20171025183206.GB9160@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/2017 11:32 AM, Omar Sandoval wrote:
> On Wed, Oct 25, 2017 at 12:04:46PM -0600, Jens Axboe wrote:
>> Since we now lookup elevator types with the appropriate multiqueue
>> capability, allow schedulers to register with an alias alongside
>> the real name. This is in preparation for allowing 'mq-deadline'
>> to register an alias of 'deadline' as well.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/elevator.c         | 22 ++++++++++++++++------
>>  include/linux/elevator.h |  1 +
>>  2 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/elevator.c b/block/elevator.c
>> index b70e69f795db..dc0432e12ecf 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -83,6 +83,16 @@ bool elv_bio_merge_ok(struct request *rq, struct bio *bio)
>>  }
>>  EXPORT_SYMBOL(elv_bio_merge_ok);
>>  
>> +static bool elevator_match(const struct elevator_type *e, const char *name)
>> +{
>> +	if (!strcmp(e->elevator_name, name))
>> +		return true;
>> +	if (e->elevator_alias && !strcmp(e->elevator_alias, name))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>  /*
>>   * Return scheduler with name 'name' and with matching 'mq capability
>>   */
>> @@ -91,7 +101,7 @@ static struct elevator_type *elevator_find(const char *name, bool mq)
>>  	struct elevator_type *e;
>>  
>>  	list_for_each_entry(e, &elv_list, list) {
>> -		if (!strcmp(e->elevator_name, name) && !(mq ^ e->uses_mq))
>> +		if (elevator_match(e, name) && !(mq ^ e->uses_mq))
>>  			return e;
>>  	}
>>  
>> @@ -922,9 +932,9 @@ int elv_register(struct elevator_type *e)
>>  	spin_unlock(&elv_list_lock);
>>  
>>  	/* print pretty message */
>> -	if (!strcmp(e->elevator_name, chosen_elevator) ||
>> +	if (elevator_match(e, chosen_elevator) ||
>>  			(!*chosen_elevator &&
>> -			 !strcmp(e->elevator_name, CONFIG_DEFAULT_IOSCHED)))
>> +			 elevator_match(e, CONFIG_DEFAULT_IOSCHED)))
>>  				def = " (default)";
>>  
>>  	printk(KERN_INFO "io scheduler %s registered%s\n", e->elevator_name,
>> @@ -1077,8 +1087,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
>>  	if (!e)
>>  		return -EINVAL;
>>  
>> -	if (q->elevator &&
>> -	    !strcmp(elevator_name, q->elevator->type->elevator_name)) {
>> +	if (q->elevator && elevator_match(q->elevator->type, elevator_name)) {
>>  		elevator_put(e);
>>  		return 0;
>>  	}
>> @@ -1126,7 +1135,8 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
>>  
>>  	spin_lock(&elv_list_lock);
>>  	list_for_each_entry(__e, &elv_list, list) {
>> -		if (elv && !strcmp(elv->elevator_name, __e->elevator_name)) {
>> +		if (elv && elevator_match(elv, __e->elevator_name) &&
>> +		    !(__e->uses_mq ^ (q->mq_ops != NULL))) {
> 
> Same thing here, (__e->uses_mq == (q->mq_ops != NULL)). Still confusing
> but less so.

I'll just add a

bool uses_mq = q->mq_ops != NULL;

to make it clearer.

-- 
Jens Axboe
