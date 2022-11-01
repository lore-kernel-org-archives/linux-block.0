Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5368EC433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 11:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiKAL32 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 07:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKAL2g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 07:28:36 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CCE29C
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 04:28:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N1nkx4vRlzKGTb
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:25:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgB3UXrRAmFjXyOJBA--.62160S3;
        Tue, 01 Nov 2022 19:28:19 +0800 (CST)
Subject: Re: [PATCH 7/7] block: store the holder kobject in bd_holder_disk
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221030153120.1045101-1-hch@lst.de>
 <20221030153120.1045101-8-hch@lst.de>
 <fd409996-e5e1-d7af-b31d-87db943eaa25@huaweicloud.com>
 <20221101104927.GA13823@lst.de>
 <d3f6ec1d-8141-19d1-ce4c-d42710f4a636@huaweicloud.com>
 <20221101112131.GA14379@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <57465370-99fe-d8a5-e150-a1057640e972@huaweicloud.com>
Date:   Tue, 1 Nov 2022 19:28:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221101112131.GA14379@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgB3UXrRAmFjXyOJBA--.62160S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KryfXF15Cw1xAFykCr4kWFg_yoW8trW3pa
        98WF4rtrykGFWDXa1DKw17WFWj9r1UJ3W8CrySkrs2grZxJr92yr17Ary7XF13Crs2yr4q
        qF45X3yFvFWvkFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2022/11/01 19:21, Christoph Hellwig Ð´µÀ:
> On Tue, Nov 01, 2022 at 07:12:51PM +0800, Yu Kuai wrote:
>>> But how could the reference be 0 here?  The driver that calls
>>> bd_link_disk_holder must have the block device open and thus hold a
>>> reference to it.
>>
>> Like I said before, the caller of bd_link_disk_holder() get bdev by
>> blkdev_get_by_dev(), which do not grab reference of holder_dir, and
>> grab disk reference can only prevent disk_release() to be called, not
>> del_gendisk() while holder_dir reference is dropped in del_gendisk()
>> and can be decreased to 0.
> 
> Oh, the bd_holder_dir reference, not the block_device one.  So yes,
> I agree.
> 
>> If you agree with above explanation, I tried to fix this:
>>
>> 1) move kobject_put(bd_holder_dir) from del_gendisk to disk_release,
>> there seems to be a lot of other dependencies.
>>
>> 2) protect bd_holder_dir reference by open_mutex.
> 
> I think simply switching the kobject_get in bd_link_disk_holder
> into a kobject_get_unless_zero and unwinding if there is no reference
> should be enough:
> 
> diff --git a/block/holder.c b/block/holder.c
> index a8c355b9d0806..cd18064f6ff80 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -83,7 +83,11 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   
>   	INIT_LIST_HEAD(&holder->list);
>   	holder->refcnt = 1;
> -	holder->holder_dir = kobject_get(bdev->bd_holder_dir);
> +	if (!kobject_get_unless_zero(bdev->bd_holder_dir)) {
> +		ret = -EBUSY;
> +		goto out_free_holder;
> +	}
> +	holder->holder_dir = bdev->bd_holder_dir;

What if bd_holder_dir is already freed here, then uaf can be triggered.
Thus bd_holder_dir need to be resed in del_gendisk() if it's reference
is dropped to 0, however, kobject apis can't do that...

Thanks,
Kuai
>   
>   	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
>   	if (ret)
> @@ -100,6 +104,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	del_symlink(disk->slave_dir, bdev_kobj(bdev));
>   out_put_holder_dir:
>   	kobject_put(holder->holder_dir);
> +out_free_holder:
>   	kfree(holder);
>   out_unlock:
>   	mutex_unlock(&disk->open_mutex);
> 
> .
> 

