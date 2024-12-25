Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E7632
	for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735095368; cv=none; b=aGNg/wvPWbm0e4En/ZRFYdrDEmwZFSOHv0As2XVwebGSYzqwi1nrYLCBn+PNEyKunalz9y05Qs6CY8o9Htrd2WJfW3Kwrzgk8c/1C0NlQ/4W9Ug3DML2xWfa0gRmcTYq6xu0elO1PDVyRAKZgd8fp0hdIGKTsZceUhKB0MMKNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735095368; c=relaxed/simple;
	bh=DVanpUUkGlIxwaVaP9w3is4maKGPvfhewzcJ2WPohB4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jkeVveVAvwgyXQGVkUf2124s+WbLwYkuyONHV90FAV4yqMwunvRJl2+512HNtulzM/N9MMj9vfvn4JPU5ujmIixJKCLe0tXaPsJTaN1dn1xleXvQ4Ess1d8f9jKH0agEbgIggfEIQVNKDVk73tfY2VcZF7blMVF8if87SunQM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YHxG50GH2z4f3lfG
	for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 10:55:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CCD251A0AF1
	for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 10:56:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4dAdGtnQ5s_Fg--.17445S3;
	Wed, 25 Dec 2024 10:56:01 +0800 (CST)
Subject: Re: [PATCHv2 blktests 2/2] throtl: fix the race between submitting IO
 and setting cgroup.procs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com, bvanassche@acm.org,
 gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241218134326.2164105-1-nilay@linux.ibm.com>
 <20241218134326.2164105-3-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0a2294ce-f60b-44fb-a0b9-bd938e48ff73@huaweicloud.com>
Date: Wed, 25 Dec 2024 10:55:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241218134326.2164105-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHo4dAdGtnQ5s_Fg--.17445S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1UCFWxZFy8GFy8ZFW8Zwb_yoW5Zw4kp3
	y7Cw48ta1fWF9rAr1xK3yruFW8Zw4vyF47CF9rKw13Ar4DJryxGr1Iqw1UXFZ0yFZ3W3y8
	ZF4rZayFkr1qy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/12/18 21:43, Nilay Shroff Ð´µÀ:
> The throttle test cases uses _throtl_issue_io function to submit IO
> to the device. This function typically runs in the background process
> however before this function starts execution and submit IO, we need
> to set the PID of the background process into cgroup.procs. The current
> implementation adds sleep 0.1 before _throtl_issue_io and it's assumed
> that during this sleep time of 0.1 second, we shall be able to write the
> PID of the background process to cgroup.procs. However this may not be
> always true as background process might starts running after sleep of 0.1
> seconds (and hence start submitting IO) before we could actually write
> the PID of background process into cgroup.procs from the parent shell.
> 
> This commit helps fix the above race condition by writing pid of the
> background/child process using $BASHPID into cgroup.procs. The $BASHPID
> returns the pid of the current bash process. So we leverage $BASHPID to
> first write the pid of the background/child job/process into cgroup.procs
> from within the child sub-shell and then start submitting IO. This way we
> eliminate the need of any communication between parent shell and the
> background/child shell process and that helps avoid the race.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   tests/throtl/004 | 7 ++-----
>   tests/throtl/005 | 7 ++-----
>   tests/throtl/rc  | 7 ++-----
>   3 files changed, 6 insertions(+), 15 deletions(-)
> 
Thanks for the patch!
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/tests/throtl/004 b/tests/throtl/004
> index 6e28612..d1461b9 100755
> --- a/tests/throtl/004
> +++ b/tests/throtl/004
> @@ -21,16 +21,13 @@ test() {
>   	_throtl_set_limits wbps=$((1024 * 1024))
>   
>   	{
> -		sleep 0.1
> +		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
>   		_throtl_issue_io write 10M 1
>   	} &
>   
> -	local pid=$!
> -	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
> -
>   	sleep 0.6
>   	echo 0 > "/sys/kernel/config/nullb/$THROTL_DEV/power"
> -	wait "$pid"
> +	wait $!
>   
>   	_clean_up_throtl
>   	echo "Test complete"
> diff --git a/tests/throtl/005 b/tests/throtl/005
> index 0778258..86e52b3 100755
> --- a/tests/throtl/005
> +++ b/tests/throtl/005
> @@ -20,16 +20,13 @@ test() {
>   	_throtl_set_limits wbps=$((512 * 1024))
>   
>   	{
> -		sleep 0.1
> +		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
>   		_throtl_issue_io write 1M 1
>   	} &
>   
> -	local pid=$!
> -	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
> -
>   	sleep 1
>   	_throtl_set_limits wbps=$((256 * 1024))
> -	wait $pid
> +	wait $!
>   	_throtl_remove_limits
>   
>   	_clean_up_throtl
> diff --git a/tests/throtl/rc b/tests/throtl/rc
> index 330e6b9..df54cb9 100644
> --- a/tests/throtl/rc
> +++ b/tests/throtl/rc
> @@ -97,18 +97,15 @@ _throtl_issue_io() {
>   # IO and then print time elapsed to the second, blk-throttle limits should be
>   # set before this function.
>   _throtl_test_io() {
> -	local pid
>   
>   	{
>   		local rw=$1
>   		local bs=$2
>   		local count=$3
>   
> -		sleep 0.1
> +		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
>   		_throtl_issue_io "$rw" "$bs" "$count"
>   	} &
>   
> -	pid=$!
> -	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
> -	wait $pid
> +	wait $!
>   }
> 

