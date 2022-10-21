Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4F7C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 03:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJUDWK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJUDWJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 23:22:09 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B426F1B65C8
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 20:22:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MtqTC3dS2z6PKNT
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 11:19:43 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3PS5dEFJje7O4AA--.29991S3;
        Fri, 21 Oct 2022 11:22:05 +0800 (CST)
Subject: Re: [PATCH 1/6] block: clear the holder releated fields when deleting
 the kobjects
To:     Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221020164605.1764830-1-hch@lst.de>
 <20221020164605.1764830-2-hch@lst.de>
 <cc7d4e79-a14d-1183-09a2-337052321e3e@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <868b6d4f-9306-0469-149a-47e5d282d141@huaweicloud.com>
Date:   Fri, 21 Oct 2022 11:22:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cc7d4e79-a14d-1183-09a2-337052321e3e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3PS5dEFJje7O4AA--.29991S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww13Ww1DAFy8AFy3ZF1kZrb_yoW3JFyxpF
        95JFyxJrWj9ry8Xr4aya15CFy7Ja1DJa1kKr1SkFn2vrsrJrnFvFy7Xr4jgF45GrW8CF4U
        JF10qrs0yr48Kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUouWlDU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/10/21 11:12, Yu Kuai 写道:
> Hi, Christoph
> 
> 在 2022/10/21 0:46, Christoph Hellwig 写道:
>> Zero out the pointers to the holder related kobjects so that the holder
>> code doesn't incorrectly when called by dm for the delayed holder
>> registration.
>>
>> Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
>> Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/genhd.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 17b33c62423df..cd90df6c775c2 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -528,8 +528,10 @@ int __must_check device_add_disk(struct device 
>> *parent, struct gendisk *disk,
>>       blk_unregister_queue(disk);
>>   out_put_slave_dir:
>>       kobject_put(disk->slave_dir);
>> +    disk->slave_dir = NULL;
>>   out_put_holder_dir:
>>       kobject_put(disk->part0->bd_holder_dir);
>> +    disk->part0->bd_holder_dir = NULL;
>>   out_del_integrity:
>>       blk_integrity_del(disk);
>>   out_del_block_link:
>> @@ -623,7 +625,9 @@ void del_gendisk(struct gendisk *disk)
>>       blk_unregister_queue(disk);
>>       kobject_put(disk->part0->bd_holder_dir);
>> +    disk->part0->bd_holder_dir = NULL;
> 
> I don't think this is enough. There is still no guarantee that
> bd_link_disk_holder() won't access freed bd_holder_dir. It's still
> possible that bd_link_disk_holer() read bd_holder_dir first, and then
> del_gendisk() free and reset it.

I just verify that with this patchset applied, and together with the
following patch to add some delay:

diff --git a/block/holder.c b/block/holder.c
index b058bda757c1..b7d87d47afee 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -1,6 +1,7 @@
  // SPDX-License-Identifier: GPL-2.0-only
  #include <linux/blkdev.h>
  #include <linux/slab.h>
+#include <linux/delay.h>

  struct bd_holder_disk {
         struct list_head        list;
@@ -32,11 +33,16 @@ static void del_symlink(struct kobject *from, struct 
kobject *to)
  static int __link_disk_holder(struct block_device *bdev, struct 
gendisk *disk)
  {
         int ret;
+       struct kobject *holder = bdev->bd_holder_dir;

         ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
         if (ret)
                 return ret;
-       ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
+
+       printk("%s: delay 5s\n", __func__);
+       msleep(5000);
+
+       ret = add_symlink(holder, &disk_to_dev(disk)->kobj);
         if (ret)
                 del_symlink(disk->slave_dir, bdev_kobj(bdev));
         return ret;

Fowlling uaf can be triggered 100%:

[  115.675974] md: personality for level 10 is not loaded!
[  121.365398] md: personality for level 10 is not loaded!
[  123.011503] __link_disk_holder: delay 5s
[  128.086884] 
==================================================================
[  128.092786] BUG: KASAN: use-after-free in sysfs_create_link+0x28/0x80
[  128.094489] Read of size 8 at addr ffff888101435e30 by task dmsetup/935
[  128.095629]
[  128.095955] CPU: 7 PID: 935 Comm: dmsetup Not tainted 
6.0.0-next-20221017-00018-gec99c641bf1
[  128.097550] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-b4
[  128.098939] Call Trace:
[  128.099293]  <TASK>
[  128.099602]  ? dump_stack_lvl+0x73/0x9f
[  128.100638]  ? print_report+0x249/0x746
[  128.101115]  ? __virt_addr_valid+0xd4/0x200
[  128.101669]  ? sysfs_create_link+0x28/0x80
[  128.102206]  ? kasan_report+0xc0/0x120
[  128.102687]  ? sysfs_create_link+0x28/0x80
[  128.103254]  ? __asan_load8+0x74/0x110
[  128.103729]  ? sysfs_create_link+0x28/0x80
[  128.104272]  ? bd_link_disk_holder.cold+0x7d/0x1b3
[  128.104905]  ? dm_setup_md_queue+0x1d5/0x340
[  128.105461]  ? dm_table_complete+0x590/0xdd0
[  128.106010]  ? dm_get_immutable_target_type+0x30/0x30
[  128.106702]  ? memset+0x4a/0x70
[  128.107136]  ? kvfree+0x44/0x50
[  128.107632]  ? dm_table_create+0x1a3/0x240
[  128.108341]  ? table_load+0x469/0x710
[  128.108971]  ? list_devices+0x4c0/0x4c0
[  128.109629]  ? kvmalloc_node+0x7d/0x160
[  128.110269]  ? __kmalloc_node+0x185/0x2b0
[  128.110928]  ? ctl_ioctl+0x388/0x7b0
[  128.111539]  ? list_devices+0x4c0/0x4c0
[  128.112216]  ? free_params+0x50/0x50
[  128.112825]  ? do_vfs_ioctl+0x931/0x10d0
[  128.113690]  ? handle_mm_fault+0x3aa/0x610
[  128.114392]  ? __kasan_check_read+0x1d/0x30
[  128.115089]  ? __fget_light+0xc2/0x370
[  128.115741]  ? dm_ctl_ioctl+0x12/0x20
[  128.116376]  ? __x64_sys_ioctl+0xd5/0x150
[  128.117100]  ? do_syscall_64+0x35/0x80
[  128.117746]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  128.118546]  </TASK>
[  128.118940]
[  128.119246] Allocated by task 179:
[  128.119799]  kasan_save_stack+0x26/0x60
[  128.120419]  kasan_set_track+0x29/0x40
[  128.120915]  kasan_save_alloc_info+0x1f/0x40
[  128.121508]  __kasan_kmalloc+0xcb/0xe0
[  128.122127]  kmalloc_trace+0x7e/0x150
[  128.122755]  kobject_create_and_add+0x3d/0xc0
[  128.123475]  device_add_disk+0x3d1/0x830
[  128.124154]  sd_probe+0x603/0x8e0
[  128.124727]  really_probe+0x4f2/0x730
[  128.125351]  __driver_probe_device+0x223/0x320
[  128.126080]  driver_probe_device+0x69/0x140
[  128.126765]  __device_attach_driver+0x10a/0x200
[  128.127475]  bus_for_each_drv+0x10e/0x1b0
[  128.128145]  __device_attach_async_helper+0x175/0x230
[  128.128944]  async_run_entry_fn+0x73/0x300
[  128.129608]  process_one_work+0x47b/0x9a0
[  128.130275]  worker_thread+0x30c/0x8b0
[  128.130905]  kthread+0x1e5/0x250
[  128.131476]  ret_from_fork+0x1f/0x30
[  128.132080]
[  128.132379] Freed by task 823:
[  128.132887]  kasan_save_stack+0x26/0x60
[  128.133547]  kasan_set_track+0x29/0x40
[  128.134187]  kasan_save_free_info+0x32/0x60
[  128.134853]  __kasan_slab_free+0x172/0x2c0
[  128.135528]  __kmem_cache_free+0x11c/0x560
[  128.136208]  kfree+0xd3/0x240
[  128.136724]  dynamic_kobj_release+0x1e/0x60
[  128.137417]  kobject_put+0x192/0x410
[  128.138027]  del_gendisk+0x227/0x670
[  128.138611]  sd_remove+0x65/0xa0
[  128.139168]  device_remove+0xbe/0xe0
[  128.139755]  device_release_driver_internal+0x161/0x2e0
[  128.140573]  device_release_driver+0x16/0x20
[  128.141285]  bus_remove_device+0x1d3/0x310
[  128.141958]  device_del+0x310/0x7e0
[  128.142555]  __scsi_remove_device+0x26c/0x360
[  128.143280]  scsi_remove_device+0x38/0x60
[  128.143959]  sdev_store_delete+0x73/0xf0
[  128.144631]  dev_attr_store+0x40/0x70
[  128.145271]  sysfs_kf_write+0x89/0xc0
[  128.145910]  kernfs_fop_write_iter+0x21d/0x330
[  128.146653]  vfs_write+0x60e/0x840
[  128.147244]  ksys_write+0xcd/0x1e0
[  128.147840]  __x64_sys_write+0x46/0x60
[  128.148483]  do_syscall_64+0x35/0x80
[  128.149134]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

> 
> By the way, I still think that the problem for the bd_holder_dir uaf is
> not just related to dm.
> 
> Thanks,
> Kuai
> 
>>       kobject_put(disk->slave_dir);
>> +    disk->slave_dir = NULL;
>>       part_stat_set_all(disk->part0, 0);
>>       disk->part0->bd_stamp = 0;
>>
> 
> .
> 

