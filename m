Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC3334677D
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210702; cv=none; b=O3YrtaVuz2VceullGPUXvr+57QtMFtf1bYFb0960u5WHDTsShXavBtuFY8R8biZcNkqpc79BdFD4kSaIli2q4jAyzpjagNMDZlnIZvmYj5DSnPmM4aDVfZkG6xdTlYotusWchTaKxm67XzDD45XMJtiquYRDHBfvw7g1SJVKeHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210702; c=relaxed/simple;
	bh=yEAqW1eeqmg0vElNqXWo/N/ta1K0BkHuWW6eIZXk9FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ff1VovL3kTlpYFytJ7Q3X1yoPUTp67HxzGUMqOzn5lCiE3aFzyt56zVsYh6YAJmcKFTj1HpFlpmamXXnmTZ4ikc6CltFST8IejvDc43ncDSyYhCujFb6CCRFlLQpWdu5fFoaaW/Hti4zcg5VNrwGvCCk59wO5HrKJN3YlD0HlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fhzJ5vv6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fhzJ5vv6"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb3bae8d3eso202115685a.1
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772210699; x=1772815499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohKeGtq/yAT9GxnaUroPn5hAKZIs71dZ2Ee53OrD68g=;
        b=fhzJ5vv6BIhINp5OjswvzsBQkPNMKTg26QFaSGTRXmlSS1DEgVFhvvCv6oJRt9jvMi
         DdTUs4Mreev8u7bvDmO+p14k1Tl3kEyynR6+miGHdOYQZD3HTmQs5oNaX+hE9KjHCCY0
         OcrCcocNoK2NeyvKFZlESigjMR2oCppUjqrNDvgEhK3PMZbuvuohJzCzSvdeXYMzv/4/
         zzyyCJXvVFyhIXclZX43OCiJt7Ht4xSqP1fkBhqMA+Tedrcfqb4BOLK4vOEZTuaQCGAM
         GD8RHABP2g2ErBAwoYX6Clr/rMHUjeXZO8goJ2Hb0DwU2EDP3kWCBs1LdUymi3RtPT0U
         CL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210699; x=1772815499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohKeGtq/yAT9GxnaUroPn5hAKZIs71dZ2Ee53OrD68g=;
        b=EKfyhpJEOn9l/vfng8CHyQeEn1MHlnCPMCknrpTXde1wI79z93viPydthrclrz7nwv
         308/AovWDLsV/+7T+ATjEfq053SpBXsWxB8uCMgIqvIGImmu4CAZZrizk81fWZ2tqSoI
         609h+3mhKnv9bhLLL34DLeOTTpVJesMBtHr5qgx9BpodLw9ThCSeMNt+1C1m9vfd40bV
         kAz/JHvf3IVea20jaAnOrnZHpqDz3P7RmiUf65V4pDfq+K90/LD1Q2n0X4tTOazQLdSY
         uJ9lr79S52JBYHX2E3pu+DjfWwdcQ4JTMMymjYqDZEXVRihCskG61TUFUSxz75b3v46X
         rJsg==
X-Gm-Message-State: AOJu0Yza3kVbbt8rmLRGzsNeo0FkfJcrfmKCPfZWvVK9kCrlpmjTAWAf
	YqKO46SnEN5lSPDWP1Kjtai70kZ5FCDBl8jyEUvW3qbajFBq4fXX3s3V017INgIsWVKKTNwfI07
	GMGC9
X-Gm-Gg: ATEYQzzzrrZquLHpBCDxQHiVnPEIGMnUZAf++3t7gEWhJeM1gxIyGGMwX/19lRD7x55
	BGRSiGEwxFM2H7xE/R2ZMiDJLxvKJ4/6j8Bx0N2a5MCe1iCDyDibF5Gjs6Hg1D5ZptkJ3Fo8khw
	HQZN4ew24KL58xmWRa9KkImq8Z7FGKjAc/MvZ+DtpMVrVhANNdnHvB04/70iNmtljlegPLE4KvC
	L6wea/MaPb8uGkZU1q1zgDtjGwhphqb5n+Ck2j3MBHHAPEA4RY0VSK1YZ8nwkoeFCrH1sFwmxjW
	Wxv/hCS0hd7R9IrOiTAJ8Vqi6ACqpeTrWA8AB4kScr1ZU8+xfrFRryhU5XQWxTOvua5pHY8PZOt
	f2XsyrZu3fYdigchKlxd42zrkbu1gaO+jobPOlymySVz3AYHr0eCYjLs+8sogG5Ee3Qs2IJzxr6
	Am1GzZ87C7uVtfnSQOaRry2dFsF3djj9HYUbDLKZj/8vv7bNRLmnxtLwpQ5Ast42zUR+oqIMIfs
	ydEzOx9
X-Received: by 2002:a05:620a:4050:b0:8ca:3c67:8923 with SMTP id af79cd13be357-8cbc8df71e1mr429922885a.53.1772210699026;
        Fri, 27 Feb 2026 08:44:59 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716cc2fsm46366956d6.14.2026.02.27.08.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:44:58 -0800 (PST)
Message-ID: <53b9e2d0-bde1-4d2e-b192-77b469101923@kernel.dk>
Date: Fri, 27 Feb 2026 09:44:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] block: fix zone write plug removal
To: Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org
References: <20260227131951.2464150-1-dlemoal@kernel.org>
 <20260227131951.2464150-2-dlemoal@kernel.org>
 <aaGhDUUM-imJehVP@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aaGhDUUM-imJehVP@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 6:50 AM, Christoph Hellwig wrote:
> You're reposting way too fast for me to keep up, but as this is
> unchanged from the last round, also here:

Indeed, please in general wait at least 24h between version reposts.

-- 
Jens Axboe

