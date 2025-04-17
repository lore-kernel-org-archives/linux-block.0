Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14920330
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744857423; cv=none; b=BsnHj+EqwHEbwqVp6CfjjQOBe+N8YynUy06BFG1lnBcgwG2+0oQv8xnZdo2TL/2HZ1VlTp75ZFIwATJXoTA5I2vBfD4KO9Maxa5OSUBsBjxzzC7+b8zfB1HPISs4rgN57b6QbfETcL7sSDuPbLeMHX5I0QhZQgHHGW4xholLmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744857423; c=relaxed/simple;
	bh=woNoRMwb2N/MPRvBDPfGEZDM4Od+7PYUhkUJm09aTQk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QkXrbqz3jGxwPUFhOCePRUkS+I314FgswsHh3KhyAZRxVqWrwbyB1TjM4U0nZP0mJRjSZvc3jCSh69Ncu+V5EYK6sID3Y/ug8R+OMIiPiAcigdkAbO8gOvHgRpZhKe2yXz2v+bq019yBT7juVyK10tdetcfCF3iA15dR48w4eiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZdMTz2ntwz4f3jYl
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 10:36:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BC8151A07BB
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 10:36:57 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl9JaQBooxXZJg--.761S3;
	Thu, 17 Apr 2025 10:36:57 +0800 (CST)
Subject: Re: [PATCH 2/3] blk-throttle: Delete unnecessary carryover-related
 fields from throtl_grp
To: Zizhi Wo <wozizhi@huawei.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250417015033.512940-1-wozizhi@huawei.com>
 <20250417015033.512940-3-wozizhi@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1beb9def-9335-3867-6d6b-87acdd0e6180@huaweicloud.com>
Date: Thu, 17 Apr 2025 10:36:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250417015033.512940-3-wozizhi@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl9JaQBooxXZJg--.761S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1rXFWfJF13Jw47CF1rWFg_yoW5CryDpF
	WSqa18W3W7tFnxWa13G3ZaqFWUXws3Gry5J398Gr1FyFsIkrn29r98Cr1Fka1IyF93CrW0
	qw1qqr9rCF1UurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Upyx
	iUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/17 9:50, Zizhi Wo Ð´µÀ:
> We no longer need carryover_[bytes/ios] in tg, so it is removed. The
> related comments about carryover in tg are also merged into
> [bytes/io]_disp, and modify other related comments.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c |  8 ++++----
>   block/blk-throttle.h | 19 ++++++++-----------
>   2 files changed, 12 insertions(+), 15 deletions(-)
> 

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index df9825eb83be..4e4609dce85d 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -658,9 +658,9 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
>   
>   	/*
>   	 * If config is updated while bios are still throttled, calculate and
> -	 * accumulate how many bytes/ios are waited across changes. And
> -	 * carryover_bytes/ios will be used to calculate new wait time under new
> -	 * configuration.
> +	 * accumulate how many bytes/ios are waited across changes. And use the
> +	 * calculated carryover (@bytes/@ios) to update [bytes/io]_disp, which
> +	 * will be used to calculate new wait time under new configuration.
>   	 */
>   	if (bps_limit != U64_MAX) {
>   		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> @@ -687,7 +687,7 @@ static void tg_update_carryover(struct throtl_grp *tg)
>   	__tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
>   	__tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
>   
> -	/* see comments in struct throtl_grp for meaning of these fields. */
> +	/* see comments in struct throtl_grp for meaning of carryover. */
>   	throtl_log(&tg->service_queue, "%s: %lld %lld %d %d\n", __func__,
>   		   bytes[READ], bytes[WRITE], ios[READ], ios[WRITE]);
>   }
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 7964cc041e06..8bd16535302c 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -101,19 +101,16 @@ struct throtl_grp {
>   	/* IOPS limits */
>   	unsigned int iops[2];
>   
> -	/* Number of bytes dispatched in current slice */
> -	int64_t bytes_disp[2];
> -	/* Number of bio's dispatched in current slice */
> -	int io_disp[2];
> -
>   	/*
> -	 * The following two fields are updated when new configuration is
> -	 * submitted while some bios are still throttled, they record how many
> -	 * bytes/ios are waited already in previous configuration, and they will
> -	 * be used to calculate wait time under new configuration.
> +	 * Number of bytes/bio's dispatched in current slice.
> +	 * When new configuration is submitted while some bios are still throttled,
> +	 * first calculate the carryover: the amount of bytes/IOs already waited
> +	 * under the previous configuration. Then, [bytes/io]_disp are represented
> +	 * as the negative of the carryover, and they will be used to calculate the
> +	 * wait time under the new configuration.
>   	 */
> -	long long carryover_bytes[2];
> -	int carryover_ios[2];
> +	int64_t bytes_disp[2];
> +	int io_disp[2];
>   
>   	unsigned long last_check_time;
>   
> 

