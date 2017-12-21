Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] nvme/pci: Remove cq_vector check in IO path
To: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-3-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <210d5bb5-2ac4-9b69-1207-37b1610554a8@kernel.dk>
Date: Thu, 21 Dec 2017 13:54:23 -0700
MIME-Version: 1.0
In-Reply-To: <20171221204636.2924-3-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/21/17 1:46 PM, Keith Busch wrote:
> This is a micro-optimization removing unnecessary check for a disabled
> queue. We no longer need this check because blk-mq provides the ability
> to quiesce queues that nvme uses, and the doorbell registers are never
> unmapped as long as requests are active.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
