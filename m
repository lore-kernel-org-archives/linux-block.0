Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0016C636D7
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 11:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBILyP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 06:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjBILxl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 06:53:41 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD2268ADC
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 03:41:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PCDsw2ptYz4f3jJ5
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 19:19:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiDU1uRjobUEDA--.15026S3;
        Thu, 09 Feb 2023 19:19:50 +0800 (CST)
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
 <Y9kiltmuPSbRRLsO@infradead.org>
 <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
 <Y9oFHssFz2obv83W@infradead.org>
 <1901c3f0-da34-1df1-2443-3426282a6ecb@huaweicloud.com>
 <1b5d3502-353d-8674-cd5d-79283fa8905d@huaweicloud.com>
 <20230208120258.64yhqho252gaydmu@quack3>
 <02e769f7-9a41-80bc-4e47-fa87c18a36b2@huaweicloud.com>
 <20230209090439.w2k37tufbbhk6qq3@quack3>
 <1bf91d5c-6130-43de-7995-af09045d4b98@huaweicloud.com>
 <20230209095729.igkpj23afj6nbxxi@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8ca26a55-f48b-5043-7890-03ccbf541ead@huaweicloud.com>
Date:   Thu, 9 Feb 2023 19:19:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230209095729.igkpj23afj6nbxxi@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiDU1uRjobUEDA--.15026S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4DWrW3JF1rtw17Kw45Jrb_yoW5XFy5pa
        yFgFWYyFWDGw1Fkw1Utw1xGw4rtrZxJr1UXF15Gr10k3s0q34agF1fKa1Dua4UWrWkJw4j
        qr1UWa4Iq3W5ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/02/09 17:57, Jan Kara 写道:
> On Thu 09-02-23 17:32:45, Yu Kuai wrote:
>> 在 2023/02/09 17:04, Jan Kara 写道:
>>> On Wed 08-02-23 22:13:02, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2023/02/08 20:02, Jan Kara 写道:
>>>>>
>>>>> After some thought I don't like opencoding blkdev_get_by_dev() in disk_scan
>>>>> partitions. But I agree Christoph's approach with blkdev_get_whole() does
>>>>> not quite work either. We could propagate holder/owner into
>>>>> blkdev_get_whole() to fix Christoph's check but still we are left with a
>>>>> question what to do with GD_NEED_PART_SCAN set bit when we get into
>>>>> blkdev_get_whole() and find out we are not elligible to rescan partitions.
>>>>> Because then some exclusive opener later might be caught by surprise when
>>>>> the partition rescan happens due to this bit being set from the past failed
>>>>> attempt to rescan.
>>>>>
>>>>> So what we could do is play a similar trick as we do in the loop device and
>>>>> do in disk_scan_partitions():
>>>>>
>>>>> 	/*
>>>>> 	 * If we don't hold exclusive handle for the device, upgrade to it
>>>>> 	 * here to avoid changing partitions under exclusive owner.
>>>>> 	 */
>>>>> 	if (!(mode & FMODE_EXCL)) {
>>>> This is not necessary, all the caller make sure FMODE_EXCL is not set.
>>>
>>> Yes, but we need to propagate it correctly from blkdev_common_ioctl() now,
>>> exactly so that ioctl does not fail if you exclusively opened the device as
>>> you realized below :)
>>
>> Ok, I get it that you want to pass in FMODE_EXCL from ioctl(). But I'm
>> not sure let others fail to open device extl is a good idea.
> 
> Other exclusive openers will not fail. They will block until we call
> bd_abort_claiming() after the partitions have been reread.

Yes, you're right, rescan and other exclusively openers will be
synchronized by bd_prepare_to_claim().
> 
>> I still prefer to open code blkdev_get_by_dev(), because many operations
>> is not necessary here. And this way, we can clear GD_NEED_PART_SCAN
>> inside open_mutex if rescan failed.
> 
> I understand many operations are not needed there but this is not a hot
> path and leaking of bdev internal details into genhd.c is not a good
> practice either (e.g. you'd have to make blkdev_get_whole() extern).

I was thinking that disk_scan_partitions() can be moved to bdev.c to
avoid that...
> 
> We could create a special helper for partition rescan in block/bdev.c to
> hide the details but think that bd_start_claiming() - bd_abort_claiming()
> trick is the simplest solution to temporarily grab exclusive ownership if
> we don't have it.

Now I'm good with this solution. By the way, do you think we must make
sure the first partition scan will be proceed?

Thanks,
Kuai
> 
> 								Honza
> 

