Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD38BC433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 11:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKALM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 07:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKALM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 07:12:57 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55D61900F
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 04:12:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4N1nP90jHYz6R5FY
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:10:21 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA3Recz_2Bjz8IpAg--.4987S3;
        Tue, 01 Nov 2022 19:12:52 +0800 (CST)
Subject: Re: [PATCH 7/7] block: store the holder kobject in bd_holder_disk
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221030153120.1045101-1-hch@lst.de>
 <20221030153120.1045101-8-hch@lst.de>
 <fd409996-e5e1-d7af-b31d-87db943eaa25@huaweicloud.com>
 <20221101104927.GA13823@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d3f6ec1d-8141-19d1-ce4c-d42710f4a636@huaweicloud.com>
Date:   Tue, 1 Nov 2022 19:12:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221101104927.GA13823@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3Recz_2Bjz8IpAg--.4987S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtryUKF15JrWftF1DCw4rKrg_yoWkKwb_u3
        45uFWxJr4F9w13K3Zrtr13WrZxJF1jv3y8ZFZ3Gan5WrWUX3W7GF4fJwn8Aw4xGw4DG3s0
        yryYk3yDuwsFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
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

ÔÚ 2022/11/01 18:49, Christoph Hellwig Ð´µÀ:
> On Mon, Oct 31, 2022 at 09:52:04AM +0800, Yu Kuai wrote:
>>>      	INIT_LIST_HEAD(&holder->list);
>>> -	holder->bdev = bdev;
>>>    	holder->refcnt = 1;
>>> +	holder->holder_dir = kobject_get(bdev->bd_holder_dir);
>>
>> I wonder is this safe here, if kobject reference is 0 here and
>> bd_holder_dir is about to be freed. Here in kobject_get, kref_get() will
>> warn about uaf, and kobject_get will return a address that is about to
>> be freed.
> 
> But how could the reference be 0 here?  The driver that calls
> bd_link_disk_holder must have the block device open and thus hold a
> reference to it.

Like I said before, the caller of bd_link_disk_holder() get bdev by
blkdev_get_by_dev(), which do not grab reference of holder_dir, and
grab disk reference can only prevent disk_release() to be called, not
del_gendisk() while holder_dir reference is dropped in del_gendisk()
and can be decreased to 0.

If you agree with above explanation, I tried to fix this:

1) move kobject_put(bd_holder_dir) from del_gendisk to disk_release,
there seems to be a lot of other dependencies.

2) protect bd_holder_dir reference by open_mutex.

Thanks,
Kuai
> 
> .
> 

