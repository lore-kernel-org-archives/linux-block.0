Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB525EFBB
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752026; cv=none; b=nJvkps3INtnEX/5kT4zKJHme2QdMH3YUiLyGd92b0QOg30bJHClNdKi0tDCY7XeA2nBHhm7MvNbYnmf70/WCx4Iplx+xHn+vSuNP7RN8OZtXMIaV9qa+8IJRc+hHAe8c+fLXq4RushomzruGhvTwtW1nLu/29xQB7hdmy1iA1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752026; c=relaxed/simple;
	bh=ko5ju/j5NSockVrPDdBGG7MHmEDZS4hS4BKQnuN+2+I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZfoRNyKIepvd4Hbwwng6BF8v3jOkUYGmSYNSI1ZOMw8LggQ67egpwcLRgab1vfU9E3Mniyn8fWTG2uRU1iskqS31x+pqF7xPDjFbjXsi1zmxHBsBJJG+6Ufceco6apMIRkp2MBRCUyVHlMnRF5tFbiXmcfN2PuYheMfbHcgtHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jiyBDCeq; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jiyBDCeq"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3f13043e2fdso661972fac.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 18:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767752024; x=1768356824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cmFoPTysutl7lpdqNp7zT7B4cAvUQjN/lrEalOzdDr0=;
        b=jiyBDCeqhaN9n2up9RBylu9i2vGERKWpCyotZrjqe1LBSp3UlZLOQ4y4X6+GL3sauN
         6AcBYGUOvxds4xMRil0UFNR1IwjpuWXsR539S/UkWN58Pr4K0XZAhb7VLeaVXnmVfAYG
         MOeSUOIZ2sYqJfUTzaDeqnilPQ+DBuMSnaWxzbprdvSEuxLtrfacegMbA/HT9YzMBfuH
         LMNzXo7LpCGbqcUUIUfQ8bpOArsbBiiG05wMnIEnz2xSUTexpWhSxqkcrzmpW6CmtLPR
         IQz4CIAjcYSIsEuvCfKWh0ZKnkZybcxuNCTUbn/MWja8fEBhp64Ufftq4cQxnFQk/0Y9
         GyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767752024; x=1768356824;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmFoPTysutl7lpdqNp7zT7B4cAvUQjN/lrEalOzdDr0=;
        b=pyCsqCjussbO4FoIMo86S/XPwsh5mzIQh+LvINgWqb6tTG9Lk9gVqsMpZVhB6sWOEM
         7nWedhmWrkqwhYHLMKLo1HL5vSN21WgbkOsXS3lkF+63WYoBv7dm4H4FuoHEfDNSGzFB
         /SVyjIu/F1T8tLzfqXIQWbG+ZGAAYVtmbuje8F1nYpP6Y7BYrtGgLTlfQt9nrTT75U1X
         30+1gquN1Y0UF3nxK5RLs7EIW91A8AZBt0XT2s9GlDDE7GHhSd7M/MCCW6gnKSn8czpT
         7FdG1dS3KmRg2dXI6bdQe/H1KP+jqCA8g7NyjZofl78nUxXZXb8vvG481QN4H7GnyhOh
         7oHg==
X-Gm-Message-State: AOJu0YxGjiCD4ekqE0Nf/r0ehD+qdflg/cDpyHTIGm59o/XWhjvmFUJR
	LcJ7I6fdtXTKAj59srqH+//cAXIndKQ1GKYi2qMRiehnsFhRfIynGSqH77MKkrt2em0Wv+wByxB
	V5hMw
X-Gm-Gg: AY/fxX4AYidKOJvDje6i7TEjV5a1ocyZsFBABGTGk1I+mtVY0lVKLBVIaFXvlFm+MGQ
	G3l22btR31NLn1yRMflU0mbTxlKUBjnaIurgwYFZnRBc83LAvKb60UcOIHbXLP7udXrF7Q6bSxM
	vpb+3kbN33ymutL5x4qYuwpKzAFSxPIoE57va4vTz/zItjk5AlurAWxSBMMxWeq174k9l0sDUPs
	rs2BN5gijxPQQ3qqxzGYGnPIydx6ZpmuzN48PBCEk7XyhZzNpDt2MCv44rtE8Qat3MKZyuDoNEP
	vrLuYiDnjw+1zQVx8mZ4GOa2sJn0t5J7H+TU4vKu22ImfDve4aOOVAYpe960yKllS5RuXcViOvE
	XgbQOjhXRIptsBOQ6vgsnKiBt4X80Bg1z4YwBdXg8Cgg9ELesg0CIqRl/16SGqNlLuVbcu8Wri6
	y8YhxRdd+e
X-Google-Smtp-Source: AGHT+IEppoxbhawLA/RHqdOT5mS+agQwDkfuGX33BEL6nW7U9EwrGzbn/dp5d0/9QmUXu76YicDHeg==
X-Received: by 2002:a05:6820:16a8:b0:65b:ccd9:c9b with SMTP id 006d021491bc7-65f55089d14mr424682eaf.62.1767752023811;
        Tue, 06 Jan 2026 18:13:43 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm2280001fac.5.2026.01.06.18.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 18:13:43 -0800 (PST)
Message-ID: <8f839d6a-02a2-47f2-97af-f77cb10c5790@kernel.dk>
Date: Tue, 6 Jan 2026 19:13:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
From: Jens Axboe <axboe@kernel.dk>
To: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <20260104151517.GA563680@unreal>
 <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
Content-Language: en-US
In-Reply-To: <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 5:46 AM, Jens Axboe wrote:
> On 1/4/26 8:15 AM, Leon Romanovsky wrote:
>> On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
>>> Jens,
>>>
>>> I would like to ask you to put these patches on some shared branch based
>>> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
>>> and DMABUF code.
>>
>> Jens,
>>
>> Can we please progress with this simple series?
> 
> If Keith/Christoph are happy with it?

It's here:

for-7.0/blk-pvec

now.

-- 
Jens Axboe

