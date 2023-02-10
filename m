Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8CDC61DA4
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 01:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBJB6n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 20:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBJB6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 20:58:42 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B4259EC
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 17:58:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PCcMw0jjzz4f3nTG
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 09:58:36 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R_MpOVjdOQnDA--.1574S3;
        Fri, 10 Feb 2023 09:58:38 +0800 (CST)
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
 <Y9oFHssFz2obv83W@infradead.org>
 <1901c3f0-da34-1df1-2443-3426282a6ecb@huaweicloud.com>
 <1b5d3502-353d-8674-cd5d-79283fa8905d@huaweicloud.com>
 <20230208120258.64yhqho252gaydmu@quack3>
 <02e769f7-9a41-80bc-4e47-fa87c18a36b2@huaweicloud.com>
 <20230209090439.w2k37tufbbhk6qq3@quack3>
 <1bf91d5c-6130-43de-7995-af09045d4b98@huaweicloud.com>
 <20230209095729.igkpj23afj6nbxxi@quack3>
 <8ca26a55-f48b-5043-7890-03ccbf541ead@huaweicloud.com>
 <20230209135830.a2lhdhnwzbu7uexe@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <668bc362-263d-d9bc-a462-d8b851062ebc@huaweicloud.com>
Date:   Fri, 10 Feb 2023 09:58:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230209135830.a2lhdhnwzbu7uexe@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R_MpOVjdOQnDA--.1574S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYr7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
        IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
        5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
        CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2
        V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
        IFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/02/09 21:58, Jan Kara 写道:

> Sorry, I'm not sure what your are asking about here :) Can you please
> elaborate more?


It's another artificail race that will cause part scan fail in
device_add_disk().

bdev_add() -> user can open the device now

disk_scan_partitions -> will fail is the device is already opened 
exclusively

I'm thinking about set disk state before bdev_add()...

Thanks,
Kuai

