Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F8ECAAA1
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 13:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiKAN32 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 09:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiKAN32 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 09:29:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8F11452
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 06:29:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N1rQg0sZQzKHh4
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 21:26:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH4+UzH2FjdsEuAg--.44981S3;
        Tue, 01 Nov 2022 21:29:24 +0800 (CST)
Subject: Re: [PATCH 7/7] block: store the holder kobject in bd_holder_disk
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221030153120.1045101-1-hch@lst.de>
 <20221030153120.1045101-8-hch@lst.de>
 <fd409996-e5e1-d7af-b31d-87db943eaa25@huaweicloud.com>
 <20221101104927.GA13823@lst.de>
 <d3f6ec1d-8141-19d1-ce4c-d42710f4a636@huaweicloud.com>
 <20221101112131.GA14379@lst.de>
 <57465370-99fe-d8a5-e150-a1057640e972@huaweicloud.com>
 <20221101131830.GA16341@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <51362eda-fd76-ed35-1961-f17d8e9a9d93@huaweicloud.com>
Date:   Tue, 1 Nov 2022 21:29:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221101131830.GA16341@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH4+UzH2FjdsEuAg--.44981S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy3JrWrAF15ZFy3ury3Arb_yoW3tFg_ua
        45JanrAw48uFn3tw47tr13urZ5Ga9FkFWDZrWxCFs09ryjqasxJr1UA3yrAFy7Wr47GrsI
        yryYgF1UtrsF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
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

ÔÚ 2022/11/01 21:18, Christoph Hellwig Ð´µÀ:
> On Tue, Nov 01, 2022 at 07:28:17PM +0800, Yu Kuai wrote:
>> What if bd_holder_dir is already freed here, then uaf can be triggered.
>> Thus bd_holder_dir need to be resed in del_gendisk() if it's reference
>> is dropped to 0, however, kobject apis can't do that...
> 
> Indeed.  I don't think we can simply move the dropping of the reference
> as you suggested as that also implies taking it earlier, and the
> device in the disk is only initialized in add_disk.
> 
> Now what I think we could do is:
> 
>   - hold open_mutex in bd_link_disk_holder as you suggested
>   - check that the bdev inode is hashed inside open_mutex before doing
>     the kobject_get

Yes, that's sounds good, check if inode is hashed is better than
what I did in another thread to introduce a new field.

Thansk,
Kuai
> 
> .
> 

