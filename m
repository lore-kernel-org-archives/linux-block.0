Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632C235341;
	Thu, 14 Aug 2025 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153521; cv=none; b=aMTH+6xhfdtkNp4cKpwSFkMpPGL6o8dK5rLDce0kxRGAd561xKNJVEoZOsczur7UEI+IFjbKVfRcaRPcT9YXln6csUeMOkRyAfmsD+8dwePtrTPG+6OBE4oXbFMb29F3HFHJhq9amrHBBaFcD0qedNPX7cu+iZnIL3aUHZj74tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153521; c=relaxed/simple;
	bh=W6z6qVkPhFJfIZeybYAsLN9vl8e4DqJY47PuPx8Q9aM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EiLinUgMRT4WqoTifhz28YEE6z3wM3pHv364PEAVFRG46dfEGGWpAyRs6qSDj9Zfquh7R8wQbb80DyK+vd60WnjadmMC/OyGmnA6Z0FT2+sTjluClmFnzd9dSXIr7wNrrVbZb3I0BFACz91mpH/B+uVorPrqmv4EWkQ7oUNOZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2bDB2kxLzYQvBp;
	Thu, 14 Aug 2025 14:38:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 01AF61A1ABB;
	Thu, 14 Aug 2025 14:38:33 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRnhJ1ops2FDg--.17931S3;
	Thu, 14 Aug 2025 14:38:32 +0800 (CST)
Subject: Re: [PATCH v4 1/2] loop: Rename and merge get_size/get_loop_size to
 lo_calculate_size
To: Rajeev Mishra <rajeevm@hpe.com>, axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250813195228.12021-1-rajeevm@hpe.com>
 <20250813195228.12021-2-rajeevm@hpe.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <43c58aed-3fff-564b-e658-ebe3f7735fb9@huaweicloud.com>
Date: Thu, 14 Aug 2025 14:38:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250813195228.12021-2-rajeevm@hpe.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxRnhJ1ops2FDg--.17931S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFW5Gw18XryUWF15WFW7Arb_yoW7AFW3pF
	15Za4FyrWrKF9rGFsrtwn7XF1Fqa1vg347Z34DZa40kwnavr9IkFyfCFWF9rW7Jr9xAFyF
	q3WDJFykAr1jqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/14 3:52, Rajeev Mishra Ð´µÀ:
> - Renamed get_size to lo_calculate_size.
> - Merged get_size and get_loop_size logic into lo_calculate_size.
> - Updated all callers to use lo_calculate_size.
> - Added header to lo_calculate_size.
> 
> Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
> ---
>   drivers/block/loop.c | 50 +++++++++++++++++++-------------------------
>   1 file changed, 21 insertions(+), 29 deletions(-)
> 

This patch has lots of style issues, please run checkpatch and fix
the warnings first.

Thanks,
Kuai

./scripts/checkpatch.pl 
0001-loop-Rename-and-merge-get_size-get_loop_size-to-lo_c.patch
WARNING: please, no spaces at the start of a line
#52: FILE: drivers/block/loop.c:142:
+       loff_t loopsize;$

WARNING: please, no spaces at the start of a line
#54: FILE: drivers/block/loop.c:144:
+       loopsize = i_size_read(file->f_mapping->host);$

WARNING: please, no spaces at the start of a line
#55: FILE: drivers/block/loop.c:145:
+       if (lo->lo_offset > 0)$

WARNING: suspect code indent for conditional statements (7, 15)
#55: FILE: drivers/block/loop.c:145:
+       if (lo->lo_offset > 0)
+              loopsize -= lo->lo_offset;

WARNING: please, no spaces at the start of a line
#58: FILE: drivers/block/loop.c:148:
+       if (loopsize < 0)$

WARNING: suspect code indent for conditional statements (7, 15)
#58: FILE: drivers/block/loop.c:148:
+       if (loopsize < 0)
+              return 0;

