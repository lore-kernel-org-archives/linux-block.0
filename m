Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9C3DE452
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998389; cv=none; b=uGiB6xNY/GR/JKvFURnj7Z1GMrBPetFdrpKRqqLtnwfeVGGeXI9cLWm/onCvaG4LQeoQDOadnFATmpCG4ORLVQczyF3SQkDOcRV+BIAG+zGiNpKH0p7E7HCxPQ//3QXXYNPNQOYJn71rrKj+JaJuoCyXZffDPJ+05HTfHGuqhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998389; c=relaxed/simple;
	bh=X04kfEHDpRK/6+9yh+0noeQWVS9wD5LI8iT5s32zjhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PK/jqQo1ypXKUYdOuQL7rhXZFoNC57hKPvxkevrWVH52pMpfOkDRb8IRGMX+GF/tJ4aXxJH+yCt5mQmKiflgncYoVXs9Frnz6QBam7GSsZtw89hsQc40871hFMOaedz81c3kvT9hFoOo8Z55MVc2B/QlXIG6/aMvWbyxzheJhpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hFyKZ0PTzzYQtph
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 14:38:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5FCCC40898
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 14:39:36 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgCnlkUmLHRq324yBQ--.24202S3;
	Thu, 06 Aug 2026 14:39:36 +0800 (CST)
Message-ID: <27b84502-9239-4a21-b38c-a44697764d57@huaweicloud.com>
Date: Thu, 6 Aug 2026 14:39:34 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: fix BLKSECDISCARD zero-length range causing
 page cache invalidation
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
 hch@lst.de, yukuai@fygo.io, linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20260725002355.347485-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260725002355.347485-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnlkUmLHRq324yBQ--.24202S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4kurW7WFyrZw1ftw1kKrg_yoW5XF1xpr
	WUGFy5Gr4DWr9ruF48K3ZrZFyq93WUKF4xA345trnxZrZFvrnFgFyrGrySgayvvr97t3y8
	XF4jvFyxK3429a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

friendly ping...

在 2026/7/25 8:23, Zizhi Wo 写道:
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
> Fixes: 0bd1ed4860d0 ("block: pass inclusive 'lend' parameter to truncate_inode_pages_range")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> Reviewed-by: Yu Kuai <yukuai@fygo.io>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> v2:
> Add the fixtag.
> 
> v1: https://lore.kernel.org/all/20260704073942.3760597-1-wozizhi@huaweicloud.com/
> ---
>   block/ioctl.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 3d4ea1537457..3b7d33a737e8 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -174,12 +174,11 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>   }
>   
>   static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
>   		void __user *argp)
>   {
> -	uint64_t start, len, end;
> -	uint64_t range[2];
> +	uint64_t range[2], start, len;
>   	int err;
>   
>   	if (!(mode & BLK_OPEN_WRITE))
>   		return -EBADF;
>   	if (!bdev_max_secure_erase_sectors(bdev))
> @@ -187,19 +186,17 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
>   	if (copy_from_user(range, argp, sizeof(range)))
>   		return -EFAULT;
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
>   	filemap_invalidate_unlock(bdev->bd_mapping);
>   	inode_unlock(bdev->bd_mapping->host);

