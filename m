Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C754C15D
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513942; cv=none; b=WBViAZqj5oypvUkIEG/OIgNi63Q6Qm91+0P7hnLImNqZxmvlJwZqbSyi5MnVq/vGg7WiL2dCjF4gRtzidvnty7B12d4TE3tObNflcHl/lU24bnWDFCqpEfZiN3ZvBYHC7A+9RZjM46g0dRC75VjqrPSqRsLqPmyI0aVZSJCtxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513942; c=relaxed/simple;
	bh=RJlS6YqenqFHHhntJjCoZPO9GYwiqjjDBuffzRWopjQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Pe9LuTEzw0IVGlBGkkgR4SnldPhhNgus0Nqb0p7B6KLQOO0pL2Ht4xrDF4DdKwPe66HmXFPk/9r4lJYHehWVhkuf5hNgyHmcLjBc/6KpXGBU8vDhd33nPZt5nl396kAuiaIygKdZVTTBxkyeADK3nE/h1YvPBUIB6JTZ6XUhX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VLRym5XWRz4f3knm
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 16:05:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 113101A0175
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 16:05:28 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHHJSJmmSWGKQ--.8913S3;
	Fri, 19 Apr 2024 16:05:27 +0800 (CST)
Subject: Re: [PATCH v2 blktests 4/5] tests/throtl: add a new test 004
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: "saranyamohan@google.com" <saranyamohan@google.com>,
 "tj@kernel.org" <tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240417022005.1410525-1-yukuai1@huaweicloud.com>
 <20240417022005.1410525-5-yukuai1@huaweicloud.com>
 <yh6dkc2tmne2log6bsoz2rvqwxjla2bz3zz5gwwa7dqknvco4c@pzb2dg7s6yqg>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <50d91266-0ab5-0021-7612-6219d6c0698c@huaweicloud.com>
Date: Fri, 19 Apr 2024 16:05:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <yh6dkc2tmne2log6bsoz2rvqwxjla2bz3zz5gwwa7dqknvco4c@pzb2dg7s6yqg>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBHHJSJmmSWGKQ--.8913S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKF43JF45GryfKw47CFWfKrg_yoW7WFWrpF
	WUGF4rKa1fAF17Aryaqan09FWfXr4rAF1xAry7Jr1rAFn0vryxtr1Ikr1FgFWrAFZrua4F
	va18X3yfG3WFkrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/19 12:45, Shinichiro Kawasaki Ð´µÀ:
> On Apr 17, 2024 / 10:20, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Test delete the disk while IO is throttled, regerssion test for:
> 
> Nit: s/regerssion/regression/
> 
>>
>> commit 884f0e84f1e3 ("blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()")
>> commit 8f9e7b65f833 ("block: cancel all throttled bios in del_gendisk()")
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   tests/throtl/004     | 37 +++++++++++++++++++++++++++++++++++
>>   tests/throtl/004.out |  4 ++++
>>   tests/throtl/rc      | 46 +++++++++++++++++++++++++++++++++-----------
>>   3 files changed, 76 insertions(+), 11 deletions(-)
>>   create mode 100755 tests/throtl/004
>>   create mode 100644 tests/throtl/004.out
>>
>> diff --git a/tests/throtl/004 b/tests/throtl/004
>> new file mode 100755
>> index 0000000..f2567c0
>> --- /dev/null
>> +++ b/tests/throtl/004
>> @@ -0,0 +1,37 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Yu Kuai
>> +#
>> +# Test delete the disk while IO is throttled, regerssion test for
> 
> Nit: s/regerssion/regression/
> 
>> +# commit 884f0e84f1e3 ("blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()")
>> +# commit 8f9e7b65f833 ("block: cancel all throttled bios in del_gendisk()")
>> +
>> +. tests/throtl/rc
>> +
>> +DESCRIPTION="delete disk while IO is throttled"
>> +QUICK=1
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	if ! _set_up_test_by_configfs power=1; then
>> +		return 1;
>> +	fi
>> +
>> +	_set_limits wbps=$((1024 * 1024))
>> +
>> +	{
>> +		sleep 0.1
>> +		_issue_io write 10M 1
>> +	} &
>> +
>> +	pid=$!
>> +	echo "$pid" > $TEST_DIR/cgroup.procs
>> +
>> +	sleep 1
> 
> When I ran this test case on my QEMU test machine, it failed with the message
> below. When I repeat the test case, it sometimes passes but fails in most
> cases. I guess this is because my machine is slow and takes some time from
> the disk deletion to write process exit.
> 
> throtl/004 (delete disk while IO is throttled)               [failed]
>      runtime  1.085s  ...  1.997s
>      --- tests/throtl/004.out    2024-04-19 11:26:56.507007360 +0900
>      +++ /home/shin/Blktests/blktests/results/nodev/throtl/004.out.bad   2024-04-19 13:34:03.766045990 +0900
>      @@ -1,4 +1,4 @@
>       Running throtl/004
>       dd: error writing '/dev/thr_nullb': Input/output error
>      -1
>      +2
>       Test complete
> 
> When I change the "sleep 1" in line above to "sleep .6", then the test case
> passed even when I repeat the test case run several times. This changes adds
> some margin and will make the result elapsed time to be round up to "1" not to
> "2". Still 0.6 second delay on the wait process and 0.1 second delay on the
> write process has the gap 0.5 second, then it is ensured to be rounded to "1".
> So I guess the sleep time 0.6 is the valid number, probably.

