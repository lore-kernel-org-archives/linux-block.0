Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] blk-mq: two patches related with CPU hotplug
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
 "jianchao . wang" <jianchao.w.wang@oracle.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <20180117164152.7066-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d9a66835-c832-a8a3-a29e-1f6715505343@kernel.dk>
Date: Wed, 17 Jan 2018 09:49:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180117164152.7066-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/17/18 9:41 AM, Ming Lei wrote:
> Hi Jens,
> 
> The 1st one fixes one regression caused by 20e4d81393 ("blk-mq: simplify
> queue mapping & schedule with each possisble CPU").
> 
> The 2nd one add comments for current two races, and convert the WARN_ON
> into printk(KERN_WARN) with dump_stack() since this warning is harmless.
> 
> V2:
> 	- fix comment and commit log in patch 1
> 	- use dump_stack() with printk to replace WARN_ON() in patch 2

Applied, thanks.

-- 
Jens Axboe
