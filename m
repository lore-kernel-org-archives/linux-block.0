Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF02C43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 03:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiGGD3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 23:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiGGD3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 23:29:32 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9FC30F4D
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 20:29:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LdhhL0BqQzKCdd
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 11:28:34 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgAXemkWU8ZiH__bAQ--.22982S3;
        Thu, 07 Jul 2022 11:29:28 +0800 (CST)
Subject: Re: [PATCH 7/8] dm: delay registering the gendisk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
References: <20210804094147.459763-1-hch@lst.de>
 <20210804094147.459763-8-hch@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ad2c7878-dabb-cb41-1bba-60ef48fa1a9f@huaweicloud.com>
Date:   Thu, 7 Jul 2022 11:29:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210804094147.459763-8-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXemkWU8ZiH__bAQ--.22982S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1xuw43ZrWDZrW5Zw1UKFg_yoW3tr15pF
        4UXrW5CrW8tr1Uta17tF1UAr1rtrsrAa4UXr4xAr10v3Wjkw1YqFy7CFWUAry7Jr4kXry7
        tFyDJw1ktr1UKaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Christoph

ÔÚ 2021/08/04 17:41, Christoph Hellwig Ð´µÀ:
> device mapper is currently the only outlier that tries to call
> register_disk after add_disk, leading to fairly inconsistent state
> of these block layer data structures.  Instead change device-mapper
> to just register the gendisk later now that the holder mechanism
> can cope with that.
> 
> Note that this introduces a user visible change: the dm kobject is
> now only visible after the initial table has been loaded.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Mike Snitzer <snitzer@redhat.com>

We found that this patch fix a nullptr crash in our test:
[   88.727918] BUG: kernel NULL pointer dereference, address: 
00000000000001a0
[   88.730698] #PF: supervisor read access in kernel mode
[   88.731381] #PF: error_code(0x0000) - not-present page
[   88.732086] PGD 0 P4D 0
[   88.732441] Oops: 0000 [#1] PREEMPT SMP
[   88.732964] CPU: 1 PID: 1317 Comm: mount Not tainted 
5.10.0-16691-gf6076432827d-dirty #169
[   88.734055] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-4
[   88.735819] RIP: 0010:__blk_mq_sched_bio_merge+0x9d/0x1a0
[   88.736544] Code: 87 1e 9d 89 d0 25 00 00 00 01 0f 85 ad 00 00 00 48 
83 05 25 a1 37 0c 01 3
[   88.739040] RSP: 0018:ffffc90000473b50 EFLAGS: 00010202
[   88.739744] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
ffffc90000473b98
[   88.740697] RDX: 0000000000001000 RSI: ffff8881080c7500 RDI: 
ffff888103a9cc18
[   88.741659] RBP: ffff88813bc80000 R08: 0000000000000001 R09: 
0000000000000000
[   88.742611] R10: ffff88810710be30 R11: 0000000000000000 R12: 
ffff888103a9cc18
[   88.743551] R13: ffff8881080c7500 R14: 0000000000000001 R15: 
0000000000000000
[   88.744501] FS:  00007f51bcdbb040(0000) GS:ffff88813bc80000(0000) 
knlGS:0000000000000000
[   88.745581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   88.746345] CR2: 00000000000001a0 CR3: 000000010d715000 CR4: 
00000000000006e0
[   88.747298] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   88.748253] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400

[   88.749204] Call Trace:
[   88.749549]  blk_mq_submit_bio+0x115/0xd80
[   88.750124]  submit_bio_noacct+0x4ff/0x610
[   88.750692]  submit_bio+0xaa/0x1a0
[   88.751149]  submit_bh_wbc+0x1cb/0x2f0
[   88.751662]  submit_bh+0x17/0x20
[   88.752102]  ext4_read_bh+0x63/0x170
[   88.752588]  ext4_read_bh_lock+0x2c/0xd0
[   88.753125]  __ext4_sb_bread_gfp.isra.0+0xa0/0xf0
[   88.753766]  ext4_fill_super+0x21f/0x5610
[   88.754317]  ? pointer+0x31b/0x5a0
[   88.754796]  ? vsnprintf+0x131/0x7d0
[   88.755304]  mount_bdev+0x233/0x280
[   88.755791]  ? ext4_calculate_overhead+0x660/0x660
[   88.756461]  ext4_mount+0x19/0x30
[   88.756926]  legacy_get_tree+0x35/0x90
[   88.757450]  vfs_get_tree+0x29/0x100
[   88.757955]  ? capable+0x1d/0x30
[   88.758406]  path_mount+0x8a7/0x1150
[   88.758918]  do_mount+0x8d/0xc0
[   88.759360]  __se_sys_mount+0x14a/0x220
[   88.759906]  __x64_sys_mount+0x29/0x40
[   88.760431]  do_syscall_64+0x45/0x70
[   88.760931]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.761634] RIP: 0033:0x7f51bbe1623a
[   88.762135] Code: 48 8b 0d 51 dc 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 
66 2e 0f 1f 84 00 00 8
[   88.764657] RSP: 002b:00007fff173ae898 EFLAGS: 00000246 ORIG_RAX: 
00000000000000a5
[   88.765700] RAX: ffffffffffffffda RBX: 000056169a120030 RCX: 
00007f51bbe1623a
[   88.766675] RDX: 000056169a120210 RSI: 000056169a120250 RDI: 
000056169a120230
[   88.767642] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007fff173ad798
[   88.768619] R10: 00000000c0ed0000 R11: 0000000000000246 R12: 
000056169a120230
[   88.769605] R13: 000056169a120210 R14: 0000000000000000 R15: 
00007f51bcbac184
[   88.770611] Modules linked in: dm_service_time dm_multipath
[   88.771388] CR2: 00000000000001a0
[   88.776323] ---[ end trace ac5d86e09fdc7c98 ]---
[   88.777009] RIP: 0010:__blk_mq_sched_bio_merge+0x9d/0x1a0
[   88.778038] Code: 87 1e 9d 89 d0 25 00 00 00 01 0f 85 ad 00 00 00 48 
83 05 25 a1 37 0c 01 3
[   88.780708] RSP: 0018:ffffc90000473b50 EFLAGS: 00010202
[   88.781443] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
ffffc90000473b98
[   88.782692] RDX: 0000000000001000 RSI: ffff8881080c7500 RDI: 
ffff888103a9cc18
[   88.783839] RBP: ffff88813bc80000 R08: 0000000000000001 R09: 
0000000000000000
[   88.784942] R10: ffff88810710be30 R11: 0000000000000000 R12: 
ffff888103a9cc18
[   88.786051] R13: ffff8881080c7500 R14: 0000000000000001 R15: 
0000000000000000
[   88.787142] FS:  00007f51bcdbb040(0000) GS:ffff88813bc80000(0000) 
knlGS:0000000000000000
[   88.788399] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   88.789444] CR2: 00007f10e97a5000 CR3: 000000010d715000 CR4: 
00000000000006e0
[   88.790586] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   88.791686] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   88.792773] Kernel panic - not syncing: Fatal exception
[   88.793573] Kernel Offset: disabled
[   88.794052] ---[ end Kernel panic - not syncing: Fatal exception ]---

