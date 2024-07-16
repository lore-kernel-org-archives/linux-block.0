Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2C13F42A;
	Tue, 16 Jul 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121314; cv=none; b=dSFZvAoHq6drw3vYSSfXwCu/RUrKobtqUGYtBbNBK6AFHMO1W2rWmkNl0RE7P5lkTg0rDayEgW/+8yqJyQrkteV48KMzN5cq7JoK0FTqwDlSTh3b83SHWRE1u/HnmBfFVwLj33xX/PeelTF0aVgWAFse6tlG7W+z/YdEBWxDKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121314; c=relaxed/simple;
	bh=wuVuGToQ2XzR6uRs8zyHPtfrlmaqGgdHN1bY7Yv94Jw=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SNFOxnZaUbX7IyaYA8yezKgi1dJs+X/A3XldGhJHxJpDo2G598qrBLl97wPFeam14DzgTJTwwpoRy5aWjOg2sV1Mrzdo0Y7sefwZ1joyLtDntQpGJuD4s/yt45D+n7WHOdmXO75DkslNdTLgTNhghhiGwLS0VuzQaZ/7REGZQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WNYLQ1qvLz4f3kvF;
	Tue, 16 Jul 2024 17:14:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 68D221A0184;
	Tue, 16 Jul 2024 17:15:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDXuTcZOpZmd+shAQ--.9600S3;
	Tue, 16 Jul 2024 17:15:07 +0800 (CST)
Subject: Re: [PATCH] block: fix deadlock between sd_remove & sd_release
To: Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240716083801.809763-1-yang.yang@vivo.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1859a975-8c53-140c-f5b5-898ad5e7f653@huaweicloud.com>
Date: Tue, 16 Jul 2024 17:15:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240716083801.809763-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXuTcZOpZmd+shAQ--.9600S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF47Kr48AFW8Jr4xZr1UZFb_yoWrXr15pF
	43JFZrJr4DZr1agrWaqw17Xr40k3W8W3WkGr97Ga42vFn7Ar1qqFyUGa48Ww15Z347Aa1q
	kFyq9ayrZw1vvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/07/16 16:38, Yang Yang Ð´µÀ:
> Our test report the following hung task:
> 
> [ 2538.459400] INFO: task "kworker/0:0":7 blocked for more than 188 seconds.
> [ 2538.459427] Call trace:
> [ 2538.459430]  __switch_to+0x174/0x338
> [ 2538.459436]  __schedule+0x628/0x9c4
> [ 2538.459442]  schedule+0x7c/0xe8
> [ 2538.459447]  schedule_preempt_disabled+0x24/0x40
> [ 2538.459453]  __mutex_lock+0x3ec/0xf04
> [ 2538.459456]  __mutex_lock_slowpath+0x14/0x24
> [ 2538.459459]  mutex_lock+0x30/0xd8
> [ 2538.459462]  del_gendisk+0xdc/0x350
> [ 2538.459466]  sd_remove+0x30/0x60
> [ 2538.459470]  device_release_driver_internal+0x1c4/0x2c4
> [ 2538.459474]  device_release_driver+0x18/0x28
> [ 2538.459478]  bus_remove_device+0x15c/0x174
> [ 2538.459483]  device_del+0x1d0/0x358
> [ 2538.459488]  __scsi_remove_device+0xa8/0x198
> [ 2538.459493]  scsi_forget_host+0x50/0x70
> [ 2538.459497]  scsi_remove_host+0x80/0x180
> [ 2538.459502]  usb_stor_disconnect+0x68/0xf4
> [ 2538.459506]  usb_unbind_interface+0xd4/0x280
> [ 2538.459510]  device_release_driver_internal+0x1c4/0x2c4
> [ 2538.459514]  device_release_driver+0x18/0x28
> [ 2538.459518]  bus_remove_device+0x15c/0x174
> [ 2538.459523]  device_del+0x1d0/0x358
> [ 2538.459528]  usb_disable_device+0x84/0x194
> [ 2538.459532]  usb_disconnect+0xec/0x300
> [ 2538.459537]  hub_event+0xb80/0x1870
> [ 2538.459541]  process_scheduled_works+0x248/0x4dc
> [ 2538.459545]  worker_thread+0x244/0x334
> [ 2538.459549]  kthread+0x114/0x1bc
> 
> [ 2538.461001] INFO: task "fsck.":15415 blocked for more than 188 seconds.
> [ 2538.461014] Call trace:
> [ 2538.461016]  __switch_to+0x174/0x338
> [ 2538.461021]  __schedule+0x628/0x9c4
> [ 2538.461025]  schedule+0x7c/0xe8
> [ 2538.461030]  blk_queue_enter+0xc4/0x160
> [ 2538.461034]  blk_mq_alloc_request+0x120/0x1d4
> [ 2538.461037]  scsi_execute_cmd+0x7c/0x23c
> [ 2538.461040]  ioctl_internal_command+0x5c/0x164
> [ 2538.461046]  scsi_set_medium_removal+0x5c/0xb0
> [ 2538.461051]  sd_release+0x50/0x94
> [ 2538.461054]  blkdev_put+0x190/0x28c
> [ 2538.461058]  blkdev_release+0x28/0x40
> [ 2538.461063]  __fput+0xf8/0x2a8
> [ 2538.461066]  __fput_sync+0x28/0x5c
> [ 2538.461070]  __arm64_sys_close+0x84/0xe8
> [ 2538.461073]  invoke_syscall+0x58/0x114
> [ 2538.461078]  el0_svc_common+0xac/0xe0
> [ 2538.461082]  do_el0_svc+0x1c/0x28
> [ 2538.461087]  el0_svc+0x38/0x68
> [ 2538.461090]  el0t_64_sync_handler+0x68/0xbc
> [ 2538.461093]  el0t_64_sync+0x1a8/0x1ac
> 
>    T1:				T2:
>    sd_remove
>    del_gendisk
>    __blk_mark_disk_dead
>    blk_freeze_queue_start
>    ++q->mq_freeze_depth
>    				bdev_release
>   				mutex_lock(&disk->open_mutex)
>    				sd_release
>   				scsi_execute_cmd
>   				blk_queue_enter
>   				wait_event(!q->mq_freeze_depth)

This looks wrong, there is a condition blk_queue_dying() in
blk_queue_enter().

Thanks,
Kuai

>    mutex_lock(&disk->open_mutex)
> 
> This is a classic ABBA deadlock. To fix the deadlock, make sure we don't
> try to acquire disk->open_mutex after freezing the queue.
> 
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>   block/genhd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 8f1f3c6b4d67..c5fca3e893a0 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -663,12 +663,12 @@ void del_gendisk(struct gendisk *disk)
>   	 */
>   	if (!test_bit(GD_DEAD, &disk->state))
>   		blk_report_disk_dead(disk, false);
> -	__blk_mark_disk_dead(disk);
>   
>   	/*
>   	 * Drop all partitions now that the disk is marked dead.
>   	 */
>   	mutex_lock(&disk->open_mutex);
> +	__blk_mark_disk_dead(disk);
>   	xa_for_each_start(&disk->part_tbl, idx, part, 1)
>   		drop_partition(part);
>   	mutex_unlock(&disk->open_mutex);
> 

