Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
To: Paolo Valente <paolo.valente@linaro.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz>
 <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
 <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <C1E15CDB-81A7-4103-A01E-E50BA6329CCA@linaro.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
 Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 Hannes Reinecke <hare@suse.de>, grant.likely@secretlab.ca,
 James.Bottomley@hansenpartnership.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d9bee0b8-c761-3970-d2bc-80ca34722350@kernel.dk>
Date: Sat, 29 Oct 2016 08:12:57 -0600
MIME-Version: 1.0
In-Reply-To: <C1E15CDB-81A7-4103-A01E-E50BA6329CCA@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/28/2016 11:38 PM, Paolo Valente wrote:
>
>> Il giorno 26 ott 2016, alle ore 18:12, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 10/26/2016 10:04 AM, Paolo Valente wrote:
>>>
>>>> Il giorno 26 ott 2016, alle ore 17:32, Jens Axboe <axboe@kernel.dk> ha scritto:
>>>>
>>>> On 10/26/2016 09:29 AM, Christoph Hellwig wrote:
>>>>> On Wed, Oct 26, 2016 at 05:13:07PM +0200, Arnd Bergmann wrote:
>>>>>> The question to ask first is whether to actually have pluggable
>>>>>> schedulers on blk-mq at all, or just have one that is meant to
>>>>>> do the right thing in every case (and possibly can be bypassed
>>>>>> completely).
>>>>>
>>>>> That would be my preference.  Have a BFQ-variant for blk-mq as an
>>>>> option (default to off unless opted in by the driver or user), and
>>>>> not other scheduler for blk-mq.  Don't bother with bfq for non
>>>>> blk-mq.  It's not like there is any advantage in the legacy-request
>>>>> device even for slow devices, except for the option of having I/O
>>>>> scheduling.
>>>>
>>>> It's the only right way forward. blk-mq might not offer any substantial
>>>> advantages to rotating storage, but with scheduling, it won't offer a
>>>> downside either. And it'll take us towards the real goal, which is to
>>>> have just one IO path.
>>>
>>> ok
>>>
>>>> Adding a new scheduler for the legacy IO path
>>>> makes no sense.
>>>
>>> I would fully agree if effective and stable I/O scheduling would be
>>> available in blk-mq in one or two months.  But I guess that it will
>>> take at least one year optimistically, given the current status of the
>>> needed infrastructure, and given the great difficulties of doing
>>> effective scheduling at the high parallelism and extreme target speeds
>>> of blk-mq.  Of course, this holds true unless little clever scheduling
>>> is performed.
>>>
>>> So, what's the point in forcing a lot of users wait another year or
>>> more, for a solution that has yet to be even defined, while they could
>>> enjoy a much better system, and then switch an even better system when
>>> scheduling is ready in blk-mq too?
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
>> both prefer to make some actual progress here.
>
> ok Jens, I give up
>
>> It's perfectly fine to
>> add an interface for a single queue interface for an IO scheduler for
>> blk-mq, since we don't care too much about scalability there. And that
>> won't take years, that should be a few weeks. Retrofitting BFQ on top of
>> that should not be hard either. That can co-exist with a real multiqueue
>> scheduler as well, something that's geared towards some fairness for
>> faster devices.
>>
>
> AFAICT this solution is good, for many practical reasons.  I don't
> have the expertise to make such an infrastructure well on my own.  At
> least not in an acceptable amount of time, because working on this
> nice stuff is unfortunately not my job (although Linaro is now
> supporting me for BFQ).
>
> Then, assuming that this solution may be of general interest, and that
> BFQ benefits convinced you a little bit too, may I get significant
> collaboration/help on implementing this infrastructure?

Of course, I already offered to help with this.

> If so, Jens
> and all possibly interested parties, could we have a sort of short
> kick-off technical meeting during KS/LPC?

I'm not a huge fan of setting up a BoF to discuss something technical,
when there's no code to discuss yet. We need some actual meat on the
bone in the shape of code, and that's much better dealt with in email.
Timing is pretty advanced at this point, otherwise I'd offer to cook
something up that we COULD discuss, but I will not have time to do that
for KS.

If you are at LPC, why don't the two of us sit down and talk about it
Wednesday or Thursday? I'd like to try and understand what parts of
blk-mq you aren't up to speed on, and how we can best get a simple
framework going that will allow us to entertain single queue scheduling
within blk-mq.

-- 
Jens Axboe
