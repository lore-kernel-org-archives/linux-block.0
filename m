Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B762417E0;
	Thu, 17 Jul 2025 23:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795465; cv=none; b=pNFjIF7xbl3KklJtCvEhHkOUwJSLeb1JelS9u5yT1nLWesr+qmN//LL9NirxSiJPQzqBXMa1dhyV/ANFazRq9NDFl0ARBsX6ZfowBzwwhO1AbhPcbFlS6SKY1nUxkxPOffMf01tn+oNmBXeh2uVNEqBKS51cJM6Ypr6Dn6ShKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795465; c=relaxed/simple;
	bh=luwEMShkvWVCsjmR6HNLMQIY9KglyhOuZde7/i+hkIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBLEKNi0UQ3SQ5r8Aegf7+SvOeEd6C7YK7hkpw+0Xt+d+w7zgTaFmOInOD5YpRxXHZw+OQT38oHpPHd3PouEYsdD4EWKRgPUvAZqzAeB6u4SbBi0Q69GmW1H9FwzssnLfx6uLKYuNzY1M9dDZFywTw49IUkd1EooVXrifMoEocc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwM6/lPb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwM6/lPb"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-556373661aaso1362500e87.2;
        Thu, 17 Jul 2025 16:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752795461; x=1753400261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tO5anYBMKUIP2eKGDmEn6W1tLK3SxEqRsEp2IYD/aOw=;
        b=lwM6/lPbMazLkUboolsSqXfhq3UZZ1QZ24Nkp85+i83ZXkP4EdX/lU2NWINHjweNWA
         jeIKi1lrG+Ss/PQ8MRiapQ8HFt9qNduKh6KxHZL6uxvh4VS6ubr9sIm7L1FawUhOD9h3
         qk8qz/lUDBxQTObKh8FERMNrjFposy/6ofZSehraT0us1xMUJF7UryZykN8fNEsaJivj
         EPlp1J9R9GtJPoxEGleXnbV1GIpokERs19ZScYGbsNGg/OI6wXbQDmBP8wXQqYFVL4GK
         thoWYFm6z2lO3x/PwVqYfawZWG8rCQ7XeYdIINYNaEuyN29IWUuZX2q3rdndxGbJT8BQ
         YRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752795461; x=1753400261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO5anYBMKUIP2eKGDmEn6W1tLK3SxEqRsEp2IYD/aOw=;
        b=WK4L+6O0bcWAtu7N2ozebNi/hSypllRZ0yvOdqKYGfuLruXR75bqJoFFODb/xWbtmH
         OD2YsgYeh+KeTrrZ5KxXNkGWp66mqSBLtj100LSNH45nnyZNTWstELQGKV2vPdg537gu
         ixF1ZamvcyEP9MlBzZCDLiRgkWcSIT4Ao3SYryBUzcuXy4B6AnWVzA26Lcw/r5gUYVuS
         FatZNPwZx6OWwC0BEaTlVDLW6r2fIZrO7J3uIMMqqvDXuXOwOC9GW6UP6q1v8nbhPdB2
         t3ktjX8dEUs75PwjqnyI4G41Oj+dk41HWlNEBGzmo0tPjwv1FlXKzL0zkdbdjhgxYD+g
         QZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE3Avjdt7uTIhsxtkKZoP44VtuMAF6xrI11WQNL/Qn/r/gxZrhIMazUEC/1b15lU9fkrcPBjWgdLOIng==@vger.kernel.org, AJvYcCUJay7TtBEkSF4eY9DKRQkJ6sCKrqdBReuq1KTO+NCxX4BQ9PeehPr2aWbZWtdUnnui+GPS02gC+GakGsqw@vger.kernel.org
X-Gm-Message-State: AOJu0YyzrFKysQu5twYTQNzJR2WIxIX/rq2nXBX49FYGB9ysTEQXqtqM
	hTFAIxGTG/qtvgn0Nc7bzqPytl4Jc5tQ6m9Fp+yN/Qw4HZ39AnfIIrVh
