Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz> <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk> <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 27 Oct 2016 19:32:16 +0200
Message-ID: <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra scheduler
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
	Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

[...]

>
> I'm hesistant to add a new scheduler because it's very easy to add, very
> difficult to get rid of. If we do add BFQ as a legacy scheduler now,
> it'll take us years and years to get rid of it again. We should be
> moving towards LESS moving parts in the legacy path, not more.

Jens, I think you are wrong here and let me try to elaborate on why.

1)
We already have legacy schedulers like CFQ, DEADLINE, etc - and most
block device drivers are still using the legacy blk interface.

To be able to remove the legacy blk layer, all block device drivers
must be converted to blkmq - of course.

So to reach that goal, we will not only need to evolve blkmq to allow
scheduling (at least for single queue devices), but we also need to
convert *all* block device drivers to blkmq. For sure this will take
*years* and not months.

More important, when the transition to blkmq has been completed, then
there is absolutely no difference (from effort point of view) in
removing the legacy blk layer - no matter if we have BFQ in there or
not.

I do understand if you have concern from maintenance point of view, as
I assume you would rather focus on evolving blkmq, than care about
legacy blk code. So, would it help if Paolo volunteers to maintain the
BFQ code in the meantime?

2)
While we work on evolving blkmq and convert block device drivers to
it, BFQ could as a separate legacy scheduler, help *lots* of Linux
users to get a significant improved experience. Should we really
prevent them from that? I think you block maintainer guys, really need
to consider this fact.

3)
While we work on scheduling in blkmq (at least for single queue
devices), it's of course important that we set high goals. Having BFQ
(and the other schedulers) in the legacy blk, provides a good
reference for what we could aim for.

>
> We can keep having this discussion every few years, but I think we'd
> both prefer to make some actual progress here. It's perfectly fine to
> add an interface for a single queue interface for an IO scheduler for
> blk-mq, since we don't care too much about scalability there. And that
> won't take years, that should be a few weeks. Retrofitting BFQ on top of
> that should not be hard either. That can co-exist with a real multiqueue
> scheduler as well, something that's geared towards some fairness for
> faster devices.

That's really great news!

I hope we get a possibility to meet and discuss the plans for this at
Kernel summit/Linux Plumbers the next week!

>
> --
> Jens Axboe

Kind regards
Ulf Hansson
