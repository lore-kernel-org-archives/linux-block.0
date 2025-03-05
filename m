Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52A45C18
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 02:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143113; cv=none; b=UWRjh2OM3Vu7cN4n62rjcD/9GDWxPkv5rEF+nBjnGg09qZsM59tio+QbmAuYD1DnVVkP8L2ZlAah16yS4uWyO//D7j+fst4YWwo7s1OSQPbBFADEbdS3FHnRT9M7hOgrM+sZHG0OhXPdizm/MfJMhkrJpC+vgqNaH8hD2GpFJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143113; c=relaxed/simple;
	bh=lHekUzxU8Zfm0A31yQ17eUQzxfAgP8UOQhPM0ZqZMnc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ps/zztPAUWpFKwUiXhG7cx2DPOoHcgoFUhA6ASDB7Ck341j7Squkq21nM6Kr60Tf51kU7/dTV2AliH38CWzPIJ3R+eNKkBuTxmTUOiQ4IUKLMO0J+qJVeMmXgZ27K+RjP1WU2IdcB1oTU0uQcnH8ihUbDdv/6V2hh6WbHaG+nsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z6xrk5Q68z4f3khQ
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 10:51:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D70241A0ACF
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 10:51:40 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl87vMdnf3dQFg--.54784S3;
	Wed, 05 Mar 2025 10:51:40 +0800 (CST)
Subject: Re: [PATCH V2] tests/throtl: add a new test 006
To: Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250304151858.3795301-1-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <155a5e5f-96a2-cfe4-ff15-6ffee8a4975d@huaweicloud.com>
Date: Wed, 5 Mar 2025 10:51:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250304151858.3795301-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl87vMdnf3dQFg--.54784S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4kAr4xXFWUJrW7KFWktFb_yoW5KFWxpF
	WDCF4rGF4fJF9rtr13GanFkFWrXw4kJry3C347Gr15Zr9rWryIkF129r1UXFWFyF9rXrWr
	ZF18ZFW8Ga1DWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUSNtxUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/03/04 23:18, Ming Lei Ð´µÀ:
> Add test for covering prioritized meta IO when throttling, regression
> test for commit 29390bb5661d ("blk-throttle: support prioritized processing
> of metadata").
> 
> Cc: Yu Kuai <yukuai1@huaweicloud.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- add ext4 jbd2 task into the cgroup(Kuai)
> 	- use 4M size IO(Kuai)
> 
>   tests/throtl/006     | 62 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/throtl/006.out |  4 +++
>   tests/throtl/rc      | 19 ++++++++++++++
>   3 files changed, 85 insertions(+)
>   create mode 100755 tests/throtl/006
>   create mode 100644 tests/throtl/006.out
> 

LGTM, just one nit below:

> diff --git a/tests/throtl/006 b/tests/throtl/006
> new file mode 100755
> index 0000000..23b30dc
> --- /dev/null
> +++ b/tests/throtl/006
> @@ -0,0 +1,62 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Ming Lei
> +#
> +# Test prioritized meta IO when IO throttling, regression test for
> +# commit 29390bb5661d ("blk-throttle: support prioritized processing of metadata")
> +
> +. tests/throtl/rc
> +
> +DESCRIPTION="test if meta IO has higher priority than data IO"
> +QUICK=1
> +
> +requires() {
> +	_have_program mkfs.ext4

Perhaps also add
_have_kernel_option EXT4_FS

feel free to add:
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> +}
> +
> +test_meta_io() {
> +	local path="$1"
> +	local start_time
> +	local end_time
> +	local elapsed
> +
> +	start_time=$(date +%s.%N)
> +	mkdir "${path}"/xxx
> +	touch "${path}"/xxx/1
> +	sync "${path}"/xxx
> +
> +	end_time=$(date +%s.%N)
> +	elapsed=$(echo "$end_time - $start_time" | bc)
> +	printf "%.0f\n" "$elapsed"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _set_up_throtl memory_backed=1; then
> +		return 1;
> +	fi
> +
> +	mkdir -p "${TMPDIR}/mnt"
> +	mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0 -F "/dev/${THROTL_DEV}" >> "$FULL" 2>&1
> +	mount "/dev/${THROTL_DEV}" "${TMPDIR}/mnt" >> "$FULL" 2>&1
> +
> +	_throtl_set_limits wbps=$((1024 * 1024))
> +	{
> +		local jbd2_pid
> +
> +		jbd2_pid=$(ps -eo pid,comm | pgrep -f "jbd2/${THROTL_DEV}" | awk '{print $1}')
> +		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
> +		echo "$jbd2_pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
> +		_throtl_issue_fs_io  "${TMPDIR}/mnt/test.img" write 4M 1 &
> +		sleep 2
> +		test_meta_io "${TMPDIR}/mnt"
> +		wait
> +	} &
> +	wait $!
> +
> +	umount "${TMPDIR}/mnt" || return $?
> +	_throtl_remove_limits
> +	_clean_up_throtl
> +	echo "Test complete"
> +}
> diff --git a/tests/throtl/006.out b/tests/throtl/006.out
> new file mode 100644
> index 0000000..8c3d176
> --- /dev/null
> +++ b/tests/throtl/006.out
> @@ -0,0 +1,4 @@
> +Running throtl/006
> +0
> +4
> +Test complete
> diff --git a/tests/throtl/rc b/tests/throtl/rc
> index df54cb9..327084b 100644
> --- a/tests/throtl/rc
> +++ b/tests/throtl/rc
> @@ -75,6 +75,25 @@ _throtl_get_max_io_size() {
>   	cat "/sys/block/$THROTL_DEV/queue/max_sectors_kb"
>   }
>   
> +_throtl_issue_fs_io() {
> +	local path=$1
> +	local start_time
> +	local end_time
> +	local elapsed
> +
> +	start_time=$(date +%s.%N)
> +
> +	if [ "$2" == "read" ]; then
> +		dd if="${path}" of=/dev/null bs="$3" count="$4" iflag=direct status=none
> +	elif [ "$2" == "write" ]; then
> +		dd of="${path}" if=/dev/zero bs="$3" count="$4" oflag=direct conv=fdatasync status=none
> +	fi
> +
> +	end_time=$(date +%s.%N)
> +	elapsed=$(echo "$end_time - $start_time" | bc)
> +	printf "%.0f\n" "$elapsed"
> +}
> +
>   _throtl_issue_io() {
>   	local start_time
>   	local end_time
> 

