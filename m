Return-Path: <klimov.linux@gmail.com>
MIME-Version: 1.0
In-Reply-To: <x49r3h2ag8y.fsf@segfault.boston.devel.redhat.com>
References: <1452822371-4967-1-git-send-email-klimov.linux@gmail.com>
	<x49r3h2ag8y.fsf@segfault.boston.devel.redhat.com>
Date: Thu, 31 Mar 2016 00:31:58 +0100
Message-ID: <CALW4P++6YkPidw33i5x1zMoC4VvZ6uJT2=E4EZD_WHztsRZxGQ@mail.gmail.com>
Subject: Re: [PATCH] elevator: remove second argument in elevator_init()
From: Alexey Klimov <klimov.linux@gmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
	Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi all,

On Wed, Jan 27, 2016 at 9:01 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Alexey Klimov <klimov.linux@gmail.com> writes:
>
>> Last user of elevator_init() with non-NULL name as second argument
>> that supposed to be s390 dasd driver has gone few releases ago.
>> Drivers rely on elevator_change(), elevator_switch() and friends
>> for example. Right now elevator_init() is always called as
>> elevator_init(q, NULL).
>>
>> Patch removes passing of second name argument and its usage.
>>
>> While we're at it fix following if-check after removed lines. We know
>> that elevator_type e is initialized by NULL and need to check only
>> chosen_elevator.
>>
>> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>


what is the status of this patch? Is it that wrong and are there some
concerns or do I need to resend it?


Best regards,
Alexey


>> ---
>>  block/blk-core.c         |  2 +-
>>  block/elevator.c         | 10 ++--------
>>  include/linux/elevator.h |  2 +-
>>  3 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 33e2f62..f742ef4 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -861,7 +861,7 @@ blk_init_allocated_queue(struct request_queue *q, request_fn_proc *rfn,
>>       mutex_lock(&q->sysfs_lock);
>>
>>       /* init elevator */
>> -     if (elevator_init(q, NULL)) {
>> +     if (elevator_init(q)) {
>>               mutex_unlock(&q->sysfs_lock);
>>               goto fail;
>>       }
>> diff --git a/block/elevator.c b/block/elevator.c
>> index c3555c9..ff5c830 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -177,7 +177,7 @@ static void elevator_release(struct kobject *kobj)
>>       kfree(e);
>>  }
>>
>> -int elevator_init(struct request_queue *q, char *name)
>> +int elevator_init(struct request_queue *q)
>>  {
>>       struct elevator_type *e = NULL;
>>       int err;
>> @@ -196,18 +196,12 @@ int elevator_init(struct request_queue *q, char *name)
>>       q->end_sector = 0;
>>       q->boundary_rq = NULL;
>>
>> -     if (name) {
>> -             e = elevator_get(name, true);
>> -             if (!e)
>> -                     return -EINVAL;
>> -     }
>> -
>>       /*
>>        * Use the default elevator specified by config boot param or
>>        * config option.  Don't try to load modules as we could be running
>>        * off async and request_module() isn't allowed from async.
>>        */
>> -     if (!e && *chosen_elevator) {
>> +     if (*chosen_elevator) {
>>               e = elevator_get(chosen_elevator, false);
>>               if (!e)
>>                       printk(KERN_ERR "I/O scheduler %s not found\n",
>> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
>> index 638b324..0ae0efd 100644
>> --- a/include/linux/elevator.h
>> +++ b/include/linux/elevator.h
>> @@ -154,7 +154,7 @@ extern void elv_unregister(struct elevator_type *);
>>  extern ssize_t elv_iosched_show(struct request_queue *, char *);
>>  extern ssize_t elv_iosched_store(struct request_queue *, const char *, size_t);
>>
>> -extern int elevator_init(struct request_queue *, char *);
>> +extern int elevator_init(struct request_queue *);
>>  extern void elevator_exit(struct elevator_queue *);
>>  extern int elevator_change(struct request_queue *, const char *);
>>  extern bool elv_rq_merge_ok(struct request *, struct bio *);
