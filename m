Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743396;
	b=B1jxln++NKlUDXEN7JvD1084WwU5/rWEN4mEzB8oGjkqG0Nh54/q/VXLpwz6mOzGxKik
	 F9LN1Stl24YTn9vBbX4uDvdlIOhm1ocVV5WW8lNCtRWuVeMmaXmbyvaQZHLpmHUZddbFY
	 zJCfz0Jwryb3Fhz3iqkcK4C6XI6pUs7aCEO9bnnGXJp/mvXt8ifmzm/bIE0FmIeZIVzzl
	 eMvwnSTCt3BJeyMEbJRXpjSQxKNF85wLn/FvTNNETztxMuY+xn0SOtRurypQSf15PkZVF
	 F+niVy2abV/4DHNarlbP+q++P+HKXfi3ezhy8PeqvdfckBLSZKQkBe7JxXPRwhoW/CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743396;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=boKDsOS3kLPQnJNVcXGwCI31PgCeu6/+157VDRHp3gg=;
	b=KA8N38YYQXHyiiseTUpbKhIAZsyzvL1ygcmMv48dJrJb8bitMzKAKvV/PaAT7CKcD117
	 Jaa3D7H4T4QEvYUJgFiQOs/W4lcXxL2KxRl7FL/LPjXovmHlRSyIsa2OmGDji19tCNgiJ
	 rtCYXWPR/ZPEnqrKufADWFZFAiOW0MMYkH4j1Q1CFl+/KsjEH92h8YexHU9a53GPExmP8
	 bouCD9hc4UfAsNqsrrCmc6xG8offIGXfPsXCrkKHgl2Xag4/kwjpi54MZ74ZeEjUcg4Or
	 VQ2HxxE/gNdTKtN3FjdCuFAMUswUJVDc7dAy+ChgVvqgr9XTmTlBxe3ghgbc746bj4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73365606A31E;
	Fri, 27 Nov 2026 01:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73365606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jbGGd1f8xz20DH;
	Fri, 27 Nov 2026 09:36:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 904AD40573;
	Fri, 27 Nov 2026 09:36:31 +0800 (CST)
Received: from [10.174.178.164] (unknown [10.174.178.164])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgCn4O+d3ghrspnPFw--.33092S3;
	Fri, 27 Nov 2026 09:36:31 +0800 (CST)
Message-ID: <7a6c6a0b-9296-4ed7-acf1-f909cd8f9298@huaweicloud.com>
Date: Fri, 27 Nov 2026 09:36:27 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND V2] block: fix BLKSECDISCARD zero-length range
 causing page cache invalidation
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
 hch@lst.de, yukuai@fygo.io, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20261102080420.3774409-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20261102080420.3774409-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn4O+d3ghrspnPFw--.33092S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4DWFWDArWDCr4rGw1xXwb_yoW5WrWxpr
	W5GFy5Gr4DWr9ruF48K3W7uFy093WjgF4xC345twn3ZrZFyrnIgFyrCrySgay0qr97J3y8
	XF4YvFyfK3429a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_
	GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Hi Jens,

Friendly ping on this patch. It has been reviewed and is ready for
picking up when you have a chance.

Thanks,
Zizhi Wo

在 2026/11/2 16:04, Zizhi Wo 写道:
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
> v1:
> https://lore.kernel.org/all/20260704073942.3760597-1-wozizhi@huaweicloud.com/
> ---
>   block/ioctl.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 64b4e6c0f696..53558963d9d7 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -175,12 +175,11 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
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
> @@ -188,19 +187,17 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
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