X-Gm-Gg: ASbGncu9Yg2KT7l34zYDsYO6x5bbGcluZrh7PEVABfl6wPKVZaXxixg9G+Hr4iyBIa0
	NwUI4k/kczaeRGcD1AFWov00jMXyv+j4+a64g1584isdv3yaeQp7mb/zspoCacHoIpWrCpWuRmr
	AXCYSwyO+DlMXNxOZte92idGqbtaOwtH1dqs5wLdRmZhw6OnucmbfPtdQZRz49pVj6vIUx+L2km
	08Na9DktWQ3SXFodAaVQ+jVpfUyVUuJ3GzZNStMlgL2/vJtqn7SagCKPJlP5WktMtRZkuunOeKO
	GITnfWiJusuueZQh5eY+Bk4c6eM4M8PvedII0ngEutagtQathGi1bIfC5IkTj5Qq309yxLbTJuo
	uaiV2iKcnDnI7QDPmvsknyFyI
X-Google-Smtp-Source: AGHT+IGkfAYurY+ewnx7eJ5OG8WEhScW7/nSoelbCOrRsOt132b5QBioe3UC7rR6qWU/oZNIbUkl/g==
X-Received: by 2002:a05:6512:3e14:b0:54f:bdfe:ece5 with SMTP id 2adb3069b0e04-55a23315c0bmr3330071e87.14.1752795460620;
        Thu, 17 Jul 2025 16:37:40 -0700 (PDT)
Received: from localhost ([2001:678:a5c:1204:126f:f00a:513f:807b])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55a31a9bf3bsm45174e87.40.2025.07.17.16.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:37:40 -0700 (PDT)
Date: Fri, 18 Jul 2025 01:37:39 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Anuj Gupta <anuj20.g@samsung.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Caleb Sander Mateos <csander@purestorage.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
Message-ID: <szmagqqo6lx36ozaqd5qf72xnzoi4e23jbfehjli6rfbvhps6w@if2cvmlgvmxv>
References: <20250711084708.2714436-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711084708.2714436-1-arnd@kernel.org>

Hi,

On 2025-07-11 10:46:51 +0200, Arnd Bergmann wrote:
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
>  block/blk-integrity.c | 10 ++++++----
>  block/ioctl.c         |  6 ++++--
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index 9d9dc9c32083..61a79e19c78f 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -62,10 +62,12 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
>  	struct logical_block_metadata_cap meta_cap = {};
>  	size_t usize = _IOC_SIZE(cmd);
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
>  	if (!bi)
>  		goto out;
>  
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9ad403733e19..af2e22e5533c 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -566,9 +566,11 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
>  			       void __user *argp)
>  {
>  	unsigned int max_sectors;
> +	int ret;
>  
> -	if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
> -		return blk_get_meta_cap(bdev, cmd, argp);

> +	ret = blk_get_meta_cap(bdev, cmd, argp);
> +	if (ret != -ENOIOCTLCMD)
> +		return ret;

This check seems to be incomplete. In the case when BLK_DEV_INTEGRITY is
disabled the ioctl can never complete as blk_get_meta_cap will then
always return -EOPNOTSUPP. Or should the !BLK_DEV_INTEGRITY stub be
changed to return -ENOIOCTLCMD instead?

It makes e.g. cryptsetup fail in my initramfs. Adding -EOPNOTSUPP to the
check fixes it for me:

diff --git a/block/ioctl.c b/block/ioctl.c
index af2e22e5533c..7d5361fd1b7d 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -569,7 +569,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 	int ret;
 
 	ret = blk_get_meta_cap(bdev, cmd, argp);
-	if (ret != -ENOIOCTLCMD)
+	if (ret != -EOPNOTSUPP && ret != -ENOIOCTLCMD)
 		return ret;
 
 	switch (cmd) {

Regards,
Klara Modin

>  
>  	switch (cmd) {
>  	case BLKFLSBUF:
> -- 
> 2.39.5
> 
