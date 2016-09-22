Return-Path: <axboe@kernel.dk>
Subject: Re: [patch V2 0/2] block/mq: Convert to new hotplug state machine
To: Christoph Hellwing <hch@lst.de>
References: <20160920152020.777561324@linutronix.de>
 <0d239a65-b34c-b062-0f44-4155c001143a@kernel.dk>
 <20160922135753.GB14645@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
 Sebastian Siewior <bigeasy@linutronix.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bb61e8ee-c58f-e05d-a979-4649cb60f383@kernel.dk>
Date: Thu, 22 Sep 2016 08:05:45 -0600
MIME-Version: 1.0
In-Reply-To: <20160922135753.GB14645@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/22/2016 07:57 AM, Christoph Hellwing wrote:
> On Tue, Sep 20, 2016 at 09:48:39PM -0600, Jens Axboe wrote:
>> On 09/20/2016 09:21 AM, Thomas Gleixner wrote:
>>> The following series converts block/mq to the new hotplug state
>>> machine. The series is against block.git/for-next and depends on
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/for-block
>>>
>>> This branch contains the necessary infrastructure for multi-instance
>>> callbacks which allows us to remove blk-mq-cpu.c completely. It can be
>>> pulled into the block tree.
>>
>> Thanks, I'll pull this in for 4.9.
>
> I still can't find it in your tree despite other commits today.

Didn't get to it yesterday, done now.

-- 
Jens Axboe
