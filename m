Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EBCC433FE
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 09:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiJRJFh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiJRJFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 05:05:25 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2BD1A39B
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 02:05:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ms7DV6jBVz6Pncj
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 17:02:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDnLS5FbE5jtncvAA--.49965S3;
        Tue, 18 Oct 2022 17:05:11 +0800 (CST)
Subject: Re: [PATCH 2/2] block: clear the holder releated fields on late
 disk_add failure
To:     Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221018073822.646207-1-hch@lst.de>
 <20221018073822.646207-2-hch@lst.de>
 <8c5359e3-39ee-d363-9425-0cb8b716dcb0@huaweicloud.com>
 <20221018082651.GA26079@lst.de>
 <4c5acbb5-72e6-3f63-2e78-478d3230aa0c@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7c021c4f-d31c-1a2b-70e4-4f21fea31488@huaweicloud.com>
Date:   Tue, 18 Oct 2022 17:05:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4c5acbb5-72e6-3f63-2e78-478d3230aa0c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnLS5FbE5jtncvAA--.49965S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw48ury8ur45Cry3Wr4xCrg_yoW3ZF45pF
        95XFZ2k3y8CryDXrsrta17Xr17JwsFka1UJrnYkr1Ivr1UKr45Xr97Aryj9r1Ykry0yFW7
        JFnYqr4UKrs8Kw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ
        7UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2022/10/18 16:40, Yu Kuai 写道:
> Hi,
> 
> 在 2022/10/18 16:26, Christoph Hellwig 写道:
>> On Tue, Oct 18, 2022 at 04:00:36PM +0800, Yu Kuai wrote:
>>> 1) in del_gendisk: (add a new api kobject_put_and_test)
>>>
>>> if (kobject_put_and_test(bd_holder_dir/slave_dir))
>>>     bd_holder_dir/slave_dir = NULL;
>>>
>>> 2) in bd_link_disk_holder, get bd_holder_dir first:
>>>
>>> if (!kobject_get_unless_zero(bd_holder_dir))
>>>     return -ENODEV;
>>> ...
>>> bd_find_holder_disk()
>>>
>>> Do you think this is ok?
>>
>> I'm not quite sure what the point is.
>>
> 
> Because I'm afraid bd_link_disk_holder() just take bdev as paramater,
> (bdev is got by blkdev_get_by_dev), but there is no guarantee that disk
> can't be remove(del_gendisk is called for the disk that bdev belongs
> to).
> 
> Thus I think the interface bd_link_disk_holder() itself is problematic,
> current caller drbd/md/dm might all be affected.
> 

I just verified that by the following thest:

