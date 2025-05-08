Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29D27A93D
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717258; cv=none; b=YgHDfCNwNBv+h2+SmVDNaNjPwDha/wUCsXA5bKpAwqlKp2PJU8AWdIrdnbyWbWz8yVoHaHx8dH1O/HhYz6ePCar7nRHitJ7WWG+2sGRy6yhm8r29MvFW81URyS+M3I+cjU+JlTQmg7nlzKJd7RlPR9QF+lCs9rstYLsGXlmBp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717258; c=relaxed/simple;
	bh=zNo3OqL2O8vDEakkQUSSbaHVMSbhS7nZS2spa5Y6Qms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOi0WlgWueyeEZIcQgGE+c+DHMEiHpSC6H9lGpuAlj19AMzvFaHR/Ht6ElTdJH+8BliVK0DOK2G4l8wmBsWA37NbIgR0gYLxRuG0iOTSH36FS4fmqdy/teXtIwYZl1EGdMcTLJnTB/q25AvY9WK7GG19BNn6IXZpt5K78wlTqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Cs+8XEfq; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Cs+8XEfq"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da739653b2so3530655ab.0
        for <linux-block@vger.kernel.org>; Thu, 08 May 2025 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746717255; x=1747322055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pP1HhmeHBLveNBlNnV+UToK3//ptG+M9b2h3DJVfCS0=;
        b=Cs+8XEfqMr+E7ocMo/WMGqF4rTMw6oriTtVNz9Rb40/Lm1BqTPFXjYt7w8qUgET8EM
         0LJ9t223aDpnzNih0UMCJO1wa5r6y4XFxsNdjwBKCHSOY83W0Wj0S7PiURuhkZM6jNb7
         FmHD+nWBlwaW3NN/9P/El7kIkDeGIn2eu5p5Fw3ykeJurYaaCgwwJGL9M+fYRZVEGxC7
         8n2kRvHvw3oIrGeJW2uu36hkgusXNE+Tny+i9dBv3xRZ52HflYsmOxppHDCxnwuB0/Gu
         4jE0nNrWEURvEF3gKFwEQtDJAdwoV0bq/t3mpKSLXpAMHQmZAmtkeMFZYRrFgi6kn/KC
         YVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746717255; x=1747322055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pP1HhmeHBLveNBlNnV+UToK3//ptG+M9b2h3DJVfCS0=;
        b=OCV9IQrL18sMHJ3PIcW7veoOcj1fxGgcDXwSm10wy0LMOZ6lV2YZDDNM4f4I5ez6AV
         nY1UMESvA2gPbeAkBPjetCoiiJrjWT8IYIcWVg/1EcpLRDAgt+DBaaV2FLJnD5hiUxwW
         6PqdazLgdIzQQGuMW/cTV8PxSh3OcZ/m9C4XxkhCfo6fNTrUuqdz5+y5aH4r5Xjs9jZZ
         KuN5FC0VjSVXIeMkMgnfZwe4p0E77wx7z1Vx1xh4ySXApX1mj4rE26er96RWkVLkMLHT
         92b+qvScxDfQnCSzNf+Bgj2fkyyySnB4TNwcrYrDtiNQh4ynWbCL7sKE4wZxvFfCM0zc
         zDFg==
X-Gm-Message-State: AOJu0YzFyVWttBOmeoZ991nqxEVlkpNVa4vbo4K4wWsBCI9Xb1s2+mOr
	vT9OsQmoOR3K8ghotdBoBfvTU7ymScIAP9gAmg6kjueikgNDeBynyiiYRmszdpY=
X-Gm-Gg: ASbGncvvLOg3KQrrm8EI3xRg53DCub+TMDuXsX52LeYbEEsuh5NqCglsQE//VcME79v
	CXIRFDJCKQj273Z41BPwEWwOZQ1jiTMFJGDboLxWIsX+gRF9AjU7sDbTD45XdMOE4qYsQTOeRuZ
	XG4/c7HN5db2oRDX7GSRwfSOeSL4HNSUfkRd4WKl2izZE5kljzEaptOwSlmA59l94+VbhU03rHj
	Gwc6qFJhKHTenaOwp4yulmpHtjYCjVYbW3M2tTEUUMeOQ8ehUxp96dtPLswhwDOpfTQZ0XisJXp
	UqnfBvQUf1U2Cc78IK1TJUA/OIUtsvRrb5eB
X-Google-Smtp-Source: AGHT+IH8RZwgW3alkS++WNfAs4ztxtBsAFcQwltyiZQ9W6aCxVaVNDkliLlu5+QTwQQt4C2jyZU+XQ==
X-Received: by 2002:a05:6e02:378e:b0:3d8:8900:9a30 with SMTP id e9e14a558f8ab-3da785a5601mr53099995ab.20.1746717255587;
        Thu, 08 May 2025 08:14:15 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa8f0a7sm3177198173.123.2025.05.08.08.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:14:15 -0700 (PDT)
Message-ID: <40fdf1f1-8e14-4c20-8057-1001dda22c80@kernel.dk>
Date: Thu, 8 May 2025 09:14:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.15
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aBzIw5ojzLmaen2g@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBzIw5ojzLmaen2g@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 9:07 AM, Christoph Hellwig wrote:
> The following changes since commit db492e24f9b05547ba12b4783f09c9d943cf42fe:
> 
>   block: only update request sector if needed (2025-05-06 07:45:59 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-08
> 
> for you to fetch changes up to 650415fca0a97472fdd79725e35152614d1aad76:
> 
>   nvme: unblock ctrl state transition for firmware update (2025-05-07 09:01:20 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for linux 6.15
> 
>  - unblock ctrl state transition for firmware update (Daniel Wagner)

Pulled, thanks.

-- 
Jens Axboe

