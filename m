Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C03C678D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 09:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCGJg1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 04:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCGJg0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 04:36:26 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D350A88DB0
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 01:36:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PW9LW54Hqz4f3nTJ
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 17:36:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CGTBQdkdu_3EQ--.13794S3;
        Tue, 07 Mar 2023 17:36:21 +0800 (CST)
Subject: Re: [bug report] BUG: KASAN: slab-use-after-free in
 bfq_setup_cooperator
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jan Kara <jack@suse.cz>, "yukuai (C)" <yukuai3@huawei.com>
References: <20230307071448.rzihxbm4jhbf5krj@shindev>
 <220e7ee3-e294-753f-d9df-8957a8f047e9@huaweicloud.com>
 <20230307091336.p2mzdo225zkoldmd@shindev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <076cb738-6f44-e731-d2a6-cad4ff464ae1@huaweicloud.com>
Date:   Tue, 7 Mar 2023 17:36:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230307091336.p2mzdo225zkoldmd@shindev>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CGTBQdkdu_3EQ--.13794S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1kKry7Gry8Gry5CF1fXrb_yoW8uw15pa
        1DKw4qyr1UKrW5XrWxAw40v34jyr1ayrykKrWSgrW2k3Z8XryfGF4q934I9a4Sqa18Crnx
        Z34qq3s7Ar48JF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

ÔÚ 2023/03/07 17:13, Shinichiro Kawasaki Ð´µÀ:
> On Mar 07, 2023 / 16:57, Yu Kuai wrote:
> [...]
>> Thanks for the report, can you help to provide the result of add2line of
>> following?
>>
>> bfq_setup_cooperator+0x120b/0x1650
>> bfq_setup_cooperator+0xa41/0x1650
>>
>> That will help to locate the problem.
> 
> Hi, Yu thanks for looking into this. Here are the faddr2line outputs:
> 
> $ ./scripts/faddr2line vmlinux bfq_setup_cooperator+0x120b/0x1650
> bfq_setup_cooperator+0x120b/0x1650:
> bfqq_process_refs at block/bfq-iosched.c:1200
> (inlined by) bfq_setup_stable_merge at block/bfq-iosched.c:2855
> (inlined by) bfq_setup_cooperator at block/bfq-iosched.c:2941
> 
> $ ./scripts/faddr2line vmlinux bfq_setup_cooperator+0xa41/0x1650
> bfq_setup_cooperator+0xa41/0x1650:
> bfq_setup_cooperator at block/bfq-iosched.c:2939
> 

So, after a quick look at the code, the difference is that fd571df0ac5b
changes the logic when bfqq_proces_refs(stable_merge_bfqq) is 0.

I think perhaps following patch can work, at least 'stable_merge_bfqq'
won't be accessed after bfq_put_stable_ref() in this case:

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8a8d4441519c..881f74b3a556 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2856,6 +2856,11 @@ bfq_setup_stable_merge(struct bfq_data *bfqd, 
struct bfq_queue *bfqq,
                            bfqq_process_refs(stable_merge_bfqq));
         struct bfq_queue *new_bfqq;

+       /* deschedule stable merge, because done or aborted here */
+       bfq_put_stable_ref(stable_merge_bfqq);
+
+       bfqq_data->stable_merge_bfqq = NULL;
+
         if (idling_boosts_thr_without_issues(bfqd, bfqq) ||
             proc_ref == 0)
                 return NULL;
@@ -2933,11 +2938,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, 
struct bfq_queue *bfqq,
                         struct bfq_queue *stable_merge_bfqq =
                                 bfqq_data->stable_merge_bfqq;

-                       /* deschedule stable merge, because done or 
aborted here */
-                       bfq_put_stable_ref(stable_merge_bfqq);
-
-                       bfqq_data->stable_merge_bfqq = NULL;
-
                         return bfq_setup_stable_merge(bfqd, bfqq,
                                                       stable_merge_bfqq,
                                                       bfqq_data);

