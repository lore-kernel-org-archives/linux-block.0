Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove parent device reference from struct
 bsg_class_device
To: Christoph Hellwig <hch@lst.de>
Cc: glagolig@gmail.com, fujita.tomonori@lab.ntt.co.jp,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20180529064023.9239-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f3fbbb60-99cf-3bf4-0b36-654d5b3895ec@kernel.dk>
Date: Tue, 29 May 2018 13:16:19 -0600
MIME-Version: 1.0
In-Reply-To: <20180529064023.9239-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/29/18 12:40 AM, Christoph Hellwig wrote:
> Bsg holding a reference to the parent device may result in a crash if a
> bsg file handle is closed after the parent device driver has unloaded.
> 
> Holding a reference is not really needed: the parent device must exist
> between bsg_register_queue and bsg_unregister_queue.  Before the device
> goes away the caller does blk_cleanup_queue so that all in-flight
> requests to the device are gone and all new requests cannot pass beyond
> the queue.  The queue itself is a refcounted object and it will stay
> alive with a bsg file.
> 
> Based on analysis, previous patch and changelog from Anatoliy Glagolev.

Applied, thanks.

-- 
Jens Axboe
