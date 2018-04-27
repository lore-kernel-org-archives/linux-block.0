Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] scsi: scsi-mq: don't hold host_busy in IO path
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "hare@suse.de" <hare@suse.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "don.brace@microsemi.com" <don.brace@microsemi.com>,
 "james.bottomley@hansenpartnership.com"
 <james.bottomley@hansenpartnership.com>, "osandov@fb.com" <osandov@fb.com>,
 "loberman@redhat.com" <loberman@redhat.com>,
 "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
References: <20180420065742.8043-1-ming.lei@redhat.com>
 <87619135ac0bfefa07f510170024b609e641db0c.camel@wdc.com>
 <607c4d2f-28e7-4152-dbf5-7fb4387e9413@kernel.dk>
 <647b4fe833fdf001f724cfa0803c9e3a79d78b13.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <df0f3eb5-b320-91f4-1eab-0aa8b9c836ea@kernel.dk>
Date: Fri, 27 Apr 2018 10:19:54 -0600
MIME-Version: 1.0
In-Reply-To: <647b4fe833fdf001f724cfa0803c9e3a79d78b13.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/27/18 9:48 AM, Bart Van Assche wrote:
> On Fri, 2018-04-27 at 09:39 -0600, Jens Axboe wrote:
>> blk_mq_tagset_busy_iter(&shost->tag_set, scsi_host_check_in_flight,
>> 			&in_flight);
>> return in_flight.cnt + atomic_read(&shost->host_busy);
>>
>> The atomic read is basically free, once we get rid of the dirty of that
>> variable on each IO.
> 
> Hello Jens,
> 
> What makes you think that " + atomic_read(&shost->host_busy)" is necessary?
> I am not aware of any code outside the SCSI core that modifies the host_busy
> member.

It's a (scalable) hack to count those as well. Going forward they should be
converted to just using reserved tags, of course.

-- 
Jens Axboe
