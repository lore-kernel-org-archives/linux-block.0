Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547A34A76B
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798851; cv=none; b=gZKGkNgGKFHEmeHVfX7YOE1XL7LhhAbpH/sJLq2tE4fxHjdF0u7c/Xash3u5oaLmcdWMgbLJKueroZDBRgRIWhATfimYVhK3tKMIGkrLy9MXkKXBa5vIwKryhPLqmaIEeQD/rFKZHPPkpZtn5Soj06fJQhnbgKy7HeHpipaJT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798851; c=relaxed/simple;
	bh=WqKaGiEmkXr2f6gO118MuoHh9j731+N3sT+jualNO4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgajHvt5ep/YdHyJPI+ulF682CTQ/BTpcCyFGeXzj1NAQESwtaAz900nBdMeiJQWn/Vbqr4WwkG9inTKxCI8TjaslL3ElXUKw3KgAzzuo9w0fM2LOasahGfZyb+4hxtAGF31WSnStOQES7vd56jSE6oW2PnP3VsM/B6WbpFYXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jLvGp98n; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jLvGp98n"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-65d1bff2abaso1304800eaf.1
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 07:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767798848; x=1768403648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHrOk5pTLZ1ba+WyDkJheiozsIQm18H+fz3+gza/bUU=;
        b=jLvGp98nWgYkWfva54Dz0j2SHRMLIh16xDRnkdRBgKEzZ5IT9yduVyupCnmHhr/Krx
         M/b/MAE5gno/zkT6B9l/YeDB55Jg5obH2R8Wz+eR/1RzQAWb5CAvBTkVj1vJzL0rm2Eu
         lLVzz/i7DLTIOFbXKmhRQYF9hqpLjIhpQSg7B7hZet/DTdc/vpnFNcQqwj01YujLnojG
         CKFkn+pKdgkBDlmv11uub8XsR2ctijkIiwYEHTFbDlU5D8wVxUzD2AUtHRapNwjdsQAS
         4WmXAU4IF4wQdsWJhIu/agaZTbPwgx8ZhxMnsEHnMfKtKpGkcZWxIDGgnLRkYC+MvS38
         iYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798848; x=1768403648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHrOk5pTLZ1ba+WyDkJheiozsIQm18H+fz3+gza/bUU=;
        b=cEfZ9J+cDUBtAD2nylFBnPElgcPQlQETWDJgrkeETzY+3cJFEZqCZrHQOfZlyBi71Z
         HTwMwJfwwwby6r3oz62Z0LyjizPTNKoJtTXPo6n85hMWaDfxwZF3TsEnTz681J0Z2Mo3
         WQvR/u4xXbCO2Qm+2tbdUg6FLtZ1LNar8PDmfTvC2NwDvMz87028XV0FjHJoNqpW8EFq
         LroWczJlv5MdnbDI9j418HxdbQHmrvdrxra6LQ1Ajjx1Pa/1IxwVM8tF2/yw032p9g+r
         wd5wA9dduOzG8JUGgY+7XQuQQigb+hoTXSXbm0Zdo1k67bdSoQDvw2dP7ieXQmtRdVWc
         QTgA==
X-Forwarded-Encrypted: i=1; AJvYcCWNEEqnh+NvbggxVXfJq+WBDDmt8mMlLJiKxDRI/l/XslCeJrXG2QHB/aJxVRnsJVegZMe8OgfbHJJ6gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8rVUvKp0WhwYvbtUUwRVrzFmrYt9qUfeaC4+5Bbla7cUFsrOL
	jfF+xFzpPioEYATwQqtwe586ZCVkJHhCOlOVBhzxRZixQSTJc9GhjgqGb/67q798GHU/k7eBcOF
	IKTQN
X-Gm-Gg: AY/fxX7M99oRKWo6KiR4yvd9Jesz/J7htS1UuJhIwwopYE93nqIaF+anwY9tFGeiro6
	xGFOQ4NG8VI1nDjNXmxBGes2VMGIFPubV4WnUVHRVcj/hrrR1NQUV8k00zs6LgidxaOg4bgBEyx
	6HfEEQauuLuyZON1J6khak3ZIcmfo5qPL9YVAtT0AhDzrmH11uPN0fuzwvTQwJ/13jdg7s+YcYv
	aSTMKcSg3HiXfOM1g8QxRDfCRVQHY8UMgoDSxE2RO4lYkFLooxpJjdO60/BO/kvyLQu9imbrwgO
	3u3Mymq45w+qtKv8G9Yuu6Eq+ZWgVW8nazwOEyfydxMXXhrih/1/y9foLkXbn7QCoSNcrwj3wwD
	6K0mQ7A18SbsLw8TF8IFl+zILX82z6muDtB4bQYiPnTelI8DKIlzwd1zDslJ6NDsPIyPjQy6ufZ
	NVK75bQ5M=
X-Google-Smtp-Source: AGHT+IEtjhWlYouyE4XkQvwKD94ryb7c45pcHTTeNQaFFsJpBA1F8X/afZoaesQ/QaKwTWR22oJquQ==
X-Received: by 2002:a4a:d4d5:0:b0:65e:e522:bf18 with SMTP id 006d021491bc7-65f54ed790bmr819778eaf.4.1767798848467;
        Wed, 07 Jan 2026 07:14:08 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa5161468sm3336356fac.22.2026.01.07.07.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 07:14:07 -0800 (PST)
Message-ID: <71e382f7-d6af-4ed6-bc90-4534e4d99792@kernel.dk>
Date: Wed, 7 Jan 2026 08:14:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <20260104151517.GA563680@unreal>
 <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
 <aV4ZcuXFjN_Eit6v@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aV4ZcuXFjN_Eit6v@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/26 1:29 AM, Keith Busch wrote:
> On Tue, Jan 06, 2026 at 05:46:21AM -0700, Jens Axboe wrote:
>> On 1/4/26 8:15 AM, Leon Romanovsky wrote:
>>> On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
>>>> Jens,
>>>>
>>>> I would like to ask you to put these patches on some shared branch based
>>>> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
>>>> and DMABUF code.
>>>
>>> Jens,
>>>
>>> Can we please progress with this simple series?
>>
>> If Keith/Christoph are happy with it?
> 
> Yes, I'm happy with this. Sorry for the delay, I'm still abroad and
> encountered some issues when I should have been holidaying (nothing
> serious, just bad luck), so it's a slow start to the year for me so far.
> 
> Acked-by: Keith Busch <kbusch@kernel.org>

OK good, thanks for taking a look. It's all queued up since yesterday.

-- 
Jens Axboe

