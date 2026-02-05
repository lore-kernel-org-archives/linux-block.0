Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72112428490
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306471; cv=none; b=EaFIqLQ11SlEgmhPbYIl0+K4+p1p9tw7ZNsHH3nTIPQT2XF/V7jVnO2p9hjfTB7eOngriXPAmo4KFkpXtPhGo5APBNIYZcKiiBdvi0HqcQ0OBrk0eQmeE5Y+26/YqUJVRvGKA9i4LhB3AO4JCZVUuux0OtE4eGdwilbO3jhHXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306471; c=relaxed/simple;
	bh=Yz6kQVMI2ISQpBNDs3Sq81slp0Av5d7+QCrZtJN92kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvPqx/HRR0vnatBn+q1TvvJcilvNpi9PA7NqNIngIsof3QyO2DJ5yV+KnyQMrQSMngwCwAAD/bwUL2qkekBfEZ7Bf4WYk/sTrHk2Dx75KpWjAixxZDnIOX9KI6jbKb8SPxdJBrZ9l6aGy4xG3rU9+hRlOSvB1ZtVOTNhXQFfogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=amFX1WD6; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="amFX1WD6"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d1851d85daso482275a34.1
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 07:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770306469; x=1770911269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rkr95X8plFoob0OOQYzANjE1jpTBHc9xrcrDHUBHuvc=;
        b=amFX1WD6Pv3uAEdc36GdY7GE0L8gaylsPjdX5XHboVk/gLcdt+XER+UB1jfQN/iHpN
         3u7eqKLe6d4OPaRQqaWjGUWoQ4ymvOkHutDaJNzNP1Ea1zxqdOvxCP9+/V9rXZmuiJ3n
         Y2z9hp+L86eGWNqj2ngy+lFIacz0c7JEqtupQLkJPKQer9WUTiEqKl47/PrgM/5UJ6zm
         oAa13/UyJVhSMpnKe/UrQHLEsrxs+HYKxN9Xnv84gJf3Eu4jVnGZW574d5vcsrRPz8dl
         utYibsRjT2/AuunBsr0MWVZLhONDSp4FWuRHIyrnPbckEMr60VQc9ApH//avlHd9/7PM
         YbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306469; x=1770911269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rkr95X8plFoob0OOQYzANjE1jpTBHc9xrcrDHUBHuvc=;
        b=PICMOuZZb43gb1UaRc9Ahil/juFRgQrq/9Asf4CuX7q5Nrwew0pcUZByWE2CKBmXfc
         g+lefU9YphfHbcleYRmzTfCQ7ZivGdGzQG8ILmB1nw4YSpGPCwGV5J8TEns0OfkPh44U
         qiyoeTQIB9bumF9OxiTMTkaxwjiH3lL9xY4idnj44+zY13u1RWmQdrwKYlubqbsuXVpf
         /TMXJ8ka5YouxiUog/wAC2/2xMn/YUzwIWGcee0OFFLKg0unEq3Lnpnkl4ZMDL4Pk2+I
         EvKiD0G8uA3Ugg5Fb4BPbhyy4XQlTGceIiBJs8QQ1IQV5UMazCC+KOA6nWMRXLjyLQJr
         Ya2g==
X-Forwarded-Encrypted: i=1; AJvYcCUE+YuFsB6J/Uhrpv5ZAVPYCA5utJicxnJZf0y+AG1T3NnwJyk/JENWxHOn8o4ToTqVOQLw8AQNFUh54w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDC1j8S+5360uMoB8m2LeSIsT3bcqeMC4tKWAF4l+iCpyxOSq
	sn6sBSuex8KR1JxVisahfKhzb0Mb1zbT9oiaibu6MCPFcskh3nF7ZMF1wyjycnSYQ7U=
X-Gm-Gg: AZuq6aKBUupl/net4ltmm2CfXJNTqDf6LV9TU/jfVK4BTqDppnfiEUnlITWMVT0k8kH
	8Ngx4Nwk4LxoS97HFg7p18Yn8MiVGWX0VuA+PbtS5rMzqhjD5qOhUiS2FdW6zT6xdHAQV2r1PVh
	vbKFnSN+rHgdAWIVb4p2ScWhZaCF9hHKEWPLjEs5zJxxdBwi3Oe9zN5Id+ulh1rM+dO/Hvxqa8C
	fY+/ad36MwciGAmdIas5WS61ajqdqwvGZC/plEi/xuXF9kJ7tHUxtbdMLez1Ia2JgbqbtGajxL6
	fq5zreBvvu8mcITzLY3a6FlS8x0LtyMLG1CfbTsgP3mHdiWrle5R8ClALEGwmeKDwBZ3uAhFp7R
	fFeyOd84VHJi5l2lV3VxDKQvYmXPdzTC4sUl5yYtJO3COXOhpx1oBOaeF98/u4PKu0TT+j4Qovb
	24ZZhXvSZH64YX/pMiQHb+8KI+cXbkxfklDnVt7KBA/jZ0+b/Xso1o6BB+28HP/hhULYFm53q12
	BTiuuux
X-Received: by 2002:a05:6830:3c8a:b0:7c5:2e2a:d386 with SMTP id 46e09a7af769-7d448ab5e2bmr3399491a34.21.1770306469315;
        Thu, 05 Feb 2026 07:47:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4492299cbsm3615966a34.21.2026.02.05.07.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:47:48 -0800 (PST)
Message-ID: <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
Date: Thu, 5 Feb 2026 08:47:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org
References: <aYS5ZlwruxpNCdTL@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aYS5ZlwruxpNCdTL@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/26 8:38 AM, Keith Busch wrote:
> Hi Jens,
> 
> Some late fixes for nvme that should go in this release. One for a pci
> regression that causes a kernel panic during certain dma conditions. The
> other fixes a vulnerability in the tcp target.
> 
> The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:
> 
>   bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-02-05
> 
> for you to fetch changes up to 52a0a98549344ca20ad81a4176d68d28e3c05a5c:
> 
>   nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec (2026-02-05 07:29:10 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.19
> 
>  - Fix NULL pointer access setting up dma mappings (Keith)
>  - Fix invalid memory access from malformed TCP PDU (YunJe)
> 
> ----------------------------------------------------------------
> Keith Busch (1):
>       nvme-pci: handle changing device dma map requirements

After this one, iod in nvme_pci_prp_iter_next() is now unused, which
will trigger a compiler warning...

-- 
Jens Axboe

