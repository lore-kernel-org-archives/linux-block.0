Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760277AbdDSHoN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 03:44:13 -0400
Date: Wed, 19 Apr 2017 15:44:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/3] mtip32xx: make it working with mq scheduler
Message-ID: <20170419074401.GA13212@ming.t460p>
References: <20170419003142.9581-1-ming.lei@redhat.com>
 <20170419062713.GA1372@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170419062713.GA1372@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 18, 2017 at 11:27:13PM -0700, Christoph Hellwig wrote:
> Hi Ming,
> 
> I don't think your patch goes int the right direction.  The mtip32xx
> driver never submits the requests it allocates using blk_mq_alloc_request.
> So to fix this it should simply kmalloc the request, set a tag aside
> and not use a block layer request for it at all, similar to what nvme
> does for the AER command.

That is only about the internal command part(patch 1 and patch 2),
and the patch 3 is required regardless.

I choose to use blk_mq_get_driver_tag() for the 1st fix becasue it is the
simpleset way, also given blk_mq_alloc_request() has been working on that
for long time.

If We do that via kmalloc, the command has to be initialzed as the way in
.init_cmd(), the reserved tag space has to be accessed exclusively like what
block layer provides, and mtip_cmd_from_tag() need to be fixed too.
We still have to pass 'reserved_tags = 1' to blk-mq anyway.

That is why I suggest to use blk_mq_get_driver_tag() to fix the issue.

Thanks,
Ming
