Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271188;
	b=JRlZ81qFjZyCNPiRBHr57eO+9WLBVPx1gI15FKAjlQTJHzzQ0j2bOIxvRbxBR6nnQuQK
	 lcKuKljbyV3f8ewrXdSQbpmHs4MovBpNDZlaGtObDFJ/os6W38MNqC4prSxeTLqhcXa4V
	 C1NiSiSzXCl+COmbpgi4o2fhXmWa0bPF+KQNskSnZyPyRj8P8AZiTtauL+f+ac071L82V
	 NPYH7DpNtkb6ckl0ialjGV7Sh6+t3vXQU+fQvDlhtvO7OVSnqpNEjHh6EM/mPRyZscfLv
	 oSMPOoqR3FQ78KOX+Xs5F3zXskEH9FKGRBr63TrGUOyYXQ1MON2c3zJt3IjI2MarbBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=z0T3u86hkedH3eaRgGYwzQ+GOmGeNII7gwe8E9j9n9o=;
	b=lZt048S5AWpOuXTXq6vojXY2a0sWeRjBqG+2DyucEFvIFv/IqowODTn3aVPEus883+3z
	 J22ZPcyZQnt+WaDTKSovmyUT1Wvn7cNkEPFBPOIq2E3flgkDXqbXoTqLtnowwgQin/O75
	 xj+KBLhpSq0Z+YlwZAlndzZoZs2xOCXKfCv+5YEAgQCzIYcRzVk2OBtmGDlbiOFqBK0zO
	 xmWaOVLYheUCxl0Ld6rm+8cjDCFQV4ipqIOMXnDLz6ctNdItzBAZ8mtF3vjMOQX/6Cr+T
	 KCUdaJ9jlVOZa+EHxiSr3lgBwsdKXopakoLgPBsIbIlJN7945JBQh/TAzy9VTwCBwGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gEWQuLGs;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFFC606A32A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FFFC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gEWQuLGs
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df4f540ebso970256f8f.3
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271186; x=1793875986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0T3u86hkedH3eaRgGYwzQ+GOmGeNII7gwe8E9j9n9o=;
        b=gEWQuLGsb2TWmX0i/zb98QqXRohpXAUBYFR15k51NTn882zLijJLOBqff8ZfnuUmyt
         6RfN7+niFBOK+6GRKUBK/NQT/i9XIRCKwnU8hfjqfyQQ/MiFetoiPQYssIAQt9sF1tFd
         LX02L9zCnUP+FnGYH3oCTfUMCTASFM4uXCwKSbuqeAfeA8yt1jJPqyGLcozcFXrk82hf
         86jjryjNii4aQuls1B80pjo+fV1Z7k9ENiktohfS+inmtjbGv7lUxX/5v6jVKBjFGycZ
         fQL24LEvjAxaLKAy1GJ4d3OKLkXUfZXmrKaPpK9M0BqiMPdIyyTI2mqFlnHk+arUVi6n
         1i6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271186; x=1793875986;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0T3u86hkedH3eaRgGYwzQ+GOmGeNII7gwe8E9j9n9o=;
        b=zDnJrdyhpwnrTc+Jx/7pn6ubyiCxAkG7PydrtPiSd1sbOARgvifgHUWSzhIrVzY/Fb
         UWEHkx2OZzXcnz8azop1iaM93ycIckrqwfhMARzmY/ozY9FXSDgYaPkJ27euAV0brQGX
         tLLU14ZrprMP/Ja6bC9eg7QV4aNvJPojO96T1Vpok+jeUGAOf4oJBQyKopnskCh3jTqZ
         Ctx8tlcbKNqVylxwd460kbHub93GdWbIX1/GuRS7F/NenzEZ41wXs0DCWaw8fC99BTsE
         +2wZJGFSu9M2EvS86TYbbgEj0QtkwsL5f9i4uDBypoHOJqsx+F5t85PWio+qYiyiYO2l
         35+g==
X-Forwarded-Encrypted: i=1; AKwUvBw+gjhtMGK2K8L9z1ETqOLPigoN3yrJ1O9+tpKwnT8MQG2SvV6/X69NktqGkZQVfniyb9PFNp+JAUZrdA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ5zWhhbGCDpCbUjJSvoOqCcEQKwF0yKYguE4NT7DbQ9dOwv84
	3mPCHSxip456xn/O/iilMvCNHz4UDGmQwhc1W8YuyULHmSN/vZZfh4SV
