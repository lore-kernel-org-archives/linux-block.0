Return-Path: <axboe@kernel.dk>
Subject: Re: support for partial irq affinity assignment V3
To: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de
References: <1478654107-7384-1-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f5270fd9-488f-a954-ba3c-1f7800820731@kernel.dk>
Date: Tue, 8 Nov 2016 21:38:11 -0700
MIME-Version: 1.0
In-Reply-To: <1478654107-7384-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/08/2016 06:15 PM, Christoph Hellwig wrote:
> This series adds support for automatic interrupt assignment to devices
> that have a few vectors that are set aside for admin or config purposes
> and thus should not fall into the general per-cpu assginment pool.
>
> The first patch adds that support to the core IRQ and PCI/msi code,
> and the second is a small tweak to a block layer helper to make use
> of it.  I'd love to have both go into the same tree so that consumers
> of this (e.g. the virtio, scsi and rdma trees) only need to pull in
> one of these trees as dependency.

Series looks good to me, you can add my Acked-by to all of them.

-- 
Jens Axboe
