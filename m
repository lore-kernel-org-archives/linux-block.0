Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <04280c25-aecb-3d79-e589-5fafa974d9e0@kernel.dk>
References: <cover.1522922101.git.zhangweiping@didichuxing.com> <04280c25-aecb-3d79-e589-5fafa974d9e0@kernel.dk>
From: Weiping Zhang <zwp10758@gmail.com>
Date: Sat, 7 Apr 2018 16:30:53 +0800
Message-ID: <CAA70yB6_W_xHWaph4CT3-h91fSX_9EBG94bp6gafoTPys8KhzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] use larger max_request_size for virtio_blk
To: Jens Axboe <axboe@kernel.dk>
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
	linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2018-04-05 22:29 GMT+08:00 Jens Axboe <axboe@kernel.dk>:
> On 4/5/18 4:09 AM, Weiping Zhang wrote:
>> Hi,
>>
>> For virtio block device, actually there is no a hard limit for max request
>> size, and virtio_blk driver set -1 to blk_queue_max_hw_sectors(q, -1U);.
>> But it doesn't work, because there is a default upper limitation
>> BLK_DEF_MAX_SECTORS (1280 sectors). So this series want to add a new helper
>> blk_queue_max_hw_sectors_no_limit to set a proper max reqeust size.
>>
>> Weiping Zhang (2):
>>   blk-setting: add new helper blk_queue_max_hw_sectors_no_limit
>>   virtio_blk: add new module parameter to set max request size
>>
>>  block/blk-settings.c       | 20 ++++++++++++++++++++
>>  drivers/block/virtio_blk.c | 32 ++++++++++++++++++++++++++++++--
>>  include/linux/blkdev.h     |  2 ++
>>  3 files changed, 52 insertions(+), 2 deletions(-)
>
> The driver should just use blk_queue_max_hw_sectors() to set the limit,
> and then the soft limit can be modified by a udev rule. Technically the
> driver doesn't own the software limit, it's imposed to ensure that we
> don't introduce too much latency per request.
>
> Your situation is no different from many other setups, where the
> hw limit is much higher than the default 1280k.
>
Hi Martin, Jens,

It seems more reasonable to change software limitation by udev rule,
thanks you.

>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
