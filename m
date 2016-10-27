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
Cc: Paolo Valente <paolo.valente@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
 Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Grant Likely <grant.likely@secretlab.ca>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
Date: Thu, 27 Oct 2016 12:21:06 -0600
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/27/2016 12:13 PM, Ulf Hansson wrote:
>>> 2)
>>> While we work on evolving blkmq and convert block device drivers to
>>> it, BFQ could as a separate legacy scheduler, help *lots* of Linux
>>> users to get a significant improved experience. Should we really
>>> prevent them from that? I think you block maintainer guys, really need
>>> to consider this fact.
>>
>>
>> You still seem to be basing that assumption on the notion that we have
>> to convert tons of drivers for BFQ to make sense under the blk-mq
>> umbrella. That's not the case.
>
> Well, let's not argue about how many. It's pretty easy to check that.

I wasn't arguing - you made a false or misleading statement, I had to
correct that.

Most of the drivers that haven't been converted yet are themselves for
legacy hardware. Some are not, though, and it'd be great to get those
converted. But coverage wise, we're in pretty good shape.

> Instead, what I can tell, as we have been looking into converting mmc
> (which I maintains) and that is indeed a significant amount of work.
> We will need to rip out all of the mmc request management, and most
> likely we also need to extend the blkmq interface - as to be able to
> do re-implement all the current request optimizations. We are looking
> into this, but it just takes time.

It's usually as much work as you make it into, for most cases it's
pretty straight forward and usually removes more code than it adds.
Hence the end result is better for it as well - less code in a driver is
better.

> I can imagine, that it's not always a straight forward "convert to blk
> mq" patch for every block device driver.

Well, I've actually done a few conversions, and it's not difficult at
all. The grunt of the work is usually around converting to using some of
the blk-mq features for parts of the driver that it had implemented
privately, like timeout handling, etc.

I'm always happy to help people with converting drivers.

>>> 3)
>>> While we work on scheduling in blkmq (at least for single queue
>>> devices), it's of course important that we set high goals. Having BFQ
>>> (and the other schedulers) in the legacy blk, provides a good
>>> reference for what we could aim for.
>>
>>
>> Sure, but you don't need BFQ to be included in the kernel for that.
>
> Perhaps not.
>
> But does that mean, you expect Paolo to maintain an up to date BFQ
> tree for you?

I don't expect anything. If Paolo or others want to compare with BFQ on
the legacy IO path, then they can do that however way they want. If you
(and others) want to have that reference point, it's up to you how to
accomplish that.

-- 
Jens Axboe
