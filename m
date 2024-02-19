Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF7208A9
	for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324777; cv=none; b=MTwdaLuM2E+PmgSy8blssWvaAH01z++/YZwHhrFiGDjKf9861oGqyqn+AvFinmhYh/p0MUTb4RtP/8CV3fLQmYJdWFCGJdw3HOsMh04SQ7ILrOT6MdZILI/+u74Xd1UEVks80tYEkKLtkVNrsuQHPy3hztPGTVCksbkzijGZTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324777; c=relaxed/simple;
	bh=rlbLrmOKxSADvMVmNN26s6K24KfNQe9dU+hIdXvqXvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKsOPevNEqmjpDVMDsyiAU1GtQxk2p0/o+ZRE2CKh+4n4Ix971caMmqIXCQ5cynVHCTLgtRTWKzoRtkq8OGXcbuIoQ1/7wFbpZF4KtZBzMhoF/aBpgkB/QSdEXv3vwTp8xKJn3WdMHqughdWI9OwSMUUufNp3X003qhrb2SuLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d1094b5568so52582711fa.1
        for <linux-block@vger.kernel.org>; Sun, 18 Feb 2024 22:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708324773; x=1708929573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqGRU2bFJJp4v7MLaxeF/Bo/6SjsMcHUq7rEHGf7wvE=;
        b=NngUlTRMCzhx0QoIsiSVUcDAEdVPpxZGfhRLrNUgRntTWBJ0bt0aky6XQb7QAl/HKv
         BzY/Xv5tglulDomMc3GzaZxZqeq90CdcrYLI/IkytR4iTUyhKyPVJIe/aQCfSR440Ana
         PvyjcKlh9da5z2SG99TM0305aup8m+zFx4ujNju1vPcfDzL/dgUJe8m8ym9XMD68Q7cU
         FhuTDgGNrYV3eyMBW2NIDeUvDypCBKFjGtOMfXwRozc0hNP5D38+O0BlbXmXDeUsuvsE
         ZHpGG/TiGJ9y7cD6Gpa+oEO10sCCmEZYUh/QBcsqmNMAQudzj0jUFeC5cbkmy8NksXca
         Qr0Q==
X-Gm-Message-State: AOJu0YwtkSwM7j3JbZfemIPWUm1nG+T4r0Ztlw7JiXyCvLCuD2nO+vbI
	oR5Pno7FdjeJsfgchRfhTERAQuodETvo/5IUlcbUUKNJj6GsQW7s
X-Google-Smtp-Source: AGHT+IEahM9GH4ASdIp5MMO2Tj6O5XvhBsd3RCYMA/SXxGetA5/cr02ncjSA6k6bhtL89GCMxL8xPw==
X-Received: by 2002:a2e:9952:0:b0:2d1:cf4:952a with SMTP id r18-20020a2e9952000000b002d10cf4952amr7415116ljj.33.1708324773131;
        Sun, 18 Feb 2024 22:39:33 -0800 (PST)
Received: from [192.168.70.102] ([94.202.230.4])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e9796000000b002d22311d8ddsm1015750lji.0.2024.02.18.22.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 22:39:32 -0800 (PST)
Message-ID: <5008baa2-7cb6-4aab-9c7a-d78f361d5c44@linux.com>
Date: Mon, 19 Feb 2024 10:39:28 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH 03/17] floppy: pass queue_limits to blk_mq_alloc_disk
Content-Language: en-US, ru-RU
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20240215070300.2200308-1-hch@lst.de>
 <20240215070300.2200308-4-hch@lst.de>
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20240215070300.2200308-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 2/15/24 11:02, Christoph Hellwig wrote:
> Pass the few limits floppy imposes directly to blk_mq_alloc_disk instead
> of setting them one at a time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/floppy.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Denis Efremov <efremov@linux.com>

> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 582cf50c6bf6b8..1b399ec8c07d1e 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4516,13 +4516,15 @@ static bool floppy_available(int drive)
>  
>  static int floppy_alloc_disk(unsigned int drive, unsigned int type)
>  {
> +	struct queue_limits lim = {
> +		.max_hw_sectors = 64,
> +	};
>  	struct gendisk *disk;
>  
> -	disk = blk_mq_alloc_disk(&tag_sets[drive], NULL, NULL);
> +	disk = blk_mq_alloc_disk(&tag_sets[drive], &lim, NULL);
>  	if (IS_ERR(disk))
>  		return PTR_ERR(disk);
>  
> -	blk_queue_max_hw_sectors(disk->queue, 64);
>  	disk->major = FLOPPY_MAJOR;
>  	disk->first_minor = TOMINOR(drive) | (type << 2);
>  	disk->minors = 1;
