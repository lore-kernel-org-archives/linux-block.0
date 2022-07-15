Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39185C43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 03:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbiGODYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 23:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGODYV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 23:24:21 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D6015FEC
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 20:24:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LkcBY1tx7zKHh1
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 11:23:17 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCnCWng3dBiDTIaAw--.57220S3;
        Fri, 15 Jul 2022 11:24:18 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH 7/8] dm: delay registering the gendisk
To:     Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
References: <20210804094147.459763-1-hch@lst.de>
 <20210804094147.459763-8-hch@lst.de>
 <ad2c7878-dabb-cb41-1bba-60ef48fa1a9f@huaweicloud.com>
 <20220707052425.GA13016@lst.de>
 <fd5c2e0a-5f68-9f1f-dfc2-49a2cd51de0b@huaweicloud.com>
Message-ID: <6ff5c130-b5b1-b611-bb99-6a2275404fcd@huaweicloud.com>
Date:   Fri, 15 Jul 2022 11:24:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fd5c2e0a-5f68-9f1f-dfc2-49a2cd51de0b@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnCWng3dBiDTIaAw--.57220S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw18tFW3Gry3Xw4kAFW8WFg_yoW8Jw48pF
        WfuFsYkrsrXFsrW392y3yjg3sY9w43Ka1rGryrGryIqryDWrZay3y2yFnFvFy3Arn7WrZI
        qFWjq345Za1vyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Christoph!

在 2022/07/07 15:20, Yu Kuai 写道:
> 在 2022/07/07 13:24, Christoph Hellwig 写道:
>> On Thu, Jul 07, 2022 at 11:29:26AM +0800, Yu Kuai wrote:
>>> We found that this patch fix a nullptr crash in our test:
>>
>>> Do you think it's ok to backport this patch(and all realted patches) to
>>> lts, or it's better to fix that bio can be submitted with queue
>>> uninitialized from block layer?
>>
>> Given how long ago this was I do not remember offhand how much prep
>> work this would require.  The patch itself is of course tiny and
>> backportable, but someone will need to do the work and figure out how
>> much else would have to be backported.
> 
> Ok, I'll try to figure out that, and backport them.(At least to 5.10.y)

While reviewing the code, I didn't found any protection that
bd_link_disk_holder() won't concurrent with
bd_register_pending_holders(). If they do can concurrent,
following scenario is problematic:

t1				t2
device_add_disk
  disk->slave_dir = kobject_create_and_add
				bd_link_disk_holder
				 __link_disk_holder
				 list_add
  bd_register_pending_holders
   list_for_each_entry
    __link_disk_holder -> -EEXIST

In this case, I think maybe ignore '-EEXIST' is fine.

I'm not familiar with dm, and I'm not sure if I missed something,
please kindly correct me if I'm wrong.

Thanks,
Kuai

