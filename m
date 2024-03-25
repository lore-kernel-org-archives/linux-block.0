Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC117F228
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711367497; cv=none; b=M/WSlORZgmmarQarbcuyI7mtlE79BWfrW5y8g6lSU/pDdsQcdg+cqW2QLctBl45qURxhPA2eIu9pYYWRIfApIEHun99Rg88uUjPcEP7lh6XGr4oviqXIi04CL2aAHzg6PYAlpH6b7PzTdT69C1/mfaBqMDMrhuYpWce63Vw+5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711367497; c=relaxed/simple;
	bh=kpfw1Hggq2UoaSOxeNsMqMzOhmme72jPbvB7+uYkO38=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XfJ4cZAEfVrVZ+I0wj7OZP8jearEQ6pu3TJGxgzAtUupKeROdpuIkWlpbjLFjv7Wrd9PNGJK7fRZaO5Q1BFV8VJFvCJ7Gv7Ps/NxzrhPE547lvz8PRmTDWKcNQp3z3vpGL5DiYVygDoft7jFdRsqOuzfrmis0h1LJ0DQ+2+GLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V3B984fD3z4f3jsf
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 19:51:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C81D01A0BEC
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 19:51:30 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RE_ZQFm7X8kIA--.64532S3;
	Mon, 25 Mar 2024 19:51:29 +0800 (CST)
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
To: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3594bd44-4c6b-d079-1209-f069353ccd58@huaweicloud.com>
Date: Mon, 25 Mar 2024 19:51:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RE_ZQFm7X8kIA--.64532S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr47JF1fGFW5WryUXw48tFb_yoWrGF1Upr
	WruFsxXr90kF1kKanru3WxXF15ur4ktw13ua4qgr9rZay5Arn7KanFgry3uFyjyr4xXa1j
	qFs5CFyUXFySk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/03/24 0:11, Christian Brauner Ð´µÀ:
> Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> default this option is set. When it is set the long-standing behavior
> of being able to write to mounted block devices is enabled.
> 
> But in order to guard against unintended corruption by writing to the
> block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> off. In that case it isn't possible to write to mounted block devices
> anymore.
> 
> A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
> which disallows concurrent BLK_OPEN_WRITE access. When we still had the
> bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
> the mode was passed around. Since we managed to get rid of the bdev
> handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
> on whether the file was opened writable and writes to that block device
> are blocked. That logic doesn't work because we do allow
> BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.

I don't get it here, looks like there are no such use case. All users
passed in BLK_OPEN_RESTRICT_WRITES together with BLK_OPEN_WRITE.

Is the following root cause here?

1) t1 open with BLK_OPEN_WRITE
2) t2 open with BLK_OPEN_RESTRICT_WRITES, with bdev_block_writes(), yes
we don't wait for t1 to close;
3) t1 close, after the commit, bdev_unblock_writes() is called
unexpected.

Following openers will succeed although t2 doesn't close;
> 
> So fix the detection logic. Use O_EXCL as an indicator that
> BLK_OPEN_RESTRICT_WRITES has been requested. We do the exact same thing
> for pidfds where O_EXCL means that this is a pidfd that refers to a
> thread. For userspace open paths O_EXCL will never be retained but for
> internal opens where we open files that are never installed into a file
> descriptor table this is fine.

 From the path blkdev_open(), the file is from devtmpfs, and user can
pass in O_EXCL for that file, and that file will be used later in
blkdev_release() -> bdev_release() -> bdev_yield_write_access().

Thanks,
Kuai

> 
> Note that BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot
> directly be raised by userspace. It is implicitly raised during
> mounting.
> 
> Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
> unset.
> 
> Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   block/bdev.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 7a5f611c3d2e..f819f3086905 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -821,13 +821,12 @@ static void bdev_yield_write_access(struct file *bdev_file)
>   		return;
>   
>   	bdev = file_bdev(bdev_file);
> -	/* Yield exclusive or shared write access. */
> -	if (bdev_file->f_mode & FMODE_WRITE) {
> -		if (bdev_writes_blocked(bdev))
> -			bdev_unblock_writes(bdev);
> -		else
> -			bdev->bd_writers--;
> -	}
> +
> +	/* O_EXCL is only set for internal BLK_OPEN_RESTRICT_WRITES. */
> +	if (bdev_file->f_flags & O_EXCL)
> +		bdev_unblock_writes(bdev);
> +	else if (bdev_file->f_mode & FMODE_WRITE)
> +		bdev->bd_writers--;
>   }
>   
>   /**
> @@ -946,6 +945,13 @@ static unsigned blk_to_file_flags(blk_mode_t mode)
>   	else
>   		WARN_ON_ONCE(true);
>   
> +	/*
> +	 * BLK_OPEN_RESTRICT_WRITES is never set from userspace and
> +	 * O_EXCL is stripped from userspace.
> +	 */
> +	if (mode & BLK_OPEN_RESTRICT_WRITES)
> +		flags |= O_EXCL;
> +
>   	if (mode & BLK_OPEN_NDELAY)
>   		flags |= O_NDELAY;
>   
> 

