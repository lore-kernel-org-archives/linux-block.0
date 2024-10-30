Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5C199B9
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296076; cv=none; b=tg8eUUahlnEjJfRQ/y1txkoD6jJ0/B/kfeVu/nt5cNJa4mA9zsvkQPDUmTsle23oVx+pBR7slxcaYEonQ8c0RtRVyBQgHHSty+NPAGBT8V/lIF0heUm+c051Mvt1si+1FM6Fi7kTe/wIlKEEPR+TBGvfFyiSSXgAp237q/wNGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296076; c=relaxed/simple;
	bh=UBbAa0q0FBKZaHNrAkGD47Pg+b/t2US3pe19p88HWT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yn2BZm2N1vp4tn6AmZ21dvAq6gzdxgiIifuGmm+TyYu7PrcECSJr40+PotNQTX0zvezyEAt/JZfwo8VRfx+52Y42QVBZ+JAvRzpNsC2xUNNuJReHptl0CsCPb1vi6O5ExHUflL9zyKmb9niURNfhMWvy89TKHbkmYMcg3dy/dXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P858KAX5; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P858KAX5"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82cd93a6617so217206939f.3
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730296073; x=1730900873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzD0f6x0FcSWSS2mErwii0h/GnGUEzj16FApQPTBDLY=;
        b=P858KAX5tgWfpu42jKpui1BIsYL0KGrjNu9UVe+zfmSyQ27zSbskv4MZc4JwPXeY/X
         JfNZ/aGg35qENyzeDHgcnWLcLjXlz7LnLj/DQS1b5IPvOLUpYe/c5ajYbjdKgJY5iFKH
         zNwkU6/35ZiLnoAscbJVGooNnyK8kmEr+8Cunlt2vazfgljyRHckeIymGWdeR41LGOcy
         JPYB0A2+sLt/ZN46ZtW2wtzXEsf7vLFGcxxdm7dSgc1+sUjV4wSsFYvGZVzpy0Fry7Z2
         gTCgDtBQ7enCgSaRIpT0C4CL5HODhGzOXL4O3olCa+NN3HG27IqaYhH34IMarPKJ6F8P
         s7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296073; x=1730900873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzD0f6x0FcSWSS2mErwii0h/GnGUEzj16FApQPTBDLY=;
        b=H7LI7RNeZv48HwAukAcjf2XuxaUa9Y1WwHDBxu/Mqmr84zT/7AolYlPe0yRsbstx+O
         8LiOZJXQFwxgtR2xg5j5BJtmkCqzDPw71kSBOplOYfPJY6PvZ5tVgl4YuECBuUKkfRTR
         a/GiNvrSIgUAFc7U140NQzFlX3t0/rXqRuaFSjVs/OtXcY3l0vbVzmHlZHCOrTuCJ540
         ZjjU8jAYNpIp3WL3Gri8j+0uJGxbowFga/aLirWksC/VZCHgIeHWH0pzt183s/v7qKtg
         t/8Dtw7p5Rqp51APQ268wT4kmrievIzFwGLHStN6oMQHgYhGwbMc55N9DyPnIXOT2T7B
         oFwA==
X-Forwarded-Encrypted: i=1; AJvYcCWYiMMrIIhafOe4lIH3uYKF9xKz7s9of9XC+d+Mu23UahHNl/UtE2nfXRiyYhzy6snUXP78Y3k1fK3wPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqo7wPl36dHA14c/K05ADgXOyVT7ZW1Ceqogam8+7EvnK4EZX
	GaxsLE/CIHZsvPDTeRnsYKC7xfxrg6KPXLY5CBuTZx2QfNi7pb3mHD8zSCBK76k=
X-Google-Smtp-Source: AGHT+IEUfmrDjxbnGC3Yqd/2uks+MpQ9zP6cr5heHW55n1ZgaWSgDdSH16y1iITqh/Mko19Tnld2IA==
X-Received: by 2002:a05:6602:2b01:b0:82a:3552:6b26 with SMTP id ca18e2360f4ac-83b1c5ddbebmr1707324939f.15.1730296072842;
        Wed, 30 Oct 2024 06:47:52 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc72784f8dsm2860991173.150.2024.10.30.06.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:47:52 -0700 (PDT)
Message-ID: <c156bc1f-da5c-4522-8e5d-b138a94cb7d2@kernel.dk>
Date: Wed, 30 Oct 2024 07:47:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
To: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
 hch@lst.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: anuj20.g@samsung.com, martin.petersen@oracle.com,
 Keith Busch <kbusch@kernel.org>
References: <CGME20241016201337epcas5p33625af2c67f92092078b0b43874d67bd@epcas5p3.samsung.com>
 <20241016201309.1090320-1-kbusch@meta.com>
 <5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 7:38 AM, Kanchan Joshi wrote:
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> 
> Jens,
> Please see if this can be picked.
> Helps to reduce a dependency for io_uring metadata series.

Keith, is this queued in the nvme tree?

-- 
Jens Axboe

