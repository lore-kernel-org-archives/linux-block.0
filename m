Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/6] Avoid that scsi-mq and dm-mq queue processing
 stalls sporadically
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <20170407181654.27836-1-bart.vanassche@sandisk.com>
 <78b80b12-a764-a793-f8a1-7a941dc84ee5@kernel.dk>
 <1491590023.2559.18.camel@sandisk.com> <1491590377.2559.22.camel@sandisk.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <97a0b03e-a1f2-4033-9dd3-c0a9c70d7bdc@kernel.dk>
Date: Fri, 7 Apr 2017 12:51:24 -0600
MIME-Version: 1.0
In-Reply-To: <1491590377.2559.22.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/07/2017 12:39 PM, Bart Van Assche wrote:
> On Fri, 2017-04-07 at 11:33 -0700, Bart Van Assche wrote:
>> On Fri, 2017-04-07 at 12:23 -0600, Jens Axboe wrote:
>>> On 04/07/2017 12:16 PM, Bart Van Assche wrote:
>>>> Hello Jens,
>>>>
>>>> The six patches in this patch series fix the queue lockup I reported
>>>> recently on the linux-block mailing list. Please consider these patches
>>>> for inclusion in the upstream kernel.
>>>
>>> Some of this we need in 4.11, but not all of it. I can't be applying patches
>>> that "improve scalability" at this point.
>>>
>>> 4-6 looks like what we want for 4.11, I'll see if those apply directly. Then
>>> we can put 1-3 on top in 4.12, with the others pulled in first.
>>
>> Hello Jens,
>>
>> Please note that patch 2/6 is a bug fix. The current implementation of
>> blk_mq_sched_restart_queues() only considers hardware queues associated with
>> the same request queue as the hardware queue that has been passed as an
>> argument. If a tag set is shared across request queues - as is the case for
>> SCSI - then all request queues that share a tag set with the hctx argument
>> must be considered.
> 
> (replying to my own e-mail)
> 
> Hello Jens,
> 
> If you want I can split that patch into two patches - one that runs all hardware
> queues with which the tag set is shared and one that switches from rerunning
> all hardware queues to one hardware queue.

I already put it in, but this is getting very awkward. We're at -rc5 time, patches
going into mainline should be TINY. And now I'm sitting on this, that I have to
justify:

 15 files changed, 281 insertions(+), 164 deletions(-)

and where one of the patches reads like it's a performance improvement, when
in reality it's fixing a hang. So yes, the patch should have been split in
two, and the series should have been ordered so that the first patches could
go into 4.11, and the rest on top of that in 4.12. Did we really need a
patch clarifying comments in that series? Probably not.

-- 
Jens Axboe
