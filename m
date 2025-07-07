Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1A1C4A0A
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751882687; cv=none; b=PR4HUqeRUfrmVoX+EUFn2AIY28KBXChql8qV/8bOILlNwc/AK4vC/P+gEh/K69d+heZAMS8hEi4mmaZu5IRdaBd0bkZBoj4FGFWXPCeARDSQsvyPH+juRuB/P0nG5d9ZCO67U9vngvcJhxjS9udM/7U7uMyLPNJdwhxF/E5oTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751882687; c=relaxed/simple;
	bh=pD2f+BMjlpgc3KfYOp5ZiVQrCcMLVO5MSSS9P8uPJzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tcy3j4yxG+RgwlCeRrOvrsvVjuEVhwWwtkr51uSbHwLirrtPDGdjv2E/zvFBWULZsAtM9ixOg73GUvXDHYGxa47Sqwlo8bRxPTnpueja20qNeMOQMkTNP/db3T/mApuXf9hsYNurw6plwT0S4PaVhFNeOcFvEBHXgK6Xp/SV1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8yEmDUb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8yEmDUb"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so4701786a12.2
        for <linux-block@vger.kernel.org>; Mon, 07 Jul 2025 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751882684; x=1752487484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=swaqcU3BXMb1jEEVuzhk0jpg3KsewS784qLaOePpGM8=;
        b=N8yEmDUbXetuJH4ae6jz0AxbERrnLivpqwl37q0hH5iuZPQhy6t3VZlW6vkUlmvRq8
         mA/fFU7j9PWgK1wEt72Rbz6EpwuyMcmFIea1E+kDRJ4t8QgohkGyhxDldJLyicTzaHeA
         3svMPVlIx8UGJTWqDa5NWBS+G1oVMy141VlbDEsQZhkmWMsRdey9Kp+JFtBYFisKWuHI
         0Km/H8qRWXnAI40o4/quPRVjREH3kwPPF4aOyl3TUXAuKIi0DW2po6f3Df8E3v8IsPrL
         Py1oC+RefaIIg/HEWNrItMejKH7DydGcsGqG0wJ6LyqycmjcICvRfpxJAytqyQ+oVg3K
         rQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751882684; x=1752487484;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swaqcU3BXMb1jEEVuzhk0jpg3KsewS784qLaOePpGM8=;
        b=ep2cQYJsryRpKSKIrPXjS0KLPb1sPXFcsiYC3Q7lQw3WHE2rvyjn1cXQcPWueTM8NG
         btdHLZmn6xYN/cnJJYFcGPBExU1TciuUX+FznKifu2OdhxTodKUNpYxTdBs5yPeQEuNx
         gCYvMMvXSQJGb8ZYCL4xrKAio+wr71+USBwCXCxIIx/kRJAY2nT7hHUCEoisyHOMIEk5
         6+o2WGpteWRdaL4iX2adhy3sYnhoiJEd88cggclHzO6nQVA+GFl7gu4PgRh+Fv10CXnf
         yTICkHV0lDaNiIHpKcYaNa5+LAgqu4bilZbVLtyXY5RrAObgHG5uaejOjTTTzx6CeLa/
         ku3g==
X-Forwarded-Encrypted: i=1; AJvYcCXo96t65DuWbX8PtvFU0U3Lx28IJs/6WYNLKJbuNsQyYVvVpmzREiZaRIeiPpHKHKND6BTqf92CCaWHhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNC+0bbn9J5GgUi4koKOseZhnnxPTHgNsR5EM6c+CUv2WikeJ
	h8TMRC/MirYoSySmMBRfnVmCQG/C0A7n4/ovFT0jGZJvttqg0JptR52X
X-Gm-Gg: ASbGnct2FgALBUyX5dxYeC7fLPYGOhFwaJGwkBqY9qIWV8p3mhXW8fO9G+pDIukb+ZM
	nQiSIXqz7t0XEfpc/ROY2t0lXHbynD2A3J/mDKoyrmwAW+gg1mvl9XJER26bKDt1XK4Se5KGP9g
	tGYW2Zmzonl/b9o4itfh9ziyTlC0qJlQfQRjTom36z9YoRhBVoiRpNhRk2pjx51mEjBdF/ejRI2
	u7YxvUeuOvySG7yLSt0+SQKTQb8KnfTRulwsYTu0kKGKhr5uxgVZ33hJlj/9vY22xGcu+vuTl/b
	aKmT0Ig/59ouKoFQ3vcPRlLcruMWzNTHe4MakIrlPZWZb/pgcV9Jf2tlcXMkIh6b9XnNfncFwkz
	/Uspradw3Ug==
X-Google-Smtp-Source: AGHT+IEmSui4Pxo0MoioqOnxxB8SETkwFzGsjWsvrYhPEE5SqNd9UI3gXGm+O1cN24/yL+l0tBkUbQ==
X-Received: by 2002:a17:907:e843:b0:ae3:ed38:8f63 with SMTP id a640c23a62f3a-ae3fe48790fmr1081351966b.14.1751882683380;
        Mon, 07 Jul 2025 03:04:43 -0700 (PDT)
Received: from [147.251.42.106] (fosforos.fi.muni.cz. [147.251.42.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b0717esm676711966b.137.2025.07.07.03.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 03:04:42 -0700 (PDT)
Message-ID: <1be92258-a886-44de-a758-ad5ea15e506b@gmail.com>
Date: Mon, 7 Jul 2025 12:04:42 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/partitions: detect LUKS-formatted disks
To: "Robin H. Johnson" <robbat2@gentoo.org>, linux-block@vger.kernel.org,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>
References: <20250704182853.3857-1-robbat2@gentoo.org>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20250704182853.3857-1-robbat2@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/25 8:28 PM, Robin H. Johnson wrote:
> If an entire device is formatted as LUKS, there is a small chance it
> maybe be detected as an Atari/AHDI disk - causing the kernel to create
> partitions, and confusing other systems.
> 
> Detect the LUKS header before the Atari partition table to prevent this
> from creating partitions on top of the LUKS volume.

Please, no. This is a horrible hack.

LUKS is not a partition. It is a completely userspace concept, detection should not be in the kernel at all.
Moreover, the detection below is oversimplified; the second header can be on multiple offsets.

The same problem can happen with Veracrypt or other systems that randomize data.

The Atari partition is known to use very weak detection, but I think blkid added some more hints to check validity in userspace - why is it not enough?
Is anything from this logic missing in the kernel?

If it is not solvable, you should turn off Atari partition detection as it is unreliable.

Milan

> 
> Link: https://unix.stackexchange.com/questions/561745/what-are-the-md-partitions-under-a-mdadm-array
> Link: https://github.com/rook/rook/issues/7940
> Link: https://bugs.launchpad.net/ubuntu/+source/util-linux/+bug/1531404
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
