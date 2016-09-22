Return-Path: <hch@lst.de>
Date: Thu, 22 Sep 2016 15:57:53 +0200
From: Christoph Hellwing <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
	Christoph Hellwing <hch@lst.de>,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 0/2] block/mq: Convert to new hotplug state machine
Message-ID: <20160922135753.GB14645@lst.de>
References: <20160920152020.777561324@linutronix.de> <0d239a65-b34c-b062-0f44-4155c001143a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0d239a65-b34c-b062-0f44-4155c001143a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 20, 2016 at 09:48:39PM -0600, Jens Axboe wrote:
> On 09/20/2016 09:21 AM, Thomas Gleixner wrote:
>> The following series converts block/mq to the new hotplug state
>> machine. The series is against block.git/for-next and depends on
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/for-block
>>
>> This branch contains the necessary infrastructure for multi-instance
>> callbacks which allows us to remove blk-mq-cpu.c completely. It can be
>> pulled into the block tree.
>
> Thanks, I'll pull this in for 4.9.

I still can't find it in your tree despite other commits today.
