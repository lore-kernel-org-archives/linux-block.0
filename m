Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0132F619B
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108093; cv=none; b=kPcdewYBASFWrDgK9s+FkWm0GJBn+BnWsn1EZAiVgvRRwNy/4i6U3mvKes0mAWcXseUpOv/9lC5ba/OjmrLCz/t+tHqSlA5h9uH/xl7RGU/CuFLCyxft3e5LTVh149a9GRFhGQVXYdXyAk9kmSeK2pMPiGCk1YUsXiELJkpZoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108093; c=relaxed/simple;
	bh=JYLGO+aunzqaQyg233Rpqn3/BKIT15UHFzo9wZBhkqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C+t2kFXko7S3rUc+oNuIdoLuL7pUZkmgw+i0AOwszzG67IIXHugjIxV1MCSfSB0P/E6fLGxg0SyIRqBdy19dLN3ZmmQq+fn5vE2tCD12ZAxNot93clF2TOgNmJwaNNwK80MZvYelK5V/jOeP++LutyHmlF/kJSM05MAT7dyMGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=i60S+LRN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="i60S+LRN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-28832ad6f64so24751095ad.1
        for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760108088; x=1760712888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbofJ5TYVrlVEz+XdSpL9ID+J57K1M46jTnGkwllw9Q=;
        b=i60S+LRNyOfZ+5UyB7ryseoQPralCRNlYAOsYj95WJ+HoVTMeztSRdQ+u3wLpxZKI/
         Q9lrPIbOVar3yFFJdhcaZeDw3Nw5MVSmisnL+dHGt0qAPNx83i47jHef+330pQaAlp9T
         IvNYOoTzkX4ApN3uSSbo8PrHjncgr/Q7ekwrlc6B9EP+9sATkv2pcTWSjpP5PjDW7pmA
         CLXAuNY36wV1jQEi37r0W2ifyVIWWQSzmUp8jepRyC0BFpohpi4Knbr5xhM4kA2QA2vt
         FSYukuF9vZp5Ys2aHXCot/QC90JWODxuopAxMHTmizM2P/mTY1p0DoOu9si0iEcsPIvV
         fOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108088; x=1760712888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbofJ5TYVrlVEz+XdSpL9ID+J57K1M46jTnGkwllw9Q=;
        b=urftMcKiE1aSyuvrnqMb2giLNAm7iLYBR0Xl5qfIUEHyUWsd/T0M2wtLyL1LxW2wSz
         ANZS8KOxpDdiuLgadoT0xpFqoGbHDYjPsTebyKrpMd6zpoXDIA+i/ST+c/QrtJf3N7wN
         w4usCdpp3McYRpjUCTxnsep3f3/5a7ai/SUvqa9tdDf03JBrB7VqsYulx1eZ90e95hDZ
         iTWC1qsM52/jbG4ya3nHsQUShTlkalgBi1KKhd4iAFKWoR3/DthTJuvwMQIybRgsFfkJ
         XqXGBnlX4o1NnHUKbPVEG6YoPsDcfG/lzCcwt5WGmr2q3CiuUMWpZLjiDDwRgwavx310
         UuxA==
X-Forwarded-Encrypted: i=1; AJvYcCVEjVQy8ZnNmqN4ewuYyilhhuXFCzWSdxYOhdpQQv1zJ/PW9FJdQ54GmfYTiHjN4E+7U25Rxy+/VCn8NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgO77oIlzuYMVC3xofjBcPhyUf2hyqNCgDaCNECAfZ+chbqo7
	JuMcQ09W1IBCmf1GBKujLnirYRfQgWn7EtkQ9PuRCdpBrk/j0x0TxYDihUaS08OTV3PCHvuyfc9
	sHPG+vRo=
X-Gm-Gg: ASbGncui+liJMWdOJ/pet+M3P8WE1pJGvfdseH4jLuFEi9ygycTXDnk7pH2/2looYGK
	8vLoVpm1fABkz/R7YzG2qwiEYDxTb61wMSLlbH8mWch8tyH10TwmKr3ArjEipC6+90wStJbo6hF
	SQF09hydenyPspq1LKERKWwq7maul6zGp0m2q4ukxjYl+gEXoahX1pVh6xIBidsguL2EgzdmejS
	gKJaIylPptITAAzDkQ4WLD9KOp4DDhqYnA0fRedSunllUYU7/jpSZmWvfxrkq5ULp+WmPr9QaWG
	ht3xqzvKPF7e0hpHORAEWN5hg/LMSTFhNb2Joo7dQsSiDriByrX9ZbXISt9P3vkeqwaS24mEizy
	P3CKXhDP6L0eJDltYIGuEusRjCI64lt4fY6I5FD1FAViLCCqcSEiMEj2L9SUm
X-Google-Smtp-Source: AGHT+IE2ykU3JRpPiQHMUmIjNKSKo2rlX9PQObXBs1FO64lFOyXHQeDzHA7ctCDQl2YOXgiwg7ruvg==
X-Received: by 2002:a17:903:2292:b0:24c:bc02:788b with SMTP id d9443c01a7336-290272e3debmr174061055ad.44.1760108087677;
        Fri, 10 Oct 2025 07:54:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29040e02648sm26130335ad.116.2025.10.10.07.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:54:47 -0700 (PDT)
Message-ID: <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
Date: Fri, 10 Oct 2025 08:54:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mainline boot fail nvme/block?
To: Genes Lists <lists@sapience.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/10/25 8:29 AM, Genes Lists wrote:
> Mainline fails to boot - 6.17.1 works fine.
> Same kernel on an older laptop without any nvme works just fine.
> 
> It seems to get stuck enumerating disks within the initramfs created by
> dracut.
> 
> Subject to bisect verification, it may have started after commit
> 
>   e1b1d03ceec343362524318c076b110066ffe305
> 
>   Merge tag 'for-6.18/block-20250929' of 
>   git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
> 
> Machine is dell xps 9320 laptop (firmware 2.23.0) with nvme
> partitioned:
> 
>     # lsblk -f
>     NAME        FSTYPE      FSVER LABEL FSAVAIL FSUSE% MOUNTPOINTS    
>     sr0
>     nvme0n1
>     ├─nvme0n1p1 vfat        FAT32 ESP   2.6G    12% /boot
>     ├─nvme0n1p2 ext4        1.0   root  77.7G    42% / 
>     └─nvme0n1p3 crypto_LUKS 2                          
>       └─home    btrfs             home  1.3T    26% /opt
>                                                     /home             
> 
> 
> 
> Will try do bisect over the weekend.

That'd be great, because there's really not much to glean from this bug
report.

-- 
Jens Axboe

