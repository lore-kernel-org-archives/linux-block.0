Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B957387569
	for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835957; cv=none; b=aYqvjo/qSox222vV2R/zKukUERgVszCMpnVTQKahKU6H8zJexZfdGy5NI8KprdhmeQeIYrQQas3tKPwiN7Y/RhgaLk0p3Dj0A6nrQQkpBVNscZwyW9SzEAewJA5nrqVOv3ytPNmutj4X1ESe01EUsxthGokJHswS5rPR09/Xqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835957; c=relaxed/simple;
	bh=9lYKl1A4wmL3dbwXIN3aCVha0yGrj9gb1A0dg+knqeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIXYO1eNCCLHgIYdkmxf0ZW/jJTs7lzzWytLfKPWQtYsOJYi5XCdSeTScoZkF0765dtBsqjxNT0DraCqqiZ+X9zKyBFapI6RdH3u6QyO7AoZvf47vhsZNBRp7mTQtCD95AYndKyOgMqim+3XusNbNmLMC4pHWJVegDJ42W5NHCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FkxvkdHD; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FkxvkdHD"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-45c93313721so2538007b6e.2
        for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768835954; x=1769440754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wte8eMJNDbcrKLuDulK17hs1mTpYcPcujxWR+qNMyWA=;
        b=FkxvkdHDP/rhGjIwObbKn0hv90Gjs/INsDHhF5CR7iSQiuxwsbie59ZNLkxms60l/o
         1hdqe+Zz/j2iXLlFTTcyRdsQEFFZ8U4ksFPxOnRR59ifM0YJJog5Hp68l8X9lR/4Ou5z
         2AjwLNdsuexnVnhFrRuXuyNYY5Q+IzN7zp5DEQZhX9Svm9AGCWnxGGv9kMd4GSFyOK8u
         qRABKY+0Ldf+E3ZRs1G/Rilkg2MsjmkGvlx7grm5+RPQ4WaeOCywceFX/5aHk53pngoX
         BPyNx+lucm5xD/W+vobUkQ49NQNOJbhXQIgrXbin1fONk+2vGraqa3AMJETL1iI0PIMy
         gRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768835954; x=1769440754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wte8eMJNDbcrKLuDulK17hs1mTpYcPcujxWR+qNMyWA=;
        b=kr5/f/KVCN+5WbNeMpfOtHQ/RKkuUxRhK0E8BLJA4a3TSzfG1x6Xovs2962USN+M0c
         Le3jpw0lwgtY9SZR0uQrM3TY37UB031pFXOyNjYq3hbxEC5MCrh2sG+ZLZL7CXsJyblQ
         fPVIL8HHD5Fv8HRC47bS+hq9MNKJjWfcjdq0tZpLkgNVnIvma2bHiOf53QsCjPOqfLTM
         aaX/9akG7Psx9fybZQ9vOlWp+mnuR+BZdzPgZal9gXGdW4izHlvBS8x1d8lNWhRJXsF0
         8GB95Kz9nOp8tjFdrUaqOS06c/p3KByTlEerGCdjWXI2fw33oQ62pbFenJr8jwWiRQYi
         r5ig==
X-Gm-Message-State: AOJu0YyqUg4UZt5t2uQ3UZLNpKOTx/yRCy5Yk+Ho69u//yG5fMsaJ1TW
	R7GLBU0s9SHEn7c4fCwmjRlQreMouR6JoV6iqTrtmVYCVb45kRzRWox0Ef/XEhoSPuc=
X-Gm-Gg: AY/fxX6hiEvUrm18p7/xQkx2SjTgn4hBIAkH1NQHaspNPXFwj+mei0JPglJ+6hFn8BH
	nqqiyn3ohEoYOTpX6UAczSe69L0iCgm1wbsorjQ2qgAP0eC7BXgFFqzf4EtlT+aBk8hkmHQSHWb
	aExzVuP3DxDl/rCWci9jTqI/AYPrWgCQj8CjdXIQ1pdQ6mmmsiskEBiyjk585VZJcH6upb6O4gx
	BjZ2HQuxY5qSsSNlaWI40Sxg2MbBchn1fngG5AffQKxn88X0v8n2aIHUCQoXj/1a+8A4clSapOF
	QZj/U2FojR+s89k40fTL2jiikrssb8T3wBlkDS8+uoMiWFd52rvcSSv0cBYvarnxUcL8znzGeYS
	Cx3m10ukRkEQOF7eF/nOsJxHKPM/YHR8SeM2DC978QHdH2vj3M4tGioj89/HUaNKjhQmJyyVRKn
	3VXqLF+EZBNTEBeoz/vDzCBGIj7Soeql9mkAV/EGZvG1nf62Dj15t6kQfGegIsKHnss40Hzw5hw
	hxga7J0
X-Received: by 2002:a05:6808:650a:b0:45c:8d9d:8db4 with SMTP id 5614622812f47-45c9c0c3149mr5241188b6e.55.1768835954379;
        Mon, 19 Jan 2026 07:19:14 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5c64asm7047741fac.16.2026.01.19.07.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 07:19:13 -0800 (PST)
Message-ID: <9859f637-d8f9-48e0-98ba-42cc6255c73b@kernel.dk>
Date: Mon, 19 Jan 2026 08:19:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion for
 local ring context
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260116074641.665422-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260116074641.665422-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/26 12:46 AM, Ming Lei wrote:
> Hello,
> 
> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
> 
> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
> context, and improves IOPS by ~10%.
> 
> 
> V2:
> 	- pass `struct io_comp_batch *` to ->end_io() directly via
> 	  blk_mq_end_request_batch().

This is a much better approach indeed. Looks good to me.

-- 
Jens Axboe

