Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9112B7F
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237476; cv=none; b=I0ZWgeLpxGh7fO8fG15MncP3goPcDKrBJ/42J9p5hov/hdASY8d+rRhVetQN+grb2PcIYWKFs9teuQBzoPngA6tZuCK+x//TYGNT/9qmyYHBNhO1ZpRAr8WJRovVlviq9TBzIUUFI7HzTgQFDP2V14zr1wQuYSyUXVxa9ecUxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237476; c=relaxed/simple;
	bh=fuC7dP0Nt0EdU7WeY+8U0eJ6hbp6I4p6k6YnlO7MGF0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IbIf79O4gnTzR31yf/4tqcG7VD5fYn+3C+iV0UJF6Ap1Mnh1pFcxEccIBxW7Gr6GfxvYzA3kvjBxtMDPnm2YqKPLZkNSGk1mdDht0cItFeDhacqtkAmszuSTZhrazB5qYwxPf0oUIcgSIYmbvUNl1FyY1kfDXLJep+yh1bjDGPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJTkF4cQXz4f3mHM
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 11:17:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 839741A0199
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 11:17:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBHc7R1mw_BrKA--.14166S3;
	Tue, 16 Apr 2024 11:17:50 +0800 (CST)
Subject: Re: [PATCH blktests 1/5] tests/throtl: add first test for
 blk-throttle
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: "yangerkun@huawei.com" <yangerkun@huawei.com>,
 "tj@kernel.org" <tj@kernel.org>,
 "saranyamohan@google.com" <saranyamohan@google.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240416020042.509291-1-yukuai1@huaweicloud.com>
 <20240416020042.509291-2-yukuai1@huaweicloud.com>
 <c14a95c9-64a6-4929-9213-3f81bf118399@nvidia.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <77c430a9-a533-8214-ea10-3ecde15904b3@huaweicloud.com>
Date: Tue, 16 Apr 2024 11:17:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c14a95c9-64a6-4929-9213-3f81bf118399@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBHc7R1mw_BrKA--.14166S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWfWw4DAFW5ur1kuw4Uurg_yoWrXw1fpF
	WUGF4YyFs7JF17Aryaq3WqgaySvw4fAF47Cry7tr15AF9Fvw1xtry2kr1UKFWrZrsrWw48
	Za18XFWfCF18trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/04/16 11:02, Chaitanya Kulkarni 写道:
> On 4/15/24 19:00, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Test basic functionality.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>    tests/throtl/001     | 84 ++++++++++++++++++++++++++++++++++++++++++++
>>    tests/throtl/001.out |  6 ++++
>>    tests/throtl/rc      | 15 ++++++++
>>    3 files changed, 105 insertions(+)
>>    create mode 100755 tests/throtl/001
>>    create mode 100644 tests/throtl/001.out
>>    create mode 100644 tests/throtl/rc
>>
>> diff --git a/tests/throtl/001 b/tests/throtl/001
>> new file mode 100755
>> index 0000000..79ecf07
>> --- /dev/null
>> +++ b/tests/throtl/001
>> @@ -0,0 +1,84 @@
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
>> +CG=/sys/fs/cgroup
>> +TEST_DIR=$CG/blktests_throtl
>> +devname=nullb0
>> +dev=""
>> +
>> +set_up_test() {
>> +	if ! _init_null_blk nr_devices=1; then
>> +		return 1;
>> +	fi
>> +
>> +	dev=$(cat /sys/block/$devname/dev)
>> +	echo +io > $CG/cgroup.subtree_control
>> +	mkdir $TEST_DIR
>> +
> 
> move above to 3 lines to rc with helper instead of repeating the
> code for every test ?

Yes, that sounds good, just test 004 is different.
> 
>> +	return 0;
>> +}
>> +
>> +clean_up_test() {
>> +	rmdir $TEST_DIR
>> +	echo -io > $CG/cgroup.subtree_control
>> +	_exit_null_blk
> 
> same here ?
> 
>> +}
>> +
>> +config_throtl() {
>> +	echo "$dev $*" > $TEST_DIR/io.max
>> +}
>> +
>> +remove_config() {
>> +	echo "$dev rbps=max wbps=max riops=max wiops=max" > $TEST_DIR/io.max
>> +}
>> +
> 
> same here for above two helper ?

Yes, of course.
> 
>> +test_io() {
>> +	config_throtl "$1"
>> +
>> +	{
>> +		sleep 0.1
>> +		start_time=$(date +%s.%N)
>> +
>> +		if [ "$2" == "read" ]; then
>> +			dd if=/dev/$devname of=/dev/null bs=4k count=256 iflag=direct status=none
>> +		elif [ "$2" == "write" ]; then
>> +			dd of=/dev/$devname if=/dev/zero bs=4k count=256 oflag=direct status=none
>> +		fi
> 
> Is there a any specific reason to use dd and not fio ?

My thoughts is that I need to make sure the number and the size
of IO that I dispatched, so that I can predict the throttle time,
and we don't need to keep issuing new IO based on time here.
> 
>> +
>> +		end_time=$(date +%s.%N)
>> +		elapsed=$(echo "$end_time - $start_time" | bc)
>> +		printf "%.0f\n" "$elapsed"
>> +	} &
>> +
>> +	pid=$!
>> +	echo $! > $TEST_DIR/cgroup.procs
>> +	wait $pid
>> +
>> +	remove_config
>> +}
>> +
> 
> apparently test_io is also repeated can be moved to rc with right
> parameters ?

There is slight difference, however, the answer is apparently yes.
> 
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	if ! set_up_test; then
>> +		return 1;
>> +	fi
>> +
>> +	_1MB=$((1024 * 1024))
> 
> starting variable name with _ seems a but weired, why not just pass
> $((1024 *1024)) ?

I'll use the name $bps_limit here, just think to prevent the same code
is better...

Thanks,
Kuai

> 
>> +
>> +	test_io wbps=$_1MB write
>> +	test_io wiops=256 write
>> +	test_io rbps=$_1MB read
>> +	test_io riops=256 read
>> +
>> +	clean_up_test
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
>> index 0000000..8fa8b58
>> --- /dev/null
>> +++ b/tests/throtl/rc
>> @@ -0,0 +1,15 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Yu Kuai
>> +#
>> +# Tests for blk-throttle
>> +
>> +. common/rc
>> +. common/null_blk
>> +
>> +group_requires() {
>> +	_have_root
>> +	_have_null_blk
>> +	_have_kernel_option BLK_DEV_THROTTLING
>> +	_have_cgroup2_controller io
>> +}
> 
> apart from that thanks for the tests ..
> 
> -ck
> 
> 

