Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9855C77B60
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 06:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbjDZGGB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 02:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDZGGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 02:06:00 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A62A2134
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 23:05:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q5pJc67n2z4f6Tkj
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 14:05:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLM_v0hk7iezIA--.51808S3;
        Wed, 26 Apr 2023 14:05:53 +0800 (CST)
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address:
 00000000000000fc
To:     Changhui Zhong <czhong@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <CAGVVp+XSpFsjfzSNxLiK9SFnLvLB-W7bPHk7tySkkX95BM5BoQ@mail.gmail.com>
 <ZEdItaPqif8fp85H@ovpn-8-24.pek2.redhat.com>
 <CAGVVp+Wrhi0bWWR4nDVM5OXKp==RKbVKPSyt8pbuofUWVqQDGA@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f5d3b05b-33a6-818f-6476-c3993f9d4e87@huaweicloud.com>
Date:   Wed, 26 Apr 2023 14:05:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGVVp+Wrhi0bWWR4nDVM5OXKp==RKbVKPSyt8pbuofUWVqQDGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLM_v0hk7iezIA--.51808S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1xZF4kXF4fXF1DZr48tFb_yoWrXry7pF
        9xJa1Ygr4kJF4rZ3yv93WxC3WDt3Wjyw1fW3y7t342yws8XasxKF93Zry3XrZF9r97Cw4q
        qa1UWr42kryFkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/04/26 13:56, Changhui Zhong 写道:
> On Tue, Apr 25, 2023 at 11:27 AM Ming Lei <ming.lei@redhat.com> wrote:
>>
>> On Tue, Apr 25, 2023 at 10:37:05AM +0800, Changhui Zhong wrote:
>>> Hello,
>>>
>>> Below issue was triggered in my test,it caused system panic ,please
>>> help check it.
>>> branch: for-6.4/block
>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>
>>> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
>>> sgdisk -n 0:0:+100MiB /dev/md0
>>> cat /proc/partitions
>>> mdadm -S /dev/md0
>>> mdadm -A /dev/md0 /dev/sda /dev/sdb
>>> cat /proc/partitions
>>>
>>>
>>> [   34.219123] BUG: kernel NULL pointer dereference, address: 00000000000000fc
>>> [   34.219507] #PF: supervisor read access in kernel mode
>>> [   34.219784] #PF: error_code(0x0000) - not-present page
>>> [   34.220039] PGD 0 P4D 0
>>> [   34.220176] Oops: 0000 [#1] PREEMPT SMP PTI
>>> [   34.220374] CPU: 8 PID: 1956 Comm: systemd-udevd Kdump: loaded Not
>>> tainted 6.3.0-rc2+ #1
>>> [   34.220787] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
>>> Gen9, BIOS P89 05/21/2018
>>> [   34.221188] RIP: 0010:blk_mq_sched_bio_merge+0x6d/0xf0
>>
>> Hi Changhui,
>>
>> Please try the following fix:
>>
>> diff --git a/block/bdev.c b/block/bdev.c
>> index 850852fe4b78..fa2838ca2e6d 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -419,7 +419,11 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>>          bdev->bd_inode = inode;
>>          bdev->bd_queue = disk->queue;
>>          bdev->bd_stats = alloc_percpu(struct disk_stats);
>> -       bdev->bd_has_submit_bio = false;
>> +
>> +       if (partno)
>> +               bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
>> +       else
>> +               bdev->bd_has_submit_bio = false;
>>          if (!bdev->bd_stats) {
>>                  iput(inode);
>>                  return NULL;
>>
>> Fixes: 9f4107b07b17 ("block: store bdev->bd_disk->fops->submit_bio state in bdev")
>>
> 
> Hi,Ming
> 
> I retest the latest updated branch for-6.4/block
> (https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.4/block),
> which contain your fix patch "block: sync part's ->bd_has_submit_bio
> with disk's".
> the kernel panic  no longer happen, but the test will failed, the
> system will reread partition table on exclusively open device,

Is this patch in the branch for-6.4/block?

3723091ea188 ("block: don't set GD_NEED_PART_SCAN if scan partition failed")
> 
> :: [ 01:50:05 ] :: [  BEGIN   ] :: Running 'mdadm -S /dev/md0'
> mdadm: stopped /dev/md0
> :: [ 01:50:06 ] :: [   PASS   ] :: Command 'mdadm -S /dev/md0'
> (Expected 0, got 0)
> :: [ 01:50:06 ] :: [  BEGIN   ] :: Running 'mdadm -A /dev/md0
> /dev/"$dev0" /dev/"$dev1"'
> mdadm: /dev/md0 has been started with 2 drives.
> :: [ 01:50:06 ] :: [   PASS   ] :: Command 'mdadm -A /dev/md0
> /dev/"$dev0" /dev/"$dev1"' (Expected 0, got 0)
> :: [ 01:50:09 ] :: [  BEGIN   ] :: Running 'lsblk'
> NAME                         MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
> sda                            8:0    1 447.1G  0 disk
> ├─sda1                         8:1    1     1G  0 part  /boot
> └─sda2                         8:2    1 446.1G  0 part
>    ├─rhel_storageqe--104-root 253:0    0    70G  0 lvm   /
>    ├─rhel_storageqe--104-swap 253:1    0   7.7G  0 lvm   [SWAP]
>    └─rhel_storageqe--104-home 253:2    0 368.4G  0 lvm   /home
> sdb                            8:16   1 447.1G  0 disk
> ├─sdb1                         8:17   1   100M  0 part
> └─md0                          9:0    0 447.1G  0 raid1
>    └─md0p1                    259:0    0   100M  0 part
> sdc                            8:32   1 447.1G  0 disk
> ├─sdc1                         8:33   1   100M  0 part
> └─md0                          9:0    0 447.1G  0 raid1
>    └─md0p1                    259:0    0   100M  0 part
> sdd                            8:48   1 447.1G  0 disk
> :: [ 01:50:09 ] :: [   PASS   ] :: Command 'lsblk' (Expected 0, got 0)
> :: [ 01:50:09 ] :: [  BEGIN   ] :: Running 'cat /proc/partitions'
> major minor  #blocks  name
> 
>     8        0  468851544 sda
>     8        1    1048576 sda1
>     8        2  467801088 sda2
>     8       48  468851544 sdd
>     8       32  468851544 sdc
>     8       33     102400 sdc1
>     8       16  468851544 sdb
>     8       17     102400 sdb1
>   253        0   73400320 dm-0
>   253        1    8060928 dm-1
>   253        2  386338816 dm-2
>     9        0  468851392 md0
>   259        0     102400 md0p1
> 
> Thanks，
> 
> .
> 

