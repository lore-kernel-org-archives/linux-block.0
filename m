Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2D4CB5B
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326740; cv=none; b=NbXRppvSPpNB5cRXIw4KdEOigX1TN7SgpFbqMK0CmXDf9KC6JC6nmFDpwIUOmiYQDgYOfXpiwNrnbsZ4MBjFytWZeyj1c4oYGDA0koXam0WhFeJh+W9FE9+TCiYBK22Uot4ef14fmHrJFU3vENoMe0IcAkQjY0dpyxH4oT7dPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326740; c=relaxed/simple;
	bh=ZFp5lZPEP8fcAWf5d5C/B/8GAvuW5E10ul4MHJLu1/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PxWKlZ0R3iKj7UsDt3+s7tKvTmR0WaAmdrN2+GcTjkJU68HxE5uSnpORyFZirjzGeK4UeEkjbyv2B0RowbmjCn7Q6iO8RjmHIh+Cxmt+Q/aRMeZUhC9x5kZURseqsb0AGMllP3sAevP7BAScg9G8kAIMWHlAaaaZIi33t5pFkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=0SlVeg5Q; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="0SlVeg5Q"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4670676ba03so3139036b6e.1
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 14:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777326737; x=1777931537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yrm3z7s9VXAebzelrUiRF927dzrrFKEWxgF4nYtzbz4=;
        b=0SlVeg5QgLoSW+tA1Os9p2WXh27hsMJPqUEG9Ft1I92NvBcLYzTVFhRcajY8EzDaTb
         j7OeAuSqCFcOGkCEcWtU406YDjBjzbjSQpsBYiEOKNdArM5hfJz4LUqwjX01L2OBPoXK
         tFGDYgt/gQfGf6p1nWSaaSK1N9N7xw3jTta8WOz+9fvktr4G2p9M5ci3gxoKVZAmlHbu
         NcCXknbhrx1hKWURrV0SGyG+5nMxWGU/lL6ThJwKEp86umceeOEhawfymwpV3xxG4gxD
         jqYgSM5PnceR2ZQMX7/LG51qdhH5grSv/7IneN972PuAdN8sSOBgwiY+sXTKTCAYrPwN
         y6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326737; x=1777931537;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yrm3z7s9VXAebzelrUiRF927dzrrFKEWxgF4nYtzbz4=;
        b=IGQIYSSjfsGIgXjoxLHIs6xHspiyv/Fc5s8TUGrnbVNjbfTNLOdojk24/NumAq8SjK
         sk50tTuIu2yOTDJnGcIbFZsLfOfxUa1Ihqelje1dckWjN5knCmGyHv8GadYADb4M20ta
         tbg7rYBbYjADie/JVtKgeqMFfcW7TjBGKwtjUdofiraw67CcfNdO/hgt/PL7oZtg1tDQ
         fY3MaMo6WwieaqSEcTYIU90zWrYX3Ob6lvTuwpcYKThq3viQzCPyBwT9arDC779TBlfY
         cv5qJ4zv2wLrHxzhtjCUzUO8Slj9H+ABFADD9YfBUhkV/wYvGq0/7uHJX47wi0uR9huu
         reRw==
X-Gm-Message-State: AOJu0Yyw80BW1LSsrE7SmzfFEP++PV1kG6OFpPPfyJuYzK4JiCD8/WGu
	V9/TY10Uq5sxnrsUaXM+tfqdaG4u+a5kRdt+es0AaZ+hOKVKhNbVQmJYWvifQOQGWFnv3E2MKJh
	q6qsgV2I=
X-Gm-Gg: AeBDiet166b6eBGCRjOPwuhb3F35xwdzYpAnI69kNC8shkd+zjQ8VVDl4vdQFgd4kRt
	gPeCPmquVkTah0liu03n+J+pXsguPlymyEJzvrtvqpNyQBhu6CehHmD/+S/AdCGdNF1RCULK2ch
	9M2oH5y8jZEAomNHq9cHVosMr49fAsJbhip2/Rfz2zv9OeqhRT/CA7liqdgchXXbcGxouPuNAmZ
	MFW9ySsyL7UtZ5/xYkatmRsD4x4qsImijX+PFafL5X8QDeHy98sAcSPHUEhZ/Ej9c71L2ke+TjL
	zlauCXtOREj/xzfucnE7WrHO7RrKpsJYPIeX6NXYbnf33PzOEmtCLp91Ggx2PkYnNVIwWzeBhUX
	kaz/ZmjW3vNnLsE8IO1oZiSFB7CNyI2xb7IaWcGTyTuOCKQEEgVWSxkxoRmKB0pPmDXJnwIzRuf
	O83INQZtKekPOQmiYhIMD2DUFomGwyd52rV3LbEHJO0beanMB29p7pVGYMk0UkN56gPUPOiLo3L
	kn5WUgadaSUrM8=
X-Received: by 2002:a05:6808:660f:b0:479:e9d2:26a3 with SMTP id 5614622812f47-47c28ee99d7mr338309b6e.19.1777326737171;
        Mon, 27 Apr 2026 14:52:17 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c291759a3sm223872b6e.11.2026.04.27.14.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:52:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-block@vger.kernel.org, daan@amutable.com
In-Reply-To: <20260427210139.1400-1-phil@philpotter.co.uk>
References: <20260427210139.1400-1-phil@philpotter.co.uk>
Subject: Re: [PATCH 0/1] cdrom, sr: patch for inclusion
Message-Id: <177732673632.2004827.11400383080055800365.b4-ty@b4>
Date: Mon, 27 Apr 2026 15:52:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 27 Apr 2026 22:01:38 +0100, Phillip Potter wrote:
> Please apply the following patch by Daan De Meyer from Amutable, which
> reworks some code to correct a longstanding issue with propagation of
> writable status to the block layer. This has been reviewed both by
> myself and Martin K. Petersen of Oracle, and I have also built and
> runtime tested it without issue.
> 
> Many thanks in advance.
> 
> [...]

Applied, thanks!

[1/1] cdrom, scsi: sr: propagate read-only status to block layer via set_disk_ro()
      commit: d1a1c3ecee38c81d0447fc0a06b0a2068d1f099a

Best regards,
-- 
Jens Axboe



