Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962171419A4;
	Fri, 24 Jul 2026 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784855873; cv=none; b=ux1cC5VEAPWL6N0wpeCBPk4zHMs+YInJ+vIzWbQ8TeM0HEGZzu6pzva5m9bRomWzNg7/kQzi1HsaAas2CFbQwbrM8QxHtyWONWaGx1j6zpnMaPK2g8BYdzBNayHO5izATpf3s0tj3SJurJs12OdqDSd/k85lNJB52Sutrah4dK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784855873; c=relaxed/simple;
	bh=bVb6/V4r2k3P0MLnACZHT8Y1lywkVoHM044PLL39rqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZ+OXrXsHWCs7GDwlHcLUeajjZI3KyIQhqWRKGhE6/l3cX11+4VBFDSxFCkXhGmX7klHLaxvGZQU2zWRJG8cKEGjhoLE4KNc5SuEvPT65ry3P45+DbYAHrVUmywduf0gMVwEDEDDcpXE4LNWydoFeiSTUxXEFAzGJVc3Z2GzIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h5qpX75XVzYQttr;
	Fri, 24 Jul 2026 09:17:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 995D94058F;
	Fri, 24 Jul 2026 09:17:40 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCXp3MxvWJqjRlTCQ--.21775S3;
	Fri, 24 Jul 2026 09:17:40 +0800 (CST)
Message-ID: <6a3873e0-4135-43fd-86af-c8a2b973d659@huaweicloud.com>
Date: Fri, 24 Jul 2026 09:17:37 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix BLKSECDISCARD zero-length range causing page
 cache invalidation
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, yukuai@fygo.io
References: <20260704073942.3760597-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260704073942.3760597-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXp3MxvWJqjRlTCQ--.21775S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary3KF1Uury3Xw4xCF13twb_yoW8urW8pr
	WUWFy5GrZ8Wr9ruF4xt3Z7ZFyqk3W8KF4xCw15Krnav39FyrnxWFy5CrySgFWvvr97t3y8
	ZF4Yva4xGFy29FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

friendly ping...

在 2026/7/4 15:39, Zizhi Wo 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> Commit 697ba0b6ec4a ("block: fix integer overflow in BLKSECDISCARD") fixed
> the start+len overflow via check_add_overflow() but did not handle the
> start=0, len=0 case. There, start + len = 0, so end = 0 passes all checks,
> and truncate_bdev_range()->truncate_inode_pages_range() is then called with
> lend=UINT64_MAX, whitch is the "truncate to the end of file" sentinel, so
> the entire page cache is invalidated.
> 
> Fix this by replacing the validation with blk_validate_byte_range(), which
> already rejects a zero-length range and is what BLKDISCARD uses. This also
> switches the alignment check from a hardcoded 512 to
> bdev_logical_block_size().
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/ioctl.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 3d4ea1537457..3b7d33a737e8 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -176,8 +176,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>   static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
>   		void __user *argp)
>   {
> -	uint64_t start, len, end;
> -	uint64_t range[2];
> +	uint64_t range[2], start, len;
>   	int err;
>   
>   	if (!(mode & BLK_OPEN_WRITE))
> @@ -189,15 +188,13 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
>   
>   	start = range[0];
>   	len = range[1];
> -	if ((start & 511) || (len & 511))
> -		return -EINVAL;
> -	if (check_add_overflow(start, len, &end) ||
> -	    end > bdev_nr_bytes(bdev))
> -		return -EINVAL;
> +	err = blk_validate_byte_range(bdev, start, len);
> +	if (err)
> +		return err;
>   
>   	inode_lock(bdev->bd_mapping->host);
>   	filemap_invalidate_lock(bdev->bd_mapping);
> -	err = truncate_bdev_range(bdev, mode, start, end - 1);
> +	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
>   	if (!err)
>   		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
>   						GFP_KERNEL);

