Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0A18B481
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531806; cv=none; b=l2D8A9yipx9jUaUDV8AGdYCCGPWCk5isre8+IXB2Kuye1uFujU8ivMUc2Tg1gVRS79wSMyaoJMDJoD3I7LSsZZPm4M2opTavynNqzi55EpcoPDbwD/3JXiErs2Ti/V4JaEeMzfn2XUBtpUotbCe2ZUX7ACr3iZr3dsOhh/ZETcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531806; c=relaxed/simple;
	bh=2Z7Mft9XLc5ptgMCtjuTy2E6f4ImDEYbhaf8ozWCLuk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mPSaeELk/YRVCYuEF7Kny2L56LRJ/Fw0Qqm8iiKMMsV2x2WO5OGczDlhsfVm4GJI8hhctUh/jae0eNUBavXYUS6XI7dVqR4qrGbdDFEGn0d/YmtjOPMS/PvtswTYEx0cZWh/6153wQdIgV/uReG/dgoUFUZB4DoDo7WcLY80Cdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bls6nG9q; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bls6nG9q"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ebc0dbc566so3447639eaf.3
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 13:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731531803; x=1732136603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=impCPrA60gwXN9wwJaTYPmPlZjsc4EwtPX6toSuydpo=;
        b=bls6nG9qC6eNybW7SI1AsnS0pxjWxPm/ot7nLkv+eNeVYRA/1FsfR34i/1XysxM/RA
         rOh/2+OL1h+2FisTLqd4L8biVigwVK4ZjzetUO2eQJWTy0CNrG8d7tQFrnUhyAbSKDLV
         vf84OwDn3uBSfCEtdGs4nAutysi25k/LKDLUoxFDu6FR/Y1Pl9AMGZ5/anQ4gdZhKo2k
         TqA1nZBUJ2Ld9ceAtAA1RKxsrCFgwCx7vyfenynujKqFNYJaXQ5PsJw5gzLi/T2U+CcU
         M5Ub21udc3bunb7nua2jzl6sD67mhDafAm/QiJ7Jej4AvqnWjZKB+GX93VpTKwIlrVh/
         bl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531803; x=1732136603;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=impCPrA60gwXN9wwJaTYPmPlZjsc4EwtPX6toSuydpo=;
        b=J8oamPIB3VFmz4vkSxSoM2L6bB5CIUJcvUk99gqYJl4xzBT7kZOcjF8pQp7yAf2jt/
         GAxF1LWqyVk96bKfre0DHR/oUHli+avPx8cEDz5nsWRtdovd/exQpBXnQh1HI2ZudjjG
         ony8e7SZd+Y7ONgZ5K4zxb24LP7xMoHkUz8DFymQDnaauX2Sns7PWgiypJhWmapoydsu
         cXCrrszec6DGWvK5v9hrO0aBxsuFQezVs0JNmVGxsg+xmZ7CxduyTIEh7AaNK67QQ1dz
         EIHXoM6VA7N9Ws2EINa9kt11b6iGaUFafYxrM2ZJeKlfYhCjR+YJGm2LRFe7yJItj9yL
         GfCA==
X-Gm-Message-State: AOJu0YxTbilzLd3kB+JiUf8TX59GpmDRPdzMESqTH2rWifNrBe+uG0IX
	1zpew4TnKB5LkZdDaBC5wdEgTQr9zu3v5mGw0HKg9TjMFMvbrin7Ga5jAEdeM3Zez62lR7aoUUd
	NpQQ=
X-Google-Smtp-Source: AGHT+IF2A3iDfVgDkFq8meEOTgPbHBMDmoqMax5gN+U8pKpFh+bpOYngYUEro6r9zol1GLKxXJxutA==
X-Received: by 2002:a05:6870:3907:b0:288:8aaa:ed0e with SMTP id 586e51a60fabf-29560001898mr19505748fac.8.1731531803553;
        Wed, 13 Nov 2024 13:03:23 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a5fe67903sm962900a34.1.2024.11.13.13.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 13:03:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: David Wang <00107082@163.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241108054500.4251-1-00107082@163.com>
References: <20241108054500.4251-1-00107082@163.com>
Subject: Re: [PATCH] block:genhd:/proc/diskstats: use seq_put_decimal_ull
 for decimal values
Message-Id: <173153180276.2249291.10428535421528000816.b4-ty@kernel.dk>
Date: Wed, 13 Nov 2024 14:03:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 08 Nov 2024 13:45:00 +0800, David Wang wrote:
> seq_printf is costy, for each block device, 19 decimal values are
> yielded in /proc/diskstats via seq_printf; On a system with 16
> logical block devices, profiling for open/read/close sequences
> shows seq_printf took ~75% samples of diskstats_show:
> 
> 	diskstats_show(92.626% 2269372/2450040)
> 	    seq_printf(76.026% 1725313/2269372)
> 		vsnprintf(99.163% 1710866/1725313)
> 		    format_decode(26.597% 455040/1710866)
> 		    number(19.554% 334542/1710866)
> 		    memcpy_orig(4.183% 71570/1710866)
> 			...
> 		srso_return_thunk(0.009% 148/1725313)
> 	    part_stat_read_all(8.030% 182236/2269372)
> 
> [...]

Applied, thanks!

[1/1] block:genhd:/proc/diskstats: use seq_put_decimal_ull for decimal values
      commit: bda9c7d92f24b693eaf0262c090de4c8c108a28e

Best regards,
-- 
Jens Axboe



