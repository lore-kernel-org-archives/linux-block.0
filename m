Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1492021462.2764.13.camel@sandisk.com>
References: <20170411235848.8686-1-bart.vanassche@sandisk.com>
 <CACVXFVOg3C-H14z5Qt1qz79qQeeg1zg6Xs2noHTHApwJ6+zwaw@mail.gmail.com> <1492021462.2764.13.camel@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 13 Apr 2017 09:20:16 +0800
Message-ID: <CACVXFVMMUkhMmBDzy5CtAaMSes8U7rNT4F-B4=H30Zr7-EfU0w@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Fix blk_execute_rq_nowait() handling of dying queues
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"snitzer@redhat.com" <snitzer@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 13, 2017 at 2:24 AM, Bart Van Assche
<Bart.VanAssche@sandisk.com> wrote:
> On Wed, 2017-04-12 at 13:01 +0800, Ming Lei wrote:
>> On Wed, Apr 12, 2017 at 7:58 AM, Bart Van Assche
>> <bart.vanassche@sandisk.com> wrote:
>> >
>> > diff --git a/block/blk-exec.c b/block/blk-exec.c
>> > index 8cd0e9bc8dc8..f7d9bed2cb15 100644
>> > --- a/block/blk-exec.c
>> > +++ b/block/blk-exec.c
>> > @@ -57,10 +57,13 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
>> >         rq->end_io = done;
>> >
>> >         /*
>> > -        * don't check dying flag for MQ because the request won't
>> > -        * be reused after dying flag is set
>> > +        * The blk_freeze_queue() call in blk_set_queue_dying() and the
>> > +        * test of the "dying" flag in blk_queue_enter() guarantee that
>> > +        * blk_execute_rq_nowait() won't be called anymore after the "dying"
>> > +        * flag has been set.
>>
>> That never be guaranteed, see the following case:
>>
>> 1) blk_get_request() is called just before queue is set as dying in another path
>>
>> 2) the request is allocated successfully and passed to
>> blk_execute_rq_nowait() even
>> though queue has been set as dying
>
> Hello Ming,
>
> Shouldn't the blk-mq code guarantee that blk_execute_rq_nowait() won't be
> called anymore after the "dying" flag has been set? I think changing the
> blk_freeze_queue_start() call into blk_freeze_queue() in blk_set_queue_dying()
> is sufficient to achieve this.

I have explained that this change isn't enough.

>
> Note: after I had posted this patch I have been able to reproduce the issue
> described in the patch description. Although I still think we need the patch
> at the start of this e-mail thread, it doesn't fix the issue I described.

Since it fixes nothing, I don't suggest to do that.


Thanks,
Ming Lei
