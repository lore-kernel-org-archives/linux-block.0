Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22016C678D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 10:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCGK37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 05:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjCGK3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 05:29:32 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F5573AE4
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 02:28:46 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PWBVy0xDpz4f3jMP
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 18:28:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CHaEQdkWxj6EQ--.13145S3;
        Tue, 07 Mar 2023 18:28:43 +0800 (CST)
Subject: Re: [bug report] BUG: KASAN: slab-use-after-free in
 bfq_setup_cooperator
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230307071448.rzihxbm4jhbf5krj@shindev>
 <220e7ee3-e294-753f-d9df-8957a8f047e9@huaweicloud.com>
 <20230307091336.p2mzdo225zkoldmd@shindev>
 <076cb738-6f44-e731-d2a6-cad4ff464ae1@huaweicloud.com>
 <20230307102040.3t6qiojxj72fqrlc@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <73a84d09-9b64-f23a-1d24-a41cc1187b4b@huaweicloud.com>
Date:   Tue, 7 Mar 2023 18:28:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230307102040.3t6qiojxj72fqrlc@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CHaEQdkWxj6EQ--.13145S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4kJr4fCw13Xr1rCF1DGFg_yoW5Xryrpa
        1UKa1qyr1UJrWUXFyIyw40vryYvr1ayrW8KrW3Kr40k3Z8XrySgF4q934S9FySqF4kCrn8
        Zw1qq34xZr48A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jan

在 2023/03/07 18:20, Jan Kara 写道:
> On Tue 07-03-23 17:36:19, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/03/07 17:13, Shinichiro Kawasaki 写道:
>>> On Mar 07, 2023 / 16:57, Yu Kuai wrote:
>>> [...]
>>>> Thanks for the report, can you help to provide the result of add2line of
>>>> following?
>>>>
>>>> bfq_setup_cooperator+0x120b/0x1650
>>>> bfq_setup_cooperator+0xa41/0x1650
>>>>
>>>> That will help to locate the problem.
>>>
>>> Hi, Yu thanks for looking into this. Here are the faddr2line outputs:
>>>
>>> $ ./scripts/faddr2line vmlinux bfq_setup_cooperator+0x120b/0x1650
>>> bfq_setup_cooperator+0x120b/0x1650:
>>> bfqq_process_refs at block/bfq-iosched.c:1200
>>> (inlined by) bfq_setup_stable_merge at block/bfq-iosched.c:2855
>>> (inlined by) bfq_setup_cooperator at block/bfq-iosched.c:2941
>>>
>>> $ ./scripts/faddr2line vmlinux bfq_setup_cooperator+0xa41/0x1650
>>> bfq_setup_cooperator+0xa41/0x1650:
>>> bfq_setup_cooperator at block/bfq-iosched.c:2939
>>>
>>
>> So, after a quick look at the code, the difference is that fd571df0ac5b
>> changes the logic when bfqq_proces_refs(stable_merge_bfqq) is 0.
>>
>> I think perhaps following patch can work, at least 'stable_merge_bfqq'
>> won't be accessed after bfq_put_stable_ref() in this case:
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 8a8d4441519c..881f74b3a556 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2856,6 +2856,11 @@ bfq_setup_stable_merge(struct bfq_data *bfqd, struct
>> bfq_queue *bfqq,
>>                             bfqq_process_refs(stable_merge_bfqq));
>>          struct bfq_queue *new_bfqq;
>>
>> +       /* deschedule stable merge, because done or aborted here */
>> +       bfq_put_stable_ref(stable_merge_bfqq);
>> +
>> +       bfqq_data->stable_merge_bfqq = NULL;
>> +
> 
> I don't think this is going to help. stable_merge_bfqq is used just a few
> lines below again in bfq_setup_merge(). The problem really is that the
> reference from stable merge can be the last one keeping bfqq alive so in
> bfq_setup_cooperator() we need to see if stable_merge_bfqq still has
> process references (and cancel the merge if not) before dropping our ref.

I was thinking that bfq_setup_merge() will only be called if 'proc_ref'
is not 0, which means that stable_merge_bfqq won't be freed.
> 
> So rather doing something like:
> 
> 		bfqq_data->stable_merge_bfqq = NULL;
> 		new_bfqq = bfq_setup_stable_merge(bfqd, bfqq,
> 						  stable_merge_bfqq, bfqq_data);
> 		bfq_put_stable_ref(stable_merge_bfqq);
> 		return new_bfqq;
> 
> should work in bfq_setup_cooperator().

Yes, this will work.

Thanks,
Kuai
> 
> 								Honza
> 

