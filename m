Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 00/12] blk-mq: fix & improve queue quiescing
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20170606152210.22806-1-ming.lei@redhat.com>
 <08a2b32d-866e-a71f-4ac6-9c131edb88e2@fb.com>
 <20170613021518.GB15043@ming.t460p> <20170618202604.GA14417@kernel.dk>
 <1497827149.16169.1.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <547999d5-8231-6dbd-3a79-0716dd070c9b@kernel.dk>
Date: Sun, 18 Jun 2017 17:48:05 -0600
MIME-Version: 1.0
In-Reply-To: <1497827149.16169.1.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/18/2017 05:05 PM, Bart Van Assche wrote:
> On Sun, 2017-06-18 at 14:26 -0600, Jens Axboe wrote:
>> On Tue, Jun 13 2017, Ming Lei wrote:
>>> If you are fine with 3-12, could you consider it for v4.13?
>>>
>>> The fixes on uses of blk_mq_tagset_busy_iter() depends on
>>> this patchset.
>>
>> Yes, I think it looks fine. I've applied the rest, except the nvme
>> patch, which no longer applies since start/stop changes have been made
>> there. Please resend that one against for-4.13/block, thanks.
> 
> Hello Jens,
> 
> Are you aware that these changes conflict with Martin's 4.13/scsi-queue
> branch? Who should work on resolving this conflict?

Nope. Not a huge problem - send it to Stephen since -next will see this
conflict shortly. And then Martin should keep it handy for sending his
pull request to Linus, as I always ship early.

Longer term, basing the scsi tree on the block tree might not be a bad
idea...

-- 
Jens Axboe
