Return-Path: <axboe@kernel.dk>
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Christoph Hellwig <hch@lst.de>
References: <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com>
 <a74de948-3026-d9b3-6b2e-b9cc1f3c05d4@deltatee.com>
 <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com>
 <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com>
 <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
 <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com>
 <20161109010959.GA32126@lst.de>
 <b3d8c5fa-b930-b21f-3986-1ff94611c7f9@wdc.com>
 <a6d1d368-04a2-e999-a610-abd96add81a9@fb.com>
 <03cda65e-3a82-6ccd-861b-67a55888eb19@kernel.dk>
 <20161109020517.GA759@lst.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 Mike Snitzer <snitzer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5d03d5ff-caea-9d0b-f530-b00012acd322@kernel.dk>
Date: Tue, 8 Nov 2016 19:11:24 -0700
MIME-Version: 1.0
In-Reply-To: <20161109020517.GA759@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/08/2016 07:05 PM, Christoph Hellwig wrote:
> On Tue, Nov 08, 2016 at 07:02:52PM -0700, Jens Axboe wrote:
>> It smells like an accounting error. One thing that I don't like with the
>> current scheme is the implicit knowledge that certain flags imply sync
>> as well. If we clear any of those flags, then we screw up accounting at
>> the end.
>>
>> Does this make a difference?
>
> That looks interesting.  In the meantime I reproduced a similar
> hang, but only half-way through an xfstests run with a non-mq device.
> I'll see how far I can narrow it down and will give your patch a try as
> well.

It'd only trigger on non-mq, and the symptoms (and the bisect) point at
this being an accounting issue. Damien/Logan, would be great you could
try the debug patch I sent.

My non-mq drive on my test box has write through caching, which probably
explains why I haven't seen the issue.

-- 
Jens Axboe
