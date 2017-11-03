Return-Path: <axboe@kernel.dk>
Subject: Re: block layer patches for nvme multipath support
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20171102182954.9263-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <983167e5-5e0c-9d83-bde3-ee0ec9bd3223@kernel.dk>
Date: Fri, 3 Nov 2017 10:33:36 -0600
MIME-Version: 1.0
In-Reply-To: <20171102182954.9263-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/02/2017 12:29 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> these patches add the block layer helpers / tweaks for NVMe multipath
> support.  Can you review them for inclusion?
> 
> There have been no functional changes to the versions posted with
> previous nvme multipath patchset.

I've queued this up. I really hate the direct_make_request(), but
I also don't have a good suggestion on how to do this any better
right now.

-- 
Jens Axboe
