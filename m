Return-Path: <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH] block: remove parent device reference from struct
 bsg_class_device
From: James Bottomley <jejb@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: glagolig@gmail.com, fujita.tomonori@lab.ntt.co.jp,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Date: Tue, 29 May 2018 11:57:01 -0700
In-Reply-To: <20180529064023.9239-1-hch@lst.de>
References: <20180529064023.9239-1-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527620221.3169.9.camel@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-05-29 at 08:40 +0200, Christoph Hellwig wrote:
> Bsg holding a reference to the parent device may result in a crash if
> a bsg file handle is closed after the parent device driver has
> unloaded.
> 
> Holding a reference is not really needed: the parent device must
> exist between bsg_register_queue and bsg_unregister_queue.  Before
> the device goes away the caller does blk_cleanup_queue so that all
> in-flight requests to the device are gone and all new requests cannot
> pass beyond the queue.  The queue itself is a refcounted object and
> it will stay alive with a bsg file.
> 
> Based on analysis, previous patch and changelog from Anatoliy
> Glagolev.

This works nicely for me, thanks!

Reviewed-by: James E.J. Bottomley <jejb@linux.vnet.ibm.com>

James
