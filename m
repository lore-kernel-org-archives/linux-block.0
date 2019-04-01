Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8E2C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 08:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75546214C6
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 08:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfDAI7s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:59:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbfDAI7s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 04:59:48 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 71F2EC2916541F21CD32;
        Mon,  1 Apr 2019 16:59:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 1 Apr 2019
 16:59:42 +0800
Subject: Re: [PATCH 1/2] block: remove devt from ext_devt_idr when delete
 partition
To:     Jan Kara <jack@suse.cz>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <tj@kernel.org>,
        <hch@lst.de>, <viro@zeniv.linux.org.uk>, <bart.vanassche@wdc.com>,
        "Keith Busch" <keith.busch@intel.com>
References: <20190318140703.28963-1-yuyufen@huawei.com>
 <20190318140703.28963-2-yuyufen@huawei.com>
 <bb6f69c4-b8d6-32cb-3a90-40c2ad2bf0a7@huawei.com>
 <20190329224244.GE8757@quack2.suse.cz>
From:   yuyufen <yuyufen@huawei.com>
Message-ID: <39e2ec62-9dac-accb-728c-69cac9d24ace@huawei.com>
Date:   Mon, 1 Apr 2019 16:59:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190329224244.GE8757@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi


On 2019/3/30 6:42, Jan Kara wrote:
> On Sat 23-03-19 20:51:45, yuyufen wrote:
>> This patch fix use-after-free on gendisk when open the disk partition.
>>
>> Ping and Cc
>>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Bart Van Assche <bart.vanassche@wdc.com>
>> Cc: Jan Kara <jack@suse.cz>
>>
>> Yufen
>> Thanks
>>
>> On 2019/3/18 22:07, Yufen Yu wrote:
>>> In part_release(), it will remove devt from ext_devt_idr and
>>> get_gendisk cannot find it. But, if disk_release() works before
>>> part_release, open device partition may cause use-after-free of
>>> disk in get_gendisk(). We use md device as example, the race sence:
>>>
>>> Process1	Worker			Process2
>>> md_free
>>> 					blkdev_open
>>> del_gendisk
>>>     add delete_partition_work_fn() to wq
>>>     					__blkdev_get
>>> 					get_gendisk
>>> put_disk
>>>     disk_release
>>>       kfree(disk)
>>>       					find part from ext_devt_idr
>>> 					get_disk_and_module(disk)
>>>       					  cause use after free
>>>
>>>       		delete_partition_work_fn
>>> 		put_device(part)
>>>       		  part_release
>>> 		    remove part from ext_devt_idr
>>>
>>> Before Woker thread removes part from ext_devt_idr, Process2 can find
>>> the part and access the disk, resulting use-after-free.
>>>
>>> We fix this by removing the devt from ext_devt_idr when delete partition.
>>>
>>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> Thanks for your analysis and the patch! I agree with our analysis of the
> problem but I'm afraid the fix won't be so straightforward. The problem is
> that once you remove device number from idr, it can get reallocated for
> another device. So if nothing else, the idr_remove() call you've left in
> part_release() could delete *newly created device* from idr which is not
> what you want. And even if this is fixed, there are other possible issues
> with reallocating device number before the device is fully shutdown -
> commit 2da78092dda "block: Fix dev_t minor allocation lifetime"
> specifically moved blk_free_devt(dev->devt) call to part_release() to avoid
> such issues (sadly without explaining more details). Adding Keith to CC
> just in case he remembers.
>
> Anyway, you are right that it is fundamentally wrong to expose a structure
> (hd_struct in our case) for lookup in idr when it is essentially scheduled
> for RCU-delayed freeing. So what we can do is to replace hd_struct pointer
> in idr with some placeholder value - NULL seems to be OK with idr - and
> delete the entry from idr in part_release() as we do now. We can call this
> new helper blk_invalidate_devt() or something like that.
>
> 								Honza
>

Thanks a lot for your detailed explanation:-). And replacing hd_struct 
pointer by
NULL in idr is a good idea. I will send v2 for this problem.

Yufen
Thanks

>>> ---
>>>    block/partition-generic.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/block/partition-generic.c b/block/partition-generic.c
>>> index 1ee3e1d1bc2a..30d1039d5e8d 100644
>>> --- a/block/partition-generic.c
>>> +++ b/block/partition-generic.c
>>> @@ -288,6 +288,11 @@ void delete_partition(struct gendisk *disk, int partno)
>>>    	kobject_put(part->holder_dir);
>>>    	device_del(part_to_dev(part));
>>> +	/*
>>> +	 * We should ensuere to delete part from idr before kfree(disk),
>>> +	 * avoiding use-after-free of disk.
>>> +	 */
>>> +	blk_free_devt(part_devt(part));
>>>    	hd_struct_kill(part);
>>>    }
>>


