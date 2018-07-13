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
 <b85c5eff-d6dc-e43c-8e2c-608249ae81a2@kernel.dk>
 <d14f5d9d08742fba54ee97e51ab0eafbf9d9088f.camel@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d7baebbd-1cd5-e6f1-c170-15e6dde67797@kernel.dk>
Date: Fri, 13 Jul 2018 14:52:08 -0600
MIME-Version: 1.0
In-Reply-To: <d14f5d9d08742fba54ee97e51ab0eafbf9d9088f.camel@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/13/18 2:48 PM, Martin Wilck wrote:
>> For all you know, the bug could be elsewhere and
>> we're just going to be hitting it differently some other way. The
>> head-in-the-sand approach is rarely a win long term.
>>
>> It's saving an allocation per IO, that's definitely measurable on
>> the faster storage. 
> 
> I an see that for the inline path, but is there still an advantage if
> we need to kmalloc() the biovec?

It's still one allocation instead of two. In the era of competing with
spdk on single digit latency devices, the answer is yes.

>>> However, so far I've only identified a minor problem, see below -
>>> it
>>> doesn't explain the data corruption we're seeing.
>>
>> What would help is trying to boil down a test case. So far it's a lot
>> of hand waving, and nothing that can really help narrow down what is
>> going on here.
> 
> It's not that we didn't try. We've run fio with verification on block
> devices with varying io sizes, block sizes, and alignments, but so far
> we haven't hit the issue. We've also tried to reproduce it by
> approximating the customer's VM setup, with no success up to now.

I ran some testing yesterday as well, but didn't trigger anything.
Didn't expect to either, as all the basic functionality was verified
when the patch was done. It's not really a path with a lot of corner
cases, so it's really weird that we're seeing anything at all. Which is
why I'm suspecting it's something else entirely, but it's really hard to
guesstimate on that with no clues at all.

> However, we're now much closer than we used to be, so I'm confident
> that we'll be able to present more concrete facts soon.

OK, sounds good.

-- 
Jens Axboe
