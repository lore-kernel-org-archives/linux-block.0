Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CC7C61DA4
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 09:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBIJdL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 04:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBIJdJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 04:33:09 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F32611FF
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 01:32:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PCBVN5Vcqz4f3jHV
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 17:32:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyG9veRjgHUADA--.19673S3;
        Thu, 09 Feb 2023 17:32:47 +0800 (CST)
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221130175653.24299-1-jack@suse.cz>
 <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
 <Y9kiltmuPSbRRLsO@infradead.org>
 <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
 <Y9oFHssFz2obv83W@infradead.org>
 <1901c3f0-da34-1df1-2443-3426282a6ecb@huaweicloud.com>
 <1b5d3502-353d-8674-cd5d-79283fa8905d@huaweicloud.com>
 <20230208120258.64yhqho252gaydmu@quack3>
 <02e769f7-9a41-80bc-4e47-fa87c18a36b2@huaweicloud.com>
 <20230209090439.w2k37tufbbhk6qq3@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1bf91d5c-6130-43de-7995-af09045d4b98@huaweicloud.com>
Date:   Thu, 9 Feb 2023 17:32:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230209090439.w2k37tufbbhk6qq3@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyG9veRjgHUADA--.19673S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7XryxArW7ZrWDKFW3Jrb_yoW8CFWfp3
        y0gFW3tFWDW34Ik348tw1DG34rtrsFyr4xJr1rCr10k3s5Xr9IkF1fKa98ua4UWFWkCa1U
        Xr4UWa4fX3WrAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/02/09 17:04, Jan Kara 写道:
> On Wed 08-02-23 22:13:02, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/02/08 20:02, Jan Kara 写道:
>>>
>>> After some thought I don't like opencoding blkdev_get_by_dev() in disk_scan
>>> partitions. But I agree Christoph's approach with blkdev_get_whole() does
>>> not quite work either. We could propagate holder/owner into
>>> blkdev_get_whole() to fix Christoph's check but still we are left with a
>>> question what to do with GD_NEED_PART_SCAN set bit when we get into
>>> blkdev_get_whole() and find out we are not elligible to rescan partitions.
>>> Because then some exclusive opener later might be caught by surprise when
>>> the partition rescan happens due to this bit being set from the past failed
>>> attempt to rescan.
>>>
>>> So what we could do is play a similar trick as we do in the loop device and
>>> do in disk_scan_partitions():
>>>
>>> 	/*
>>> 	 * If we don't hold exclusive handle for the device, upgrade to it
>>> 	 * here to avoid changing partitions under exclusive owner.
>>> 	 */
>>> 	if (!(mode & FMODE_EXCL)) {
>> This is not necessary, all the caller make sure FMODE_EXCL is not set.
> 
> Yes, but we need to propagate it correctly from blkdev_common_ioctl() now,
> exactly so that ioctl does not fail if you exclusively opened the device as
> you realized below :)

Ok, I get it that you want to pass in FMODE_EXCL from ioctl(). But I'm
not sure let others fail to open device extl is a good idea.

I still prefer to open code blkdev_get_by_dev(), because many operations
is not necessary here. And this way, we can clear GD_NEED_PART_SCAN
inside open_mutex if rescan failed.

Thanks,
Kuai

> 
>>> 		error = bd_prepare_to_claim(disk->part0, disk_scan_partitions);
>>> 		if (error)
>>> 			return error;
>>> 	}
>>  From what I see, if thread open device excl first, and then call ioctl()
>> to reread partition, this will cause this ioctl() to fail?
> 
> 								Honza
> 