1) add some delay before calling bd_link_disk_holder:

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 95a1ee3d314e..b300c667ff57 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -745,6 +745,8 @@ static int open_table_device(struct table_device 
*td, dev_t dev,
         if (IS_ERR(bdev))
                 return PTR_ERR(bdev);

+       printk("%s: delay 5s\n", __func__);
+       msleep(5000);
         r = bd_link_disk_holder(bdev, dm_disk(md));
         if (r) {
                 blkdev_put(bdev, td->dm_dev.mode | FMODE_EXCL);

2) run the cmd:

dmsetup create test1 --table "0 100000 linear /dev/sda 0" &
sleep 1
echo 1 > /sys/block/sda/device/delete

And the follwing uaf is triggered:

[  164.085806] 
==================================================================
[  164.087942] BUG: KASAN: use-after-free in kobject_get+0x20/0x120
[  164.089350] Read of size 1 at addr ffff8881021624bc by task dmsetup/915
[  164.090837]
[  164.091227] CPU: 19 PID: 915 Comm: dmsetup Not tainted 
6.0.0-next-20221017-00006-ga50117a47
[  164.093327] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-4
[  164.096194] Call Trace:
[  164.096577]  <TASK>
[  164.096761]  ? dump_stack_lvl+0x73/0x9f
[  164.097072]  ? print_report+0x249/0x746
[  164.097421]  ? __virt_addr_valid+0xd4/0x200
[  164.097815]  ? kobject_get+0x20/0x120
[  164.098135]  ? kasan_report+0xc0/0x120
[  164.098491]  ? kobject_get+0x20/0x120
[  164.098824]  ? __asan_load1+0x68/0xb0
[  164.099159]  ? kobject_get+0x20/0x120
[  164.099500]  ? bd_link_disk_holder+0x203/0x270
[  164.099872]  ? dm_get_table_device.cold+0x59/0xbf
[  164.100295]  ? dm_get_device+0x35c/0x4f0
[  164.100651]  ? dm_put_device+0x230/0x230
[  164.101011]  ? vsscanf+0x1360/0x1360
[  164.101374]  ? __kmem_cache_alloc_node+0x1ce/0x490
[  164.101836]  ? kasan_set_track+0x29/0x40
[  164.102187]  ? kasan_save_alloc_info+0x1f/0x40
[  164.102588]  ? __kasan_kmalloc+0xcb/0xe0
[  164.102959]  ? linear_ctr+0x190/0x260
[  164.103290]  ? linear_dtr+0x50/0x50
[  164.103606]  ? dm_table_destroy+0x280/0x280
[  164.103976]  ? __kasan_check_write+0x20/0x30
[  164.104369]  ? up_read+0x25/0xf0
[  164.104667]  ? dm_table_add_target+0x2f5/0x840
[  164.105058]  ? dm_split_args+0x2f0/0x2f0
[  164.105440]  ? __kasan_check_write+0x20/0x30
[  164.105886]  ? mutex_lock+0xa6/0x110
[  164.106230]  ? memset+0x4a/0x70
[  164.106524]  ? kvfree+0x44/0x50
[  164.106816]  ? dm_table_create+0x1a3/0x240
[  164.107202]  ? table_load+0x2b5/0x710
[  164.107543]  ? list_devices+0x4c0/0x4c0
[  164.107900]  ? kvmalloc_node+0x7d/0x160
[  164.108853]  ? ctl_ioctl+0x388/0x7b0
[  164.109191]  ? list_devices+0x4c0/0x4c0
[  164.109568]  ? free_params+0x50/0x50
[  164.109900]  ? do_vfs_ioctl+0x931/0x10d0
[  164.110282]  ? handle_mm_fault+0x3aa/0x610
[  164.110667]  ? __kasan_check_read+0x1d/0x30
[  164.111054]  ? __fget_light+0xc2/0x370
[  164.111408]  ? dm_ctl_ioctl+0x12/0x20
[  164.111744]  ? __x64_sys_ioctl+0xd5/0x150
[  164.112125]  ? do_syscall_64+0x35/0x80
[  164.112489]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  164.112978]  </TASK>
[  164.113183]
[  164.113327] Allocated by task 179:
[  164.113647]  kasan_save_stack+0x26/0x60
[  164.113977]  kasan_set_track+0x29/0x40
[  164.114316]  kasan_save_alloc_info+0x1f/0x40
[  164.114709]  __kasan_kmalloc+0xcb/0xe0
[  164.115063]  kmalloc_trace+0x7e/0x150
[  164.115399]  kobject_create_and_add+0x3d/0xc0
[  164.115806]  device_add_disk+0x3bf/0x800
[  164.116164]  sd_probe+0x603/0x8e0
[  164.116482]  really_probe+0x4f2/0x730
[  164.116832]  __driver_probe_device+0x223/0x320
[  164.117243]  driver_probe_device+0x69/0x140
[  164.117627]  __device_attach_driver+0x10a/0x200
[  164.118032]  bus_for_each_drv+0x10e/0x1b0
[  164.118410]  __device_attach_async_helper+0x175/0x230
[  164.118877]  async_run_entry_fn+0x73/0x300
[  164.119254]  process_one_work+0x47b/0x9a0
[  164.119641]  worker_thread+0x30c/0x8b0
[  164.119979]  kthread+0x1e5/0x250
[  164.120283]  ret_from_fork+0x1f/0x30
[  164.120611]
[  164.120755] Freed by task 821:
[  164.121043]  kasan_save_stack+0x26/0x60
[  164.121420]  kasan_set_track+0x29/0x40
[  164.121805]  kasan_save_free_info+0x32/0x60
[  164.122205]  __kasan_slab_free+0x172/0x2c0
[  164.122588]  __kmem_cache_free+0x11c/0x560
[  164.122975]  kfree+0xd3/0x240
[  164.123252]  dynamic_kobj_release+0x1e/0x60
[  164.123646]  kobject_put+0x192/0x410
[  164.123972]  del_gendisk+0x22a/0x640
[  164.124314]  sd_remove+0x65/0xa0
[  164.124610]  device_remove+0xbe/0xe0
[  164.124930]  device_release_driver_internal+0x161/0x2e0
[  164.125401]  device_release_driver+0x16/0x20
[  164.125809]  bus_remove_device+0x1d3/0x310
[  164.126162]  device_del+0x310/0x7e0
[  164.126475]  __scsi_remove_device+0x26c/0x360
[  164.126854]  scsi_remove_device+0x38/0x60
[  164.127214]  sdev_store_delete+0x73/0xf0
[  164.127569]  dev_attr_store+0x40/0x70
[  164.127903]  sysfs_kf_write+0x89/0xc0
[  164.128242]  kernfs_fop_write_iter+0x21d/0x330
[  164.128637]  vfs_write+0x60e/0x840
[  164.128942]  ksys_write+0xcd/0x1e0
[  164.129255]  __x64_sys_write+0x46/0x60
[  164.129598]  do_syscall_64+0x35/0x80
[  164.129915]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  164.130370]
[  164.130518] The buggy address belongs to the object at ffff888102162480
[  164.130518]  which belongs to the cache kmalloc-64 of size 64
[  164.131590] The buggy address is located 60 bytes inside of
[  164.131590]  64-byte region [ffff888102162480, ffff8881021624c0)
[  164.132629]
[  164.132775] The buggy address belongs to the physical page:
[  164.133277] page:0000000072f285df refcount:1 mapcount:0 
mapping:0000000000000000 index:0x02
[  164.134136] flags: 
0x2fffff80000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
[  164.134793] raw: 002fffff80000200 ffff88810004c640 dead000000200020 
0000000000000000
[  164.135493] raw: 0000000000000000 0000000000000000 00000001ffffffff 
0000000000000000
[  164.136186] page dumped because: kasan: bad access detected
[  164.136697]
[  164.136849] Memory state around the buggy address:
[  164.137300]  ffff888102162380: fa fb fb fb fb fb fb fb fc fc fc fc fc 
fc fc fc
[  164.137980]  ffff888102162400: fa fb fb fb fb fb fb fb fc fc fc fc fc 
fc fc fc
[  164.138638] >ffff888102162480: fa fb fb fb fb fb fb fb fc fc fc fc fc 
fc fc fc
[  164.139305]                                         ^
[  164.139780]  ffff888102162500: fa fb fb fb fb fb fb fb fc fc fc fc fc 
fc fc fc
[  164.140444]  ffff888102162580: fa fb fb fb fb fb fb fb fc fc fc fc fc 
fc fc fc
[  164.141086] 
==================================================================
> Thanks,
> Kuai
>> If you want to really clean this up a good thing would be to remove
>> the delayed holder registration entirely and just do them in dm
>> after add_disk and remove them before del_gendisk.  I've been wanting
>> to do that a few times but always gave up due to the mess in dm.
>>
>> .
>>
> 
> .
> 

