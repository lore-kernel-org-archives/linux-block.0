Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69803C6FA82
	for <linux-block@archiver.kernel.org>; Tue, 13 Sep 2022 13:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiIMNjQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiIMNjP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 09:39:15 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E84757569
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 06:39:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MRkzd71nPzl67y
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 21:37:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgA3inP6hyBjSHwpAw--.14604S3;
        Tue, 13 Sep 2022 21:39:07 +0800 (CST)
Subject: Re: wbt_lat_usec still set despite wbt disabled by BFQ
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        linux-block <linux-block@vger.kernel.org>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <a5041479-f417-2b95-b645-56e665a7e557@applied-asynchrony.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <17e0e889-e848-0bd3-3203-cb4e9b801462@huaweicloud.com>
Date:   Tue, 13 Sep 2022 21:39:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a5041479-f417-2b95-b645-56e665a7e557@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inP6hyBjSHwpAw--.14604S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyxCrW5Kw17XFyDZFy8uFg_yoW3GrXEvF
        13tr48Jw1rZr1F9w15Kws2kFyDKws7XF95Jw1rXr17Z3sxJFnIkws3C345uan8Jwn7Cr1q
        9ry7XrykXw40qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Holger

在 2022/08/18 1:12, Holger Hoffstätte 写道:
> 
> I just noticed that my device configured with BFQ still shows wbt_lat_usec
> as configured, despite the fact that BFQ disables WBT in bfq_init_queue 
> [1]:
> 
> $cat /sys/block/sdc/queue/scheduler
> mq-deadline [bfq] none
> $cat /sys/block/sdc/queue/wbt_lat_usec
> 75000
> 
> Is this supposed to be 0 (since it's disabled) or is sysfs confused?
> 
> Thanks,
> Holger

I'm reviewing wbt codes recently, and I found that this problem will
happen if the default elevator is bfq. I'll try to fix this, do you mind
if I add reported-by tag?

Thanks,
Kuai
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/bfq-iosched.c#n7195 
> 
> 
> .
> 

