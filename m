Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E51C0032E
	for <linux-block@archiver.kernel.org>; Mon, 23 Oct 2023 01:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjJWBLk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Oct 2023 21:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjJWBLj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Oct 2023 21:11:39 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FA0ED
        for <linux-block@vger.kernel.org>; Sun, 22 Oct 2023 18:11:36 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SDHFs3xn7z4f3jM3
        for <linux-block@vger.kernel.org>; Mon, 23 Oct 2023 09:11:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id AFCFD1A0338
        for <linux-block@vger.kernel.org>; Mon, 23 Oct 2023 09:11:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdVAyDVljIfGDg--.26722S3;
        Mon, 23 Oct 2023 09:11:31 +0800 (CST)
Subject: Re: [PATCH] block: Improve shared tag set performance
To:     Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ed Tsai <ed.tsai@mediatek.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231018180056.2151711-1-bvanassche@acm.org>
 <31ca731b-7ffb-185a-fdbc-9e4821e2b46f@huaweicloud.com>
 <b3325fe5-4208-432b-97a9-d40f5cdda4b0@acm.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a7734eb8-4031-8a0c-53c1-efcd4363187f@huaweicloud.com>
Date:   Mon, 23 Oct 2023 09:11:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b3325fe5-4208-432b-97a9-d40f5cdda4b0@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdVAyDVljIfGDg--.26722S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFykWF47ZFyrCw4fWF4xCrg_yoW8tw4xpa
        yrta1akryDG348Jw4kG34jqa4xtr97Jan8JryrWFyUAw43Gr4IqFy5ZryY9r9Ivr4rJr1a
        v3WUtr98Zr18Ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/10/22 0:21, Bart Van Assche 写道:
> 
> On 10/21/23 00:32, Yu Kuai wrote:
>> Sorry for such huge delay, I was struggled on implementing a smoothly
>> algorithm to borrow tags and return borrowed tags, and later I put this
>> on ice and focus on other stuff.
>>
>> I had an idea to implement a state machine, however, the amount of code
>> was aggressive and I gave up. And later, I implemented a simple version,
>> and I tested it in your case, 32 tags and 2 shared node, result looks
>> good(see below), however, I'm not confident this can work well general.
>>
>> Anyway, I'll send a new RFC verion for this, and please let me know if
>> you still think this approch is unacceptable.
>>
>> Thanks,
>> Kuai
>>
>> Test script:
>>
>> [global]
>> ioengine=libaio
>> iodepth=2
>> bs=4k
>> direct=1
>> rw=randrw
>> group_reporting
>>
>> [sda]
>> numjobs=32
>> filename=/dev/sda
>>
>> [sdb]
>> numjobs=1
>> filename=/dev/sdb
>>
>> Test result, by monitor new debugfs entry shared_tag_info:
>> time    active        available
>>      sda     sdb    sda    sdb
>> 0    0    0    32    32
>> 1    16    2    16    16    -> start fair sharing
>> 2    19    2    20    16
>> 3    24    2    24    16
>> 4    26    2    28    16     -> borrow 32/8=4 tags each round
>> 5    28    2    28    16    -> save at lease 4 tags for sdb
> 
> Hi Yu,
> 
> Thank you for having shared these results. What is the unit of the
> numbers in the time column?


I added a timer in blk_mq_tags, and timer function is used to implement
borrow tags and return borrowed tags, the timer will start when one node
is busy, and will expire in HZ, so the time means each second.
> 
> In the above I see that more tags are assigned to sda than to sdb
> although I/O is being submitted to both LUNs. I think the current
> algoritm defines fairness as dividing tags in a fair way across active
> LUNs. Do the above results show that tags are divided per active job
> instead of per active LUN? If so, I'm not sure that everyone will agree
> that this is a fair way to distribute tags ...

Yes, active tag is divided into per active LUN, specifically each
request_queue or hctx that is sharing tags.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> 
> .
> 

