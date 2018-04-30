Return-Path: <sandeen@sandeen.net>
Subject: Re: [PATCH 2/2] xfs: add 'discard_sync' mount flag
To: Jens Axboe <axboe@kernel.dk>, "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
 linux-block@vger.kernel.org, hch@lst.de
References: <1525102372-8430-1-git-send-email-axboe@kernel.dk>
 <1525102372-8430-3-git-send-email-axboe@kernel.dk>
 <20180430171945.GB22176@bfoster.bfoster>
 <24df628d-c861-6f39-96a8-d759902d1fe3@kernel.dk>
 <20180430182525.GE27875@wotan.suse.de>
 <4cb68c8e-bf6c-b717-73f0-20e850582004@sandeen.net>
 <210ebc4e-780a-1cf2-92e0-2482b98704a2@kernel.dk>
 <c149cd30-97ba-cd86-de8d-efb83825521a@sandeen.net>
 <6f4137ac-d7c2-2727-d1da-649df30f3682@kernel.dk>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5d5d6d6a-f312-a2ad-8718-97a2f334ec7f@sandeen.net>
Date: Mon, 30 Apr 2018 17:59:05 -0500
MIME-Version: 1.0
In-Reply-To: <6f4137ac-d7c2-2727-d1da-649df30f3682@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/30/18 2:58 PM, Jens Axboe wrote:
> On 4/30/18 1:57 PM, Eric Sandeen wrote:
>> On 4/30/18 2:21 PM, Jens Axboe wrote:

...

>> Ok, but I'm not sure how that precludes a block device tunable?  You'd tune
>> it for your workload, right?
> 
> What kind of tunable are you thinking of? Right now we have one tunable,
> which is the max discard size. Patch #1 actually helps make this do what
> it should for sync discards, instead of just building a bio chain and
> submitting that all at once.
> 
>> Or is the concern that it could only be for the entire block device, and
>> perhaps different partitions have different workloads?
>>
>> Sorry, caveman filesystem guy doesn't completely understand block devices.
> 
> I just don't know what you are trying to tune :-)

I'm wondering if "make discards synchronous" couldn't just be a block device
tunable, rather than a filesystem mount option tunable.

-Eric
