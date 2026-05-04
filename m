Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1C3A383A
	for <linux-block@vger.kernel.org>; Mon,  4 May 2026 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890487; cv=none; b=jhtwtUMkWTNaiVG8zF3tUHXJ/O9MRyZ0h1YJ1HTQf0EFzYHP/a11KCQrrMtL1kr7mhmpoXQTbOQhIGtqhPGPdxES5pd+UE051u70KLNu1eGYrmhDgrlx13lcYdGLVIo1LAIKeSjnZLe/kmAUty864iBmq/GzF6pZvg76Xv6LFU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890487; c=relaxed/simple;
	bh=5xdOX+5arWSGEvcko0QhRQZxIy5sg/8ZA7krb4Kpmuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpEmSCHJL58+V7joZsdVkkCVkhsDeosZwHWXpfY2/34JeQS91+gMBonQrCFyT8uXdV3QXPOxsNT5cCJniONdU02EuuwBuj/73nGhWcrRzHptm6rzjhgbUA1KZDPDiWuzTAvKUjenW18q5DycaIIJMpwEGcY1263Vn1qGtq0VbL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so2781862b3a.3
        for <linux-block@vger.kernel.org>; Mon, 04 May 2026 03:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777890485; x=1778495285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36PFWv+dxWmp+SudS0+HKGu6RNXmbG2x8E/T6lDWSiQ=;
        b=kjTyPptljZ5NIOFwdjvp7GivusPZzT5BbanJZVZ25lYkRFFxepcJIi0T/gPKTkmmpA
         mpwMzYG0XfB4vMND2ZBYBihnrC68w1xs0bLtCyVs407QrlXlkImHMq4pHrF20OtbMJf/
         CP3AOQw9Qj/dwzPbJ5mhjZtbYa2EB5oObUC5gR/HI0HvnKCZRV7iCtxXCuaVbXX0IXHa
         R7+RhVUNVLX6nFtlLBC9Qh/YJ5jnCKYHdOFSFyy57629X2WxrqeO3aS2YEOfCYw2GdV9
         ayHkIR5GaQhGO02CiHULwPXB8CCneb6o7ubK8ODwU8GQ0M5uimKUCwlc5kszq2O9hYyU
         ig4A==
X-Gm-Message-State: AOJu0YyivDTusDnQWe5gKyRQFWOD7MN56Xyf5nD/kIwH3SYC6B/Oeakh
	AzAMQzvQV1W7a3U8zYny5nx+rzaeCYfKSgyqZ4VsjlkKQQj2+XKa8a5w
X-Gm-Gg: AeBDiesGDEm/xKCIEydlzJqnvHdVfiAZe68YgEgtSjiz7IJlxoPO8aWIilFi4KfvVBB
	xxAsQDI8HfqiWUpJPO6jMiawNscyQfda6xqjPk/vFGu1EEWNUD3dkxj8/ZayZKGdC2m7AoJFZBC
	s8gnlSq6XuWw4ZALX/FcN8dTtztnf/QrDg6YM6EowfGvWF1l3qMb0f3Z2LH8z0CX35wlSmfrL1F
	V0pbAIjWlFfboIgFMGMXjRtbIe4OlUDEhpAamsR92lDM2R5iv/U75ne8sxcxJpqWPVE7Qugp7oo
	HJT62juDDTudKZUGUZukwyAld6Hk43vlxnvccaW1CQga2nqLaGqLykdRrjcfcOuypNF6OATi5ZR
	3CPpLuUMXK3KFBXJtwfLQfq/Kdlg7oshkxfIoOWjXMh8AQ25Gx6yPsrT0M8x43s+zH2tx0XqIMZ
	9do164GfYKpW1C40sJMyD+jrydOoSBMfcBr0quhR78yNlXs6Smp8u/yySsPsyfk7DBOeMo
X-Received: by 2002:a05:6a00:aa8c:b0:82f:623f:e5b3 with SMTP id d2e1a72fcca58-8352d2b58d9mr9304507b3a.34.1777890484980;
        Mon, 04 May 2026 03:28:04 -0700 (PDT)
Received: from [10.68.32.41] (bba-86-97-226-202.alshamil.net.ae. [86.97.226.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158a26d3sm11222616b3a.19.2026.05.04.03.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 03:28:04 -0700 (PDT)
Message-ID: <05c7b472-6335-49f8-8c2c-73737b300f1f@linux.com>
Date: Mon, 4 May 2026 14:27:52 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: select FDC before arming timeout work
To: Cen Zhang <zzzccc427@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com
References: <20260504032853.316099-1-zzzccc427@gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20260504032853.316099-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, 

thank you for the patch.

On 04/05/2026 07:28, Cen Zhang wrote:
> floppy_shutdown() uses current_fdc to choose which controller state
> to mark for reset when fd_timeout expires. lock_fdc() currently arms
> that timeout before set_fdc() has selected the drive/FDC and updated
> current_drive/current_fdc.
> 
> drive_params[drive].timeout is user configurable, so the timeout
> can be immediate. Even with a non-zero timeout, a delayed caller can
> leave the timeout work running while set_fdc() is still testing
> fdc_state[fdc].rawcmd and updating the adjacent reset bitfield. The
> timeout can then use stale selected-controller state or race the reset
> bitfield update.
> 
> Move the timeout arm after set_fdc() in lock_fdc(), and keep the
> same ordering for the direct floppy_queue_rq() path. This ensures
> fd_timeout cannot run until the selected-controller state describes
> the operation being timed.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Reviewed-by: Denis Efremov (Oracle) <efremov@linux.com>

> ---
>  drivers/block/floppy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 92e446a64371..f9b924a2f276 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -894,8 +894,8 @@ static int lock_fdc(int drive)
>  
>  	command_status = FD_COMMAND_NONE;
>  
> -	reschedule_timeout(drive, "lock fdc");
>  	set_fdc(drive);
> +	reschedule_timeout(drive, "lock fdc");
>  	return 0;
>  }
>  
> @@ -2874,8 +2874,8 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	spin_unlock_irq(&floppy_lock);
>  
>  	command_status = FD_COMMAND_NONE;
> -	__reschedule_timeout(MAXTIMEOUT, "fd_request");
>  	set_fdc(0);
> +	__reschedule_timeout(MAXTIMEOUT, "fd_request");
>  	process_fd_request();
>  	is_alive(__func__, "");
>  	return BLK_STS_OK;

Thanks,
Denis
