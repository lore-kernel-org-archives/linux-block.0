Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] blk-mq: support physical CPU hotplug
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Haberland <sth@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20180112025306.28004-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0b61848b-a911-9115-524d-60e778f8a300@kernel.dk>
Date: Fri, 12 Jan 2018 11:02:13 -0700
MIME-Version: 1.0
In-Reply-To: <20180112025306.28004-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/11/18 7:53 PM, Ming Lei wrote:
> Hi,
> 
> This two patches support physical CPU hotplug, so that we can make blk-mq
> scale well when new physical CPU is added or removed, and this use case
> is normal for VM world.
> 
> Also this patchset fixes the following warning reported by Christian
> Borntraeger:
> 
> 	https://marc.info/?l=linux-block&m=151092973417143&w=2
> 
> Christoph Hellwig (2):
>   genirq/affinity: assign vectors to all possible CPUs
>   blk-mq: simplify queue mapping & schedule with each possisble CPU

Applied, thanks Ming.

-- 
Jens Axboe
