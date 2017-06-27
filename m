Return-Path: <axboe@kernel.dk>
Subject: Re: block: spread MSI(-X) vectors to all possible CPUs
To: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170626102058.10200-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5dee80fb-8439-8611-a5f2-a30f1aefb835@kernel.dk>
Date: Tue, 27 Jun 2017 12:24:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170626102058.10200-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/26/2017 04:20 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series contains the left-over block bits to spread the MSI-X
> vectors over all CPU.  Thomas already rewrote and then merged the
> irq bits into the tip irq/core branch, and this is the remainder.
> 
> As there are no dependencies on other block changes adding them
> to the tip tree might be easiest if Jens could ACK them.

Looks fine to me, you can add my Reviewed-by if you want to funnel
them through the tip tree.

-- 
Jens Axboe
