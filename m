Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB518A93C;
	Fri,  8 Aug 2025 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621270; cv=none; b=tBsTIsWmajxtlIez3g0UBy7UTovnlvXjiFLFjIaSBgdB1QdrM7vY8+E/AOzr8PFrbNK36pPgZpm1Hcqjh06xTDIUSgJ+KmIoeaMKknQP9PoGiEU9/j3RHD/BrZW7fJ63Go1D6F03vIu9tXvnS0uaK8bd9qRNvNbrubrqTmrQXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621270; c=relaxed/simple;
	bh=gt6kifYbsOMOVRvFZ7+2EDUxcMagZ4qqgqlPSn5/yZM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fRwAX2b2I/XedVtjTXN2y3Vr7q6T/5niFVHxM+6Sjc/6+0zI8ycOoLaeRoFgKzNyXB/x3wVz1UiBXJLfu2CDXEZNGIjIK0dEtQoYBreIYUmtcY0BS33j8ACSVveq4OUqyGBpy++pthy9Ccg6KRxaypFtyDsxV9QcFDz+XKNhU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bypNc1qXtzKHMrj;
	Fri,  8 Aug 2025 10:47:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5D3201A1A98;
	Fri,  8 Aug 2025 10:47:43 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhNNZZVoX27KCw--.31726S3;
	Fri, 08 Aug 2025 10:47:43 +0800 (CST)
Subject: Re: [PATCH 1/1] loop: sync filesystem cache before getting file size
 in get_size()
To: Rajeev Mishra <rajeevm@hpe.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250807232522.192898-1-rajeevm@hpe.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <756e15de-dbbc-4438-80c6-454b2fcc44ac@huaweicloud.com>
Date: Fri, 8 Aug 2025 10:47:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250807232522.192898-1-rajeevm@hpe.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhNNZZVoX27KCw--.31726S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyktw1DCr4UtFW3Gry3urg_yoW5Xw1UpF
	WrAFyYyryDGFW7GanxGwsrZ34Fgws7uFyUury7Aa1vvFnxCw1akF93GFyYga1jgr9xA3WY
	qayDJryj9FyDZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7I
	JmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/08 7:25, Rajeev Mishra Ð´µÀ:
> The get_size() function now uses vfs_getattr_nosec() with AT_STATX_SYNC_AS_STAT

With a quick code review, I didn't found how can that flag ensure
filesystem cache is synchronized, can you explain in detail? Or Do you
mean getattr for filesystem like fuse to get latest data from server?

> to ensure filesystem cache is synchronized before retrieving file size. This
> provides more accurate size information, especially when:
> 
> - The backing file size has been changed by another process
> - The file is on a network filesystem (NFS, CIFS, etc.)
> - The file is being modified concurrently

I don't think this make sense in real world. If a file is already used
by loop device, then user should avoid modifying this file directly. For
a file in fuse, I feel it's not good to use it as loop device.

> - The most accurate size is needed for loop device setup
> > The implementation gracefully falls back to i_size_read() if 
vfs_getattr_nosec()
> fails, maintaining backward compatibility.
> 
> Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
> ---
>   drivers/block/loop.c | 31 +++++++++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1b6ee91f8eb9..15d5edbc69ce 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -137,12 +137,39 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
>   static int max_part;
>   static int part_shift;
>   
> +/**
> + * get_size - calculate the effective size of a loop device
> + * @offset: offset into the backing file
> + * @sizelimit: user-specified size limit
> + * @file: the backing file
> + *
> + * Calculate the effective size of the loop device
> + *
> + * Returns: size in 512-byte sectors, or 0 if invalid
> + */
>   static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
>   {
> +	struct kstat stat;
>   	loff_t loopsize;
> +	int ret;
> +
> +	/*
> +	 * Get file attributes for validation. We use vfs_getattr() to ensure
> +	 * we have up-to-date file size information.
> +	 */
> +	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE,
> +			        AT_STATX_SYNC_AS_STAT);
> +	if (ret) {
> +		/*
> +		 * If we can't get attributes, fall back to i_size_read()
> +		 * which should work for most cases.
> +		 */
> +		loopsize = i_size_read(file->f_mapping->host);
> +	} else {
> +		/* Use the size from getattr for consistency */
> +		loopsize = stat.size;
> +	}

I'm ok switch from i_size_read() to getattr, however, the commit message
is confusing for me :(

Thanks,
Kuai
>   
> -	/* Compute loopsize in bytes */
> -	loopsize = i_size_read(file->f_mapping->host);
>   	if (offset > 0)
>   		loopsize -= offset;
>   	/* offset is beyond i_size, weird but possible */
> 

