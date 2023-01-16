Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84018C3DA78
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 03:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjAPDJz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Jan 2023 22:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjAPDJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Jan 2023 22:09:54 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6464D4485
        for <linux-block@vger.kernel.org>; Sun, 15 Jan 2023 19:09:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NwH7Z6J34z4f3wv0
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 11:09:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR_7v8RjsnKXBg--.28376S3;
        Mon, 16 Jan 2023 11:09:49 +0800 (CST)
Subject: Re: [PATCH] block, bfq: fix uaf for bfqq in bic_set_bfqq()
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Jan Kara <jack@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230113094410.2907223-1-yukuai3@huawei.com>
 <bab60ee7-b0b7-4e45-40b4-29d77de67372@applied-asynchrony.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <963eaa70-79bc-796a-9c88-9e92929729a6@huaweicloud.com>
Date:   Mon, 16 Jan 2023 11:09:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bab60ee7-b0b7-4e45-40b4-29d77de67372@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR_7v8RjsnKXBg--.28376S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4DZF1xGw18ZF18Xr1UZFb_yoW5WryrpF
        1ktF4UWryUGr1ktr47Jw1DXFyrXF4rJ34DKryjqa42vry3Jr12qF4j9r40gF10gr4rGw47
        XryUW3yDZr17XFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/01/13 21:38, Holger Hoffstätte 写道:
> On 2023-01-13 10:44, Yu Kuai wrote:
>> After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 
>> 'bfqq->bic'"),
>> bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
>> bic->bfqq will be freed first, and bic_set_bfqq() is called with the 
>> freed
>> bic->bfqq.
>>
>> Fix the problem by always freeing bfqq after bic_set_bfqq().
>>
>> Fixes: 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
>> Reported-and-tested-by: Shinichiro Kawasaki 
>> <shinichiro.kawasaki-Sjgp3cTcYWE@public.gmane.org>
>> Signed-off-by: Yu Kuai <yukuai3-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>   block/bfq-cgroup.c  | 2 +-
>>   block/bfq-iosched.c | 4 +++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index a6e8da5f5cfd..feb13ac25557 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -749,8 +749,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>>            * old cgroup.
>>            */
>>           bfq_put_cooperator(sync_bfqq);
>> -        bfq_release_process_ref(bfqd, sync_bfqq);
>>           bic_set_bfqq(bic, NULL, true, act_idx);
>> +        bfq_release_process_ref(bfqd, sync_bfqq);
>>       }
>>   }
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 815b884d6c5a..2ddf831221c4 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -5581,9 +5581,11 @@ static void bfq_check_ioprio_change(struct 
>> bfq_io_cq *bic, struct bio *bio)
>>       bfqq = bic_to_bfqq(bic, false, bfq_actuator_index(bfqd, bio));
>>       if (bfqq) {
>> -        bfq_release_process_ref(bfqd, bfqq);
>> +        struct bfq_queue *old_bfqq = bfqq;
>> +
>>           bfqq = bfq_get_queue(bfqd, bio, false, bic, true);
>>           bic_set_bfqq(bic, bfqq, false, bfq_actuator_index(bfqd, bio));
>> +        bfq_release_process_ref(bfqd, old_bfqq);
>>       }
>>       bfqq = bic_to_bfqq(bic, true, bfq_actuator_index(bfqd, bio));
>>
> 
> Hello,
> 
> does this condition also affect the current code? I ask since the patch 
> does not apply
> as bfq_sync_bfqq_move() is only part of the multi-actuator work, which 
> is only in
> Jens' for-next. Comparing the code sections it seems it should also be 
> necessary for
> current 6.1/6.2, but I wanted to check.

bfq_sync_bfqq_move() already make sure bfq_release_process_ref() is
called after bic_set_bfqq(), so the problem this patch tries to fix
should not exist here.

Thanks,
Kuai
> 
> thanks
> Holger
> 
> .
> 

