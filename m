Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:9999 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdKBMeH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Nov 2017 08:34:07 -0400
Subject: Re: [bug report after v4.5-rc1]block: When the scsi device has a
 timeout IO, the scsi device is stuck when it is deleted
To: "Zouming (IT)" <zouming.zouming@huawei.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
References: <32770656ECCC174D9F733890F5D00C0D99557B3A@dggemm511-mbs.china.huawei.com>
CC: wangzhoumengjian <wangzhoumengjian@huawei.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <77dc5059-a8db-6f9b-e4ee-1a65b030c9bf@hisilicon.com>
Date: Thu, 2 Nov 2017 20:33:46 +0800
MIME-Version: 1.0
In-Reply-To: <32770656ECCC174D9F733890F5D00C0D99557B3A@dggemm511-mbs.china.huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

在 2017/11/2 20:16, Zouming (IT) 写道:
> 1.Repeat steps:
> (1) send IO on the device /dev/sdx.
> (2) Simulate an IO lost
> (3) Use the command before to  delete scsi device  before IO timeout
>        ehco 1 > /sys/class/sdx/device/delete
>
> 2.The stack of delete thead is before:
> [<ffffffff810999ef>] msleep+0x2f/0x40
> [<ffffffff812f78b4>] __blk_drain_queue+0xa4/0x170
> [<ffffffff812f7bfd>] blk_cleanup_queue+0x13d/0x150
> [<ffffffff81473d2a>] __scsi_remove_device+0x4a/0xd0
> [<ffffffff81473dd6>] scsi_remove_device+0x26/0x40
> [<ffffffff81473e05>] sdev_store_delete_callback+0x15/0x20
> [<ffffffff8127fdc4>] sysfs_schedule_callback_work+0x14/0x60
> [<ffffffff810a881a>] process_one_work+0x17a/0x440
> [<ffffffff810a94e6>] worker_thread+0x126/0x3c0
> [<ffffffff810b098f>] kthread+0xcf/0xe0
> [<ffffffff816b4f18>] ret_from_fork+0x58/0x90
>
> 3.The reason is before:
>    (1) When the scsi device is deleted, invoke blk_cleanup_queue funtion to
>          set the flag of request_queue dying, and wait all IO back.
>
>    (2) when IO timout,the timeout workqueue invoke blk_timeout_work function to abort IO,
>         but it will not abort the IO because it call  blk_queue_enter funtion
>         judge the request_queue is dying and return direct without doing anything.

Hi Zouming,
You can have a test on Bart's patch "[PATCH] block: Fix a race between 
blk_cleanup_queue() and timeout handling" for this issue.
I think this patch can solve your issue.
