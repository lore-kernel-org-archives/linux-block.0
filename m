Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951363C17
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767189636; cv=none; b=XZ2C2lADXTIy7YY0LMp9U34Xjdanc4k5CsP/PzR+xxETtALn1tU56fl4aYl1VNjT9cu8+T1G/BafEXccEpbAqgiCIJK/wIGHMO1zoSn2UhcwhJIKnujTK8umEgj9PH15k2ntFJw4FFtzd3MFw1sGyRo0PYSsXoQVy9SwQlewsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767189636; c=relaxed/simple;
	bh=BOt80TWAlzsyCinqdLVYmsvJ386QzQRR83aL2v1in5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zfg92HrvjwC5Phoq0tHenKXdq5QzOpUlntlS5SB7lQ15dYckj494tU4oBTSqgBMnq0BpyoNrRIdfcmMYIUqNtFLtvHCmcsbU/ycSvr7/zLh9nq+Ff2fLHGbGd69GbMKOz1t45jpCeDFgWjw+LvRToqBWemA1z8H5BIgK+4JWWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=afFG5LWQ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="afFG5LWQ"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3f551ad50d1so3845603fac.0
        for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767189632; x=1767794432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y23pRxBQqrSDyo7LNxDDUtSMxRfvlMn24l6u+kU+XH8=;
        b=afFG5LWQTsBuDsbhIWKQbtPgIdG0Xd3kr5T842A7JbAAjziwNuCSWyW3salvbnI4Up
         0h5s1fstraMbe37Q+/4U3WrzBW/J2ju2R3Q9LqwqEAekyJDWK1181CpuC6ogNjKbRBnY
         cE/dMkL4YEt0d1n3SGvOM301kpkGauBHSYoMNtdNo7YvyJelT8x241y3YJO037bU+tfm
         X9yw3g4RIiFc/KO+yJlUV5Eig3aEvyiDAaillvSleUXTsjMhaQZzTmm9mMERrW3oiL36
         X7WGInOTJBU7lojRJ4M7stCm7isy0gVynR1Ah2l8vC+JAwGbITJG9D00BP4aaFKZcxSy
         JYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767189632; x=1767794432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y23pRxBQqrSDyo7LNxDDUtSMxRfvlMn24l6u+kU+XH8=;
        b=dbshK5tXiNKFL/EWF91a0rxXXWRJhsJa2oLF6ceSnFxVHfohqz6lANoQ+vBVw594Mm
         gbFeW3nKc3KMwmWfsul32HgfWWwCKmfYXleDkTQqA8McsN68M23uD2+UFLrJEbjIfncS
         TRvro5nnIAoUQaZoFf306InEoeWo/FkB16EPQyiZ9YKXf2laqCP3sBTManoWwuywjUqa
         2jalC+jbkRTqJ4JPyIGydoGdE8HFSaA3hVbmALvTYtLD1IVGNyRy/60Bfsv0Vr2MICnr
         HlvVrECZwQ03m7svoRt34eAsekaklq4Z2crwNtaUW90IJYUTyTCjfBqfNFuYkyFrBcEL
         k3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXgQzTlc2vBtZx0sTxBmHs1vO+0XE71oUIQ6wNp8OlhlNbx4Ny8UatoV1i/qf2JF7nAEy542SMq05EFvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfh1umdlw2emDjxI0n3XG66gzMCfWc12GF3b3R8CVGsZjZ78jn
	CVwe6vIMNeGtGEicl2Qttv9dzWaSRO1irdEsRu0SYiVuhdVM6aM9P7WAYJm2gam12+8=
X-Gm-Gg: AY/fxX4cGEFTkjvGG/3hgUZy8/MX7oD5xyrJ+UiSs/vUVRg9fnuIa7RCACrQNCWLQYx
	SLaoV3H8jUj2P174IqJraW9vtA9SIi5duHTfc04bFABGOFOOleJPvZEVYfYLVGIYbR0L6ZONsco
	daBQb47fyOT9zyYax1sYkB24TX3Ts932aLfUs56wC0gh+QVquxQAhpSIVS8XbAwP7CidkrfXjaz
	cHfUweU+zVyNA/Uw8WX291+ySm2Q00iqaYKuT0dNxAasNrxgewk6Eg1+Un43hhkj/d/us+2VCkX
	rw/eemnm57N5tV8fY0IfGRrFMKRQ66MbQg595K+fndV+hCdq2u6D9Itr/kPiQaMkUiCJWPfRVjL
	MASVRKSNZarckQwiHQkUhbeFLawXrAQ347DJbRQD3gAckrPOuP4n1zik/HsWVGeO3b3UZMASfr4
	zXZlrck7sQ
X-Google-Smtp-Source: AGHT+IEJTWeeJmVjUHuR4zws5/FZzesd9X+daLWNvN0vX+BxWuJTQySB9pISvfKxN4xR8NfdeyZKCQ==
X-Received: by 2002:a05:6820:80f:b0:659:9a49:8e53 with SMTP id 006d021491bc7-65d0ea15d0amr15634024eaf.35.1767189632104;
        Wed, 31 Dec 2025 06:00:32 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaa8d4521sm22162034fac.4.2025.12.31.06.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 06:00:31 -0800 (PST)
Message-ID: <b2e5e9cd-21ae-48fa-ae61-f23f61da8a63@kernel.dk>
Date: Wed, 31 Dec 2025 07:00:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.19-20251230
To: Yu Kuai <yukuai@fnnas.com>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org
Cc: linan122@huawei.com, dannyshih@synology.com, islituo@gmail.com
References: <20251231091740.217388-1-yukuai@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251231091740.217388-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/25 2:17 AM, Yu Kuai wrote:
> Hi Jens,
> 
> Please consider pulling the following changes into your block-6.19 branch.
> 
> This pull request contains:
> 
> - Fix null-pointer dereference in raid5 sysfs group_thread_cnt store
>   (Tuo Li)
> - Fix possible mempool corruption during raid1 raid_disks update via
>   sysfs (FengWei Shih)
> - Fix logical_block_size configuration being overwritten during
>   super_1_validate() (Li Nan)
> - Fix forward incompatibility with configurable logical block size:
>   arrays assembled on new kernels could not be assembled on kernels
>   <=6.18 due to non-zero reserved pad rejection (Li Nan)
> - Fix static checker warning about iterator not incremented (Li Nan)

Pulled, thanks.

-- 
Jens Axboe

