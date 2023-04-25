Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE9EC77B61
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 08:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjDYIWP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Apr 2023 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjDYIWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 04:22:14 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF707E4
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 01:22:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5FNH47hsz4f3wtN
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 16:22:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLCujUdkd9xzIA--.34816S3;
        Tue, 25 Apr 2023 16:22:08 +0800 (CST)
Subject: Re: [PATCH blktests] dm: add a regression test
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>,
        Li Lingfeng <lilingfeng3@huawei.com>
References: <20221230065424.19998-1-yukuai1@huaweicloud.com>
 <20230112010554.qmjuqtjoai3qqaj7@shindev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6ccff2ec-b4bd-a1a6-5340-b9380adc1fff@huaweicloud.com>
Date:   Tue, 25 Apr 2023 16:22:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230112010554.qmjuqtjoai3qqaj7@shindev>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLCujUdkd9xzIA--.34816S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4fGF4fCF15Kr4rGF18uFg_yoWrGF1kpa
        yjkF4Ykrs7AF12yF1avw17ua4rAw4fCr45Cr13Kr1UZrW3Zr1kGa47Kr47CryfXrZYqa97
        Z3Wvqrn5ur4jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2023/01/12 9:05, Shinichiro Kawasaki Ð´µÀ:
> Hello Yu, thanks for the patch. I think it is good to have this test case to
> avoid repeating the same regression. Please find my comments in line.
> 
> CC+: Mike, dm-devel,
> 
> Mike, could you take a look in this new test case? It adds "dm" test group to
> blktests. If you have thoughts on how to add device-mapper related test cases
> to blktests, please share (Or we may be able to discuss later at LSF 2023).

Can we add "dm" test group to blktests? I'll send a new version if we
can.

Thanks,
Kuai
> 
> On Dec 30, 2022 / 14:54, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Verify that reload a dm with itself won't crash the kernel.
> 
> With this test case, I observed the system crash on Fedora default kernel
> 6.0.18-300.fc37. Will the kernel fix be delivered to stable kernels? If not,
> it would be the better to require kernel version 6.2 for this test case not
> to surprise the blktests users.
> 
> Regarding the wording, "reload a dm with itself" is a bit confusing for me.
> How about "reload a dm with maps to itself"?
> 
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   tests/dm/001     | 27 +++++++++++++++++++++++++++
>>   tests/dm/001.out |  4 ++++
>>   tests/dm/rc      | 11 +++++++++++
>>   3 files changed, 42 insertions(+)
>>   create mode 100755 tests/dm/001
>>   create mode 100644 tests/dm/001.out
>>   create mode 100644 tests/dm/rc
>>
>> diff --git a/tests/dm/001 b/tests/dm/001
>> new file mode 100755
>> index 0000000..55e07f3
>> --- /dev/null
>> +++ b/tests/dm/001
>> @@ -0,0 +1,27 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2022 Yu Kuai
>> +#
>> +# Regression test for commit 077a4033541f ("block: don't allow a disk link
>> +# holder to itself")
>> +
>> +. tests/dm/rc
>> +
>> +DESCRIPTION="reload a dm with itself"
> 
> Same comment on wording as the commit message.
> 
>> +QUICK=1
>> +
>> +requires() {
>> +	_have_program dmsetup && _have_driver dm-mod
> 
> I suggest to move these checks to group_requires in dm/rc, since future new test
> cases in dm group will require them also.
> 
> Nit: '&&' is no longer required to check multiple requirements. Just,
> 
> 	_have_program dmsetup
> 	_have_driver dm-mod
> 
> is fine and a bit better.
> 
>> +}
>> +
>> +test_device() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	dmsetup create test --table "0 8192 linear ${TEST_DEV} 0"
>> +	dmsetup suspend test
>> +	dmsetup reload test --table "0 8192 linear /dev/mapper/test 0"
>> +	dmsetup resume test
>> +	dmsetup remove test
>> +
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/dm/001.out b/tests/dm/001.out
>> new file mode 100644
>> index 0000000..23cf1f0
>> --- /dev/null
>> +++ b/tests/dm/001.out
>> @@ -0,0 +1,4 @@
>> +Running dm/001
>> +device-mapper: reload ioctl on test failed: Invalid argument
>> +Command failed
>> +Test complete
> 
> With my test system and kernel v6.2-rc3, the messages above were slightly
> diffrent. To make the test case pass, I needed changes below:
> 
> diff --git a/tests/dm/001.out b/tests/dm/001.out
> index 23cf1f0..543b1db 100644
> --- a/tests/dm/001.out
> +++ b/tests/dm/001.out
> @@ -1,4 +1,4 @@
>   Running dm/001
> -device-mapper: reload ioctl on test failed: Invalid argument
> -Command failed
> +device-mapper: reload ioctl on test  failed: Invalid argument
> +Command failed.
>   Test complete
> 
> 
>> diff --git a/tests/dm/rc b/tests/dm/rc
>> new file mode 100644
>> index 0000000..e1ad6c6
>> --- /dev/null
>> +++ b/tests/dm/rc
>> @@ -0,0 +1,11 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2022 Yu Kuai
>> +#
>> +# TODO: provide a brief description of the group here.
> 
> Let's not leave this TODO. How about "# Tests for device-mapper."?
> 
>> +
>> +. common/rc
>> +
>> +group_requires() {
>> +	_have_root
>> +}
>> -- 
>> 2.31.1
>>
> 

