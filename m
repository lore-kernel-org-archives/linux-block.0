Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB903E556D
	for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354201; cv=none; b=VcsNUbWQ0i3azafKQOinzTCoQAP3L78IjJKxU71IFWoWGRXwaDectjQTLBZUAu24gr11nkWdhlcgS/GOi+pyZRe+eaypKQMX9hQC4z6zwXA/VkttzPuV3KvNA/Sl/fjZ27KGhr64K/hvs8JBKGgCEZRtvcJdK4SXuPr1F9lXiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354201; c=relaxed/simple;
	bh=PggJQkR2J13/8y/6UciNaSwyEFkyOn5qCQmy/otiZMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ht6N/OgJ6YG/lTk/urRSmfUM7GVtyTTXD7tAeEPL93MehdKYL8g0qC/fmRBAiRjqEDO3hpECuuKH6gIg9kxrXQCqbBzXd1mgiF6v9+QnJPGuv4HQwklzvwzrSERqTXs44V/WyrVQtHPmvVqLW8BtrjuByYKye7H1S9CD4a9yb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=JxGLG+V0; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="JxGLG+V0"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-48633190849so768254b6e.3
        for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 05:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781354198; x=1781958998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTrGzTSA4wURCRICWGU/m2ppaKyLA5r9IM6ezNzjNiU=;
        b=JxGLG+V0nEBeCynUFDtjMk70Q1SDOqewYMUclssptAU0hrYaNKubAUdN9iRw6qzRPt
         5S0ihND4z2afxwAtrz16hIymsUhMhjAnBHZ8bFvVpk0aOaCEw14iUazZZWqpxvBvN+Qf
         0y3sM25ttJyzYe/IVDM60DMP0UPRi2hkxGpJaYX3J74sOXusW16fIgzUkyOqbBJgi/H6
         /RL9MK/fj4V+ViPn4kqoTtZPPtoMJ80xy3Y1K8zTnaIFL+eGjDFVbawH3ec/LWYnNnRw
         7paw2jpMtCASz2RwODkRExz5MeP+pKJhaW0ct7cm7YoHxMIKMCRjWVQEhfHRj/yV0nFU
         HsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781354198; x=1781958998;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JTrGzTSA4wURCRICWGU/m2ppaKyLA5r9IM6ezNzjNiU=;
        b=VGjIopG8spVXkcPH2s7zabo4119jph6PCH79tUPCH+1SsZn7rP52vXkBvECMCiXkwc
         pKsjuGKesbcrbvRBjns6ql67seh6uDn7QKo5+DVZ1M7Nj72BJJth6b1Z6tB2jWy8f3VI
         UaBp8Sbtk58FbqG2tYvxdmE/gRTzuGwKqkPIDv/n16Zcj5koNp0yWC3PIYXW/FnRilrg
         hTsnMvCDiWJBtMNtW3z563yKbfCVDveeVWG8uXPXWXtp2dahYKIIgz8XH+XvuBCdDxwA
         XRI3txSA6aMxtd34EJ+4WO7cYB1SN+v7xZlQbL1qivKU6vx7AlY0k5yG2ljIVTVpF9I7
         3nZw==
X-Gm-Message-State: AOJu0YwlJGk9efVa1DWNAVJrWkrO1mCTNO5LJ6Z2sgZEMbM2o1iXX/5B
	/nrGWoa/yS3vIc6CXhfcZrhcz6vJlpbvSebWXy6kqv09IRWGgeEIvl1MhikEkkNFkxg=
X-Gm-Gg: Acq92OFoeDc9eySIi0plM6v0D5mDCFc5q8HluU+v+sYB0xpZL5LSwTJPPJzbkWkHFgJ
	NNIiTPbz7MmuICdU2VrsCQVXGq8OkUjbehwt5QqjJnYRHf8fGSwWKYS+tyTkTz23Ufur7LM4CKL
	W1seZadnV1+Q1Q0DjQkX++f6j5zy0nk1goWCIw3q1YyPNFv2JApf4A4mBCHEFxs15bhXSOGwsXa
	G+cM7GeS9j476EdBnPmdK1g48EZ2TILovp7bCnpH+woThZJRAUqdyXcz/v08fNIGvCu7aNrO8NX
	ziP+8f0f9pnCE099MIO3Uzl7qWOsho8anbSc33jzCVsqZP0JBwPuVMcCNUIShXKBQOmzFrT2fA0
	2P4YQfeDKGxYvnkfYPTWQFaiRAjiQnfdltxjPyU3ts0cL4y7d6NnQpHRz0DySZKHJHYMGaQ4Z1M
	J4n8KgM4gytPl9QgiblhUKW/5It5dPT5duOy1KVtj703lX98BbFlOZ2ZL+yFGMq6XCJWuD+x+qY
	SZI
X-Received: by 2002:a05:6809:11b:10b0:487:500f:ef56 with SMTP id 5614622812f47-48750102fedmr401749b6e.34.1781354198173;
        Sat, 13 Jun 2026 05:36:38 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48731554fb9sm2641107b6e.12.2026.06.13.05.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 05:36:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>, 
 Carlos Maiolino <cem@kernel.org>
In-Reply-To: <20260612223205.465913-1-kbusch@meta.com>
References: <20260612223205.465913-1-kbusch@meta.com>
Subject: Re: [PATCH] block: check bio split for unaligned bvec
Message-Id: <178135419637.1909114.6793253892373336850.b4-ty@b4>
Date: Sat, 13 Jun 2026 06:36:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 12 Jun 2026 15:32:04 -0700, Keith Busch wrote:
> Offsets and lengths need to be validated against the dma alignment. This
> check was skipped for sufficiently a small bio with a single bvec, which
> may allow an invalid request dispatched to the driver. Force the
> validation for an unaligned bvec by forcing the bio split path that
> handles this condition.
> 
> 
> [...]

Applied, thanks!

[1/1] block: check bio split for unaligned bvec
      commit: 9b0c3673c88588d613d8f09f5931b2b466c6a83d

Best regards,
-- 
Jens Axboe



