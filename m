Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014E7C4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 01:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKCBDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 21:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCBDe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 21:03:34 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAD5265B
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 18:03:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N2lnS4rqnzl9Bs
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 09:01:16 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgBH39NfE2NjNdITBQ--.33068S3;
        Thu, 03 Nov 2022 09:03:28 +0800 (CST)
Subject: Re: [PATCH 8/7] block: don't claim devices that are not live in
 bd_link_disk_holder
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221102064854.GA8950@lst.de>
 <1dc5c1d0-72b6-5455-0b05-5c755ad69045@huaweicloud.com>
 <20221102141700.GA4442@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3380eda2-6a38-4593-0071-6ff86dcdcda3@huaweicloud.com>
Date:   Thu, 3 Nov 2022 09:03:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221102141700.GA4442@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH39NfE2NjNdITBQ--.33068S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1DZFW8Cw1rWF45KrW7Arb_yoWftFcEgr
        Z5u3yDJw1UGa13KF1ftr15Wa9IqFs8Xry8Xr13ZFs5Xa4xX393JFWku348Xa15GrsxArn0
        kryYk3s2vw4SgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
        U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2022/11/02 22:17, Christoph Hellwig 写道:
> On Wed, Nov 02, 2022 at 08:17:37PM +0800, Yu Kuai wrote:
>> I think this is still not safe 🤔
> 
> Indeed - wrong open_mutex.
> 
>> +       /*
>> +        * del_gendisk drops the initial reference to bd_holder_dir, so we
>> need
>> +        * to keep our own here to allow for cleanup past that point.
>> +        */
>> +       mutex_lock(&bdev->bd_disk->open_mutex);
>> +       if (!disk_live(bdev->bd_disk)) {
>> +               ret = -ENODEV;
>> +               mutex_unlock(&bdev->bd_disk->open_mutex);
>> +               goto out_unlock;
>> +       }
> 
> I think this needs to be done before taking disk->open_mutex, otherwise
> we create a lock order dependency.  Also the comment seems to overflow
> the usual 80 character limit, and as you noted in the next mail this
> needs more unwinding.  But yes, otherwise this is the right thing to
> do.  Do you want to send a replacement for this patch?
> 
Of course. And I just spotted a new problem here, I'll send them
together.

Thanks,
Kuai
> .
> 

