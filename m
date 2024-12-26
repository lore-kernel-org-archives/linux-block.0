Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385651361
	for <linux-block@vger.kernel.org>; Thu, 26 Dec 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735220592; cv=none; b=JocJDkmD30pIJyrdhgZR9uEYx6xKTu5ecvw1I5kB6VmiRhFpKVpNjeSg7qYS4cE6gmN0bdLZY2SGjX45SZpORn23KmCyKXE38HDSSJVmxZK94IJ1MKAcMBkkiyjEUpcRkJRKyD3abEBjFVfBMIKEP1nHX4o+3A9z1+WL6HOXMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735220592; c=relaxed/simple;
	bh=M+lyGJRIM/lXGcoLZ6mxSF1s4QEicDI9c93+PwtAN5Q=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cBfolyJfkZyYMx0Z+4UR0dE1hsgo9rMZ2x5CGpmn056NQMY/9GcXxE2nfQRaAa54/6QkhDMFvVA4sfOD3r4Qmlk6DHcvRJYKZtoq3pFj/z7vlp0VxlR7yKxS2YDGf9XSb+wR9ZGGt644070OH+G4C1NtTGrvVbW0KPnJACII7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HASecbLp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HASecbLp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21669fd5c7cso75518585ad.3
        for <linux-block@vger.kernel.org>; Thu, 26 Dec 2024 05:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735220587; x=1735825387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxj1BzkLW+GlWL/bA0IlcvLkeVCJEkfouglIPkuBbXA=;
        b=HASecbLpc23GtqxlUvcRFLT4hkPOXcROzUCbqqcWz/2LfuNDMcrchfgM78nq0fTNNQ
         D5HNUGPJuqBUCeyiBU3TXIEi1VcCzUU4MKWLmUD9faX+TjQwJACTvqwWxoFZUpTN6eB3
         eOPri6neTBZTv7LyTOfojPKKlMoNN2VFQzXnp897u2Sx60xt1bwTjE1T07iBs677foUX
         /GOfa8MSF6TEsJ3mPyrh8WIEYbsZts0LfIxiZ9S4yiMH4wYYq10/xhQWaIlLTi//Y05T
         7fGeV9hNyvPYe+DBWrqVzmk7CpeOG1VEsc3YVMhyWKRVh1OwiU4ESfsH/hOzisqPv6Q5
         Ia7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735220587; x=1735825387;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxj1BzkLW+GlWL/bA0IlcvLkeVCJEkfouglIPkuBbXA=;
        b=L06B/USDWa3yoF9vtBpSZzLBROG8kui5XgSwD41prQUaOwm/5+I7EtRyqmfZkynM2J
         UYY+URuoacfAkQXbzGtluoFr9e1/i8AotcztLzaTgg8Uan4sZX8DAHhqSX+E4e8MFfbp
         zy8833rMT+pQ0WF3J8kLdK2BZ8wuGkMbYe2EUlhvHCQw3IWq5icGqoGeXQDdgJ2mNj9J
         bHoEemYBZBNMGYn4U7bF7bKSxq2BfXHeab4U8UJffpVEL+SqfcG7ZC8pKkrpBzajKuFZ
         p1W/mGevUOjYG70+N3b5GeCvxMJw4fQdQxSNrlEVHdzub0EEcUbTTvet5fwj2r+gU8Lp
         sHiQ==
X-Gm-Message-State: AOJu0YzEhkP99v3uJutwEr3GMmf/Db5iwcRfTNAPMgb1FIslnKYLOBLQ
	5AKcPj9pcy6PSjgF1V09pbhuRKEzM7AZdm3q4WFgcBdtPmMck78a5Jf74ZrDVwTOpXVzXN0Ut6V
	K
X-Gm-Gg: ASbGncuqahFjLLfwm/k4eEWLLdz5aYmAtDFxf457uoINkVx24MZUvH6TQwm3nD6scyY
	WmEmP91oFq/5atJRHuYt1y7QxNhoiOwFObym8yMPYiFLdKYSpKzgFfokCHvEsgdi+8Znhh22mUw
	LbwEFPacWlBpZ6szFqhOLx5vdD+INNbjm89tkEex3RHX0F/sizDuxjcXujMNggP2QidqDgVqXSF
	EL0QPFMYuGpMka8jUfOC20wgyWSSqHP5uBfBdt7yWBTG1DK
X-Google-Smtp-Source: AGHT+IEtfHGrx1DdtvzB+pTP27sUP8RUpHqueIn7usTCsqugJ/9lWUkhEockA5zZvj8omo+ScTen8g==
X-Received: by 2002:a05:6a21:2d04:b0:1e1:b224:74c0 with SMTP id adf61e73a8af0-1e5e0815ee4mr38369988637.38.1735220587298;
        Thu, 26 Dec 2024 05:43:07 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821dab8sm11851967a12.39.2024.12.26.05.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 05:43:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20241225110640.351531-1-ming.lei@redhat.com>
References: <20241225110640.351531-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: detach gendisk from ublk device if add_disk()
 fails
Message-Id: <173522058607.111572.2058737259195753416.b4-ty@kernel.dk>
Date: Thu, 26 Dec 2024 06:43:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Wed, 25 Dec 2024 19:06:40 +0800, Ming Lei wrote:
> Inside ublk_abort_requests(), gendisk is grabbed for aborting all
> inflight requests. And ublk_abort_requests() is called when exiting
> the uring context or handling timeout.
> 
> If add_disk() fails, the gendisk may have been freed when calling
> ublk_abort_requests(), so use-after-free can be caused when getting
> disk's reference in ublk_abort_requests().
> 
> [...]

Applied, thanks!

[1/1] ublk: detach gendisk from ublk device if add_disk() fails
      commit: 75cd4005da5492129917a4a4ee45e81660556104

Best regards,
-- 
Jens Axboe



