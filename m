Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A2249E5;
	Wed, 13 Aug 2025 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049143; cv=none; b=gFXyd9elzedE1yKJusEVsZGyNZvFI662lXWG8vurj/kq849a+3NJYN4AzV0Q4F/7cKv0psDeBd+yo4xD5X+Cv4RJ9F6Ae4SMbsTjo6GK+x51/AwyNoxPifLrGJdgyX17O0rXetWH1WeSY6CUmF+y65QRLgz6r/rP89jgEQgneLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049143; c=relaxed/simple;
	bh=zebIcP0FhE9iryQbt4t5GrgcBb7UjoUQb/AunSA7xeA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O0rHN+Nm3lGa/i9Gj0BJEYExw20/fePZR/CYUeNMWfnDr6L1bsffqjbfayDNyiwb5n3rBLuo/xaBdXln5wSxuM2AUuytZPJK54AWP0UlW9J47ptxp/5VSp3QAIaJFRvE8KTcx9T0yc3aQP5i5rZklsVC/G/8tCkSs3ka4T5OEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c1rcx1Ys2zYQv2M;
	Wed, 13 Aug 2025 09:38:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CD8E51A0359;
	Wed, 13 Aug 2025 09:38:55 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgC3MxSv7JtoHen7DQ--.59944S3;
	Wed, 13 Aug 2025 09:38:55 +0800 (CST)
Subject: Re: [PATCH v3] loop: use vfs_getattr_nosec() for accurate file size
To: Rajeev Mishra <rajeevm@hpe.com>, axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250812200707.233139-1-rajeevm@hpe.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ddaef6bd-fbf3-0d6b-e437-6f4fd9c967d2@huaweicloud.com>
Date: Wed, 13 Aug 2025 09:38:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250812200707.233139-1-rajeevm@hpe.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3MxSv7JtoHen7DQ--.59944S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWUZF17Zr48try8CrWfXwb_yoWruw1DpF
	y3ua4FyrWrtF9rGFsrZws7Xr15Gw4kW347ZryUCa40kFn0qrnI9Fn5CFWF9rW7Xr98CFyF
	qa1DJFykurnrAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUG0PhUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/13 4:07, Rajeev Mishra Ð´µÀ:
> This commit includes the following changes:
>   1. Renamed get_size to lo_calculate_size.
>   2. Merged the functionality of get_size and
>      get_loop_size into lo_calculate_size.
>   3  Updated callers of the above functions
>      to use lo_calculate_size.
>   4. Replaced i_size_read with vfs_getattr_nosec()
>      to obtain a more accurate file size for
>       network filesystems where cached metadata may be stale
> 
Please split 1-3 to a seperate patch.

> Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
> ---
>   drivers/block/loop.c | 53 +++++++++++++++++++++++++++++---------------
>   1 file changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1b6ee91f8eb9..6bfec38275b0 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -137,20 +137,43 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
>   static int max_part;
>   static int part_shift;
>   
> -static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
> +/**
> + * lo_calculate_size - calculate the effective size of a loop device
> + * @lo: loop device
> + * @file: backing file
> + *
> + * Calculate the effective size of the loop device based on backing file size,
> + * offset, and size limit. Uses vfs_getattr_nosec() for accurate file size
> + * information, particularly important for network filesystems where cached
> + * metadata may be stale.
> + *
> + * Returns: size in 512-byte sectors, or 0 on error
> + */

I feel this internal function comment is not necessary, the name can
explain itself, and you explain getattr below as well.

Otherwise this patch LGTM.

Thanks,
Kuai

> +static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
>   {
> +	struct kstat stat;
>   	loff_t loopsize;
> +	int ret;
>   
> -	/* Compute loopsize in bytes */
> -	loopsize = i_size_read(file->f_mapping->host);
> -	if (offset > 0)
> -		loopsize -= offset;
> -	/* offset is beyond i_size, weird but possible */
> +	/*
> +	 * Get the accurate file size. This provides better results than
> +	 * cached inode data, particularly for network filesystems where
> +	 * metadata may be stale.
> +	 */
> +	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
> +	if (ret)
> +		return 0;
> +
> +	loopsize = stat.size;
> +
> +	if (lo->lo_offset > 0)
> +		loopsize -= lo->lo_offset;
> +	/* offset is beyond file size, weird but possible */
>   	if (loopsize < 0)
>   		return 0;
>   
> -	if (sizelimit > 0 && sizelimit < loopsize)
> -		loopsize = sizelimit;
> +	if (lo->lo_sizelimit > 0 && lo->lo_sizelimit < loopsize)
> +		loopsize = lo->lo_sizelimit;
>   	/*
>   	 * Unfortunately, if we want to do I/O on the device,
>   	 * the number of 512-byte sectors has to fit into a sector_t.
> @@ -158,11 +181,6 @@ static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
>   	return loopsize >> 9;
>   }
>   
> -static loff_t get_loop_size(struct loop_device *lo, struct file *file)
> -{
> -	return get_size(lo->lo_offset, lo->lo_sizelimit, file);
> -}
> -
>   /*
>    * We support direct I/O only if lo_offset is aligned with the logical I/O size
>    * of backing device, and the logical block size of loop is bigger than that of
> @@ -569,7 +587,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>   	error = -EINVAL;
>   
>   	/* size of the new backing store needs to be the same */
> -	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
> +	if (lo_calculate_size(lo, file) != lo_calculate_size(lo, old_file))
>   		goto out_err;
>   
>   	/*
> @@ -1063,7 +1081,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   	loop_update_dio(lo);
>   	loop_sysfs_init(lo);
>   
> -	size = get_loop_size(lo, file);
> +	size = lo_calculate_size(lo, file);
>   	loop_set_size(lo, size);
>   
>   	/* Order wrt reading lo_state in loop_validate_file(). */
> @@ -1255,8 +1273,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>   	if (partscan)
>   		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>   	if (!err && size_changed) {
> -		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
> -					   lo->lo_backing_file);
> +		loff_t new_size = lo_calculate_size(lo, lo->lo_backing_file);
>   		loop_set_size(lo, new_size);
>   	}
>   out_unlock:
> @@ -1399,7 +1416,7 @@ static int loop_set_capacity(struct loop_device *lo)
>   	if (unlikely(lo->lo_state != Lo_bound))
>   		return -ENXIO;
>   
> -	size = get_loop_size(lo, lo->lo_backing_file);
> +	size = lo_calculate_size(lo, lo->lo_backing_file);
>   	loop_set_size(lo, size);
>   
>   	return 0;
> 

