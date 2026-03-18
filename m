Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527A3DA7F8
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847486; cv=none; b=Pj3c2jPmrWsfqamVhsjKHu/Rs1Eu/RIK+4Vf+5cyvORNdVttgd+byyqsV4gurebu51t92NMG0/xvyiWPQ8ejIEWtGxxisw+9it6ROIsdXUM22gDQfSsrPxtOskw9lmgKKwSS5hNnbu1D4hp6LeP8M2REoOooyhZ/qEyhEs/k4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847486; c=relaxed/simple;
	bh=c/DCmR6L+58F9B58bTD30uRYZyniFjE8iAFlTLFoSio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbJuc1GtqAXeaQpkkVnUPPD25egV6TF2gwauYVY3mfLnldLgDZ4cIBTkDQ8a1IdxWj0tJ0ZCnjhJJ7ZxAd9Pyc4CNh/Y2MLpipNiGRL/vppTyW92DpEUyXbZuk8RvG5Vz6j5vB6tuzxEygoFd366O6P6SlHbBe5wjmPSc16hLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=TZgi7HuA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="TZgi7HuA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso59612295e9.2
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1773847481; x=1774452281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gyu5ICoUlpKJMIvNRjsizKDezce3zOQx/9IXKSYvK4Y=;
        b=TZgi7HuAyE3r+ISt53aKT1EuvdfNOIoImZQ6djnbUwi6zU5RTZpUblVxnxjBB5Cjbg
         wKAZwCGV06M8q5bPnzBECgARdgYMH85U83BpFwR7dQR0izZ186l39NxiDRejRQ3NXYRv
         Fubt4yASZylmUTfoBZw29f9x8n2lmgpUo0VE/hqNcjUAAhlTQf6KkdDRpqozI6oKrYBz
         CiNoR+DZiGGNM6VFA7V5vPBNSrF4iK6iTD3xuQA/80u+2t6AQN+G+OYCRhywTKnkevBN
         8veKkZPs5ixkDHkET95TLCatxFVXIjVBdDVKKS+DPVZBdSalqBeqh5N5/1lxNEYUZv1i
         w20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847481; x=1774452281;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gyu5ICoUlpKJMIvNRjsizKDezce3zOQx/9IXKSYvK4Y=;
        b=HIRdJczThQhYiIlSeAWpRET+AjZtUR+13z3K0xXkn1mbCGaS2RV6JmIGZe5PK0jsIe
         N2WADu5kw6WI+yOatYHmuOUehQV4h5CtfQr9vjb/a33+5uxyEPFp32YVCzeSknZLjejP
         5a7O5xWcwAPlC5KLvb+5FPTr3N5YIQ5K4TM0C5tweISM4K7gvqOrJjHAQp3ra5HXfPSR
         aZgblmdswjqxBwdAHsnasVB8TPM4DtC61WcuTM1cdQHnH66jA9HSI8AScatWlQgm7LBV
         dPKswjh/mqaZrpAftbEi0duA+LotUNTJeIaz4BqkMFkf3EFx4Clc4gkDJBecixT9nixN
         2l3g==
X-Forwarded-Encrypted: i=1; AJvYcCUXB88OKeAGbaDTN0fzsaWXXCfV0ZgX9R/0Hf4bY7MaTpKW4SKmD2GuqlDWoCF+C9xZ6oDvQ1Xg3v1dbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywDN35X1irjklvHh4jfu5aM+k+BUliqQ/0/zZ3MfkWBLgH/V08
	vju5U920RA6Dnz4KLDHhXhY8cPf5k7QqHeiph5ODsvbm1+SOgJyVT7BtX3zhXvyHXwM=
