Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9625484B
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548898; cv=none; b=U09lOkHx9i4NPa1Rw61abb50ppE+vMl8iN/pXRlvCs+JlZuooeLIzVps9t9jKlTXuhik6pes5VA9l8QJG1AJGxh1jRSFjNfeOwEsFdkRGiudljXQMM2z4k3ppFwMVlC8cgcmSqY/+F4FSwMT1lni79syFKf1enlc60afQa8VARE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548898; c=relaxed/simple;
	bh=4x4n3mO6D+93cLd6q6vTkflWI6nd583PfYO7dCX4kr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U/oD2LvCbz96SdIqMQTDyzyaTRm2GY0m1es8xVKN/ICpwA81CgcY6Qt1B9KFa1j8OO0rF8Sc0MUAKtOol2PnxTRrCm+icXL3XnFM6AVhOxUxcUpOt1mx36MRIb/mCEPkSxV/oSbS4ASfm8dDCcJqz0QwD+eLIykFv9i+l+mfU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgU4QRgo; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgU4QRgo"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3885553b3a.1
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758548895; x=1759153695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LOnKTSulzKsRf/xM8Nl08MrqLXYoF+P+XOcW++vxAss=;
        b=JgU4QRgoCrQjg8jRXrQf98F/LrNC9dHXx4jPZA/qnp73oqPhyQjpW1402lzPwtMLx5
         5BjXOK2XSQURVf0kVixVBWNxCZeegzDpcO+U31OhysX+0XQgQpeNSkFjd7VECbIYvaqz
         vojFd5EFjZpYcof7Y+nUi2EXEXXz8zmf+TxHvjdg9w2nB3QkebyDpbZuP6zes8pIS9aw
         lstrwlaJZYqlihzXELBmy1l/B/8UgHazKwLPPsxJeUuwrVfy1F9zMEJHvbBVaQVBQEtU
         ERQTcYAbdfakdF+kiEh3Z1ogXkJCDxhyMDDvh5tJiu8ZffmiPqDQs4KU6tqCEzMnqp6/
         B45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548895; x=1759153695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOnKTSulzKsRf/xM8Nl08MrqLXYoF+P+XOcW++vxAss=;
        b=qgedP4DVlkQVekYZvgLgjnXv0Itzdn+7PkFdaOZQdY195sVVhRXdSvGStslJ5OLG3z
         tE8+3zeTtVkswakasG3F+/lVte/eka2eQUQu131mAnuG1VvX2FwtJGRxwRk/ae8INIhZ
         3pJIlksZh46bSyzZkdPDuVcRpi6dosjs0D3jXfhgfmXCwg2xdlZGlDi88fMaw7J0JAWH
         5BrsTT6+iTjnMjAGOe64RcADlGbFnZK1gd8796dBT9LqJ1KnORQV6HdoTLxAQ6yP8vvC
         uQsQZjmXd2g8eLOn56DBHgtgy7MUKk0+mmu7hpD6JV4z4AU+bh0d+Alj86FGhvxIhO7M
         0QLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWILYJlBdToEwqszm8s5rGXo3ve5pGpTTQQ5FboGdlmikl/K6lGSJItLBrz6UlB02ecA0MU6uLQ1j1VUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn14Qw+CtsU1ztiN8bqBRxm4Ih5hCskLljzByKfbyRDBaOESbI
	hBRsKiI8i2H0vgA9c4dJ5zShcmsimiFZ85OMUUPaskJYFEK2dMXrdkhhu+AGP65c
X-Gm-Gg: ASbGnct70KYQ2WCt+wQv1YUu1Pq4t99A4l90JESxxB7kfIsFE01XJafCy7VPTt3eISh
	rfNGyb5afaO3i1pwPq6VG36XC1qj39s8fh+Rtq27HcSIhjp3dLS00/5vd+ztlDAvsgQjbVJOSLg
	0MZn9w+rK+FhRa/54imL9hVpE4QoDidhvJIHl2EWhvr3vsq8d1KBYmtLKaPZaKxOAlDcaUFMOdW
	dz51tkYFS/oWvtUM3wd8nvebz5GGAfKmte5qJGNYPlDRPMOcjFpuQ1+QzTgeRzZRKgwVPZ4RyDr
	IzWLz7hKou8sh+7CRzXkft/+Y90uTDr1aL8mWUL7Hh/zg6vdDCrfWzFZFYOFSeTtk64uDhejyFm
	H2snargnnXkFlQ62Qf0+uLMJVV52qJTfqznHZzgvwhGWXwYRGBIPA9mj/pZVr+LRP3I3xG1pRr2
	1RH4sDfyNWINFme9oq78Krj2s/K91zO/6jZ5oiK/GyZnxeOfCl8dJwTA==
X-Google-Smtp-Source: AGHT+IE5DZJyw3CURO6GslMf/BGBxP3QRRbYdn4w1VShrogFVumFTWHKmSBd7VtrggPz1eOTupPXcA==
X-Received: by 2002:a05:6a00:1a0a:b0:77f:43e6:ce65 with SMTP id d2e1a72fcca58-77f43e6d795mr2070302b3a.0.1758548894785;
        Mon, 22 Sep 2025 06:48:14 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c27:f451:34c1:9461:5e32:1d72? ([2401:4900:1c27:f451:34c1:9461:5e32:1d72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f335995cbsm3851942b3a.63.2025.09.22.06.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:48:13 -0700 (PDT)
Message-ID: <898a2fff-54a0-461b-84b9-07c08e6d1f9e@gmail.com>
Date: Mon, 22 Sep 2025 19:18:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix EOD return for device with nr_sectors == 0
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <855243b5-1226-47d5-9ca8-c023209f5ee7@kernel.dk>
Content-Language: en-US
From: Sahil Chandna <chandna.linuxkernel@gmail.com>
In-Reply-To: <855243b5-1226-47d5-9ca8-c023209f5ee7@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/25 5:28 PM, Jens Axboe wrote:
> A recent commit skipped dumping the usual "attempt to access beyond end
> of device" message if the device size is 0 sectors, as that's a common
> pattern for devices that have been hot removed. But while it stopped
> that message, it also prevented returning -EIO for that condition.
> Reinstate the -EIO return, while retaining the quiet operation for
> triggering EOD for a device with 0 sectors.
> 
> Reported-by: syzbot+4b12286339fe4c2700c1@syzkaller.appspotmail.com
> Reported-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
> Fixes: d0a2b527d8c3 ("block: tone down bio_check_eod")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4201504158a1..a27185cd8ede 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -557,9 +557,11 @@ static inline int bio_check_eod(struct bio *bio)
>   	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
>   	unsigned int nr_sectors = bio_sectors(bio);
>   
> -	if (nr_sectors && maxsector &&
> +	if (nr_sectors &&
>   	    (nr_sectors > maxsector ||
>   	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
> +		if (!maxsector)
> +			return -EIO;
>   		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
>   				    "%pg: rw=%d, sector=%llu, nr_sectors = %u limit=%llu\n",
>   				    current->comm, bio->bi_bdev, bio->bi_opf,
> 
Hi,
I tested the patch and it *does not* reproduce the original syzkaller 
bug [1].
Tested-by: Sahil Chandna <chandna.linuxkernel@gmail.com>

[1] https://syzkaller.appspot.com./bug?extid=4b12286339fe4c2700c1
