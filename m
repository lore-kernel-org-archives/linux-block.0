Return-Path: <neutrino8@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20161027092656.GD19743@quack2.suse.cz>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz> <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk> <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk> <20161027092656.GD19743@quack2.suse.cz>
From: Grozdan <neutrino8@gmail.com>
Date: Thu, 27 Oct 2016 16:34:25 +0200
Message-ID: <CAFLt3pgEFH2CfO+W3mrXGHBPvLQ+EtNNH1Ojx-qfxtYSDVmKCA@mail.gmail.com>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra scheduler
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
	Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>, Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
	Hannes Reinecke <hare@suse.de>, grant.likely@secretlab.ca,
	James.Bottomley@hansenpartnership.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 27, 2016 at 11:26 AM, Jan Kara <jack@suse.cz> wrote:
> On Wed 26-10-16 10:12:38, Jens Axboe wrote:
>> On 10/26/2016 10:04 AM, Paolo Valente wrote:
>> >
>> >>Il giorno 26 ott 2016, alle ore 17:32, Jens Axboe <axboe@kernel.dk> ha scritto:
>> >>
>> >>On 10/26/2016 09:29 AM, Christoph Hellwig wrote:
>> >>>On Wed, Oct 26, 2016 at 05:13:07PM +0200, Arnd Bergmann wrote:
>> >>>>The question to ask first is whether to actually have pluggable
>> >>>>schedulers on blk-mq at all, or just have one that is meant to
>> >>>>do the right thing in every case (and possibly can be bypassed
>> >>>>completely).
>> >>>
>> >>>That would be my preference.  Have a BFQ-variant for blk-mq as an
>> >>>option (default to off unless opted in by the driver or user), and
>> >>>not other scheduler for blk-mq.  Don't bother with bfq for non
>> >>>blk-mq.  It's not like there is any advantage in the legacy-request
>> >>>device even for slow devices, except for the option of having I/O
>> >>>scheduling.
>> >>
>> >>It's the only right way forward. blk-mq might not offer any substantial
>> >>advantages to rotating storage, but with scheduling, it won't offer a
>> >>downside either. And it'll take us towards the real goal, which is to
>> >>have just one IO path.
>> >
>> >ok
>> >
>> >>Adding a new scheduler for the legacy IO path
>> >>makes no sense.
>> >
>> >I would fully agree if effective and stable I/O scheduling would be
>> >available in blk-mq in one or two months.  But I guess that it will
>> >take at least one year optimistically, given the current status of the
>> >needed infrastructure, and given the great difficulties of doing
>> >effective scheduling at the high parallelism and extreme target speeds
>> >of blk-mq.  Of course, this holds true unless little clever scheduling
>> >is performed.
>> >
>> >So, what's the point in forcing a lot of users wait another year or
>> >more, for a solution that has yet to be even defined, while they could
>> >enjoy a much better system, and then switch an even better system when
>> >scheduling is ready in blk-mq too?
>>
>> That same argument could have been made 2 years ago. Saying no to a new
>> scheduler for the legacy framework goes back roughly that long. We could
>> have had BFQ for mq NOW, if we didn't keep coming back to this very
>> point.
>>
>> I'm hesistant to add a new scheduler because it's very easy to add, very
>> difficult to get rid of. If we do add BFQ as a legacy scheduler now,
>> it'll take us years and years to get rid of it again. We should be
>> moving towards LESS moving parts in the legacy path, not more.
>>
>> We can keep having this discussion every few years, but I think we'd
>> both prefer to make some actual progress here. It's perfectly fine to
>> add an interface for a single queue interface for an IO scheduler for
>> blk-mq, since we don't care too much about scalability there. And that
>> won't take years, that should be a few weeks. Retrofitting BFQ on top of
>> that should not be hard either. That can co-exist with a real multiqueue
>> scheduler as well, something that's geared towards some fairness for
>> faster devices.
>
> OK, so some solution like having a variant of blk_sq_make_request() that
> will consume requests, do IO scheduling decisions on them, and feed them
> into the HW queue is it sees fit would be acceptable? That will provide the
> IO scheduler a global view that it needs for complex scheduling decisions
> so it should indeed be relatively easy to port BFQ to work like that.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Hello,

Let me first say that I'm in no way associated with Paolo Valente or
any other BFQ developer. I'm a mere user who has had great experience
using BFQ

My workload is one that takes my disks to their limits. I often use
large files like raw Blu-ray streams which then I remux to mkv's while
at the same time streaming at least 2 movies to various devices in
house and using my system as I do while the remuxing process is going
on. At times, I'm also pushing video files to my NAS at close to Gbps
speed while the stuff I mentioned is in progress

My experience with BFQ is that it has never resulted in the video
streams being interrupted due to disk trashing. I've extensively used
all the other Linux disk schedulers in the past and what I've observed
is that whenever I start the remuxing (and copying) process, the
streams will begin to hiccup, stutter and often multi-seconds long
"waits" will occur. It gets even worse, when I do this kind of
workload, the whole system will come to almost a halt and
interactivity goes out the window. Impossible to start an app in a
reasonable amount of time. Loading a visited website makes Chrome hang
while trying to get the contents from its cache, etc

BFQ has greatly helped to have a responsive system during such
operations and as I said, I have never experience any interruption of
the video streams. Do I think BFQ is the best thing since sliced
bread? No, as with BFQ too there are sometimes corner cases where it
takes too long to start a program. But if I was on one of the other
disk schedulers, most of the time that program won't start at all
until the disk gets some "relief"

So in the end, I'm here to support the inclusion of BFQ. Paolo has put
too much energy, time, and sleepless nights into this so people like
me can have a working, responsive system during heavy disk operations.
>From a normal user's perspective, I do not want BFQ to be dismissed
and all the effort/time/etc thrown out the window. From my
perspective, Paolo deserves more support from the guys in charge of
the block layer in Linux.

Thanks :)



-- 
Yours truly
