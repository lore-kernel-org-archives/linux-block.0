Return-Path: <axboe@kernel.dk>
Subject: Re: [RFC PATCH 0/2] use larger max_request_size for virtio_blk
To: cohuck@redhat.com, mst@redhat.com, jasowang@redhat.com,
 linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <cover.1522922101.git.zhangweiping@didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <04280c25-aecb-3d79-e589-5fafa974d9e0@kernel.dk>
Date: Thu, 5 Apr 2018 08:29:47 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1522922101.git.zhangweiping@didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/5/18 4:09 AM, Weiping Zhang wrote:
> Hi,
> 
> For virtio block device, actually there is no a hard limit for max request
> size, and virtio_blk driver set -1 to blk_queue_max_hw_sectors(q, -1U);.
> But it doesn't work, because there is a default upper limitation
> BLK_DEF_MAX_SECTORS (1280 sectors). So this series want to add a new helper
> blk_queue_max_hw_sectors_no_limit to set a proper max reqeust size.
> 
> Weiping Zhang (2):
>   blk-setting: add new helper blk_queue_max_hw_sectors_no_limit
>   virtio_blk: add new module parameter to set max request size
> 
>  block/blk-settings.c       | 20 ++++++++++++++++++++
>  drivers/block/virtio_blk.c | 32 ++++++++++++++++++++++++++++++--
>  include/linux/blkdev.h     |  2 ++
>  3 files changed, 52 insertions(+), 2 deletions(-)

The driver should just use blk_queue_max_hw_sectors() to set the limit,
and then the soft limit can be modified by a udev rule. Technically the
driver doesn't own the software limit, it's imposed to ensure that we
don't introduce too much latency per request.

Your situation is no different from many other setups, where the
hw limit is much higher than the default 1280k.

-- 
Jens Axboe
