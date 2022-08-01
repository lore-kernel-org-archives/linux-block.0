Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C519C00140
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 01:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiHABEr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 21:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbiHABEq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 21:04:46 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82D11472
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 18:04:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Lx0HN0NdHzKGpk
        for <linux-block@vger.kernel.org>; Mon,  1 Aug 2022 09:03:28 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgA3tzCoJudi5cI3AA--.46416S3;
        Mon, 01 Aug 2022 09:04:41 +0800 (CST)
Subject: Re: [PATCH 7/8] dm: delay registering the gendisk
To:     Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20210804094147.459763-1-hch@lst.de>
 <20210804094147.459763-8-hch@lst.de>
 <ad2c7878-dabb-cb41-1bba-60ef48fa1a9f@huaweicloud.com>
 <20220707052425.GA13016@lst.de>
 <fd5c2e0a-5f68-9f1f-dfc2-49a2cd51de0b@huaweicloud.com>
 <6ff5c130-b5b1-b611-bb99-6a2275404fcd@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a858472c-6899-a42e-d961-e82b7047ac7c@huaweicloud.com>
Date:   Mon, 1 Aug 2022 09:04:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6ff5c130-b5b1-b611-bb99-6a2275404fcd@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA3tzCoJudi5cI3AA--.46416S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3ZF17tw4fAF1kKF1DGFg_yoW8AFWfpa
        48JFs0krZrXrs7W397t34UZr9Yvr4UJw1UJry5GFyxKryDWr9Yqr4xXF4qgFy7Jr4kWr1j
        qF4Utry5Zr4kA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi, Christoph!

在 2022/07/15 11:24, Yu Kuai 写道:
> Hi, Christoph!
> 
> 在 2022/07/07 15:20, Yu Kuai 写道:
>> 在 2022/07/07 13:24, Christoph Hellwig 写道:
>>> On Thu, Jul 07, 2022 at 11:29:26AM +0800, Yu Kuai wrote:
>>>> We found that this patch fix a nullptr crash in our test:
>>>
>>>> Do you think it's ok to backport this patch(and all realted patches) to
>>>> lts, or it's better to fix that bio can be submitted with queue
>>>> uninitialized from block layer?
>>>
>>> Given how long ago this was I do not remember offhand how much prep
>>> work this would require.  The patch itself is of course tiny and
>>> backportable, but someone will need to do the work and figure out how
>>> much else would have to be backported.
>>
>> Ok, I'll try to figure out that, and backport them.(At least to 5.10.y)

I posted a stable patchset on stable 5.10, can you pleas take a loock ?

dm: fix nullptr crash
https://lore.kernel.org/all/20220729062356.1663513-1-yukuai1@huaweicloud.com/

Thanks,
Kuai
> 
> While reviewing the code, I didn't found any protection that
> bd_link_disk_holder() won't concurrent with
> bd_register_pending_holders(). If they do can concurrent,
> following scenario is problematic:
> 
> t1                t2
> device_add_disk
>   disk->slave_dir = kobject_create_and_add
>                  bd_link_disk_holder
>                   __link_disk_holder
>                   list_add
>   bd_register_pending_holders
>    list_for_each_entry
>     __link_disk_holder -> -EEXIST
> 
> In this case, I think maybe ignore '-EEXIST' is fine.
> 
> I'm not familiar with dm, and I'm not sure if I missed something,
> please kindly correct me if I'm wrong.
> 
> Thanks,
> Kuai
> 
> .
> 

