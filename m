Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 1/5] nvme: track subsystems
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-2-hch@lst.de>
 <fbacd62b-4228-60cb-a382-9c88daadb336@grimberg.me>
 <20171109125356.GB21795@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <69e9a206-6776-8f57-0c5b-7870d7bbe6bc@grimberg.me>
Date: Thu, 9 Nov 2017 15:01:54 +0200
MIME-Version: 1.0
In-Reply-To: <20171109125356.GB21795@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> Any reason to do all this before we know if we found an existing subsystem?
> 
> We'd either have to do all the initialization including the memory
> allocation and ida_simple_get under nvme_subsystems_lock, or search
> the list first, then allocate, then search again.
> 
> Given that the not found case is vastly more common than the found
> case that doesn't seem to be worth the tradeoff.

Noted.
