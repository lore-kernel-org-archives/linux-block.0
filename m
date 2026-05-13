Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15664D98F1
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692514; cv=none; b=YsPx9khRS+2q0J5l7pHemXQANLEXyg+PgI073t5fdUwnUUzPGZ9wCJY/4LRnll2vAC7FKuvXlWJNh7qqpbXWNm4DXKjrOYuXGHbPIMbR33m9rbiHCOtP0StWK2NOwICngt8xa3vFGUaKFe0rszDpwZOvCVqa4hWGDj8sOjuw6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692514; c=relaxed/simple;
	bh=Iaz4Ta7/aArc8u5jlDHa5DhHsZ4NcZfOvMTNbV7KGSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEaxyUUGWQYg2FBcZdCZbL3PUUdtUhrcQFunMDFLpvqkvLcH2pzhIaJHJcWUmMvzv+ZA5F3etyicxOdd22jIarQ+UBTXP3L6HB/OBJQ7vgfVTJOx8BgBfhjCI2COCV2umwuyGiC1cRx29FCx+uRGwrMmakh3X/+f9y9yGP7dEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=EdLZOvWG; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="EdLZOvWG"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6948d7ccfbbso2968381eaf.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778692509; x=1779297309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzcET/6EBA26O2gB5meYX8WxvSiEZYzWqssd3s1sb8s=;
        b=EdLZOvWGT9Gnb7r2EIssEUFb9Ljn0BYDLGWy9ymz9FZ/DZtvVdF4eMU9RevEFGtC6+
         FnuUbwavKhWjOqLsCPGzAbjIN3EnJ1m9J93YrxB43NTFqVnKOUrg7vqeGG1TcBKuND4h
         l8HzsyFnYfosMcHpn/kA7XvcbGtkibEW6JVCBR1Lyw6QBVLcKpKyFHqhCe9UXvUCgOa3
         W9eSHmyjDwVEufcWBfCOi/oBpX5LJg74IkGaWHG8OdNcDjmEASRLv4YqnCDFize26s25
         YdCpETz1XXOKMvG3wGIBAKaesTi9NMrfV+fNjbEcXbS+5IEZ1+PBFWKdmYo0+Thz4fU0
         gA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692509; x=1779297309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzcET/6EBA26O2gB5meYX8WxvSiEZYzWqssd3s1sb8s=;
        b=tS20F3RHIpcam8RWaRzdBQ5ohA1Y10IlCeOLMHhDSXNYjfSnM2AXeGBCt4UXYMIoys
         dKjYXPPu+OTTvTp4OTU4h7/5DYB3qAI1xKdTxTEMsS3cpdR5U2fsRMlDyCNjos95xXkJ
         vqMfWbbet1ERs+ZheviifStR4I/kF5+ZMM80vSYNInw+DyW6pnlszr4qXa7fJz7Qsmvp
         2jdKlG54M+dsx2nqZvnydG8fkh3wtVJcF3DZqP+hVNtEACQ/RVScT5VpGNe+AnQF9W6B
         9PwJepPyFe+7CEzoY5W/dnlnWJcUeMtn0akP0eQ0b7tgXRPf+Lc3A0CYk8BrMU8pELpf
         u4GA==
X-Forwarded-Encrypted: i=1; AFNElJ8hHJSw3ZQA5/aLvDCzVj8sdhvXDivde9qdR6hDF4xBnmIOP70UArGEoocFm8HR00YuctTOv/eUNTfP/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwweFljS0tXEy62LRMjLGNlvfuQ8KSLsB+V0z1a06b34YAxMT1B
	AreB8HctNY/dem0xBftlRPTk751zR1yewnkuQaW4s37u8DpYBTtAGQCWFBm6GMJMcls=
X-Gm-Gg: Acq92OGS23UEWF7iRoZPDn1Ci4Dbdn3gjCUJEk77L2tba8mElApjZDQ5nOPFeaN7Ymf
	h5Cqy37M7IX8+YR9Bt/1CYOOY5rGEq1+4iTm8ZGZCJJU7YOCyVSqMP+qi5gxZFQBRn3c9TRdeFz
	aOQcJ3HY6mPFr6vPrrzPTH5W3M97akotEqllZOEs9rABKb2VeejoBneHhjhj5WxIxzeeYc7C0P2
	IiODmp/04QoVsSGvqRGI6k+VFdCNZaFE41lZMBfJ6G54x1pVOguqEFXL2JgRVPSGJ8qQ8bwmX+f
	OX3exly80dbVoUf6XoyBjIOaojPy9yiIvmnYjo/bY7glfUl2VXrjsUmi+PcYdxepjxcX3TcUdRG
	0rsBKUDXHEnvrHBoUFEmAaNxMDLGaUVHTGjn43gAN+woopjzOIgvk9GO8dhmpAU9yIK0CEAmZRG
	7fzaWmivaUJVTXwB9PmP0z/phgH+T0OLp/mgo1TFOLrl4bEd0xPAXpAXqHs96za7M79N6VxrbRz
	JQR7Eg7
X-Received: by 2002:a05:6820:4b0b:b0:696:1fae:fb83 with SMTP id 006d021491bc7-69b78dd8381mr2499356eaf.34.1778692509425;
        Wed, 13 May 2026 10:15:09 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25e0dbb5sm9611857eaf.13.2026.05.13.10.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 10:15:08 -0700 (PDT)
Message-ID: <683792db-32fc-4765-9ba6-3712af01676c@kernel.dk>
Date: Wed, 13 May 2026 11:15:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fix block layer bounce buffering for block size > PAGE_SIZE v2
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Pankaj Raghav <pankaj.raghav@linux.dev>, linux-block@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260507050153.1298375-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260507050153.1298375-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/26 11:01 PM, Christoph Hellwig wrote:
> Hi all,
> 
> this series has two fixes that make the new block layer bounce
> buffering code work for the block size > PAGE_SIZE case.
> 
> Changes since v1:
>  - update a commit log to better describe the applicability

Can we get some Fixes tags on these, please?

-- 
Jens Axboe

