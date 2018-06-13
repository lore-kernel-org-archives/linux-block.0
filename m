Return-Path: <prvs=695691628=Bart.VanAssche@wdc.com>
Subject: Re: [PATCH] blkdev_report_zones_ioctl(): Use vmalloc() to allocate
 large buffers
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Shaun Tancheff <shaun.tancheff@seagate.com>,
 Damien Le Moal <damien.lemoal@hgst.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.com>, stable@vger.kernel.org
References: <20180522152722.15920-1-bart.vanassche@wdc.com>
 <a903a9f6-e78d-d35d-c644-5a99c45f6919@kernel.dk>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <f7dfa181-6a4e-581c-7f4a-bd10c51e8de6@wdc.com>
Date: Wed, 13 Jun 2018 08:20:42 -0700
MIME-Version: 1.0
In-Reply-To: <a903a9f6-e78d-d35d-c644-5a99c45f6919@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 05/22/18 10:58, Jens Axboe wrote:
> On 5/22/18 9:27 AM, Bart Van Assche wrote:
>> Avoid that complaints similar to the following appear in the kernel log
>> if the number of zones is sufficiently large:
>>
>>    fio: page allocation failure: order:9, mode:0x140c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null)
>>    Call Trace:
>>    dump_stack+0x63/0x88
>>    warn_alloc+0xf5/0x190
>>    __alloc_pages_slowpath+0x8f0/0xb0d
>>    __alloc_pages_nodemask+0x242/0x260
>>    alloc_pages_current+0x6a/0xb0
>>    kmalloc_order+0x18/0x50
>>    kmalloc_order_trace+0x26/0xb0
>>    __kmalloc+0x20e/0x220
>>    blkdev_report_zones_ioctl+0xa5/0x1a0
>>    blkdev_ioctl+0x1ba/0x930
>>    block_ioctl+0x41/0x50
>>    do_vfs_ioctl+0xaa/0x610
>>    SyS_ioctl+0x79/0x90
>>    do_syscall_64+0x79/0x1b0
>>    entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> 
> Applied, thanks.

Thank you Jens. This patch (commit 327ea4adcfa3) is now in Linus tree.
We would like this patch to appear in the v4.14 and v4.17 kernel series 
too. Since this patch does not have a stable tag, how do you want us
to proceed? Do you want to send this patch yourself to Greg or do you
rather expect us to do that?

Thanks,

Bart.
