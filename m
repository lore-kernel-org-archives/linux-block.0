Return-Path: <hare@suse.com>
Subject: Re: [PATCH] genhd: Do not hold event lock when scheduling workqueue
 elements
To: Bart Van Assche <Bart.VanAssche@sandisk.com>, "hare@suse.de"
 <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
References: <1484732896-22941-1-git-send-email-hare@suse.de>
 <1485822639.2669.16.camel@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jth@kernel.org" <jth@kernel.org>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <532c55c4-15da-d2f9-401c-36bc4343756b@suse.com>
Date: Tue, 31 Jan 2017 17:15:06 +0100
MIME-Version: 1.0
In-Reply-To: <1485822639.2669.16.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/31/2017 01:31 AM, Bart Van Assche wrote:
> On Wed, 2017-01-18 at 10:48 +0100, Hannes Reinecke wrote:
>> @@ -1488,26 +1487,13 @@ static unsigned long disk_events_poll_jiffies(struct gendisk *disk)
>>  void disk_block_events(struct gendisk *disk)
>>  {
>>         struct disk_events *ev = disk->ev;
>> -       unsigned long flags;
>> -       bool cancel;
>>  
>>         if (!ev)
>>                 return;
>>  
>> -       /*
>> -        * Outer mutex ensures that the first blocker completes canceling
>> -        * the event work before further blockers are allowed to finish.
>> -        */
>> -       mutex_lock(&ev->block_mutex);
>> -
>> -       spin_lock_irqsave(&ev->lock, flags);
>> -       cancel = !ev->block++;
>> -       spin_unlock_irqrestore(&ev->lock, flags);
>> -
>> -       if (cancel)
>> +       if (atomic_inc_return(&ev->block) == 1)
>>                 cancel_delayed_work_sync(&disk->ev->dwork);
>>  
>> -       mutex_unlock(&ev->block_mutex);
>>  }
> 
> Hello Hannes,
> 
> I have already encountered a few times a deadlock that was caused by the
> event checking code so I agree with you that it would be a big step forward
> if such deadlocks wouldn't occur anymore. However, this patch realizes a
> change that has not been described in the patch description, namely that
> disk_block_events() calls are no longer serialized. Are you sure it is safe
> to drop the serialization of disk_block_events() calls?
> 
Well, this whole synchronization stuff it a bit weird; I so totally fail
to see the rationale for it.
But anyway, once we've converted ev->block to atomics I _think_ the
mutex_lock can remain; will be checking.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
