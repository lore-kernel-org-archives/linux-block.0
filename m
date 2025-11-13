Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE1314B8F
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066457; cv=none; b=blo52VxP32YYGQS92s8cES+REYRUKViyD8iK3z7ZSOJYuD/OuFevdKLwgAuhHQg+tsZi3xRYpZ0lZmGhi3adUKwsdH8F+VWpcIqmCzJ8T7kiSkC2gpLN0QA9orc3UHgq8NxjSqr9KhFGYvE/58NHQoFMnV2HO36HMcIKp2UQ+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066457; c=relaxed/simple;
	bh=Ka3At7WPk4wmi6/DS8bRRyvVtAFTo7hHIaaXRIcwWDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6P3TXChj8uoMGygmaT44+zCT8KXlhEu1wDSsYs9h7xtMiuoyXW3JBhskH+THHTfZNXTcxGBVlHjzQpnTGOT9OnexIaqMm95yVzOD/CeTRMSNSsuAvkMH24EF9MnZSr/irzw6ITdS96i26rTNOW3qgOnG9nZ5PXN4LmNOufFVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UdGNfNpV; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UdGNfNpV"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-9486696aafeso107537439f.3
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 12:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763066454; x=1763671254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osznKCBfEFQCGLbmhEnQi6dIYbExH2J+9TBGF3q1rfE=;
        b=UdGNfNpVN3Zq3f1MGrVlVFNQkV3dysBFi1Gk0SM/LGj/hYMNFh9i8549AlR9g7z+Sf
         JXyyN1JrATKThhSNdMB2CXThcF0ExvoJjYoZM2QKvSOS8voNihdNngTMtgyICEw/3Cyw
         yyyVo8VwqvTbhtT49xzU8U0l3WMldQBRgsvUqzQGBzxCIx7tLSYMRIewEwVgLW4pxPlu
         OEb1EOuFNodUmvBwRFrIHzHDh6o5BmPVeqmpmeamt7reBBbgAYfx4ASHJr/v61DV6P+9
         mA7GKwgshtEn1sO+X1vNLlhkeoyVKa11uf2F/J/ejburTBhalaDE70wi6hXA56ofXUm2
         aaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763066454; x=1763671254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osznKCBfEFQCGLbmhEnQi6dIYbExH2J+9TBGF3q1rfE=;
        b=Jxl0xkgPtNe37vGtbnLk/R/67sO2TyDzZPs2FGjy5DfXbsJl8LQGTdv32epQcZxsbj
         E0NDorkiC2Tm8pXVi0FvSxc5n+M3MnRw/yML2QvWo1m9CYNU0cvXugDagLfzMn1nxJTk
         AtyuEhDf7Xftnc4F11eFu/8JsMeizgNNOtLGWM0DnQp/guB/r6JFePk08HMxCEkqVpBH
         Dx3tu8kU3ncqbWW/7c5E8qNkS4n5xnRTd72XKEOLfwGOuESDSiIlJl0XcWJVMi2+lewW
         TbLcWHSjWGgWz0q+Cvn82lUbxT3hCUMESoF9wyf9YajUdcYHnUrynF8wotnji2Loriup
         hW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyFuE1wVwXxWHqHioG3731eexZjXaf0YSfrerEg6haFb1/U4a3bmvO2AcUwQgUvz1oMRwyHjimGOESOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wChThgvlw+DfWMILkQR0RzjrRUZLfkke1EHoFIsrsQP75zbc
	VExKB9DhqhftBDvxrh27ZgOebgjOLDAEz7o6ZAOCTP850jdeLxTxcsTDa23DEr8dTXs=
X-Gm-Gg: ASbGnctaVyMxPIgVFb6GsvQIcCya7KT8sx7puj7IEKAfGJM7va6XmYeKGjoJvlsFsP5
	nBebGgtybnd5Md3ctoWouJRvGsdPQD2GAt/AzhfgIGE+gqves/z2Ou8veT7mY+Y6bf0N7lTS/5l
	JNT9q48eUdIJPJnCbEV7wFuymmJGtWIXlK6L/Z0RdzdrzGtgEw1ZbzKc8nBg5ibHl8Rzqlmu5vz
	5XkUmXzO4FH3Zxwyt3WkDivNJqLV74QHvPbtNIJym7CZZ6QIp339fWUBA5BldVm/ZQj83jJ1DLx
	1Zu1OMwWP4CHWotLE1vBIiUcxJv6iKk6W0H/cfZyf1KiXtsFHayejtvCtCTKwKuoP9aW7wfesMN
	NLmOXi3sgByl4jy/n6k+WxZK3wiVv18VYzalHhn0LYYThGK9qgVjrZQRqLrQrkY257EJT7D3xrA
	==
X-Google-Smtp-Source: AGHT+IEKENnV7/NRGeIGQ2XIYLLt5iWsWtTU4O2KKL2oTQn4ke/vffhOdn+C7P0rpZj1Df3mhEH7qA==
X-Received: by 2002:a05:6e02:12cb:b0:433:7d37:38ea with SMTP id e9e14a558f8ab-4348c94e16fmr11150855ab.24.1763066454158;
        Thu, 13 Nov 2025 12:40:54 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43483990056sm10796925ab.19.2025.11.13.12.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 12:40:53 -0800 (PST)
Message-ID: <d1641814-5ef8-4ccd-8a41-42bf99a61d0d@kernel.dk>
Date: Thu, 13 Nov 2025 13:40:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <aRY28IRvBFmTW6cz@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aRY28IRvBFmTW6cz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 12:52 PM, Keith Busch wrote:
> On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
>> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
>> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
>> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
>> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
>> be a fatal error. And secondly, this just further backs up that there's
>> ZERO testing done on this patchset at all. WTF?
>>
>> FWIW, the below makes it boot just fine, as expected, as a default zero
>> filled iter then matches the UNKNOWN case.
> 
> I think this must mean you don't have CONFIG_PCI_P2PDMA enabled. The

Right, like most normal people :-)

> state is never set in that case, but I think it should have been.

If you want the patchset to boot, yes it should have been...

-- 
Jens Axboe
