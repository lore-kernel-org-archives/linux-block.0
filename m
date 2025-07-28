Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41F43147
	for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709991; cv=none; b=KPgshaz4PvzX/T1Ic0BUP3C8Jqk49DKt6FKPXc9bemg8qHFh9xTkQRlx21yHoLXqkeQ9u3ysny+Yg06s7us41+FL1HdRvXhFdfs8RseNl531k1uaAAPMDpbXA4ko41AT+CbFySA+sNvTJ8mUaNd1iLiqrR/Hcm8+iZSPKIQ/zAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709991; c=relaxed/simple;
	bh=gnP7Ho82e+2s2JRpLg89JIyPpoGI5zM/Q7VIgOaQq9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=YRWTgWy4NYei88HOgBOBEoxTDrBXo/1Dc9ShjJloJuxn5nvWAX5H21J0kLX3CeDasyVbM11Fvk7vdZyDq5QlVwIU1IBw6WxoR66CRPBVjdudI6UUQvfvdMjLHXTj+uSH2W5/N47BHVy0xMdJK+cBRRNp5kpfHYz6fnh26xLvBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ur0cYhpS; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ur0cYhpS"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250728133941euoutp01588a421553e19963641ca4f2690f0e5e~Wbe-OihRZ1399013990euoutp01b
	for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 13:39:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250728133941euoutp01588a421553e19963641ca4f2690f0e5e~Wbe-OihRZ1399013990euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753709981;
	bh=rLMXzfjtCxJZTFfF29cOu6ADGH4klb3b0shQniuYdUE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ur0cYhpS/vzbF/MyneBpkfh74lTvzdsSmg/4oiXIcbMt9rjx4b3eCZSPGI7HIxINN
	 ZxfUED+gU90tcoo+LWSvKxUhRzYzwGAwZR2nueWCaQajSjULxnt/aEiyz3ndqJj7iP
	 qxk5BrFAtjTkoK/o8s6QwQKeDYzfMvPuibX6ZLr0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250728133941eucas1p1110f4ef3da6f291256bc704a1835c866~Wbe_1RoxF2005220052eucas1p15;
	Mon, 28 Jul 2025 13:39:41 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250728133939eusmtip1c509bd530b71e291fc5ec8af00c1a663~Wbe9ocdKY1520215202eusmtip1j;
	Mon, 28 Jul 2025 13:39:39 +0000 (GMT)
Message-ID: <d556ddfd-36f0-4ae3-aac4-9dc0f903d7b1@samsung.com>
Date: Mon, 28 Jul 2025 15:39:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
To: Arnd Bergmann <arnd@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Kanchan Joshi
	<joshi.k@samsung.com>, Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>, Anders Roxell
	<anders.roxell@linaro.org>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Caleb Sander Mateos <csander@purestorage.com>, Pavel
	Begunkov <asml.silence@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250711084708.2714436-1-arnd@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250728133941eucas1p1110f4ef3da6f291256bc704a1835c866
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250728133941eucas1p1110f4ef3da6f291256bc704a1835c866
X-EPHeader: CA
X-CMS-RootMailID: 20250728133941eucas1p1110f4ef3da6f291256bc704a1835c866
References: <20250711084708.2714436-1-arnd@kernel.org>
	<CGME20250728133941eucas1p1110f4ef3da6f291256bc704a1835c866@eucas1p1.samsung.com>

On 11.07.2025 10:46, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Anders and Naresh found that the addition of the FS_IOC_GETLBMD_CAP
> handling in the blockdev ioctl handler breaks all ioctls with
> _IOC_NR==2, as the new command is not added to the switch but only
> a few of the command bits are check.
>
> Move the check into the blk_get_meta_cap() function itself and make
> it return -ENOIOCTLCMD for any unsupported command code, including
> those with a smaller size that previously returned -EINVAL.
>
> For consistency this also drops the check for NULL 'arg' that
> is really useless, as any invalid pointer should return -EFAULT.
>
> Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")
> Link: https://lore.kernel.org/all/CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com/
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: add the check in blk-integrity.c instead of ioctl.c
>
> I've left out the maximum-size check this time, as there was no
> consensus on whether there should be one, or what value.
>
> We still need to come up with a better way of handling these in
> general, for now the patch just addresses the immediate regression
> that Naresh found.
>
> I have also sent a handful of patches for other drivers that have
> variations of the same bug.
> ---

In my tests I've found that this patch, merged as commit 42b0ef01e6b5 
("block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()"), 
breaks udev operation on some of my test boards - no /dev/disk/* entries 
and directories are created. Reverting $subject on top of next-20250728 
fixes/hides this problem. I suspect that another corner case is missing 
in the checks. I will try to investigate this a bit more later, probably 
tomorrow.


>   block/blk-integrity.c | 10 ++++++----
>   block/ioctl.c         |  6 ++++--
>   2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index 9d9dc9c32083..61a79e19c78f 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -62,10 +62,12 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
>   	struct logical_block_metadata_cap meta_cap = {};
>   	size_t usize = _IOC_SIZE(cmd);
>   
> -	if (!argp)
> -		return -EINVAL;
> -	if (usize < LBMD_SIZE_VER0)
> -		return -EINVAL;
> +	if (_IOC_DIR(cmd)  != _IOC_DIR(FS_IOC_GETLBMD_CAP) ||
> +	    _IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP) ||
> +	    _IOC_NR(cmd)   != _IOC_NR(FS_IOC_GETLBMD_CAP) ||
> +	    _IOC_SIZE(cmd) < LBMD_SIZE_VER0)
> +		return -ENOIOCTLCMD;
> +
>   	if (!bi)
>   		goto out;
>   
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9ad403733e19..af2e22e5533c 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -566,9 +566,11 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
>   			       void __user *argp)
>   {
>   	unsigned int max_sectors;
> +	int ret;
>   
> -	if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
> -		return blk_get_meta_cap(bdev, cmd, argp);
> +	ret = blk_get_meta_cap(bdev, cmd, argp);
> +	if (ret != -ENOIOCTLCMD)
> +		return ret;
>   
>   	switch (cmd) {
>   	case BLKFLSBUF:

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

