Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B58C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 14:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BB720883
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 14:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDIOH1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:07:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfDIOH1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 10:07:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 89CD1F1E68AF7FE76F09;
        Tue,  9 Apr 2019 22:07:24 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
 22:07:22 +0800
Subject: Re: [PATCH v3] block: fix use-after-free on gendisk
To:     <axboe@kernel.dk>
CC:     Jan Kara <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <bart.vanassche@wdc.com>, <linux-block@vger.kernel.org>
References: <20190402120634.51040-1-yuyufen@huawei.com>
 <20190402151639.GB25668@quack2.suse.cz>
From:   yuyufen <yuyufen@huawei.com>
Message-ID: <e7b738e1-dca9-f744-6ead-b3175bf81c07@huawei.com>
Date:   Tue, 9 Apr 2019 22:07:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190402151639.GB25668@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping ?


On 2019/4/2 23:16, Jan Kara wrote:
> On Tue 02-04-19 20:06:34, Yufen Yu wrote:
>> commit 2da78092dda "block: Fix dev_t minor allocation lifetime"
>> specifically moved blk_free_devt(dev->devt) call to part_release()
>> to avoid reallocating device number before the device is fully
>> shutdown.
>>
>> However, it can cause use-after-free on gendisk in get_gendisk().
>> We use md device as example to show the race scenes:
>>
>> Process1		Worker			Process2
>> md_free
>> 						blkdev_open
>> del_gendisk
>>    add delete_partition_work_fn() to wq
>>    						__blkdev_get
>> 						get_gendisk
>> put_disk
>>    disk_release
>>      kfree(disk)
>>      						find part from ext_devt_idr
>> 						get_disk_and_module(disk)
>>      					  	cause use after free
>>
>>      			delete_partition_work_fn
>> 			put_device(part)
>>      		  	part_release
>> 		    	remove part from ext_devt_idr
>>
>> Before <devt, hd_struct pointer> is removed from ext_devt_idr by
>> delete_partition_work_fn(), we can find the devt and then access
>> gendisk by hd_struct pointer. But, if we access the gendisk after
>> it have been freed, it can cause in use-after-freeon gendisk in
>> get_gendisk().
>>
>> We fix this by adding a new helper blk_invalidate_devt() in
>> delete_partition() and del_gendisk(). It replaces hd_struct
>> pointer in idr with value 'NULL', and deletes the entry from
>> idr in part_release() as we do now.
>>
>> Thanks to Jan Kara for providing the solution and more clear comments
>> for the code.
>>
>> Fixes: 2da78092dda1 ("block: Fix dev_t minor allocation lifetime")
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Bart Van Assche <bart.vanassche@wdc.com>
>> Cc: Keith Busch <keith.busch@intel.com>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> Thanks. The patch looks good to me. You can add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
>
>> ---
>>   block/genhd.c             | 19 +++++++++++++++++++
>>   block/partition-generic.c |  7 +++++++
>>   include/linux/genhd.h     |  1 +
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 961b2bc4634f..a4ef0068dbb2 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -529,6 +529,18 @@ void blk_free_devt(dev_t devt)
>>   	}
>>   }
>>   
>> +/**
>> + *	We invalidate devt by assigning NULL pointer for devt in idr.
>> + */
>> +void blk_invalidate_devt(dev_t devt)
>> +{
>> +	if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
>> +		spin_lock_bh(&ext_devt_lock);
>> +		idr_replace(&ext_devt_idr, NULL, blk_mangle_minor(MINOR(devt)));
>> +		spin_unlock_bh(&ext_devt_lock);
>> +	}
>> +}
>> +
>>   static char *bdevt_str(dev_t devt, char *buf)
>>   {
>>   	if (MAJOR(devt) <= 0xff && MINOR(devt) <= 0xff) {
>> @@ -791,6 +803,13 @@ void del_gendisk(struct gendisk *disk)
>>   
>>   	if (!(disk->flags & GENHD_FL_HIDDEN))
>>   		blk_unregister_region(disk_devt(disk), disk->minors);
>> +	/*
>> +	 * Remove gendisk pointer from idr so that it cannot be looked up
>> +	 * while RCU period before freeing gendisk is running to prevent
>> +	 * use-after-free issues. Note that the device number stays
>> +	 * "in-use" until we really free the gendisk.
>> +	 */
>> +	blk_invalidate_devt(disk_devt(disk));
>>   
>>   	kobject_put(disk->part0.holder_dir);
>>   	kobject_put(disk->slave_dir);
>> diff --git a/block/partition-generic.c b/block/partition-generic.c
>> index 1ee3e1d1bc2a..7cf769103a25 100644
>> --- a/block/partition-generic.c
>> +++ b/block/partition-generic.c
>> @@ -288,6 +288,13 @@ void delete_partition(struct gendisk *disk, int partno)
>>   	kobject_put(part->holder_dir);
>>   	device_del(part_to_dev(part));
>>   
>> +	/*
>> +	 * Remove gendisk pointer from idr so that it cannot be looked up
>> +	 * while RCU period before freeing gendisk is running to prevent
>> +	 * use-after-free issues. Note that the device number stays
>> +	 * "in-use" until we really free the gendisk.
>> +	 */
>> +	blk_invalidate_devt(part_devt(part));
>>   	hd_struct_kill(part);
>>   }
>>   
>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>> index 06c0fd594097..69db1affedb0 100644
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -610,6 +610,7 @@ struct unixware_disklabel {
>>   
>>   extern int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
>>   extern void blk_free_devt(dev_t devt);
>> +extern void blk_invalidate_devt(dev_t devt);
>>   extern dev_t blk_lookup_devt(const char *name, int partno);
>>   extern char *disk_name (struct gendisk *hd, int partno, char *buf);
>>   
>> -- 
>> 2.16.2.dirty
>>


