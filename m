Return-Path: <axboe@kernel.dk>
Subject: Re: Silent data corruption in blkdev_direct_IO()
To: Martin Wilck <mwilck@suse.com>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
 <3419a3ae-da82-9c20-26e1-7c9ed14ff8ed@kernel.dk>
 <a1679897-ed41-1ceb-f94f-bd1be537ce4e@suse.de>
 <57a2b121-9805-8337-fb97-67943670f250@kernel.dk>
 <a0b0e59b-60cd-9933-6752-4c21a7a975fe@kernel.dk>
 <2311947c2f0f368bd10474edb0f0f5b51dde6b7d.camel@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b85c5eff-d6dc-e43c-8e2c-608249ae81a2@kernel.dk>
Date: Fri, 13 Jul 2018 12:00:41 -0600
MIME-Version: 1.0
In-Reply-To: <2311947c2f0f368bd10474edb0f0f5b51dde6b7d.camel@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/13/18 10:56 AM, Martin Wilck wrote:
> On Thu, 2018-07-12 at 10:42 -0600, Jens Axboe wrote:
>>
>> Hence the patch I sent is wrong, the code actually looks fine. Which
>> means we're back to trying to figure out what is going on here. It'd
>> be great with a test case...
> 
> We don't have an easy test case yet. But the customer has confirmed
> that the problem occurs with upstream 4.17.5, too. We also confirmed
> again that the problem occurs when the kernel uses the kmalloc() code
> path in __blkdev_direct_IO_simple().
> 
> My personal suggestion would be to ditch __blkdev_direct_IO_simple()
> altogether. After all, it's not _that_ much simpler thatn
> __blkdev_direct_IO(), and it seems to be broken in a subtle way.

That's not a great suggestion at all, we need to find out why we're
hitting the issue. For all you know, the bug could be elsewhere and
we're just going to be hitting it differently some other way. The
head-in-the-sand approach is rarely a win long term.

It's saving an allocation per IO, that's definitely measurable on
the faster storage. For reads, it's also not causing a context
switch for dirtying pages. I'm not a huge fan of multiple cases
in general, but this one is definitely warranted in an era where
1 usec is a lot of extra time for an IO.

> However, so far I've only identified a minor problem, see below - it
> doesn't explain the data corruption we're seeing.

What would help is trying to boil down a test case. So far it's a lot
of hand waving, and nothing that can really help narrow down what is
going on here.

-- 
Jens Axboe
