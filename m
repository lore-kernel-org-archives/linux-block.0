Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D14AECF
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513727; cv=none; b=qpAfppJfA07WYnBkabosAe05Eo4xTZ/Ag4Aj4sVAoQrpwajNwbSX9npVJ8BjtINklcmUUZQbEmbWrnVJW+Gn8rLI4y/uZa+5+r5bxNFoejzRSgCympp9nID1MJvlx6p7Q5demrsGEHYJw1UVWG4HXX3KuTHvonwK2Jw9eHwZS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513727; c=relaxed/simple;
	bh=qU84fd/nn5v+UHmdShRHw10J0OENH9/JnmAr54mvoi0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cuqkg6DtqEh4iMfaYf0ngi+bE1CeI7WnnDn+Ni/A2IXe4cJfnu8rlJ4rEz2svFdBWSKPF4fSGmvfNS1c/wlTtmjQxq5P4g7gLLpnc9qP58py+kF7/G2VofKMtxCEHd1hJ91qeVsQr9QIxnJ6Oes/CmH3bsmb9XqSH15HDRto5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VLRtj1hTnz4f3kp0
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 16:01:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E699E1A0175
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 16:01:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7wJCJmlO2FKQ--.7858S3;
	Fri, 19 Apr 2024 16:01:53 +0800 (CST)
Subject: Re: [PATCH v2 blktests 1/5] tests/throtl: add first test for
 blk-throttle
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: "saranyamohan@google.com" <saranyamohan@google.com>,
 "tj@kernel.org" <tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240417022005.1410525-1-yukuai1@huaweicloud.com>
 <20240417022005.1410525-2-yukuai1@huaweicloud.com>
 <vx5xlimpl5znnqzwjwevtl4yj3yaxyaebaqfxkdi6ndztzu4hs@6fddxhpmqfhg>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a680d187-3711-8b29-4638-fa303e64edf8@huaweicloud.com>
Date: Fri, 19 Apr 2024 16:01:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <vx5xlimpl5znnqzwjwevtl4yj3yaxyaebaqfxkdi6ndztzu4hs@6fddxhpmqfhg>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7wJCJmlO2FKQ--.7858S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKF4DWFy5Zr1UZryfuFyxuFg_yoWxWr1rpF
	W7GF4YyF1kGF17Ar13ta13Za4fZw48ArW7Cr17Kr1YyrsIvryxtF12yr45GrWrXF47Wa1F
	va18Xa4fG3WjyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/19 12:29, Shinichiro Kawasaki Ð´µÀ:
> On Apr 17, 2024 / 10:20, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
> 
> Hi Yu, thank you for this series. It is great to expand the test coverage and
> cover a number of regressions!
> 
> Please find my comments in line, and consider if they make sense for you or not.
> I ran the test cases on my test machine and observed that e new test cases
> passed except throtl/004. I will note the failure for the 4th patch.
> 
>>
>> Test basic functionality.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   tests/throtl/001     | 39 ++++++++++++++++++++++++
>>   tests/throtl/001.out |  6 ++++
>>   tests/throtl/rc      | 71 ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 116 insertions(+)
>>   create mode 100755 tests/throtl/001
>>   create mode 100644 tests/throtl/001.out
>>   create mode 100644 tests/throtl/rc
>>
>> diff --git a/tests/throtl/001 b/tests/throtl/001
>> new file mode 100755
>> index 0000000..739efe2
>> --- /dev/null
>> +++ b/tests/throtl/001
>> @@ -0,0 +1,39 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Yu Kuai
>> +#
>> +# Test basic functionality of blk-throttle
>> +
>> +. tests/throtl/rc
>> +
>> +DESCRIPTION="basic functionality"
>> +QUICK=1
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	if ! _set_up_test nr_devices=1; then
>> +		return 1;
>> +	fi
>> +
>> +	bps_limit=$((1024 * 1024))
>> +
>> +	_set_limits wbps=$bps_limit
>> +	_test_io write 4k 256
>> +	_remove_limits
>> +
>> +	_set_limits wiops=256
>> +	_test_io write 4k 256
>> +	_remove_limits
>> +
>> +	_set_limits rbps=$bps_limit
>> +	_test_io read 4k 256
>> +	_remove_limits
>> +
>> +	_set_limits riops=256
>> +	_test_io read 4k 256
>> +	_remove_limits
>> +
>> +	_clean_up_test
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/throtl/001.out b/tests/throtl/001.out
>> new file mode 100644
>> index 0000000..a3edfdd
>> --- /dev/null
>> +++ b/tests/throtl/001.out
>> @@ -0,0 +1,6 @@
>> +Running throtl/001
>> +1
>> +1
>> +1
>> +1
>> +Test complete
>> diff --git a/tests/throtl/rc b/tests/throtl/rc
>> new file mode 100644
>> index 0000000..871102c
>> --- /dev/null
>> +++ b/tests/throtl/rc
>> @@ -0,0 +1,71 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Yu Kuai
>> +#
>> +# Tests for blk-throttle
>> +
>> +. common/rc
>> +. common/null_blk
>> +
>> +CG=/sys/fs/cgroup
>> +TEST_DIR=$CG/blktests_throtl
> 
> The names of these two global variables sounds too geneic for me. I think they
> have risk to have name conflict in the future. I suggest to drop them and use
> the function and the global variable defined in common/cgroup, as follows.
> 
>    $CG -> "$(_cgroup2_base_dir)"
>    $TEST_DIR -> "$CGROUP2_DIR"
> 
> For this change, "mkdir $TEST_DIR" in _set_up_test() needs to be replaced with
> _init_cgroup2 call. Same for "rmdir $TEST_DIR" in _clean_up_test() with
> _exit_cgroup2. This change will add some new shellcheck warns then some more
> double quotations will be required around $(_cgroup2_base_dir) and $CGROUP2_DIR.

