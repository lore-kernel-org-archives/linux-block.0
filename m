Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET 0/28] blk-mq driver conversions and legacy path removal
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <1540508961.66186.82.camel@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2be62d76-85d0-dbc8-ad1e-8d07127d445e@kernel.dk>
Date: Thu, 25 Oct 2018 17:11:57 -0600
MIME-Version: 1.0
In-Reply-To: <1540508961.66186.82.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 5:09 PM, Bart Van Assche wrote:
> On Thu, 2018-10-25 at 15:10 -0600, Jens Axboe wrote:
>> The first round of this went into 4.20-rc, but we've still some of
>> them pending. This patch series converts the remaining drivers to
>> blk-mq. The ones that support dual paths (like SCSI and DM) have
>> the non-mq path removed. At the end, legacy IO code and schedulers
>> are killed off.
>>
>> This patch series is on top of my for-linus branch. It can also
>> be bound in my mq-conversions branch.
> 
> Hi Jens,
> 
> I cloned your mq-conversions branch and ran the block, srp and nvmeof-mp
> test groups from the blktests project. The result of these tests on my
> setup is the same as with kernel v4.19: except for a few false positive
> lockdep complaints, all tests pass. The most recent commit that is
> involved in the false positive lockdep complaints I encountered is
> 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing").
> Patches are being discussed to address these false positives.

Great, thanks for doing this testing, Bart!

-- 
Jens Axboe
