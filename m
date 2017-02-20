Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Bart Van Assche <Bart.VanAssche@sandisk.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <1D08B61A9CF0974AA09887BE32D889DA0A74F3@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <633d226d-cec3-a01f-a069-ffff307e9715@kernel.dk>
 <1487556740.2244.15.camel@HansenPartnership.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <75b9d9d8-9395-c7af-b29d-f016e9921498@kernel.dk>
Date: Sun, 19 Feb 2017 19:59:53 -0700
MIME-Version: 1.0
In-Reply-To: <1487556740.2244.15.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/19/2017 07:12 PM, James Bottomley wrote:
> On Sun, 2017-02-19 at 18:15 -0700, Jens Axboe wrote:
>> On 02/19/2017 06:09 PM, Bart Van Assche wrote:
>>> On 02/19/2017 04:11 PM, Jens Axboe wrote:
>>>> - Removal of the BLOCK_PC support in struct request, and
>>>> refactoring of
>>>>   carrying SCSI payloads in the block layer. This cleans up the
>>>> code
>>>>   nicely, and enables us to kill the SCSI specific parts of
>>>> struct
>>>>   request, shrinking it down nicely. From Christoph mainly, with
>>>> help
>>>>   from Hannes.
>>>
>>> Hello Jens, Christoph and Mike,
>>>
>>> Is anyone working on a fix for the regression introduced by the 
>>> BLOCK_PC removal changes (general protection fault) that I had 
>>> reported three weeks ago? See also
>>> https://www.spinics.net/lists/raid/msg55494.html
>>
>> I don't think that's a regression in this series, it just triggers 
>> more easily with this series. The BLOCK_PC removal fixes aren't 
>> touching device life times at all.
>>
>> That said, we will look into this again, of course. Christoph, any
>> idea?
> 
> We could do with tracing the bdi removal failure issue fingered both by
> the block xfstests and Omar.  It's something to do with this set of
> commits
> 
>> - Fixes for duplicate bdi registrations and bdi/queue life time
>>   problems from Jan and Dan.
> 
> But no-one has actually root caused it yet.

The above set from Jan and Dan fixed one set of issues around this, and
the reproducer test case was happy as well. But we've recently found
that there are still corner cases that aren't happy, Omar reported that
separately on Friday. So there will be a followup set for that,
hopefully intersecting with the issue that Bart reported.

-- 
Jens Axboe
