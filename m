Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz>
 <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
 <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
 <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
 <CAPDyKFpLhp0eoS8LWy-jU0_U_cWq4immq2+bPdi-j7=oa24OjA@mail.gmail.com>
Cc: Paolo Valente <paolo.valente@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
 Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Grant Likely <grant.likely@secretlab.ca>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e792e932-cf16-4272-2388-ae813a0372b6@kernel.dk>
Date: Thu, 27 Oct 2016 15:08:51 -0600
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpLhp0eoS8LWy-jU0_U_cWq4immq2+bPdi-j7=oa24OjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/27/2016 01:34 PM, Ulf Hansson wrote:
> [...]
>
>>> Instead, what I can tell, as we have been looking into converting mmc
>>> (which I maintains) and that is indeed a significant amount of work.
>>> We will need to rip out all of the mmc request management, and most
>>> likely we also need to extend the blkmq interface - as to be able to
>>> do re-implement all the current request optimizations. We are looking
>>> into this, but it just takes time.
>>
>>
>> It's usually as much work as you make it into, for most cases it's
>> pretty straight forward and usually removes more code than it adds.
>> Hence the end result is better for it as well - less code in a driver is
>> better.
>
> From a scalability and maintenance point of view, converting to blkmq
> makes perfect sense.
>
> Although, me personally don't want to sacrifice on performance (at
> least very little), just for the sake of gaining in
> scalability/maintainability.

Nobody has said anything about sacrificing performance. And whether you
like it or not, maintainability is always the most important aspect.
Even performance takes a backseat to maintainability.

> I would rather strive to adopt the blkmq framework to also suit my
> needs. Then it simply do takes more time.
>
> For example, in the mmc case we have implemented an asynchronous
> request path, which greatly improves performance on some systems.

blk-mq has evolved to support a variety of devices, there's nothing
special about mmc that can't work well within that framework.

>>>>> 3)
>>>>> While we work on scheduling in blkmq (at least for single queue
>>>>> devices), it's of course important that we set high goals. Having BFQ
>>>>> (and the other schedulers) in the legacy blk, provides a good
>>>>> reference for what we could aim for.
>>>>
>>>>
>>>>
>>>> Sure, but you don't need BFQ to be included in the kernel for that.
>>>
>>>
>>> Perhaps not.
>>>
>>> But does that mean, you expect Paolo to maintain an up to date BFQ
>>> tree for you?
>>
>>
>> I don't expect anything. If Paolo or others want to compare with BFQ on
>> the legacy IO path, then they can do that however way they want. If you
>> (and others) want to have that reference point, it's up to you how to
>> accomplish that.
>
> Do I get this right? You personally don't care about using BFQ as
> reference when evolving blkmq for single queue devices?
>
> Paolo and lots of other Linux users certainly do care about this.

I'm getting a little tired of this putting words in my mouth... That is
not what I'm saying at all. What I'm saying is that the people working
on BFQ can do what they need to do to have a reference implementation to
compare against. You don't need BFQ in the kernel for that. I said it's
up to YOU, with the you here meaning the people that want to work on it,
how that goes down.

> Moreover, I am still trying to understand what's the big deal to why
> you say no to BFQ as a legacy scheduler. Ideally it shouldn't cause
> you any maintenance burden and it doesn't make the removal of the
> legacy blk layer any more difficult, right?

Not sure I can state it much clearer. It's a new scheduler, and a
complicated one at that. It WILL carry a maintenance burden. And I'm
really not that interested in adding such a burden for something that
will be defunct as soon as the single queue blk-mq version is done.
Additionally, if we put BFQ in right now, the motivation to do the real
work will be gone.

The path forward is clear. It'd be a lot better to put some work behind
that, rather than continue this email thread.

-- 
Jens Axboe
