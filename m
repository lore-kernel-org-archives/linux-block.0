Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731D6C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 08:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJRIAt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 04:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiJRIAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 04:00:48 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208279EF3
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 01:00:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ms5p05xPBzK88q
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 15:58:16 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDnLS4lXU5jW0wtAA--.44530S3;
        Tue, 18 Oct 2022 16:00:38 +0800 (CST)
Subject: Re: [PATCH 2/2] block: clear the holder releated fields on late
 disk_add failure
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221018073822.646207-1-hch@lst.de>
 <20221018073822.646207-2-hch@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8c5359e3-39ee-d363-9425-0cb8b716dcb0@huaweicloud.com>
Date:   Tue, 18 Oct 2022 16:00:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221018073822.646207-2-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnLS4lXU5jW0wtAA--.44530S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyUZF1UAFy8Ar4DAF1fWFg_yoW8Gw1fpF
        Z8uFsYgry0kFWDWa12ya1UXFy8G3s8Xas7JFyS9r1IvrnxXw12va9Fkry5WF12krs3Kws0
        qFn8tay5ZF4vkFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi, Christoph!

ÔÚ 2022/10/18 15:38, Christoph Hellwig Ð´µÀ:
> Zero out the pointers to the holder related kobjects so that
> bd_unlink_disk_holder does the right thing when dm cleans up the delayed
> holders after add_disk fails.
> 

I'm planning to do the similar thing in the normal path:

1) in del_gendisk: (add a new api kobject_put_and_test)

if (kobject_put_and_test(bd_holder_dir/slave_dir))
	bd_holder_dir/slave_dir = NULL;

2) in bd_link_disk_holder, get bd_holder_dir first:

if (!kobject_get_unless_zero(bd_holder_dir))
	return -ENODEV;
...
bd_find_holder_disk()

Do you think this is ok?

Thanks,
Kuai

> Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
> Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 6123005154b2a..734c2e74f42e3 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -530,8 +530,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>   	bd_unregister_all_holders(disk);
>   out_put_slave_dir:
>   	kobject_put(disk->slave_dir);
> +	disk->slave_dir = NULL;
>   out_put_holder_dir:
>   	kobject_put(disk->part0->bd_holder_dir);
> +	disk->part0->bd_holder_dir = NULL;
>   out_del_integrity:
>   	blk_integrity_del(disk);
>   out_del_block_link:
> 

