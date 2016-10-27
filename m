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
Cc: Paolo Valente <paolo.valente@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
 Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Grant Likely <grant.likely@secretlab.ca>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
Date: Thu, 27 Oct 2016 11:43:11 -0600
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/27/2016 11:32 AM, Ulf Hansson wrote:
> [...]
>
>>
>> I'm hesistant to add a new scheduler because it's very easy to add, very
>> difficult to get rid of. If we do add BFQ as a legacy scheduler now,
>> it'll take us years and years to get rid of it again. We should be
>> moving towards LESS moving parts in the legacy path, not more.
>
> Jens, I think you are wrong here and let me try to elaborate on why.
>
> 1)
> We already have legacy schedulers like CFQ, DEADLINE, etc - and most
> block device drivers are still using the legacy blk interface.

I don't think that's an accurate statement. In terms of coverage, most
drivers do support blk-mq. Anything SCSI, nvme, virtio-blk, SATA runs on
(or can run on) top of blk-mq.

> To be able to remove the legacy blk layer, all block device drivers
> must be converted to blkmq - of course.

That's a given.

> So to reach that goal, we will not only need to evolve blkmq to allow
> scheduling (at least for single queue devices), but we also need to
> convert *all* block device drivers to blkmq. For sure this will take
> *years* and not months.

Correct.

> More important, when the transition to blkmq has been completed, then
> there is absolutely no difference (from effort point of view) in
> removing the legacy blk layer - no matter if we have BFQ in there or
> not.
>
> I do understand if you have concern from maintenance point of view, as
> I assume you would rather focus on evolving blkmq, than care about
> legacy blk code. So, would it help if Paolo volunteers to maintain the
> BFQ code in the meantime?

We're obviously still maintaining the legacy IO path. But we don't want
to actively develop it, and we haven't, for a long time.

And Paolo maintaining it is a strict requirement for inclusion, legacy
or blk-mq aside. That would go for both. I'd never accept a major
feature from an individual or company if they weren't willing and
capable of maintaining it. Throwing submissions over the wall is not
viable.

> 2)
> While we work on evolving blkmq and convert block device drivers to
> it, BFQ could as a separate legacy scheduler, help *lots* of Linux
> users to get a significant improved experience. Should we really
> prevent them from that? I think you block maintainer guys, really need
> to consider this fact.

You still seem to be basing that assumption on the notion that we have
to convert tons of drivers for BFQ to make sense under the blk-mq
umbrella. That's not the case.

> 3)
> While we work on scheduling in blkmq (at least for single queue
> devices), it's of course important that we set high goals. Having BFQ
> (and the other schedulers) in the legacy blk, provides a good
> reference for what we could aim for.

Sure, but you don't need BFQ to be included in the kernel for that.

>> We can keep having this discussion every few years, but I think we'd
>> both prefer to make some actual progress here. It's perfectly fine to
>> add an interface for a single queue interface for an IO scheduler for
>> blk-mq, since we don't care too much about scalability there. And that
>> won't take years, that should be a few weeks. Retrofitting BFQ on top of
>> that should not be hard either. That can co-exist with a real multiqueue
>> scheduler as well, something that's geared towards some fairness for
>> faster devices.
>
> That's really great news!
>
> I hope we get a possibility to meet and discuss the plans for this at
> Kernel summit/Linux Plumbers the next week!

I'll be there.

-- 
Jens Axboe
