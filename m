Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279679;
	b=Jc7hqYbsWZHMpQQ7Fdh71Ay3iO0IRLSiFduH872bu8c73hIAsHJ79HmX71Xsi1Su6Bt9
	 uIVHCx3jQwGBNFKSwGzG+kzeHCWMAemTvArAvWrtluml9yJuoJbhEe1bpYvmS4jirr+WU
	 h/3nqBJzV8lktB3bPVgqubu/5qJoB5xqZ94esLNTeAUg6sjvCGobW+hJRJ5k0Hm0+YeYp
	 uMUvWcC+tCCCqlrY0RaFBHOTFNTSROhlHjD9bBybgOf/EyKsMKzI6Pi+8MWsIajluWfIf
	 xoCfrhdnicq53cujIhUC/6swGdpvbkfAjqh3jaO1ZdO1hFtbXZpoZ6gPncSWqD0oZ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=B4JNfpIs+7BNA5NHOCKDIWXlXnSir9Ien9Mz5JjF82o=;
	b=xWdJL/QJS2r84CTMfoQBVO4/56k1OlsUK7EOefM5hJ5NalGcWaHli2CORGIMNzimw3V1
	 gRjfyolUfmwrv7SCy8b4EYIFmg0BfQD8xe/lOsYzx+Q2JND2XH5PvnW+iSZ7Ym/VzOk3U
	 b7Px7M5UhgAknDKccvtjjP/iQbRpIRrRSiUtpWle5g37wpx9Jyjz4AShRL29Tb5t6Z9Dk
	 qaRoKgezJEJ/9mHdNtVHinEmCWpj3rI3rTn56fWqHsLxZOqBZ3W70XOll1ysNqIQaUuKM
	 wPZNRzAppv/vUiIYn6LSspbbGCZymreEFPuwLs5YK6NwScA021ycI1xP89gO3/GSx0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bFZzLuQA;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83E606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A83E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bFZzLuQA
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2856450c88.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793279677; x=1793884477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4JNfpIs+7BNA5NHOCKDIWXlXnSir9Ien9Mz5JjF82o=;
        b=bFZzLuQAt2RuSTkFddoyUeYCjg3+iISLlIutNPQlstotzrOkECF0jl6/tGu3QviTsB
         FhSiOvzp2pR9qlmcQs3H7VHonKErYF7tzZpaAALAiMYUC8HvjPd4+fZVuLeaAkK1mWsR
         ZJHiGm3qxPVQCdy5TqmFMFhE05eHN3eAD7iimPiGKalTnu2dH9D80EnPfIlI+lU9DSMu
         C2N7VAOCeC/doDUityVjHmxBfYEGVkkSu6SPFpqCvG8Fj22itvV2UZBgj/K2/hGOpUH8
         4d0AUSdxNMz7L+rCrU7ztn7JkDSHPcTcsQCx8QT6XAw/UzJVubbSDbgem+PTGsKc/kyu
         6MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279677; x=1793884477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4JNfpIs+7BNA5NHOCKDIWXlXnSir9Ien9Mz5JjF82o=;
        b=ZnB3VqH4HeUed9DEzWmpDTSRT9Whu9U6GgtwBMXV0I6AIb4vLMTzwnqzL2o2oLG5q3
         w5uCoKiTEgjZHkI5XeYPWChrTyTyout5ozyQybyUi//aPIOswA1vy0YfRs3CY/YaMnzo
         GGxLnkDVVSW808M6y5i/VLj8re+OkFyDQtdJdoG2co+TiDaBTN+JMk1yQnjV0Xldquge
         ICiA7BsBUYqYH5Na0Fpw2G/7TejvJ+i2wj18bqdN8147Ka2zJqeEQvptzSiFwnHK4h2V
         19RIpcyFjZQuWcetqyDfJOeGaHdTAajwHqe70CM9bhzp1FUdYv5dDBVE9EFc9m4YXM/i
         pK2g==
