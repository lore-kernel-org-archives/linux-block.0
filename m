Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6F245006
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599039; cv=none; b=PXoKuPdvB9dkD9wNrt8lyNXLiRMUNI7kA3qmZsVkarz/ca8uefPR3351yOWGxYQncCt6l2H1OxZKxDuhHdjLjwUJQYzUlvJLKRNL9bpZsQ0enxDoQQTYYIblP8Wm/xpZmh+XZPdxl+qBAgGTQ901YHlEHKv9VcDQLIpf+ghhCKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599039; c=relaxed/simple;
	bh=d+3Xa90kEP/tvphor+5LeyeLnqS9aMCkcfd5dDXJ66g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r8hcfL/PQ3J+CoFIWh8HbvqR5e9Umwb5mVm/Kq1EVoPtWH4wckxR7vy+SLHmJG1pmmgFOCoogq67Q5E+amVCHzkG30bnk/RQJUXWO544iqatzPUdP6G5vAH2L7A41zRM0ldi75oYtiW6WFd/XSR4EVPvJW8y6WxGpl46ia7T0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZlKg+EE8; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZlKg+EE8"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-855183fdcafso39046339f.1
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 11:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740599037; x=1741203837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sLDeLKPUoOShmf1w7pHGv7wy9rSrQDySNHUSOVnEJhk=;
        b=ZlKg+EE8N8eqYeH9wXrcfO5nSpCee8QIPpKMJYA3GoEXRMrlKObWkoXcUQY88Y1lIB
         yCQc8BTuWR20OxPElp6n0GncNvBbBpoNxasW87I+/YU0xv6VG9ld1X+DgP52f7ryeQya
         venVBsR4EJd9WScGKfkXm0cuiOMfFi7lSHdmpwnZUbBh2mgKiGsLeDAcKIuffh8L1hMT
         8FSXBAtpxq33orxmqMYZ3CS5vMMW2uArRyJP6Ay5iNf7JXjjGBIN7rtCc6WuddYVgb6w
         6lv+cLVB1gN7xqPd4J5iJ6ihBzlZh/2dej26lVzfWlmvsqLCVv47kNebad/YAz+nnwBj
         vA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740599037; x=1741203837;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLDeLKPUoOShmf1w7pHGv7wy9rSrQDySNHUSOVnEJhk=;
        b=vExk2ZMSqusjXXJkr6IEtKrQBmJBPJ6Ttzt2kME4uwOiH19z1oGh4SgHlPrFH5FdWN
         7sZyiSpTk73cVsGtkjm8COi1CuXql14Ld5j0SocfBye/8x7RSrilek/uRLr9GHmUnIzh
         nkAPiQVBvLKmXjMxYwRU5/ybNlMsMNo0CZkDAkhA5yaLqb/DMP9oydMD592WKvJYarNc
         dKitwJXGkcIuPsjbaXfZONYU79E+QONTGyfAHhBok69U8vakBgOBSHqIjXk8IBJQz48H
         IUfPVfUuJj0Er5IgV4SGMUu7wVZ7D/ASIpsVOXmf+xm/VbAN5c6O2Xktp5CWJKnNzrf4
         Xlkg==
X-Forwarded-Encrypted: i=1; AJvYcCXs+w62GC3//J0ZPR7+nNouXwz3zVGvGMESkFqe+fXayP6ejEMckv0vYJBgduvbVRoxhhlvdd+Eov/SBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTuRlYG860W2SyHvAIyeUegtI+uMcZwGq36Kiwq/zWGALKZkip
	J4pRX+Zr2iPrA+lmnQ4zB24+lOWG67IKhYEv+k65la50xBjWGLW8LgQ/OB0cuKA=
X-Gm-Gg: ASbGncuQA4+QHPtollyi+jFgj2dl5JaAICeR/qCeCgeJRXAJOC4FtOSCNv/rgTr7hTy
	0ir83DUJha7PAPftKAMxgQVVctPW14f54qTxSHSRVS8m5nDipbmMUMy4dn8sGJGrgTsQ01ojZgh
	hQBN9Y9+TTfqlswLgtB/KNnBCDDCAMFdBHqB1bDWl7FyiK0bj99q+d4OIFRbLB2Kp4JakxCPuRv
	tGJtoG0PPJifdCM4zTkMqeVdj1DaL2fF6qPtfZQLBW1MK7i2KOG61Ht3DwDhnJg/7ZSx5L5qoz/
	4dwqee9L959TVZ44f1PHdg==
X-Google-Smtp-Source: AGHT+IEHXu4Adf4k7lWreSj75gITEDxxBueHs8E5ge9AqxuGDEfV9yiPcdGZf2s42AauL5pJO3vumQ==
X-Received: by 2002:a5e:8a0a:0:b0:856:290e:6399 with SMTP id ca18e2360f4ac-85870ec35fbmr60644539f.3.1740599037569;
        Wed, 26 Feb 2025 11:43:57 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-856209f8868sm86187539f.1.2025.02.26.11.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:43:56 -0800 (PST)
Message-ID: <e20b3f2f-9842-49a8-9f78-c469957e66f5@kernel.dk>
Date: Wed, 26 Feb 2025 12:43:56 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 6/6] io_uring: cache nodes and mapped buffers
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-7-kbusch@meta.com>
 <83b85824-ddef-475e-ba83-b311f1a7b98f@kernel.dk>
Content-Language: en-US
In-Reply-To: <83b85824-ddef-475e-ba83-b311f1a7b98f@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ignore this one, that was bogus. Trying to understand a crash in here.

-- 
Jens Axboe

