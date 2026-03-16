Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525B265CC2
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661123; cv=none; b=l7d/N/rwy+W5Odt0tZtDMXz4tkJ0re/SJ6vUerKl630UEGiyNNIKVpLo3BShiMxPsIPVZ5IndBeFmcm3epo3zBMjxpITDwdU1dMnW68Y4K4vJfIpiUXQtNO11dFof1I4I68ELNlEDgdS7iDdAV+Rp1WpJ1zE9c3XsmFBBCfsaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661123; c=relaxed/simple;
	bh=gOMrOsyfFrwV0gR+CT3Byaic8SjUfj8ZTzmoI7LCgv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJklb2Kqg8EMfRVWqtUTmzDaHqownEb8mV/OVU7xuoTDp8ys65p5aPJt+XqDi+pygNTKxnr9e+FD0axgWamUp4qISVl7oLb8T4xubYj1w/JXEqnuYfR5i6a5ngLvypl0P0TcyrCwcDHjpLjnz7vAGF15OMgX1VRQnu1F4QjnjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fZCkZ0yzfzYQvQQ
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 19:37:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F11564056D
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 19:38:37 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with SMTP id cCh0CgD3+Ni767dpl1tvBA--.34742S3;
	Mon, 16 Mar 2026 19:38:37 +0800 (CST)
Message-ID: <fede463e-729e-47e8-8c1d-4680b2998fd3@huaweicloud.com>
Date: Mon, 16 Mar 2026 19:38:35 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] blk-throttle: remove leftover carryover checks in
 tg_within_[bps/iops]_limit
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, yukuai@fnnas.com,
 ming.lei@redhat.com, linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20260316084455.3323966-1-wozizhi@huaweicloud.com>
 <20260316084455.3323966-2-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260316084455.3323966-2-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3+Ni767dpl1tvBA--.34742S3
X-Coremail-Antispam: 1UD129KBjvJXoWxArW5GF4rJFWrKF1fuw43Awb_yoW5uF1fpr
	4xGr1I9F4xXFn7KFnxAan8ZFWrJr47Ary5GrW3X348CFn8CFyqqr90grW5tay7Arn7uFWf
	Z3ZYq3Z7Ar4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Hi,

I need to correct myself — this change is actually problematic. Please 
ignore this patch...

[bytes/io]_disp is intentionally signed and can be negative to represent
carryover. By changing io_allowed to unsigned int, the comparison
tg->io_disp[rw] + 1 <= io_allowed becomes a signed/unsigned comparison. 
When io_disp is negative, it will be implicitly converted to a large 
unsigned value.


在 2026/3/16 16:44, Zizhi Wo 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> Commit bb8d5587bdc3 ("blk-throttle: fix wrong comparation while
> 'carryover_ios/bytes' is negative") changed the type of "io_allowed" and
> "bytes_allowed", and added "io_allowed > 0" and "bytes_allowed > 0" checks
> to handle the case where carryover_ios/bytes could be negative.
> 
> Since commit 6cc477c36875 ("blk-throttle: carry over directly") removed
> the "carryover" fields, the allowed values are now computed solely by
> calculate_io_allowed() and calculate_bytes_allowed(), which always return
> non-negative results. The extra checks are therefore no longer necessary.
> 
> Remove the now-unnecessary "> 0" checks and restore the types of
> "io_allowed" and "bytes_allowed" to unsigned to match the return types of
> the corresponding calculate functions.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 97188a795848..b82da0dfa8e8 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -760,7 +760,7 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
>   				 u32 iops_limit)
>   {
>   	bool rw = bio_data_dir(bio);
> -	int io_allowed;
> +	unsigned int io_allowed;
>   	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>   
>   	jiffy_elapsed = jiffies - tg->slice_start[rw];
> @@ -768,7 +768,7 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
>   	/* Round up to the next throttle slice, wait time must be nonzero */
>   	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, DFL_THROTL_SLICE);
>   	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
> -	if (io_allowed > 0 && tg->io_disp[rw] + 1 <= io_allowed)
> +	if (tg->io_disp[rw] + 1 <= io_allowed)
>   		return 0;
>   
>   	/* Calc approx time to dispatch */
> @@ -783,8 +783,7 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   				u64 bps_limit)
>   {
>   	bool rw = bio_data_dir(bio);
> -	long long bytes_allowed;
> -	u64 extra_bytes;
> +	u64 bytes_allowed, extra_bytes;
>   	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>   	unsigned int bio_size = throtl_bio_data_size(bio);
>   
> @@ -796,9 +795,7 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   
>   	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, DFL_THROTL_SLICE);
>   	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
> -	/* Need to consider the case of bytes_allowed overflow. */
> -	if ((bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
> -	    || bytes_allowed < 0)
> +	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed)
>   		return 0;
>   
>   	/* Calc approx time to dispatch */

