Return-Path: <axboe@kernel.dk>
Subject: Re: [patch V2 0/2] block/mq: Convert to new hotplug state machine
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20160920152020.777561324@linutronix.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwing <hch@lst.de>,
 Sebastian Siewior <bigeasy@linutronix.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0d239a65-b34c-b062-0f44-4155c001143a@kernel.dk>
Date: Tue, 20 Sep 2016 21:48:39 -0600
MIME-Version: 1.0
In-Reply-To: <20160920152020.777561324@linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/20/2016 09:21 AM, Thomas Gleixner wrote:
> The following series converts block/mq to the new hotplug state
> machine. The series is against block.git/for-next and depends on
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/for-block
>
> This branch contains the necessary infrastructure for multi-instance
> callbacks which allows us to remove blk-mq-cpu.c completely. It can be
> pulled into the block tree.

Thanks, I'll pull this in for 4.9.

-- 
Jens Axboe
