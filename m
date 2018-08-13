Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 0/2] Fix a race condition related to creation of
 /dev/nvme0n<x>
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180813172531.7451-1-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6f10ca9c-ba9b-50ac-3c8c-fb62d7dd750c@suse.de>
Date: Mon, 13 Aug 2018 20:42:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180813172531.7451-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/13/2018 07:25 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> The two patches in this series fix a race condition related to the creation of
> the sysfs attributes for the /dev/nvme0n<x> devices nodes. I encountered this
> race while adding tests to the blktests project for the NVMeOF kernel
> drivers. Please consider these patches for the upstream kernel.
> 
> Thanks,
> 
> Bart.
> 
> Bart Van Assche (2):
>    block: Introduce alloc_disk_node_attr()
>    nvme: Fix race conditions related to creation of /dev/nvme0n<x>
> 
>   block/genhd.c                | 26 ++++++++++++++++++++++++--
>   drivers/nvme/host/core.c     | 17 +++++------------
>   drivers/nvme/host/lightnvm.c | 34 +++++++---------------------------
>   drivers/nvme/host/nvme.h     |  9 ++++-----
>   include/linux/genhd.h        | 13 +++++++++++--
>   5 files changed, 51 insertions(+), 48 deletions(-)
> 
I have fixed the very same thing with my patchset titled "genhd: 
register default groups with device_add_disk" which is waiting for 
inclusion.

Cheers,

Hannes