root cause:
t1 dm-mpath       t2 mount

alloc_dev
  md->queue = blk_alloc_queue
  add_disk_no_queue_reg

dm_setup_md_queue
  case DM_TYPE_REQUEST_BASED -> multipath
   md->disk->fops = &dm_rq_blk_dops;
                         ext4_fill_super
                         ©®__ext4_sb_bread_gfp
                         ©® ext4_read_bh
                         ©®  submit_bio -> queue is not initialized yet
                         ©®   __blk_mq_sched_bio_merge
                         ©®    ctx = blk_mq_get_ctx(q); -> ctx is NULL
   dm_mq_init_request_queue

Do you think it's ok to backport this patch(and all realted patches) to
lts, or it's better to fix that bio can be submitted with queue
uninitialized from block layer?

Thanks,
Kuai
> ---
>   drivers/md/dm-rq.c |  1 -
>   drivers/md/dm.c    | 23 +++++++++++------------
>   2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index 0dbd48cbdff9..5b95eea517d1 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -559,7 +559,6 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
>   	err = blk_mq_init_allocated_queue(md->tag_set, md->queue);
>   	if (err)
>   		goto out_tag_set;
> -	elevator_init_mq(md->queue);
>   	return 0;
>   
>   out_tag_set:
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index f003bd5b93ce..7981b7287628 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1693,7 +1693,10 @@ static void cleanup_mapped_device(struct mapped_device *md)
>   		spin_lock(&_minor_lock);
>   		md->disk->private_data = NULL;
>   		spin_unlock(&_minor_lock);
> -		del_gendisk(md->disk);
> +		if (dm_get_md_type(md) != DM_TYPE_NONE) {
> +			dm_sysfs_exit(md);
> +			del_gendisk(md->disk);
> +		}
>   		dm_queue_destroy_keyslot_manager(md->queue);
>   		blk_cleanup_disk(md->disk);
>   	}
> @@ -1788,7 +1791,6 @@ static struct mapped_device *alloc_dev(int minor)
>   			goto bad;
>   	}
>   
> -	add_disk_no_queue_reg(md->disk);
>   	format_dev_t(md->name, MKDEV(_major, minor));
>   
>   	md->wq = alloc_workqueue("kdmflush", WQ_MEM_RECLAIM, 0);
> @@ -1989,19 +1991,12 @@ static struct dm_table *__unbind(struct mapped_device *md)
>    */
>   int dm_create(int minor, struct mapped_device **result)
>   {
> -	int r;
>   	struct mapped_device *md;
>   
>   	md = alloc_dev(minor);
>   	if (!md)
>   		return -ENXIO;
>   
> -	r = dm_sysfs_init(md);
> -	if (r) {
> -		free_dev(md);
> -		return r;
> -	}
> -
>   	*result = md;
>   	return 0;
>   }
> @@ -2081,10 +2076,15 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>   	r = dm_table_set_restrictions(t, md->queue, &limits);
>   	if (r)
>   		return r;
> -	md->type = type;
>   
> -	blk_register_queue(md->disk);
> +	add_disk(md->disk);
>   
> +	r = dm_sysfs_init(md);
> +	if (r) {
> +		del_gendisk(md->disk);
> +		return r;
> +	}
> +	md->type = type;
>   	return 0;
>   }
>   
> @@ -2190,7 +2190,6 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
>   		DMWARN("%s: Forcibly removing mapped_device still in use! (%d users)",
>   		       dm_device_name(md), atomic_read(&md->holders));
>   
> -	dm_sysfs_exit(md);
>   	dm_table_destroy(__unbind(md));
>   	free_dev(md);
>   }
> 

