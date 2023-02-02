Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9052C61DA4
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 12:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjBBMuv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 07:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBBMuu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 07:50:50 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E7330C0
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 04:50:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P6zD26M88z4f3t1C
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 20:50:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyGjsdtjyyZ2Cg--.38498S3;
        Thu, 02 Feb 2023 20:50:45 +0800 (CST)
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221130175653.24299-1-jack@suse.cz>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5af26157-d191-1046-7081-1841239fef71@huaweicloud.com>
Date:   Thu, 2 Feb 2023 20:50:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221130175653.24299-1-jack@suse.cz>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyGjsdtjyyZ2Cg--.38498S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyDWF17Xr1fJFyrGrWfXwb_yoW8Aryrpa
        ykGFZxKryDGr47ua4DXa1xJr18Gws7ArWftr98Kr1F9ry3X3sayFWak3y5C3WYvrZ3JrWU
        Zr1Yqry8WF1rCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jan and Christoph

ÔÚ 2022/12/01 1:56, Jan Kara Ð´µÀ:
> Since commit 10c70d95c0f2 ("block: remove the bd_openers checks in
> blk_drop_partitions") we allow rereading of partition table although
> there are users of the block device. This has an undesirable consequence
> that e.g. if sda and sdb are assembled to a RAID1 device md0 with
> partitions, BLKRRPART ioctl on sda will rescan partition table and
> create sda1 device. This partition device under a raid device confuses
> some programs (such as libstorage-ng used for initial partitioning for
> distribution installation) leading to failures.
> 
> Fix the problem refusing to rescan partitions if there is another user
> that has the block device exclusively open.

Still by code review, I just found another race that cound cause disk
can't scan partition while creating:

t1: create device	t2: open device exclusively
device_add_disk()
  bdev_add
   insert_inode_hash
                         ...
                         bd_finish_claiming
                          bdev->bd_holder = holder
disk_scan_partitions
// check holder and failed

This race is artificial and unlikely to happend in practice, but this
is easy to fix by following:

diff --git a/block/genhd.c b/block/genhd.c
index 09f2ac548832..23e87753313b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -497,6 +497,11 @@ int __must_check device_add_disk(struct device 
*parent, struct gendisk *disk,
                 if (ret)
                         goto out_unregister_bdi;

+               /*
+                * In case user open device before disk_scan_partitions(),
+                * set state here, so that blkdev_open() can scan 
partitions.
+                */
+               set_bit(GD_NEED_PART_SCAN, &disk->state);
                 bdev_add(disk->part0, ddev->devt);
                 if (get_capacity(disk))
                         disk_scan_partitions(disk, FMODE_READ, NULL);

