Return-Path: <hare@suse.de>
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-7-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1d2fe3fa-564f-c056-bbc5-b80282bee912@suse.de>
Date: Thu, 19 Oct 2017 14:45:03 +0200
MIME-Version: 1.0
In-Reply-To: <20171018165258.23212-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/18/2017 06:52 PM, Christoph Hellwig wrote:
> With this flag a driver can create a gendisk that can be used for I/O
> submission inside the kernel, but which is not registered as user
> facing block device.  This will be useful for the NVMe multipath
> implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c         | 53 ++++++++++++++++++++++++++++++++++-----------------
>  include/linux/genhd.h |  1 +
>  2 files changed, 36 insertions(+), 18 deletions(-)
> 
To quote:

On Fri, Oct 06, 2017 at 09:13 AM, Christoph Hellwig wrote:
> On Fri, Oct 06, 2017 at 10:39:50AM +1100, NeilBrown wrote:
[ .. ]
>>
>> There is some precedent for hiding things from /proc/partitions.
>> removable devices like CDROMs are hidden, and you can easily hide
>> individual devices by setting GENHD_FL_SUPPRESS_PARTITION_INFO.
>> We might be able to get that through.  It is certainly worth writing
>> a patch and letting people experiment with it.
>
> No way in hell this would get through.  Preemptive NAK right here.
>
> That whole idea is just amazingly stupid, and no one has even
> explained a reason for it.

I wonder what has changed ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
