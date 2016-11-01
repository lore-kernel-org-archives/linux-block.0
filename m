Return-Path: <axboe@kernel.dk>
Subject: Re: block device direct I/O fast path
To: Christoph Hellwig <hch@lst.de>
References: <1477936765-8828-1-git-send-email-hch@lst.de>
 <20161101170019.GB9797@kernel.dk> <20161101170636.GA22639@lst.de>
 <20161101175437.GC9797@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d7350267-e3ec-958f-3c52-db219e424b80@kernel.dk>
Date: Tue, 1 Nov 2016 12:22:42 -0600
MIME-Version: 1.0
In-Reply-To: <20161101175437.GC9797@kernel.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/01/2016 11:54 AM, Jens Axboe wrote:
> On Tue, Nov 01 2016, Christoph Hellwig wrote:
>> On Tue, Nov 01, 2016 at 11:00:19AM -0600, Jens Axboe wrote:
>>> #2 is a bit more problematic, I'm pondering how we can implement that on
>>> top of the bio approach. The nice thing about the request based approach
>>> is that we have a 1:1 mapping with the unit on the driver side. And we
>>> have a place to store the timer. I don't particularly love the embedded
>>> timer, however, it'd be great to implement that differently. Trying to
>>> think of options there, haven't found any yet.
>>
>> I have a couple ideas for that.  Give me a few weeks and I'll send
>> patches.
>
> I'm not that patient :-)
>
> For the SYNC part, it should be easy enough to do by just using an
> on-stack hrtimer. I guess that will do for now, since we don't have
> poll support for async O_DIRECT right now anyway.
>
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.10/dio&id=e96d9afd56791a61d463cb88f8f3b48393b71020
>
> Untested, but should get the point across. I'll fire up a test box.

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.10/dio&id=b879a97d749c5c1755d1e2f20c721eb6fde0c291

Now tested, inadvertently used the absolute timer instead of the
relative. Works for me.

-- 
Jens Axboe
