Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD7C38142
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 07:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjBAHUd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 02:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjBAHUc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 02:20:32 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719BE27D4C
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 23:20:30 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P6CxN4975z4f3p12
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 15:20:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR+5EtpjkFUvCg--.14594S3;
        Wed, 01 Feb 2023 15:20:26 +0800 (CST)
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
To:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221130175653.24299-1-jack@suse.cz>
 <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
 <Y9kiltmuPSbRRLsO@infradead.org>
 <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
 <Y9oFHssFz2obv83W@infradead.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1901c3f0-da34-1df1-2443-3426282a6ecb@huaweicloud.com>
Date:   Wed, 1 Feb 2023 15:20:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y9oFHssFz2obv83W@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR+5EtpjkFUvCg--.14594S3
X-Coremail-Antispam: 1UD129KBjvdXoWrJryUKFWkAw4xuFy8CF18Grg_yoWxGFb_Z3
        yDu34vyw4SgF9a9r4kCa1rtrWjka1DX3yDXr1fWrs7XFyrtaykZ34vga4jyF95Gw4a9r9x
        Gr1rZry5CFsIqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
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

Hi,

ÔÚ 2023/02/01 14:22, Christoph Hellwig Ð´µÀ:
> On Wed, Feb 01, 2023 at 09:04:12AM +0800, Yu Kuai wrote:
>>> +	if (test_bit(GD_NEED_PART_SCAN, &disk->state) && !bdev->bd_holder)
>>>    		bdev_disk_changed(disk, false);
>>
>> I think this is wrong here... We should at least allow the exclusively
>> opener to scan partition, right?
> 
> bd_holder is only set in bd_finish_claiming, which is called after
> the partition rescan.
> .
> 

I mean that someone open bdev exclusively first, and then call ioctl to
rescan partition.

By the way, disk_scan_partitions() won't claim bdev in the first
place...

Thanks,
Kuai

