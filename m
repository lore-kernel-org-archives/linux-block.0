Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B63D412B
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068778; cv=none; b=mZSz1coiFkc3ad58VIfY6OqJmiZHIkf3q2rKUzxtls6XYtkUcUX6/krUQ11p6P+c2sVpabCDwC3KMYOP21Oj9oqvkD0eXHZ6Y5PdDcRrR2eoVjlDRP158sSox2ykiQhpk6tlgD7Ehn7e6mXJumX6e+qyYArle8Y2AnhhmGR++5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068778; c=relaxed/simple;
	bh=wRzvLbBGaAh9TMd/K6fo819fSxGJuZ6OqTWdUwzMPLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRLVGm+K5KuoCfzESVDtfwbZUG0Rgk/qUk7ygTCgyMzkhssL2XK365PI1JxVrRVqlhVbUHyL79gyoqE96+7GXty1zKKT5MnmyEAQJpdRotlctp4RUKoq1PkFiADfIMuXaQ45utqbvaz7IDb7Kkxr2qyONdanEjHJt5k3q9ehWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QgQvDif1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QgQvDif1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50917e02472so13388281cf.2
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773068774; x=1773673574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/pSwYu0Cu6TqiNKu2kObY4zE6l9DNx84f7s+dA/j44=;
        b=QgQvDif1NIjqRxM11baBFkHEqk/HxULzhzftporqFxmVEHecLGAje59XnFE8gEPg0D
         LeK66wT733AJybGdkJ1kKkpbmyOIbGI9DG/l2cWKRJqrsCGll/KbazQ4ch5nrmwKpePm
         RDwb5WJkumj8UjEBAMz9zQl0p3sqs5V46rgvcEWc/mTYf/7AATdsHnJzvl87dGnDyFQk
         hsj9JSRIXSpP7HGhYzFA0O0pWcd2HEUt/DA5mWWHnKxPnBt0WYytP6SPaLuFWGcG01qn
         fvwpa7INTrUY3zANODcXIFPiT1iZhw6sRNVXpcrIpqdgUAz28jCIqqJl8sJRo5zGKA5s
         l2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068774; x=1773673574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/pSwYu0Cu6TqiNKu2kObY4zE6l9DNx84f7s+dA/j44=;
        b=HapZt7NgQ+/Q5pVsEf39Jv2ta4mG/QCZ7KmNGeqrxWMPU45mvRd7a4CtJSqGIVceXX
         sIAC/kF2lyZohl8w+VEds3Ks0jC30MtpaC78bEnkYzBBPDrdr+BG9r1/Q4YsxfucpUwT
         kPNpe/TGIP2RpQ42sv9AgjWjRxtGrB/FHevCDyF5WeGZZTzFWy3qDAXF1Z/9xRf1aUm9
         9wwOdYM32rOC+5l1QahlLtY02CLOQmZUfFKAfegB1K3ZboJllU/q4KIjeD/hrO3COt+7
         fW+gUASulaWgoaRt07fGJAx6GYMGofiInX3Q9WOmoX0HZ0UBtbFpzjIt9rwLAOAIB7eC
         0MnA==
X-Forwarded-Encrypted: i=1; AJvYcCXnckgW1pfdlxUW46IpZx/GHii556FpIhxVHoEIdWgVUijhsrhCqhYDeXEFhjtU6f7UjvoeuMj0uly/Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwURKW0Y//nbWHPBT9N53jz+6RSLbN/Rb4nUw6movDB/Y1eL7
	GmdXra7Au91kjyr9X77aQMNCaQPp7gBbLfE8AOwcGHLTERb3wa7/EE8DEGkWkNpMurU=
X-Gm-Gg: ATEYQzz2pKYrB3tJxQQ6kqfz9WHil5AQPxT+2VL82Si1fdFG23P/N1KMXs5Go4l4PcL
	STifOgS+mv0tSma1VL6sYXsX4+gMzf3W3ZvK47E73LzsFQJeGUI59zI2HToKVgaBmgh17rmCnTX
	OrEhivZZoKGcJ8nO2i4wKtp77+JIZ/1e0waiOyzYkdtnkvbKe4SwQA/EDwtzj/8TSjHxyh1afmp
	8wN7902ZX/kbNkK9RhLDe7PJrO/+2IVRSqfhKvAfDoFGEX4H1nD46SwdlDNz21JWANFF9BgZPPB
	Umu4q3BH2tjIx3pOeubhWItifxM5zKrrjeddphQegpDauMFGUGS7P7Pbwx0jR4j80sncjSCGZf9
	xJU9GagFraPo/KdtQWLj6IL9hu5wuyHhVG+UrPu+wGkiuTPmdSKQkyiJl+jGH9gG7qnDiWKbRr8
	46gUX5sqwnY1q4Tbbt+I0lrUAyMFDxI08DVv9Apm28gAklUXSNuQ==
X-Received: by 2002:ac8:7f86:0:b0:509:17b5:654c with SMTP id d75a77b69052e-50917b56abdmr50427091cf.37.1773068774226;
        Mon, 09 Mar 2026 08:06:14 -0700 (PDT)
Received: from [172.19.0.48] ([99.196.133.212])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50923ed69bbsm5209671cf.28.2026.03.09.08.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 08:06:13 -0700 (PDT)
Message-ID: <4d46676d-e738-497c-b848-4278ec15d868@kernel.dk>
Date: Mon, 9 Mar 2026 09:05:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] block: export blk-crypto symbols required by
 dm-inlinecrypt
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>,
 linux-block@vger.kernel.org, ebiggers@kernel.org
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
 dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, gmazyland@gmail.com,
 israelr@nvidia.com, mpatocka@redhat.com
References: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com>
 <20260304121729.1532469-2-linlin.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260304121729.1532469-2-linlin.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 5:17 AM, Linlin Zhang wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> bio_crypt_set_ctx(), blk_crypto_init_key(), and
> blk_crypto_start_using_key() are needed to use inline encryption; see
> Documentation/block/inline-encryption.rst.  Export them so that
> dm-inlinecrypt can use them.  The only reason these weren't exported
> before was that inline encryption was previously used only by fs/crypto/
> which is built-in code.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

