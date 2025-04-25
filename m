Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2452AF12
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545995; cv=none; b=Ufvlm9cXxh1coqux3IEq9Adia7wKLA9JI012j3lTP0J1W4CfKrsoyhXE84C0KlEBfvVD+SgdgjgTGxOud31KSNOeplybpUVVhZXjBzLBMF4Ec0JGhaitxhbzuymHevIH42EBytoltrzTBWqC2YXuf/KtvOYBfTqXfSK10wbmTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545995; c=relaxed/simple;
	bh=iatUk4u4IMPTlU2X1LYZ+O+ko2WDtIfg48fWNIH/2fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3B8UcdBY4M2E1p8yGBe7r+QP3ZBogu328N/7lvhKYAJ+aSbhTKuFoUMu/CfQcs2wr5Hx6q/gFOPTtlx2EEc+Y9HBoeUFhBL41P1Sj5u4HIfl+8C9/wEp2MZWgzEFTQPbAj+RT5LqqxK9xy3G/I068/W3SDmd+dFm8jvtsntExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DNg9Lw5R; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DNg9Lw5R"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d5e2606a1bso14480735ab.0
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745545989; x=1746150789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1WzMTSe4dQSGXSkG0BNvOisHvoXW4Y4V/ACV2v4vQE=;
        b=DNg9Lw5R45DFig2EpyMmv8U+UUYHxzMrORfae8p+T1VnYBKawoTdwMPDjIBqj7ObUM
         QCq+6T9FpvlPAbIHDlGF4F1pySEFtRgI+LVbTf//NqG8LOMlBTPs+W75lxlFNldiSMHd
         Zq256MD2vUaxx/fZoTETFdYBCzaijIZtWlr/Ss+vm65it162ARyikMx9Za/2GKT3mOgl
         X6KwsV7eWRGf+MvALPVytH2PWSfsGB/WCnHQyL2D/Ck/K47PC9Gun5k+QFeB+NxAZrE4
         weObk3BQu3fGMf15obMmcacim5rF23m7D/zXwv4KSYx9CiaHvan/p2b8aK9MBCTJYJeD
         RGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745545989; x=1746150789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1WzMTSe4dQSGXSkG0BNvOisHvoXW4Y4V/ACV2v4vQE=;
        b=jzRg1HobJbLJVt43DLGuvQzmwfMdqYCMKNPAqeuBvptfIIGyO/HYx2k4cjlSUmEHii
         4hb4Wr6+GfJNstssjPS3diB1XBc1jXumI6mXjT891/sHCXinatAOq5wsdmukthKOApWq
         en4hfh03aunv69fcpUqeQqKVv5lPehM3o4Xdjchd/25WYoi02OYY6xGOyDShFBvhgTY4
         zI/mPLa/UCWURVN3RnaTtoamVUaxOw+QZJ8xV95XoXgevlE432m1V4Z4BLiPiOALfqiq
         h8iRo+yIcpy05A6QKWNeNBpvVHHJrgk6VpsKWZKsJWsfUGbi2bxSMbISdsOhzv6QOv6Q
         nCIQ==
X-Gm-Message-State: AOJu0YxYBrVLI26YvXBMwzToa0pvoSK7qSfrMvgLzV5sgcFEZgOGFuS5
	1t/Cb2hYKT2PM1oG23j39SR4crG18x3bl1cqueDjxyMRFVek6ey76MV/s6aN2YE=
X-Gm-Gg: ASbGnctvBUXKo1QYet33v0ndfFrQ68c7fHVLrtaB+eNCK32hs8IvTYW9ERy8YKmcokV
	xc38NUXB06mu7vSeeWln8Ovv5/+E4uasuoqxbkEA1ZVf2X/Ybi8ncl5Af9laKFwjsGl2LYnpCHO
	TBisIC0w88xL0/Q4iCLi7MKOZXk2DJfcyU20JBdKhhP/nFwhprrVuxcEJONiiTo4q6xeaZXeOre
	2tTeO5CzAopwAuDU1I+ZO3MQwj/u6cQI43RvqUl8IotMXnqi3PWJ/ckFyH4g3TED3p/qrxWseZa
	OyFHYws4YCNYmsKW5rVFsRoN5mwELrgyJc//zA==
X-Google-Smtp-Source: AGHT+IHjM2AMwJNFOy6MqAzmSqc/5TgTGv2bG+i7YpRZaYW0WWL34s9KQf4/lq7ee+Apz9BzWEz+uw==
X-Received: by 2002:a05:6e02:1a82:b0:3d4:2306:6d6 with SMTP id e9e14a558f8ab-3d93b606d0fmr5577865ab.21.1745545989506;
        Thu, 24 Apr 2025 18:53:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a41a18sm544733173.48.2025.04.24.18.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 18:53:08 -0700 (PDT)
Message-ID: <76e7db33-7c24-40f9-b105-fcb84602b9f3@kernel.dk>
Date: Thu, 24 Apr 2025 19:53:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ublk: fix race between io_uring_cmd_complete_in_task
 and ublk_cancel_cmd
To: Ming Lei <ming.lei@redhat.com>, Jared Holzman <jholzman@nvidia.com>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Guy Eisenberg <geisenberg@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
 Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
References: <20250423092405.919195-1-ming.lei@redhat.com>
 <f7d8a462-7685-47e0-a206-77d358ff4639@nvidia.com> <aArox0HMI386qGZd@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aArox0HMI386qGZd@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 7:43 PM, Ming Lei wrote:
>
>> Hi Ming,
>>
>> It's a solid fix. I ran it through our automation and it passed 300 iterations without an issue. Previously we were getting crash after less than 20.
>>
> 
> Jared, thanks for the test and feedback!
> 
> 
>> I also back-ported the patches to 6.14 and it works there too.
>>
>> Will these fixes make it into 6.15? Or only 6.16?
> 
> I think it is fine for v6.15 if Jens agrees.

We can take them for 6.15 I think, I queued up the v2.

-- 
Jens Axboe