X-Gm-Gg: ATEYQzw4T9FC+8geO3jgVDhInot2L4kh1Yewtbrec4iQJw//V1K4jW5s0hll+W05M1N
	8u+/3ZV6dOoxg2wm3/ynrsaV6kPaR5ftxOr8/KSopRvQEEl/1EVMvnVhxQS9fwE3ciloLy9HejA
	E7dYySQfxonNIB1fDrdAbOmJPR92ixRBLcRR6dH4Ju52t/Cc91PH5OcELi4tlGpjTCiIyp/dblK
	P2R4d/4xw5SuEBE1fR5r1UJ1C/Dm9LiMjPt2PmBxTkMymbBmIaVR50aClDYTr2c3jnhCzWdG2Nl
	HaYuaiWVStr9b9Wn0JtM3ggPi7EWrTU+2qxbNr89QroGtBTsd2IT8hsSUA4GM61Qmtq8lgeRAh2
	hHWmDq2IlvlY0nZYfQ5gsnizVoAdMkTaGw2CZbigjB1xQXt+lKMubTdQ9JuGpJ13v3LQr3ZgR/3
	7oF7ydm47aWSU0rRwy7wcZh5+aGLkIHjNIMEUZ7Gugm5qGirTFvdO2yGGTxx4OhL5AJEHUaXdYx
	GhgCCMkv2xgC+E=
X-Received: by 2002:a05:600c:3b28:b0:485:3aa1:a7f1 with SMTP id 5b1f17b1804b1-486f441bc51mr65620445e9.7.1773847481385;
        Wed, 18 Mar 2026 08:24:41 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eae3396sm144310575e9.9.2026.03.18.08.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 08:24:40 -0700 (PDT)
Message-ID: <eeb73048-d5ae-4fbd-9920-1395a3ca51eb@linbit.com>
Date: Wed, 18 Mar 2026 16:24:39 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drbd: fix rdma dependency
To: Arnd Bergmann <arnd@kernel.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@google.com>,
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260318104858.1868731-1-arnd@kernel.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260318104858.1868731-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Am 18.03.26 um 11:48 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new rdma transport module uses a trick to only build support
> if infiniband/rdma is enabled. This seems to be done the wrong way
> around, as it gets built if RDMA is in a loadable module, but not
> if it's built-in.
> 
> However, this fails in configurations that have infiniband support
> in a loadable module but drbd built-in:
> 
> ERROR: modpost: "rdma_bind_addr" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_listen" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_destroy_id" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_destroy_qp" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_disconnect" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "__rdma_create_kernel_id" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_resolve_route" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_reject" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_accept" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_create_qp" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> 
> Address this by moving the logic from Makefile into Kconfig and
> describing the two conditions in which rdma transport can be used
> in drbd.
> 
> Fixes: 038cb6e644e4 ("drbd: add RDMA transport implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/drbd/Kconfig  | 5 +++++
>  drivers/block/drbd/Makefile | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
> index 377f0d040031..29ec6ed84251 100644
> --- a/drivers/block/drbd/Kconfig
> +++ b/drivers/block/drbd/Kconfig
> @@ -39,6 +39,11 @@ config BLK_DEV_DRBD
>  
>  	  If unsure, say N.
>  
> +config DRBD_TRANSPORT_RDMA
> +	tristate
> +	depends on RDMA=y || (BLK_DEV_DRBD=RDMA)
> +	default BLK_DEV_DRBD
> +
>  config DRBD_FAULT_INJECTION
>  	bool "DRBD fault injection"
>  	depends on BLK_DEV_DRBD
> diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
> index 99a1cfeed423..caf888235d53 100644
> --- a/drivers/block/drbd/Makefile
> +++ b/drivers/block/drbd/Makefile
> @@ -13,4 +13,4 @@ obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
>  
>  obj-$(CONFIG_BLK_DEV_DRBD)     += drbd_transport_tcp.o
>  obj-$(CONFIG_BLK_DEV_DRBD)     += drbd_transport_lb-tcp.o
> -obj-$(if $(CONFIG_BLK_DEV_DRBD),$(if $(CONFIG_INFINIBAND),m)) += drbd_transport_rdma.o
> +obj-$(CONFIG_DRBD_TRANSPORT_RDMA) += drbd_transport_rdma.o

Seems like we raced here, I already (supposedly?) fixed this on the
drbd-next branch.

My fix is this Kconfig:

config BLK_DEV_DRBD_RDMA
	tristate "DRBD RDMA transport"
	depends on BLK_DEV_DRBD && INFINIBAND_ADDR_TRANS
	help

	  RDMA transport support for DRBD. This enables DRBD replication
	  over RDMA-capable networks for lower latency and higher throughput.

	  If unsure, say N.

And then just this in the Makefile:

obj-$(CONFIG_BLK_DEV_DRBD_RDMA) += drbd_transport_rdma.o

That should be equivalent, right?

Thanks,
Christoph

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

