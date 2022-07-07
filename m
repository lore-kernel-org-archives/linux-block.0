Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B4C43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 07:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiGGHUx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 03:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGGHUw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 03:20:52 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3664720F78
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 00:20:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LdnqQ1gKFzl1sF
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 15:20:02 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCnCWlOicZilpTiAQ--.30604S3;
        Thu, 07 Jul 2022 15:20:48 +0800 (CST)
Subject: Re: [PATCH 7/8] dm: delay registering the gendisk
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
References: <20210804094147.459763-1-hch@lst.de>
 <20210804094147.459763-8-hch@lst.de>
 <ad2c7878-dabb-cb41-1bba-60ef48fa1a9f@huaweicloud.com>
 <20220707052425.GA13016@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fd5c2e0a-5f68-9f1f-dfc2-49a2cd51de0b@huaweicloud.com>
Date:   Thu, 7 Jul 2022 15:20:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220707052425.GA13016@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnCWlOicZilpTiAQ--.30604S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWUWrWDKw48Xw18GrW8Crg_yoWxCFc_ZF
        s8W3s7C3W5G3Wvga1UKr95J39xKa4xZ34kWFy7uF4Duw18Xa1DWFy7GwnxXr15J348Xr9x
        ZryYgrWUCw1jqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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

ÔÚ 2022/07/07 13:24, Christoph Hellwig Ð´µÀ:
> On Thu, Jul 07, 2022 at 11:29:26AM +0800, Yu Kuai wrote:
>> We found that this patch fix a nullptr crash in our test:
> 
>> Do you think it's ok to backport this patch(and all realted patches) to
>> lts, or it's better to fix that bio can be submitted with queue
>> uninitialized from block layer?
> 
> Given how long ago this was I do not remember offhand how much prep
> work this would require.  The patch itself is of course tiny and
> backportable, but someone will need to do the work and figure out how
> much else would have to be backported.

Ok, I'll try to figure out that, and backport them.(At least to 5.10.y)

Thanks,
Kuai
> .
> 

