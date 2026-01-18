Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41433121D
	for <linux-block@vger.kernel.org>; Sun, 18 Jan 2026 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768742914; cv=none; b=N6Rg8kAamiwAuaI8IvSdcjzdICcmmZahkrlnL99KA07GaAA/1115r1FcnZVGrecyqPLblBQTkz0+bf3bElT0Z68JsTPlqexyUKxigf7WI6by8xpuGvniiHY/dVVf3TaT7FLaV6/td1CLZ9vZpfE0cXMhAS+5e1Fnli1JjFmMBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768742914; c=relaxed/simple;
	bh=BZnQlZrPOXp5Bia5QlQZWKSgV/pc65sqDLK+k80YnmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lek+kniCL/Ab2riadJQ84ISbmog4Y4rcPSMZ8kvCsG9omCxv6Nz4+xEneOWDU7v8Rmx6EAmFkSXWEtDpbpMZf/5GH1BRo7CImNw/uMSkRZKtIUybgLXR7SBXkXLG7GO0lpQ/iXrS8E/p49XJJ4IdJnHZ9tumQ9PXPUWqGzHnA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YwkVd7xf; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YwkVd7xf"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7cfdf7e7d19so1758158a34.2
        for <linux-block@vger.kernel.org>; Sun, 18 Jan 2026 05:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768742909; x=1769347709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xe4jmpRoBUFldmYxsM+TCFz25gUOTTr+errdkuJmq6Q=;
        b=YwkVd7xfSqjOL0clKJV4TLy8b7Rq8H+1IZ2SzgHcJKFfRj2O6pm0Oz5ESWIH9q8daH
         Y1XOTA12r6vyqWbU/t4dNHa2n5yzNzWdZbfVqRChHekMxAPdrIVbaAL7hPQlCvt4cST9
         Iq9jkbJpUP/otisilgL2WNyfFPDML/w/Cb7uXr+6rloHuCfSDKtrkq4uViq2Jsl/5dbk
         s4NeW6+MvsyigqHtwUczJ0EqIALZfOrhX450clviMohgd4bqZPryE7aAw9ECEV7qN4WU
         scV7UG3sTJhokWGLtQKh4xqPY3pu/MfIpAZwYUur93DRUQhoaTPu9UzY1qiGk7+Z6YfC
         s2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768742909; x=1769347709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xe4jmpRoBUFldmYxsM+TCFz25gUOTTr+errdkuJmq6Q=;
        b=EotS2fJ7uiMDd+bLOyOcKP5/C38yuLDv8mZwQiGBP3eUdDGXqMuQ6Sji7Sg5fzi6u+
         cW1SiMLVVP2n/xiuRecZTzWdB0YEVCpyEwDXFvbMgSHGxc14KrKmGHODfqgk2c6lWrAp
         8OIG11Bs2VL3ojfCieQxlDkgMgq3Bei6MpMtTDgIkNcYz2H+eSSsjhEdu3IDLO5KFFCC
         Mnsw/meqPBXJ70xos64zXRJHyvmMTl/0Nwl7kAmhXlUmXWY84syC2Rj61NvCPyW+SW5b
         QyE/nmhkoiIHQEvOCgvTl59AskvBctJ1EXsjcg/L1m27mGuvC2QBzVjWDYFQk18eGNeW
         zykQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt1jfG7Xud3XRJ59Lx07Pf/pecbtqsHez6riyZSNLL5CPWphdJmqjpBBjWghDjA5Gd4YXSjetYMEqNgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YweuVRBwCJebC42obh8m1XJ4i2VbipbKrx6XvnSaFrBc4rN1i4G
	XtRaOtneo0H0ReaRHomso1f3jKsLqFDiKVh3FG0Co9L9yASp2UplkzsCJN75ziCAnrE=
X-Gm-Gg: AY/fxX7nF+xNReyVhcBIUlb5Sb+foOmTpyZbtVrlvFfKYXcTt1dVphAM7p/6VRmE/HE
	nWlwL446EWP7Ge/1qnEGJCQBq8Q0YFD4eiVBteuHWEgbTAsqF3V4sMG0uvT1/Y6vHbUDgXTwbPt
	46wo0nMOft+g/iXNJz5vLHw9Ewh1kejxVVCyZSo/MKzrQFB2vwBO2rJmIGc6d3kRdpFWEU0lj0d
	gReHQw8oHyvUfaNhDfPUULxhsQaaRwPpqRqKrabvcca81DCblolAecPQNlROsNdoWqblICF1qkX
	9xrq1ccLDzTpklAb2cg8oCiR77CzQSLdteTWDinSPOOlveva1k9D99zKDsp51cw/giFjtuzOVgx
	N4KgBMiKppASASOukVm24QOgNd6jjaZ3ECkytaN4ZSN2S/y4bZPkHXXAR+PI0/anHq7PpwOkMZe
	5Qeam2YJrZ+9KCbMAOYs5MfDzZn/+yb+gKe1ZqH9a/GSglqsKRW9AdtO6Z2FvXGxOsHsTuvezDt
	BXsf9A1
X-Received: by 2002:a05:6808:50a2:b0:455:8400:f078 with SMTP id 5614622812f47-45c9d740b59mr3689428b6e.25.1768742909285;
        Sun, 18 Jan 2026 05:28:29 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9dec6619sm4135385b6e.3.2026.01.18.05.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 05:28:28 -0800 (PST)
Message-ID: <9ee2af51-9716-469e-97c3-dc59c545085a@kernel.dk>
Date: Sun, 18 Jan 2026 06:28:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
To: Alex Williamson <alex@shazbot.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <176775184639.14145.18318539882421290236.b4-ty@kernel.dk>
 <20260114133241.5b876b40@shazbot.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260114133241.5b876b40@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 1:32 PM, Alex Williamson wrote:
> On Tue, 06 Jan 2026 19:10:46 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On Wed, 17 Dec 2025 11:41:22 +0200, Leon Romanovsky wrote:
>>> Jens,
>>>
>>> I would like to ask you to put these patches on some shared branch based
>>> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
>>> and DMABUF code.
>>>
>>> --------------------------------------------------------------------------------
>>> Changelog:
>>> v3:
>>>  * Rebased on top v6.19-rc1
>>>  * Added note that memory size is not changed despite change in the
>>>    variable type.
>>> v2: https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/
>>>  * Added Chaitanya's Reviewed-by tags.
>>>  * Removed explicit casting from size_t to unsigned int.
>>> v1: https://patch.msgid.link/20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org
>>>
>>> [...]  
>>
>> Applied, thanks!
>>
>> [1/2] nvme-pci: Use size_t for length fields to handle larger sizes
>>       commit: 073b9bf9af463d32555c5ebaf7e28c3a44c715d0
>> [2/2] types: move phys_vec definition to common header
>>       commit: fcf463b92a08686d1aeb1e66674a72eb7a8bfb9b
> 
> Hi Jens,
> 
> I see this is currently on your for-7.0/blk-pvec branch, thanks for
> splitting it out.  I haven't seen this merged into your for-next branch
> though, which gives me some pause merging it for a dependent series
> from Leon.  Is there anything blocking that merge?  Thanks,

Nope, I can certainly merge it in. Did so now.

-- 
Jens Axboe

