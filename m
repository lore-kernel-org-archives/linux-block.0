Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536BF248893
	for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768162991; cv=none; b=IHmBtptIH14mOht4BYW7i0SHL3xeHICPM5e0H7/6BKBFgwFJLCUOMSvzGOWANlXBytSXI19OAkdFwIyZeC1dvLx43KoyuyNKJkG1ZDJ542Q12fD+cHxyzsDZUtjVjWD9i+tesl7p/XMqSmYse2it67Ojjlw0IFVHlw3PYGfxJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768162991; c=relaxed/simple;
	bh=GaRP4uT4b8/WwHC68Y1xxHaEwxVKUiaDnXjrhRbIdaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI2e2ixl4UgsFNN5Tvt1AEAU8gFgbwxwKrSmvVplKCG7jt9HQVpvdDVlXHgiMTsfJWbcnp9gbzChXTXsMXJclmm+qKPnDRc4SpXCfpEZ9kO/BYcsz3ctMEz3e8Pn+IDkPBOV2gFZ4KIUQEXlfLGjXHc++LLIXQ2pNNEz1BFEdv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=YW5KxQj9; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="YW5KxQj9"
X-Virus-Scanned: Yes
Message-ID: <e1998ea0-7948-41cf-be65-b283eb388c47@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1768162603; bh=GaRP4uT4b8/WwHC68Y1xxHaEwxVKUiaDnXjrhRbIdaQ=;
	h=Subject:To:Cc:References:Reply-To:From:In-Reply-To;
	b=YW5KxQj9TRtTK7MGbwyAtuscJX6ElP4cjzHQEZZiW9anZvBTSjwcPSZUj7hm5XRmC
	 D1jxj2i7IrlR/EAN+wyGXJMd1mcQxzuCZw4zbLJqTjXi7OQky1pPGuD8SsNhQ+VUnY
	 q3r8gDYy3IyAR9laXPxDSGqYHCnx/vKGDcnVHq9IBM7c2ji7uohjxSh81gWprY7guw
	 MSvMJlLpThOXJn2vAY2Ki55CN4RsRhUfFwzp9Nznx9IRzCDLTox9UbS/gPW9PJGWOq
	 BnpnaWGBwO8ojkGKGWSkhnPX3rVUWC3evbWfWgwsBt9DkE/s+cONAOMQexOdKeYUtT
	 YhHHUktRskwrPMNa7IWa3M6XygEtHCk6TygJz3zfSLX1pQW7BZIgknV3Bkub3UMXBa
	 9eyvL2oKqVHk6+XvqT7uU8DdLQst62EIQZ633jsGAmzq7l4Gq8MHwZhK3kcIvg7HHG
	 Zuc93VNVMHqE/u9XZH56ZIN0U02LMS+94Q1zJzDwsn1qBLGGTisag9mC1T+9s64px1
	 GzlYUOvmLBVVz+hvlh0GfU2Vw8LOBtkTgtgqz4v2ZxL84gG93XD2uxSPPVMXxeBTkb
	 qdgyB5all0BFVGqkzD+YSoxvzjUf+fj3zJRGpV5oElVXs16Zs6UtpneKFjdfwwt89F
	 QNUdNTFioS0CKfjJyQUV7/7I=
Date: Sun, 11 Jan 2026 22:16:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/3] ublk: add UBLK_CMD_TRY_STOP_DEV command
Content-Language: en-GB
To: Yoav Cohen <yoav@nvidia.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 csander@purestorage.com
Cc: jholzman@nvidia.com, omril@nvidia.com, Yoav Cohen <yoav@example.com>
References: <20260111094504.24701-1-yoav@nvidia.com>
 <20260111094504.24701-3-yoav@nvidia.com>
Reply-To: alex+zkern@zazolabs.com
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <20260111094504.24701-3-yoav@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Yoav,

On 11.01.26 11:45, Yoav Cohen wrote:
> This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
> device if there are no active openers for the ublk block device.
> If the device is busy, the command returns -EBUSY instead of
> disrupting active clients. This allows safe, non-destructive stopping.


This description is either wrong or the implementation is wrong.

It is missing that fact that after try fails any further opens will
fail with EBUSY, what if an active opener wants to open one more time or 
reopen - it will be disrupted - is this intended behaviour?

A beleive that a TRY interface is not expected to have side effects,
so might be ublk_ctrl_graceful_stop_dev would be a better name in that 
case. But in anyway it must be specified in the commit message what it 
does and why.


> 
> Advertise UBLK_CMD_TRY_STOP_DEV support via UBLK_F_SAFE_STOP_DEV
> feature flag.
> 
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/block/ublk_drv.c      | 44 +++++++++++++++++++++++++++++++++--
>   include/uapi/linux/ublk_cmd.h |  9 ++++++-
>   2 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2d5602ef05cc..fc8b87902f8f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -54,6 +54,7 @@
>   #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)

[snip]

>   
> @@ -919,6 +923,9 @@ static int ublk_open(struct gendisk *disk, blk_mode_t mode)
>   			return -EPERM;
>   	}
>   
> +	if (ub->block_open)
> +		return -EBUSY;
> +
>   	return 0;
>   }
>   

[snip]

> +static int ublk_ctrl_try_stop_dev(struct ublk_device *ub)
> +{
> +	struct gendisk *disk;
> +	int ret = 0;
> +
> +	disk = ublk_get_disk(ub);
> +	if (!disk)
> +		return -ENODEV;
> +
> +	mutex_lock(&disk->open_mutex);
> +	if (disk_openers(disk) > 0) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +	ub->block_open = true;
> +	/* release open_mutex as del_gendisk() will reacquire it */
> +	mutex_unlock(&disk->open_mutex);
> +
> +	ublk_ctrl_stop_dev(ub);
> +	goto out;
> +
> +unlock:
> +	mutex_unlock(&disk->open_mutex);
> +out:
> +	ublk_put_disk(disk);
> +	return ret;
> +}
> +

[snip]

-- 
have fun,
alex

