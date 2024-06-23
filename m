Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E834C85
	for <linux-block@vger.kernel.org>; Sun, 23 Jun 2024 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719106627; cv=none; b=VyJY10RjLKMda/Hz4kUgm2jQu12RyLcj2nU+Y0Qk9kH3KgU6SlA0IZafye5BPUxP8Do0fAlvZEelSMTmLRVTiaGjsJCFh0UliiGsJY+nirYY46ix90h/DY3dGOgQham/cRBKnj4LzE+SaY0rIh+r/Md4AMrVpBjb3HqixUNavN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719106627; c=relaxed/simple;
	bh=AQe3Tn6Qc1XA/J69TXrhsCWNQ/EvlaX/MU6KB08Molw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzX5qd9jMSbIB6nIyjDx0NSqmylIPp+GLyltHZ54SFXWhO+zxJRkUvhMKZWSdG8kMV8Me87uwFLJfW1JweBeHXAv2VHU0vxvVQVKjspYAcmKg6BQSdAg8I+IxAxti8oKbn1qZRPWUcJjrAT4w9DnZoIpb1tCGaMIg4QYag02Zeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AqmsddIB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AqmsddIB"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2cb6750fcso573337a91.1
        for <linux-block@vger.kernel.org>; Sat, 22 Jun 2024 18:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719106623; x=1719711423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2ro/SXJtBiu7qaa17nB1gWVO/LS7U+zP+FmiFSe8w8=;
        b=AqmsddIBy6b2nqDoqBxFnXR3Dc1Nfj66qr6ckMG2+qeGI60/g4/iwWcE8uxj/u7siS
         sP7wb9wmpA0O2WtLL144pM3lO8x/qzj0ODN5pfp96PaERN12vUN/PN+AENW1k+RffSAg
         k7eKJ/RajNImtLMvSRVmOqG0dt7JpCKwT1+l0PtylAV6ANo9sa4LaXmY63cGoR3mOgD4
         ZwQfdbA72UBZFmr8xyw7pOaULBLJnpSrlrQYR0v4iYFUNEAWQj1fIWrjGctb2jyqBbHq
         k5t6yvHpG4S1gd7rSE0FuERsByH5ZeFnBb52fPazFKpiXBfGy5CXdSTlSZ8siSPHYab3
         SwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719106623; x=1719711423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2ro/SXJtBiu7qaa17nB1gWVO/LS7U+zP+FmiFSe8w8=;
        b=vpcm/ny3fkgrFQ2YZX36mDKqKK+vETEsNtFxGEIGwpGlZosHGXMcK3MClAbrm3Qno5
         9ffnOUKVsmrizrKTsbemFwJHgT6l55MP3zrksE33mtgPmCyhXD4kvG4RuFXYvkZsWoLK
         O/Yy9Hhjwk9PUhus89/zWcPuO6gxeVQ9zE9Rq1QBs7dhgNYGkdQqmdvWqu2XvCV6vFgi
         R/CyzOiD4jzngz2p0rR/vdZoktnZRsa6XnqBBsJq5loQoTvay7jl35iJGoo/yoDGIIs3
         a+GesBiYc75IxvVLSbwk9wK0GyX4CeYgaVz8iMqBCnE7gOElzNfuGv1peYCSSeuh8DFF
         73Ig==
X-Gm-Message-State: AOJu0YyEWu0EewQ+nbEd6osk4aUkZOZy9aMMnnShn1moCZmLyjx7SIKY
	aDkoR4yvir5SHgLwaMvlv/ZQVXvXsyHgIftUocNNa8M4lEfuC0lF7dt2Kpntd2oMKVhuz+nccac
	3
X-Google-Smtp-Source: AGHT+IGso56LKs1ZCO/+7izzRcazH4+WGJ095hXp3oRXPVFf2dYWN9HickXXK5iDx5Pjj6UdaoH5ZA==
X-Received: by 2002:a05:6a21:118e:b0:1bc:bade:ea3 with SMTP id adf61e73a8af0-1bcea5f5e55mr3038569637.5.1719106622811;
        Sat, 22 Jun 2024 18:37:02 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651309bdbsm3693017b3a.210.2024.06.22.18.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 18:37:01 -0700 (PDT)
Message-ID: <83f11cd7-b323-4b71-8492-c021a78d0b1a@kernel.dk>
Date: Sat, 22 Jun 2024 19:37:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cdrom: Add missing MODULE_DESCRIPTION()
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-block@vger.kernel.org
References: <20240601221816.136977-1-phil@philpotter.co.uk>
 <20240601221816.136977-2-phil@philpotter.co.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240601221816.136977-2-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/24 4:18 PM, Phillip Potter wrote:
> From: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o
> 
> Add the missing MODULE_DESCRIPTION() macro invocation.

Applied, but change it to:

MODULE_DESCRIPTION("Uniform CD-ROM driver");

as there's really no reason to state that it's "for Linux", it's
a Linux driver after all.

-- 
Jens Axboe


