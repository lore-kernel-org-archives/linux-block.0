Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8276255227
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055716; cv=none; b=gPB9jYRb1lHE3JqLm6y2Oh1fSUn+MPSbZ7SXhvXdXi7XZCIbkly3Sr5+t0ut5cTVALYx6AFKQ48phuPo3sr41VHiPoGEK2y6CkOqBTupjbBwI5kBmFabOre19v/Mp6PZhdvvUzUb0bztjP+Z1sRRDvTCjkG7NY6+EGD3APBiV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055716; c=relaxed/simple;
	bh=8JUhd1pHVvQhXcg+Gs72vPAf8WawZzojulGB5T5QypM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nYDTopNdCMDKHuSmDlab2vHaYOHOPFv+6ljkm2PXZs3bAOQaIrNCo9Sp9msEEnflNiK2M4xQ4MAGD/p8waPbe6n2Ws8Sxlnq5xQ9/fhnKKTeLmzLBSRr2Bc2PQ1evZhdgbNz126mcVtS3TFleTRnL2zqhBJl2PNYN4MQApVHn54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zp0mvJbN; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zp0mvJbN"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8647a81e683so94362739f.1
        for <linux-block@vger.kernel.org>; Mon, 12 May 2025 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747055714; x=1747660514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQCveqj7Hc3IDGz6i0bT7Kycx88I5VfC1zkfFXT76AU=;
        b=zp0mvJbN49bzYdH2wMnpLYZ6JeUUye796gzhBBXnWHKKkUlRV+8cRBAjOgmmWKsSNE
         MiuzXmbLvaUh9R72uZjbBzz9fDk6XllczzozICxoJ7/6GJSs/7tyhJ4KTjYTmq54ev8/
         JfBteYQJSe5Cb7KFBvJC0OZBWhH2kyIEQ+9jEt7XxZidM5iccjZDzObM/S9OlVz0b2ju
         /cdjLhgDspK49ic6A4R23AuAG9b2hCcv03B4PiyN6xKAY5BUqiTptl/pgmEI9QVdniZ8
         jxPfaKbSusr/bgDJslQ4o142+keucvXDKgioS8MK3dox9UpjeCKLYUBaM1NbZZJwu1K8
         RzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055714; x=1747660514;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQCveqj7Hc3IDGz6i0bT7Kycx88I5VfC1zkfFXT76AU=;
        b=GrD6fWOwMiLWsN896YxIT9wh/gfiuPgTjvAOdMHTIQJ695FmBW4kIvCKQ06nU9s7EY
         v8I6aD1Ye51R1xgu76KugWASTLSmlBHQ13hljFCKpdXKOCNe+ksK/nETr8GrWe3bksbB
         u/RGfOGyoT39NwKLX/2eZrlKHcZlsP+N11qXEkfqhcQRq0djgcnHh/3kcsqo45ijBV7f
         e5wgT8kis8QwschXnwW1fkDroYosYZfgZIL5AK7ZhCPODsrZdzlz/bEkjMTkPv2IS/EF
         a/xVvTRJGQ0wNJbgNysqQth3xMkj2zJyCti9YOK9gawwap5drG3sLALQ/tTOBv8u1i98
         CVKg==
X-Gm-Message-State: AOJu0YyvIiFMgV9l7xYbooGA8YRrZ+dmsll0gMlUI0UziLrDBDKD7q/F
	XvagsG4LEPxH9QAguCcPpYDcMRdX2hkTvgY/rBGKr366KbKnpwNsqiztX2KwCjdWV6ZYQTpump9
	D
X-Gm-Gg: ASbGncsBYEuvYXJZWo66RcDyfn+3As/46WvvcRliNmHY50SbWHFoBBbXHCWYZpU288r
	LbzepY7wfwMa8ys4zDFAsCInpCXMQ9f1UTcG7K5HfkABJeWUkdjj6OTFIbtdQ+bFOOWNA5PiVAb
	oDxXHmxATRZyQUp1XCctzFn4MNfWSCJFZaD/vviOsBd3EV5/cycSYQ/r1j1gAXtJTBuBPrTFN5x
	xKjMMH2Ly9ZRWKTWhB+Fn3oYc5PfZqIJWUs9oq9kYb712ck2GoKcWS99BUcJc3PagpsoV3OKr5I
	UnGID/qJaLPR2B2oD/xB22/cvY2rVnMlJfMoKpbb8Q==
X-Google-Smtp-Source: AGHT+IGi6tvzwpnlhkRZfe80Hx1RNlmXzYIhWSC0pwH4mhFQGnsGnh0fgg/BYRBH5qaEtnuyCYV0Qg==
X-Received: by 2002:a05:6602:3f94:b0:85b:4afc:11d1 with SMTP id ca18e2360f4ac-86763575ad3mr1537191839f.5.1747055713813;
        Mon, 12 May 2025 06:15:13 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa224d8beesm1629208173.30.2025.05.12.06.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:15:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: ming.lei@redhat.com, hch@lst.de, gjoyce@ibm.com
In-Reply-To: <20250512092952.135887-1-nilay@linux.ibm.com>
References: <20250512092952.135887-1-nilay@linux.ibm.com>
Subject: Re: [PATCH] block: unfreeze queue if realloc tag set fails during
 nr_hw_queues update
Message-Id: <174705571306.246834.8183093309651690453.b4-ty@kernel.dk>
Date: Mon, 12 May 2025 07:15:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 12 May 2025 14:43:38 +0530, Nilay Shroff wrote:
> In __blk_mq_update_nr_hw_queues(), the current sequence involves:
> 
> 1. unregistering sysfs/debugfs attributes
> 2. freeze the queue
> 3. reallocating the tag set
> 4. updating the queue map
> 5. reallocating hardware contexts
> 6. updating the elevator (which unfreeze the queue again)
> 7. re-register sysfs/debugfs attributes
> 
> [...]

Applied, thanks!

[1/1] block: unfreeze queue if realloc tag set fails during nr_hw_queues update
      commit: 2d8951aee844b7c6d146e25b5c3eebc1c72aa6ff

Best regards,
-- 
Jens Axboe