X-Gm-Gg: AYBFou09MWycJW5lS5eGSf5CxuU9HNYTpshREm2as78wQuvuVgqTet1jXUghUS5pROu
	RSs7mQQA7RdmwYjknOerlmeo1cymXWF41qR3CG6l5gvipOkdQISRBm4C6nhjWN2sdlfdyx5PWFX
	2qPmllnUxncgWq8uZ0pszOJ9by9jpulIUIE18RsipOf044JGWVk4xPaWeIXCpw5+ivs2/tKvf6j
	rsV5k4hqOEls9UJ780C1S+97AYotn+jPW2bJtxH1UJMPh0D4PNZRcTaPidx4FKL0FPBk0UNKsGc
	oyWvXo+g5V2i3G8CeKSXDCq/4zn69nrLoE5xxqdUSkfIhCXbBMxg6u1YhDcQn0n3SX7gHSaGzME
	nqBoGPDX0RgqwIRz+80GkY/LVV8EgYMmG9qnLXFxmvbhZobkdzCUAPcTT/J5AE5gDkEVHIOXZ22
	usbsoDj4s8Y9RS8E7Do/+vI+CafjttAPHaV+p0q3LqaNBnj2/8PkmCerwDBk/qqo7XzWGSmlLBm
	iVAcby33v9Fj3IcRLMd3bpBm4d6PI6b0j2UDrZ73VKo/QJHRycK3/XBAhmk0XvnWtsKH0VXt1YS
	ehMri0iNLYblxIrCObTy4s86vBEvpI6nF4JtTh9kX6s1yTTCJX1b8zOnNDb1M8YcG+o8Rjy/DSe
	JIREW+L9jESLpzm8Dx7LiQzalE/GL+U1SAFz8Dl+uTNFO/45NFHUzuCSPgVH68lfHfUX6Iyvu0V
	yvQSnB3vdhVOa8sFgvBquoVFQ=
X-Received: by 2002:a5d:5f52:0:b0:48c:69bd:e971 with SMTP id ffacd0b85a97d-48e5d2e6d40mr12705105f8f.16.1793271186318;
        Thu, 29 Oct 2026 03:53:06 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm31889960f8f.7.2026.10.29.03.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:53:05 -0700 (PDT)
Message-ID: <7fb73a55-c7f8-45bd-b12d-e46f1efcbe67@gmail.com>
Date: Thu, 29 Oct 2026 10:53:07 +0000
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
Subject: Re: [PATCH v2 5/5] nvme: support dma-buf registered buffers for
 passthrough
To: Anuj Gupta <anuj1072538@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 mkp@kernel.org, bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
 <20261022144501.2478417-6-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261022144501.2478417-6-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 15:44, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Allow registering a dma-buf against an NVMe namespace character device
> and using it as the data buffer of fixed uring_cmd passthrough I/O.
> Complete through io_uring_cmd_hw_done(), so the dma-buf map is released
> at hardware completion.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   drivers/nvme/host/core.c  | 16 ++++++++++++++++
>   drivers/nvme/host/ioctl.c |  5 +++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d81462e864a4..6157ff839929 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -8,6 +8,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/blk-mq.h>
>   #include <linux/blk-integrity.h>
> +#include <linux/dma-buf-io.h>
>   #include <linux/compat.h>
>   #include <linux/delay.h>
>   #include <linux/errno.h>
> @@ -3982,6 +3983,20 @@ static int nvme_ns_chr_release(struct inode *inode, struct file *file)
>   	return 0;
>   }
>   
> +static int nvme_ns_chr_init_dma_buf_io_ctx(struct file *file,
> +					   struct dma_buf_io_ctx *ctx)
> +{
> +	struct nvme_ns *ns =
> +		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
> +	struct nvme_ctrl *ctrl = ns->ctrl;
> +
> +	if (ctx->dmabuf->size > UINT_MAX)
> +		return -EINVAL;
> +	if (!ctrl->ops->init_dma_buf_io_ctx)
> +		return -EINVAL;

Let's return -EOPNOTSUPP for consistency, with that

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