Yes, I was worried about slow machine, that's why I creat the null_blk
with 1s IO latency. use 0.6 sounds good to me, time precision is still
one second.

Thanks,
Kuai
> 
>> +	echo 0 > /sys/kernel/config/nullb/$devname/power
>> +	wait "$pid"
>> +
>> +	_clean_up_test
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/throtl/004.out b/tests/throtl/004.out
>> new file mode 100644
>> index 0000000..03331fe
>> --- /dev/null
>> +++ b/tests/throtl/004.out
>> @@ -0,0 +1,4 @@
>> +Running throtl/004
>> +dd: error writing '/dev/nullb0': Input/output error
>> +1
>> +Test complete
>> diff --git a/tests/throtl/rc b/tests/throtl/rc
>> index 871102c..f70e250 100644
>> --- a/tests/throtl/rc
>> +++ b/tests/throtl/rc
>> @@ -30,6 +30,21 @@ _set_up_test() {
>>   	return 0;
>>   }
>>   
>> +_set_up_test_by_configfs() {
>> +	if ! _init_null_blk nr_devices=0; then
>> +		return 1;
>> +	fi
>> +
>> +	if ! _configure_null_blk $devname "$*"; then
>> +		return 1;
>> +	fi
>> +
>> +	echo +io > $CG/cgroup.subtree_control
>> +	mkdir $TEST_DIR
>> +
>> +	return 0;
>> +}
>> +
>>   _clean_up_test() {
>>   	rmdir $TEST_DIR
>>   	echo -io > $CG/cgroup.subtree_control
>> @@ -46,23 +61,32 @@ _remove_limits() {
>>   	echo "$dev rbps=max wbps=max riops=max wiops=max" > $TEST_DIR/io.max
>>   }
>>   
>> +_issue_io()
>> +{
>> +	start_time=$(date +%s.%N)
>> +
>> +	if [ "$1" == "read" ]; then
>> +		dd if=/dev/$devname of=/dev/null bs="$2" count="$3" iflag=direct status=none
>> +	elif [ "$1" == "write" ]; then
>> +		dd of=/dev/$devname if=/dev/zero bs="$2" count="$3" oflag=direct status=none
>> +	fi
>> +
>> +	end_time=$(date +%s.%N)
>> +	elapsed=$(echo "$end_time - $start_time" | bc)
>> +	printf "%.0f\n" "$elapsed"
>> +}
>> +
>>   # Create an asynchronous thread and bind it to the specified blk-cgroup, issue
>>   # IO and then print time elapsed to the second, blk-throttle limits should be
>>   # set before this function.
>>   _test_io() {
>>   	{
>> -		sleep 0.1
>> -		start_time=$(date +%s.%N)
>> +		rw=$1
>> +		bs=$2
>> +		count=$3
>>   
>> -		if [ "$1" == "read" ]; then
>> -			dd if=/dev/$devname of=/dev/null bs="$2" count="$3" iflag=direct status=none
>> -		elif [ "$1" == "write" ]; then
>> -			dd of=/dev/$devname if=/dev/zero bs="$2" count="$3" oflag=direct status=none
>> -		fi
>> -
>> -		end_time=$(date +%s.%N)
>> -		elapsed=$(echo "$end_time - $start_time" | bc)
>> -		printf "%.0f\n" "$elapsed"
>> +		sleep 0.1
>> +		_issue_io "$rw" "$bs" "$count"
>>   	} &
>>   
>>   	pid=$!
>> -- 
>> 2.39.2
>> .
> 

