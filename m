Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398062522BA
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784421; cv=none; b=QmwF5p9i53cJqe5AfpKEgJmZTDq8SDBBPScJPJF0JTDah9boMfmEP/Hmd+ciJM33y0y8tvrM+if6IJiMBHo3IXpGCmpfdZmlqYFHsRLpOcDKR/jfJfN3JI0kAb697vx7gc4+Mvc82oRlDI4movlksXo4KloMqC8Ku2wrYt11kQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784421; c=relaxed/simple;
	bh=OfD1MH6MkkaOH6ktP+83qM22Keu9ZLwEjYFA1yo+uwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGY722HywaLKzD4F+44XPdeGshg80XM1y5QIlPJAPe1qsMa5x3TH8oxNR/n8Ex8VTTCdxuiDKmGLySbgImZmXCG79TVYfv/Me6+wz/2Vw/mwhY60If+SQ6J+dJUm/j0a0XWze9r34Re40UMQH6mIFKf2KlUGKNFxw6jUdpvuWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bJPcG54HRzYQv6X
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 11:13:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AE47F1A0E23
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 11:13:33 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgBXul5cl0to8GxsPQ--.28950S3;
	Fri, 13 Jun 2025 11:13:33 +0800 (CST)
Message-ID: <593e7a1b-058b-4ef9-a6a0-214c90b72971@huaweicloud.com>
Date: Fri, 13 Jun 2025 11:13:32 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/throtl: add a new test 007
To: Yu Kuai <yukuai1@huaweicloud.com>, shinichiro.kawasaki@wdc.com,
 linux-block@vger.kernel.org, ming.lei@redhat.com
Cc: yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250613023538.2900008-1-wozizhi@huaweicloud.com>
 <6e302504-ff4f-e689-dbff-d13d464734bc@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <6e302504-ff4f-e689-dbff-d13d464734bc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul5cl0to8GxsPQ--.28950S3
X-Coremail-Antispam: 1UD129KBjvJXoWxArWktFW8Jw15GFy7WF4fGrg_yoW5Xryrpr
	y8CFZ0kFW7JFn7Ar1ft3ZrCFWFvr48Z3WUA34xXF15ArsFk34UKF1Ivr1qgFZ3JFs7ur1j
	vw1qqF93CF17ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1D
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/6/13 10:52, Yu Kuai 写道:
> Hi,
> 
> 在 2025/06/13 10:35, Zizhi Wo 写道:
>> From: Zizhi Wo <wozizhi@huawei.com>
>>
>> Test change config while IO is throttled, for IO splitting scenario.
>> Regression test for commit d1ba22ab2bec ("blk-throttle: Prevents the bps
>> restricted io from entering the bps queue again").
>>
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>>   tests/throtl/007     | 41 +++++++++++++++++++++++++++++++++++++++++
>>   tests/throtl/007.out |  6 ++++++
>>   2 files changed, 47 insertions(+)
>>   create mode 100755 tests/throtl/007
>>   create mode 100644 tests/throtl/007.out
>>
>> diff --git a/tests/throtl/007 b/tests/throtl/007
>> new file mode 100755
>> index 0000000..98ba4ea
>> --- /dev/null
>> +++ b/tests/throtl/007
>> @@ -0,0 +1,41 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2025 Zizhi Wo
>> +#
>> +# Test change config while IO is throttled, for IO splitting scenario.
> 
> This test do not change config while IO is throttled, it's iops limit
> over io split.

Oh, there was something wrong with my understanding before..

> 
>> +# Regression test for commit d1ba22ab2bec ("blk-throttle: Prevents 
>> the bps
>> +# restricted io from entering the bps queue again")
>> +
>> +. tests/throtl/rc
>> +
>> +DESCRIPTION="bps limit with iops limit over io split"
>> +QUICK=1
>> +
>> +test() {
>> +    echo "Running ${TEST_NAME}"
>> +
>> +    if ! _set_up_throtl max_sectors=8; then
>> +        return 1;
>> +    fi
> 
> And this should be updated, please take a look at
> 60fa2e3 ("throtl/{002,003}: update max_sectors setting").
> 

Yes, I didn't notice this. I will modify it.

Thanks,
Zizhi Wo


> Thanks,
> Kuai
> 
>> +
>> +    local bps_limit=$((1024 * 1024))
>> +    local iops_limit=1000000
>> +
>> +    # just set bps limit first
>> +    _throtl_set_limits wbps=$bps_limit
>> +    _throtl_test_io write 1M 1 &
>> +    _throtl_test_io write 1M 1 &
>> +    wait
>> +    _throtl_remove_limits
>> +
>> +    # set the same bps limit and a high iops limit
>> +    # should behave the same as no iops limit
>> +    _throtl_set_limits wbps=$bps_limit wiops=$iops_limit
>> +    _throtl_test_io write 1M 1 &
>> +    _throtl_test_io write 1M 1 &
>> +    wait
>> +    _throtl_remove_limits
>> +
>> +    _clean_up_throtl
>> +    echo "Test complete"
>> +}
>> diff --git a/tests/throtl/007.out b/tests/throtl/007.out
>> new file mode 100644
>> index 0000000..d28cdef
>> --- /dev/null
>> +++ b/tests/throtl/007.out
>> @@ -0,0 +1,6 @@
>> +Running throtl/007
>> +1
>> +2
>> +1
>> +2
>> +Test complete
>>