WARNING: Statements should start on a tabstop
#59: FILE: drivers/block/loop.c:149:
+              return 0;

WARNING: please, no spaces at the start of a line
#60: FILE: drivers/block/loop.c:150:
+       if (lo->lo_sizelimit > 0 && lo->lo_sizelimit < loopsize)$

WARNING: suspect code indent for conditional statements (7, 15)
#60: FILE: drivers/block/loop.c:150:
+       if (lo->lo_sizelimit > 0 && lo->lo_sizelimit < loopsize)
+              loopsize = lo->lo_sizelimit;

WARNING: please, no spaces at the start of a line
#66: FILE: drivers/block/loop.c:156:
+       return loopsize >> 9;$

total: 0 errors, 10 warnings, 80 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0001-loop-Rename-and-merge-get_size-get_loop_size-to-lo_c.patch has 
style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.

> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1b6ee91f8eb9..5faf8607dfb2 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -137,30 +137,23 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
>   static int max_part;
>   static int part_shift;
>   
> -static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
> -{
> -	loff_t loopsize;
> -
> -	/* Compute loopsize in bytes */
> -	loopsize = i_size_read(file->f_mapping->host);
> -	if (offset > 0)
> -		loopsize -= offset;
> -	/* offset is beyond i_size, weird but possible */
> -	if (loopsize < 0)
> -		return 0;
> -
> -	if (sizelimit > 0 && sizelimit < loopsize)
> -		loopsize = sizelimit;
> -	/*
> -	 * Unfortunately, if we want to do I/O on the device,
> -	 * the number of 512-byte sectors has to fit into a sector_t.
> -	 */
> -	return loopsize >> 9;
> -}
> -
> -static loff_t get_loop_size(struct loop_device *lo, struct file *file)
> -{
> -	return get_size(lo->lo_offset, lo->lo_sizelimit, file);
> +static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
> +{
> +       loff_t loopsize;
> +       /* Compute loopsize in bytes */
> +       loopsize = i_size_read(file->f_mapping->host);
> +       if (lo->lo_offset > 0)
> +	       loopsize -= lo->lo_offset;
> +       /* offset is beyond i_size, weird but possible */
> +       if (loopsize < 0)
> +	       return 0;
> +       if (lo->lo_sizelimit > 0 && lo->lo_sizelimit < loopsize)
> +	       loopsize = lo->lo_sizelimit;
> +       /*
> +	* Unfortunately, if we want to do I/O on the device,
> +	* the number of 512-byte sectors has to fit into a sector_t.
> +	*/
> +       return loopsize >> 9;
>   }
>   
>   /*
> @@ -569,7 +562,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>   	error = -EINVAL;
>   
>   	/* size of the new backing store needs to be the same */
> -	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
> +	if (lo_calculate_size(lo, file) != lo_calculate_size(lo, old_file))
>   		goto out_err;
>   
>   	/*
> @@ -1063,7 +1056,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   	loop_update_dio(lo);
>   	loop_sysfs_init(lo);
>   
> -	size = get_loop_size(lo, file);
> +	size = lo_calculate_size(lo, file);
>   	loop_set_size(lo, size);
>   
>   	/* Order wrt reading lo_state in loop_validate_file(). */
> @@ -1255,8 +1248,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>   	if (partscan)
>   		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>   	if (!err && size_changed) {
> -		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
> -					   lo->lo_backing_file);
> +		loff_t new_size = lo_calculate_size(lo, lo->lo_backing_file);
>   		loop_set_size(lo, new_size);
>   	}
>   out_unlock:
> @@ -1399,7 +1391,7 @@ static int loop_set_capacity(struct loop_device *lo)
>   	if (unlikely(lo->lo_state != Lo_bound))
>   		return -ENXIO;
>   
> -	size = get_loop_size(lo, lo->lo_backing_file);
> +	size = lo_calculate_size(lo, lo->lo_backing_file);
>   	loop_set_size(lo, size);
>   
>   	return 0;
> 