Ok, sounds good.
> 
>> +devname=nullb0
> 
> The global variable name devname is too generic, too. I suggest to use prefix
> "_thr" or "THR" for the global variables and functions defined in
> tests/throtl/rc. This devname can be "THR_DEV" or something like that.
> 
> Also, I suggest to use "thr_nullb" as the device name because null_blk device
> name nullb0 can not be used when the null_blk driver is built-in. In short,
> I suggest,

I'll try with built-in null_blk, and switch the name.

> 
>     THR_DEV=dev_nullb
> 
>> +
>> +group_requires() {
>> +	_have_root
>> +	_have_null_blk
>> +	_have_kernel_option BLK_DEV_THROTTLING
>> +	_have_cgroup2_controller io
> 
> This rc file introduces the dependency to the bc command. I suggest to check the
> requirement by adding one more check here:
> 
>      _have_proggram bc

Ok, and perhaps also check dd as well?

> 
>> +}
>> +
>> +# Create a new null_blk device, and create a new blk-cgroup for test.
>> +_set_up_test() {
>> +	if ! _init_null_blk "$*"; then
> 
> _configure_null_blk is the better than _init_null_blk, because _init_null_blk
> requires loadable null_blk and does not work with built-in null_blk. Some
> blktests users run tests with built-in modules, so it is the better to avoid
> dependencies to built-in drivers. Then I suggest as follows.
> 
>         if ! _configure_null_blk $THR_DEV "$@" power=1; then
> 
> Please note that "$@" should be used in place of "$*" to pass positional
> parameters correctly. With this change, _set_up_test_by_configfs() that the 4th
> patch introduced will not be required. nr_device=1 and power=1 options in
> throtl/00x will not be required either.
> 
> Regarding other functions, I can think of renames as follows:
> 
>      _set_up_test -> _setup_thr
>      _clean_up_test -> _cleanup_thr (or _exit_thr ?)
>      _set_limits -> _thr_set_limits
>      _remove_limits -> _thr_remove_limits
>      _issue_io -> _thr_issue_io
>      _test_io -> _thr_test_io

Will update in the next version.

Thanks,
Kuai
> 
>> +		return 1;
>> +	fi
>> +
>> +	echo +io > $CG/cgroup.subtree_control
>> +	mkdir $TEST_DIR
>> +
>> +	return 0;
>> +}
>> +
>> +_clean_up_test() {
>> +	rmdir $TEST_DIR
>> +	echo -io > $CG/cgroup.subtree_control
>> +	_exit_null_blk
>> +}
>> +
>> +_set_limits() {
> 
> Nit: local variable declaration "local dev" will make the code a bit more
> robust. Same for other functions in this file.
> 
>> +	dev=$(cat /sys/block/$devname/dev)
>> +	echo "$dev $*" > $TEST_DIR/io.max
>> +}
>> +
>> +_remove_limits() {
>> +	dev=$(cat /sys/block/$devname/dev)
>> +	echo "$dev rbps=max wbps=max riops=max wiops=max" > $TEST_DIR/io.max
>> +}
>> +
>> +# Create an asynchronous thread and bind it to the specified blk-cgroup, issue
>> +# IO and then print time elapsed to the second, blk-throttle limits should be
>> +# set before this function.
>> +_test_io() {
>> +	{
>> +		sleep 0.1
>> +		start_time=$(date +%s.%N)
>> +
>> +		if [ "$1" == "read" ]; then
>> +			dd if=/dev/$devname of=/dev/null bs="$2" count="$3" iflag=direct status=none
>> +		elif [ "$1" == "write" ]; then
>> +			dd of=/dev/$devname if=/dev/zero bs="$2" count="$3" oflag=direct status=none
>> +		fi
>> +
>> +		end_time=$(date +%s.%N)
>> +		elapsed=$(echo "$end_time - $start_time" | bc)
>> +		printf "%.0f\n" "$elapsed"
>> +	} &
>> +
>> +	pid=$!
>> +	echo "$pid" > $TEST_DIR/cgroup.procs
>> +	wait $pid
>> +}
>> -- 
>> 2.39.2
>> .
> 

