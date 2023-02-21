Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594D1C61DA3
	for <linux-block@archiver.kernel.org>; Tue, 21 Feb 2023 06:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjBUGkA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Feb 2023 01:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBUGkA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 01:40:00 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBDE2367B
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 22:39:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PLV5P0mLXz4f3wtW
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 14:39:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CE3Z_RjQLS5Dg--.51190S3;
        Tue, 21 Feb 2023 14:39:53 +0800 (CST)
Subject: Re: [GIT PULL for-6.3] Block updates for 6.3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk>
 <CAHk-=wiLu7VRyPUpthiV6qMJp1eN3n_wD+vAroDsnDZq05QsLA@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e2071a24-cd25-e5bd-9166-a3b575b7bf4a@huaweicloud.com>
Date:   Tue, 21 Feb 2023 14:39:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiLu7VRyPUpthiV6qMJp1eN3n_wD+vAroDsnDZq05QsLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CE3Z_RjQLS5Dg--.51190S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw15JF1fXw1rtw43uw43GFg_yoW8CrWrp3
        W5KFs0krs7GrZ3Jry8Aw12q3WSyFyftryrAas0grn8AF95Ww17JF90kw4Y9F9a93yrCr1S
        vF95GrZ5C34DZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

在 2023/02/21 6:52, Linus Torvalds 写道:
> On Thu, Feb 16, 2023 at 6:54 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I've pushed a merged branch here:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=for-6.3/block-merged
> 
> Hmm. I do verify against suggested merges after doing my own (even
> when your suggested merge was then made stale by another later
> addition), and I think your merge was wrong wrt bfq_sync_bfqq_move(),
> which in your version does the bfq_release_process_ref() before doing
> the bic_set_bfqq().

It's right this is wrong, I think this happened as following:

1) bfq_sync_bfqq_move() is introduced in commit 9778369a2d6c ("block,
bfq: split sync bfq_queues on a per-actuator basis"), which is merged to
for-6.3 branch.

2) commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
is merged to mainline.

3) later, the fix for 2) b600de2d7d3a ("block, bfq: fix uaf for bfqq in
bic_set_bfqq()") is merged to mainline as well, however, I missed the
change in bfq_sync_bfqq_move() in for-6.3 brach.

4) At last, 1) is merged to mainline with some rebase, this is how
bfq_check_ioprio_change() is fixed, however, bfq_sync_bfqq_move() is
still problematic.

Thanks,
Kuai
> 
> IOW, I think your merge essentially dropped one of the fixes in commit
> b600de2d7d3a ("block, bfq: fix uaf for bfqq in bic_set_bfqq()").
> 
> Maybe there were reasons why that ordering wasn't required any more,
> but it looks funky (and you appear to have correctly merged the other
> case in bfq_check_ioprio_change()).
> 
> Anyway, this is just a nit-picky email saying that I'm pretty sure
> I've done the merge right, but since it doesn't match what you did, I
> thought I'd mention it.
> 
> Worth double-checking this, in other words. I realize you're mostly
> afk this week, so whenever you're back.
> 
>                  Linus
> .
> 

