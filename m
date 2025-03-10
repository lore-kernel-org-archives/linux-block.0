Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1013C695
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571031; cv=none; b=i+tF6z1s3T85q2Rao3Q5YNeLie/tvckfcxNiukBs+UwyqdfSkTzlGssqMsJY9soqnCXw+EuI43dmpJVFyrGjkjpZWKdIcsgaoyvrdmvvflPD1w5VqwZJKOtFos1RpyZUHhH1/Ot1YrozhJbwOgAvBoup+rdn5N2+/WULS+4+X8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571031; c=relaxed/simple;
	bh=MUJ5B2eVBhAgxcOa0bL1S28BsrZcDV9jms4Sc+su0RU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o0/H3VrUYkbdOql6nWMY7jU6EsyU1I6pJa454B7JGYv4vxLeNRviw0ovDVP8BTH0Ij4mQR016rQ+s1u+PsCd8Ey2+bdqm2o/bjz8f0WkC+GfttYhT9sUgvp1bSUqwZtvwgnjRTIvq6XvZIxOu94OtxPWxY9JRmzPDJEGB2PdEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZB06238MSz4f3kFQ
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 09:43:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B76181A06D7
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 09:43:44 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB32l7QQ85n0ZkvGA--.62971S3;
	Mon, 10 Mar 2025 09:43:44 +0800 (CST)
Subject: Re: [PATCH RFC 1/2] tests/throtl: add a new test 007
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250307080318.3860858-1-yukuai1@huaweicloud.com>
 <20250307080318.3860858-2-yukuai1@huaweicloud.com> <Z8rAo8aCwi-OWADq@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <322164c2-7f95-df1b-44b5-197a8cc225cc@huaweicloud.com>
Date: Mon, 10 Mar 2025 09:43:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z8rAo8aCwi-OWADq@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32l7QQ85n0ZkvGA--.62971S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF47WryrZF4UXr4fur17KFg_yoW5Gw1xpF
	WUKF4Fka1xX3ZrAF13t3WUJayrtw4rZr4UAry3Kr1Yyryq9r17Kr1IkryUKFZ5Ar47Wr48
	Z3WjqFWfCr1YkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUG0PhUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/03/07 17:47, Ming Lei Ð´µÀ:
> On Fri, Mar 07, 2025 at 04:03:17PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Add test for IO merge over iops limit.
>>
>> Noted this test will fail for now, kernel solution is in development.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   tests/throtl/007     | 65 ++++++++++++++++++++++++++++++++++++++++++++
>>   tests/throtl/007.out |  4 +++
>>   2 files changed, 69 insertions(+)
>>   create mode 100755 tests/throtl/007
>>   create mode 100644 tests/throtl/007.out
>>
>> diff --git a/tests/throtl/007 b/tests/throtl/007
>> new file mode 100755
>> index 0000000..597f879
>> --- /dev/null
>> +++ b/tests/throtl/007
>> @@ -0,0 +1,65 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2025 Yu Kuai
>> +#
>> +# Test iops limit over io merge
>> +
>> +. tests/throtl/rc
>> +
>> +DESCRIPTION="basic functionality"
>> +QUICK=1
>> +
>> +requires() {
>> +	_have_program taskset
>> +	_have_program fio
>> +}
>> +
>> +# every 16 0.5k IO will merge into one 8k IO, ideally runtime is 1s,
>> +# however it's about 1.3s in practice
>> +__fio() {
>> +	taskset -c 0 \
>> +	fio -filename=/dev/$THROTL_DEV \
>> +	-name=test \
>> +	-size=1600k \
>> +	-rw=write \
>> +	-bs=512 \
>> +	-iodepth=32 \
>> +	-iodepth_low=16 \
>> +	-iodepth_batch=16 \
>> +	-numjobs=1 \
>> +	-direct=1 \
>> +	-ioengine=io_uring &> /dev/null
>> +}
>> +
>> +test_io() {
>> +	start_time=$(date +%s.%N)
>> +
>> +	{
>> +		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
>> +		__fio
>> +	} &
>> +
>> +	wait $!
>> +	end_time=$(date +%s.%N)
>> +	elapsed=$(echo "$end_time - $start_time" | bc)
>> +	printf "%.0f\n" "$elapsed"
>> +}
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	# iolatency is 10ms, iops is at most 200/s
>> +	if ! _set_up_throtl irqmode=2 completion_nsec=10000000 hw_queue_depth=2; then
>> +		return 1;
>> +	fi
>> +
>> +	test_io
>> +
>> +	# 300 means 50% error range, no IO should be throttled
>> +	_throtl_set_limits wiops=300
>> +	test_io
>> +	_throtl_remove_limits
>> +
>> +	_clean_up_throtl
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/throtl/007.out b/tests/throtl/007.out
>> new file mode 100644
>> index 0000000..0d568ef
>> --- /dev/null
>> +++ b/tests/throtl/007.out
>> @@ -0,0 +1,4 @@
>> +Running throtl/007
>> +1
>> +1
>> +Test complete
> 
> I'd suggest to check if actual iops matches with the iops limit directly,
> and it isn't intuitive to compare time taken in test wrt. iops throttle.

Yes, that's a good idea.

BTW, I'll wait if we agree with the change in kernel first before
sending the next version.

Thanks,
Kuai

> 
> Thanks,
> Ming
> 
> 
> .
> 

