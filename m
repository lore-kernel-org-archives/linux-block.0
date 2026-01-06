Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6ED32D7FF
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767703586; cv=none; b=ikJY9k/7nJuzucaZcZChh9CTsbqmkAC64gJEm9xHjl87a/N/f4wfcIWhrTJ0BXuTlCXhCeFasUYWcj14aRTI/dqDBY8f65Ih+BTGJBUrjK59eEwZWMdzxL7TMmZ0PwkCsj5YiLBr9HY3Ff35TUClc9lItRBORH0iV4HgGWLK5bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767703586; c=relaxed/simple;
	bh=n10Pz/tlyqrwshlkhpOrzbaZFlFXsqQRZ+y8tIclAMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYdSrE3Fub610kceBEwVum08x8cIXXU8iAPaUUC9DGcgC5jwMD0fKmMfjBqO1hYWLzKRgCD/VkAvgBFGTDBwHQHtiOZqYrEvTt2FIDrNl3xmWMSOeLWF7SRttRFOw1ljIMMgai5WIYtLH9Ex1PmSCEgnmPkE/3JqquXZDCFYM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WXMsojVB; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WXMsojVB"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-459a516592eso608822b6e.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 04:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767703583; x=1768308383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pr+lt1Ch0E+axfhx3pE3FOAJ1aIxZZRzJz3T25FMQ0I=;
        b=WXMsojVB0AMu7q3thEvbH0NQWvp7WM4sStMcVZs14fsaxr0wxLM0YRI3UfBTv4CpIq
         i4/JtIoyPqJSJ9ygDt/qxGueq/xjSWDVxH8BVsxQaNFx0zsadiG/9CbgJL/z2PDhC4ao
         itLDttHEqQcdTc1psAm6I7SXB5K0hjsH7jKETKi1Wk+O7BPWPYklhaxYA04HjNlVCi0u
         2g3FrV4jOdhUpAPYmrD89HFTp9nSOpwpJtv/1W5SyFOBX5s/I9Lc357J+YqRc0XoXA8+
         DMaA1p2r/ESWafLciXG5mX3xwvUUonagQVEcEx0yttQ1T4t0Yk7z33QqWQyjwbuNGgtB
         0I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767703583; x=1768308383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr+lt1Ch0E+axfhx3pE3FOAJ1aIxZZRzJz3T25FMQ0I=;
        b=dQkskBwZHPI3VPC/gXf0ZgI0GEPkjI7Z1z0fQjTfSMiuv2BVXaQJftbKuHXO3HKNKc
         lVysEKJ/ivA31BZObj2bgDcY/Z0la9sb6gd+07oz6ZEz/Lg2PpY7FrkQSCthrLFHgaL8
         USUnLDujpLCggaFvxwMKjVkTpb8MxHt2FXoZdjLcIHtamRDuUdjmDIUuzOLQKAZdhU+9
         UmLRPiix8pIlqSsOtWJSVHCCiqFIqQeL4/3sZAR+LqnNWf87WjJEGLwJCVUgJcpXmKdj
         pXAWYM7kO/SuGnv6uBpm7ownB3bL98sin+A29sYWKCJoSN2JXckpfSfPm+aQtxGA4c64
         MLFQ==
X-Gm-Message-State: AOJu0YzmT9X/wqHPQThV7SWiG0llLbbF6yJvwG/O0xpJnD+5n+Ssb5uA
	pX4elMPILpRqjlmmXJM/FOLIlSVETyPjQ9XQ3AVovhb/SBu3jrbA5szQxVxDFlWerdg=
X-Gm-Gg: AY/fxX7VIxSmoB598IpjsZd2vXhEvCmKkxo1F7iJ0NThjYZbklPhWKSJ4xgFp7tGyhl
	4p+/YohTPbDsLqKWkdo0TGC4wagOqRNfhqIRU4/RPRsr7bPMvwLCbm8erQF+EyxFavadDJjVwvI
	rRwXY/Ac2UihF61T6uP+MW/Md6O+1SgGZOmrxSVIYLQBNeciGd49ASCd55fPNJ+GtLtStFwRH1B
	y2SEff5XhOVZZK4qryJleCTnLBZT8SmRSAzUN95XoGFyFplNFD882HQmrb6RoWs8kSILuEM4XHq
	+c3o39FiGQFHOfjrV67C74S3o2m+StW2vAsqzwJVGDaOoS5E7iXQrxWM9osVsmrJJR5MbsWpLkT
	0xbVtX+rgi0ie0yntM1j8vTvujOLEQQB/dGbOSM5v9K8Cq4qxpJukiAD6RN1nwsHx22TDtuToNl
	RY6jDFDN5L
X-Google-Smtp-Source: AGHT+IHc2lcTDeoYYXv75EDUp9CHROOBR7QiN7T52GiFkXS92SGUSQ2yanZmFDd2NjtTHIO3ToClsg==
X-Received: by 2002:a05:6808:c3ea:b0:450:89ee:922c with SMTP id 5614622812f47-45a5b1df806mr1793325b6e.27.1767703583556;
        Tue, 06 Jan 2026 04:46:23 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e17cd0esm924524b6e.3.2026.01.06.04.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 04:46:22 -0800 (PST)
Message-ID: <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
Date: Tue, 6 Jan 2026 05:46:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
To: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <20260104151517.GA563680@unreal>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260104151517.GA563680@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/26 8:15 AM, Leon Romanovsky wrote:
> On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
>> Jens,
>>
>> I would like to ask you to put these patches on some shared branch based
>> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
>> and DMABUF code.
> 
> Jens,
> 
> Can we please progress with this simple series?

If Keith/Christoph are happy with it?

-- 
Jens Axboe

