Return-Path: <axboe@kernel.dk>
Subject: Re: blktest for [PATCH v2] block: do not use interruptible wait
 anywhere
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
 <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
 <1523608284.7787.3.camel@suse.de>
 <d1ce87d6-f77c-96d0-a3df-5ee5ed73a0bf@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <edda0c9e-93c3-2da1-9521-0775d41ca1c1@kernel.dk>
Date: Sat, 14 Apr 2018 13:52:22 -0600
MIME-Version: 1.0
In-Reply-To: <d1ce87d6-f77c-96d0-a3df-5ee5ed73a0bf@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/14/18 1:46 PM, Alan Jenkins wrote:
> On 13/04/18 09:31, Johannes Thumshirn wrote:
>> Hi Alan,
>>
>> On Thu, 2018-04-12 at 19:11 +0100, Alan Jenkins wrote:
>>> # dd if=/dev/sda of=/dev/null iflag=direct & \
>>>    while killall -SIGUSR1 dd; do sleep 0.1; done & \
>>>    echo mem > /sys/power/state ; \
>>>    sleep 5; killall dd  # stop after 5 seconds
>> Can you please also add a regression test to blktests[1] for this?
>>
>> [1] https://github.com/osandov/blktests
>>
>> Thanks,
>> 	Johannes
> 
> Good question. It would be nice to promote this test.
> 
> Template looks like I need the commit (sha1) first.
> 
> I had some ideas about automating it, so I wrote a standalone (see 
> end).  I can automate the wakeup by using pm_test, but this is still a 
> system suspend test.  Unfortunately I don't think there's any 
> alternative. To give the most dire example
> 
>      # This test is non-destructive, but it exercises suspend in all drivers.
>      # If your system has a problem with suspend, it might not wake up again.
> 
> 
> So I'm not sure if it would be acceptable for the default set?
> 
> How useful is this going to be? Is there an expanded/full set of tests 
> that gets run somewhere?
> 
> If you can't guarantee it's going to be run somewhere, I'd worry the 
> cost/benefit  feels a little narrow :-(. There were one or two further 
> "interesting" details, and it might theoretically bitrot if it's not run 
> periodically.

I run it, just last week we found two new bugs with it. I'm requiring
anyone that submits block patches to run the test suite, and also
working towards having it be part of the 0-day runs so it gets run
on posted patches automatically.

So yes, it's useful and it won't bitrot. Please do turn it into a blktests
test.

-- 
Jens Axboe
