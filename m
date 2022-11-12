Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2BBC4332F
	for <linux-block@archiver.kernel.org>; Sat, 12 Nov 2022 06:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiKLGXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Nov 2022 01:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiKLGXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Nov 2022 01:23:49 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED545A1D
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 22:23:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N8QWL2Bx4z4f3jHm
        for <linux-block@vger.kernel.org>; Sat, 12 Nov 2022 14:23:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgBHPazwO29jtC94AQ--.18697S3;
        Sat, 12 Nov 2022 14:23:45 +0800 (CST)
Subject: Re: [PATCH 5/7] dm: track per-add_disk holder relations in DM
To:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221030153120.1045101-1-hch@lst.de>
 <20221030153120.1045101-6-hch@lst.de>
 <9b5b4c2a-6566-2fb4-d3ae-4904f0889ea0@huaweicloud.com>
 <20221109082645.GA14093@lst.de> <Y20+UNI0KV2VjUSi@redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6230db62-9ad0-6f81-aafb-0fcb160d294d@huaweicloud.com>
Date:   Sat, 12 Nov 2022 14:23:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y20+UNI0KV2VjUSi@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHPazwO29jtC94AQ--.18697S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyfCrWUGw4UAF4fuFyDKFg_yoW5ArWxpF
        WrKFW7KrZ8Gw43uwn2vw4j9Fy5t34FkayrJFyrGryI9wn8AF9YvFW3tFW3Xa4kJrn5KF1Y
        qFW2q3yrZF4vyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
        -UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



ÔÚ 2022/11/11 2:09, Mike Snitzer Ð´µÀ:
> On Wed, Nov 09 2022 at  3:26P -0500,
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> On Wed, Nov 09, 2022 at 10:08:14AM +0800, Yu Kuai wrote:
>>>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>>>> index 2917700b1e15c..7b0d6dc957549 100644
>>>> --- a/drivers/md/dm.c
>>>> +++ b/drivers/md/dm.c
>>>> @@ -751,9 +751,16 @@ static struct table_device *open_table_device(struct mapped_device *md,
>>>>    		goto out_free_td;
>>>>    	}
>>>>    -	r = bd_link_disk_holder(bdev, dm_disk(md));
>>>> -	if (r)
>>>> -		goto out_blkdev_put;
>>>> +	/*
>>>> +	 * We can be called before the dm disk is added.  In that case we can't
>>>> +	 * register the holder relation here.  It will be done once add_disk was
>>>> +	 * called.
>>>> +	 */
>>>> +	if (md->disk->slave_dir) {
>>> If device_add_disk() or del_gendisk() can concurrent with this, It seems
>>> to me that using 'slave_dir' is not safe.
>>>
>>> I'm not quite familiar with dm, can we guarantee that they can't
>>> concurrent?
>>
>> I assumed dm would not get itself into territory were creating /
>> deleting the device could race with adding component devices, but
>> digging deeper I can't find anything.  This could be done
>> by holding table_devices_lock around add_disk/del_gendisk, but
>> I'm not that familar with the dm code.
>>
>> Mike, can you help out on this?
> 
> Maybe :/
> 
> Underlying component devices can certainly come and go at any
> time. And there is no DM code that can, or should, prevent that. All
> we can do is cope with unavailability of devices. But pretty sure that
> isn't the question.
> 
> I'm unclear about the specific race in question:
> if open_table_device() doesn't see slave_dir it is the first table
> load. Otherwise, the DM device (and associated gendisk) shouldn't have
> been torn down while a table is actively being loaded for it. But
> _where_ the code lives, to ensure that, is also eluding me...
> 
> You could use a big lock (table_devices_lock) to disallow changes to
> DM relations while loading the table. But I wouldn't think it needed

How about using table_devices_lock to protect device addition and
removal to forbid table load race with creating and deleting explictily,
as Christoph suggested?

Thanks,
Kuai

> as long as the gendisk's lifecycle is protected vs table loads (or
> other concurrent actions like table load vs dm device removal). Again,
> more code inspection needed to page all this back into my head.
> 
> The concern for race aside:
> I am concerned that your redundant bd_link_disk_holder() (first in
> open_table_device and later in dm_setup_md_queue) will result in
> dangling refcount (e.g. increase of 2 when it should only be by 1) --
> given bd_link_disk_holder will gladly just bump its holder->refcnt if
> bd_find_holder_disk() returns an existing holder. This would occur if
> a DM table is already loaded (and DM device's gendisk exists) and a
> new DM table is being loaded.
> 
> Mike
> 
> .
> 