X-Gm-Message-State: AFq9FYKP6Y/gtfz405Z6LDRBQc/VKLty0+V/MceCG/5j4R25aENFQIln
	fEV0D2X6s9b8IdxOVIrgDiQRl74QGo9W0HtXl/1LDwHkBA4w6ISnUQaf+DhXZ5UbdKRDklFjq77
	i4PcJDT0=
X-Gm-Gg: AYBFou25rXO4eWZxkMELl51TwvwLak8jCVCsUoXbhr9Tti9R10NiPBcE2tDEVJvlIAp
	5KoQIRoTynimTWWDSZylmsNtHazPO5E1yNR+x/MmBFyRua5iuh1hNHQfg/WM4S9JM84eCE+mc28
	u6u+GsiIx/pNm7hiXIHizIRtw8lP3NiXyvuKCQtsE6h8TECGUhwN57GEH8o4f3yZqz6REDMT6MB
	1u7s8WSF0ii/ZdHto/ecquywxHMdsNDMZqDocMnDW0JrCO5jMf+zvGlnQ9FPOBcUhCcAKoQLXOa
	VI7zwpUJl7NGssSJxuB/GEcYSnaXX03ku9ce8T2rEtA6RIz5v9kpBvSoUEIh3V60k1u4ehmt4EJ
	THqzCpdHlrjoUU4+rcuKWRocJTsLPnv2py2qH4C/Q7hKBzSqB7a7IONIMNtJSx1eDvyQsSZvKR9
	mtpNQRBbPAH2wrKM1/DXD/xr3lLLf3Iunc9Rr+2VepJAgDWgCY6Q2DiPgEcKmUv7ZtU01MzjrZ2
	RRv3POrmxtHKpymXEX+Y7L6H9VfZ2RR7zfhqpZ+joqp/1V83tmHGJaiTeos4UAVmlLarxzTo7mA
	LqQAlxExNZKJHs1aesTp8fu5f8hsxc6/kOlPQ09ji5B25DVwwH3eipe+BU6sVmR49ViwdI7yMgZ
	XDc8ddV2YRyD2
X-Received: by 2002:a05:7022:f507:b0:159:aa67:28c1 with SMTP id a92af1059eb24-1a6cc819250mr6866374c88.20.1793279677432;
        Thu, 29 Oct 2026 06:14:37 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75ffac4a1sm14575466c88.20.2026.10.29.06.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 06:14:36 -0700 (PDT)
Message-ID: <867e747a-1901-4006-b232-2312c92e5e7b@kernel.dk>
Date: Thu, 29 Oct 2026 07:14:36 -0600
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
Subject: Re: [PATCH 42/98] block: partitions/mac: compute the sectors in 64
 bits
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-43-axboe@kernel.dk> <auNGGO5_gBUZD95Q@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <auNGGO5_gBUZD95Q@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 7:11 AM, Christoph Hellwig wrote:
> On Wed, Oct 28, 2026 at 10:41:45AM -0600, Jens Axboe wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> start_block and block_count are converted to 512 byte sectors in 32-bit
>> arithmetic, although put_partition() takes a sector_t. With a block size
>> above 512 bytes anything beyond 2TiB wraps and the partition lands on
>> top of another one.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/partitions/mac.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/partitions/mac.c b/block/partitions/mac.c
>> index df03ca428e15..f372392af95b 100644
>> --- a/block/partitions/mac.c
>> +++ b/block/partitions/mac.c
>> @@ -97,8 +97,8 @@ int mac_partition(struct parsed_partitions *state)
>>  		if (be16_to_cpu(part->signature) != MAC_PARTITION_MAGIC)
>>  			break;
>>  		put_partition(state, slot,
>> -			be32_to_cpu(part->start_block) * (secsize/512),
>> -			be32_to_cpu(part->block_count) * (secsize/512));
>> +			(sector_t)be32_to_cpu(part->start_block) * (secsize/512),
>> +			(sector_t)be32_to_cpu(part->block_count) * (secsize/512));
> 
> PLease just put this into a helper..

For this and others, we can add helpers later.

-- 
Jens Axboe

