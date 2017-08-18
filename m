Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-pci: add a fallback when pci_irq_get_affinity
 returns NULL
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20170817102447.28819-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <19fcbeda-9507-048f-d794-b4f3be95765c@kernel.dk>
Date: Fri, 18 Aug 2017 08:08:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170817102447.28819-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/17/2017 04:24 AM, Christoph Hellwig wrote:
> While pci_irq_get_affinity should never fail for SMP kernel that
> implement the affinity mapping, it will always return NULL in the
> UP case, so provide a fallback mapping of all queues to CPU 0 in
> that case.

Applied for 4.13.

-- 
Jens Axboe
