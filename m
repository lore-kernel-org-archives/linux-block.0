Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011122192E7
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399956; cv=none; b=nXHCdsYHLy6E9ffM5vzhV3APTB4w4UdbLIxNLVps3EbuWm9QhRumdowCse2nat8ravnS7IdRd0+71i9P1CzPBLfTT0R4J73e+jxgM0GgpwXQP+d8cyE6Il6tUuYePid/Vjs9MozI6T3B46MmOyxWLFzoxZ+zx/l6FTF/gpozNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399956; c=relaxed/simple;
	bh=e8JAmxQaNFbfsHH7b8InFGcfcsBtlN2wD+rXQz4Kzn8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Nfl6KwKY+MixJT4gcsnXG9ux9FRs1LTL9c1aFPLqjxeu9f6zKtqvL10zByK0pYcvVd6UMaLNuChAcF0T78yWJQURlg/rutnDzzphNGKgdHZnHo+3zVFFibcYVi3HMZ71PkyOnwkY5Vj9K68shhGm8lu/Ub7CQwVyQmnkTNThzqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z1g1M2vThz4f3lDc
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 20:25:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 95E8E1A0E98
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 20:25:50 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3m19NZbxnunEPEw--.56566S3;
	Mon, 24 Feb 2025 20:25:50 +0800 (CST)
Subject: Re: [PATCH] tests/throtl: add a new test 006
To: Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250224095945.1994997-1-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <94ad8a55-97a7-d75a-7cfd-08cbce159bed@huaweicloud.com>
Date: Mon, 24 Feb 2025 20:25:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250224095945.1994997-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3m19NZbxnunEPEw--.56566S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4kAr4xXFWUJrWxGw4fAFb_yoW5trWrpr
	WDCFWrGF4fJF9rtrnxJanIgFZ5Xw4kJrW7Cry7Gr15Ar9rW34IkF129r4UXFWrAF9xXrWf
	ZF18ZFyrGa1DurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

ÔÚ 2025/02/24 17:59, Ming Lei Ð´µÀ:
> Add test for covering prioritized meta IO when throttling, regression
> test for commit 29390bb5661d ("blk-throttle: support prioritized processing
> of metadata").
> 
> Cc: Yu Kuai <yukuai1@huaweicloud.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   tests/throtl/006     | 58 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/throtl/006.out |  4 +++
>   tests/throtl/rc      | 19 +++++++++++++++
>   3 files changed, 81 insertions(+)
>   create mode 100755 tests/throtl/006
>   create mode 100644 tests/throtl/006.out
> 
> diff --git a/tests/throtl/006 b/tests/throtl/006
> new file mode 100755
> index 0000000..4baadaf
> --- /dev/null
> +++ b/tests/throtl/006
> @@ -0,0 +1,58 @@
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
> +		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
> +		_throtl_issue_fs_io  "${TMPDIR}/mnt/test.img" write 64K 64 &
> +		sleep 2
> +		test_meta_io "${TMPDIR}/mnt"

Do you run this test without the kernel patch? If I remembered
correctly, ext4 issue the meta IO from jbd2 by default, which is from
root cgroup, and root cgroup can only throttled from cgroup v1.

Thanks,
Kuai

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

