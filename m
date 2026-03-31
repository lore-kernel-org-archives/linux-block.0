Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23313DBD53
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962448; cv=none; b=uaoeqI5rOFwntbB8mdkhnXUCXXKVe4w99M1BvkyTbenMk6cxQ8ZrmKEelmcuYzU8D63empo5C6uoO1hzLBI0ATvQDdjPccGddw1QPeeFNLl5iTDy6uOTQlhUVxecps9SR2XiNiDm2rxNMnDyTH4DcTMPSSFbnf0z4NkCtfu8ms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962448; c=relaxed/simple;
	bh=3mcJkD4vKqnObHqLS3Vh/zwg4vB8bfTdmHHDXR+zskI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=inVt401zslk7KiCNytULl8x0NVpe+2QBnVL9urWqPJB1bgIpJb7SESM9i44a14bYLkV6Dc4VOYQgXDG/D8WbTP83XT7s8AqrXeXz3pH3ugc0/1Kdk5K80sgava5fOkBbVGfMaF55QgsYVPrPFtGGKTERMuOmi07ubRXftgbW0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WMZXHA8t; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WMZXHA8t"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d556c1a79eso5808984a34.3
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774962444; x=1775567244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AUuDp7qRRFNh+jkpUI3TamYrmgDFQIePYtpyrxIyfI=;
        b=WMZXHA8tbCRbciOa/MrfJai7rHZk1zfmMeP8SfPxHomJk5IRGqvOb6HOx3MxhC/I8A
         h0+igbkgkuYQvG+dZZ7FCt/LHIgSk3++n4VPJqZ+ZLzLfoYHwwgPX5TJqsJ7xyj9Okhg
         baL5uYDA/Ta5MjsKVJynx6CKmixw89dAJQnmIL/+mBI5o3NnsKpNAcT1RlPRUoyfUr3y
         BDwNDYXZJ2Da2Y8la3tLlbD3i6CGlY+fb++FUdnJeJMxGgd2fldsM40jdv9yvZoVpGR3
         wxrfg1W4c203go4idmkdz98nc8qxILYfhuuW3GueOGatphw2DXQzehvayLLSIRBv8iCj
         WYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774962444; x=1775567244;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0AUuDp7qRRFNh+jkpUI3TamYrmgDFQIePYtpyrxIyfI=;
        b=nEwWZeIFrdfEDEs+NDYQj9MjlG+qOx72jnItc9nnAWaUn+4h0KCqKj0suiyMjM/knM
         4DZXlq8Pvm0L/c+6vAlv2VniRCMjVjDlAwG4KDcXQKu6jr1NIzLVy2v8az2ZWC6Wb0QY
         JytYcv+lYx8kbylWc01RDqgKLBxJRD7XIltV0k3qXOqqqBwNk3YW5zGJRzBzPx52qh9h
         WM2BVA0CjYg+o77w+HodELxLj3R4/8qgOR8NO3XSot/wV3EbAhGhr6TWxaKoTbYnDfCm
         m4MOqn0mINOkOzdrQayj5R0ePMnMgCdLesJjggpeOfmvVYGD7G3TRSoTogbC3GGlp7W2
         ELUg==
X-Gm-Message-State: AOJu0YymuQH6I0lfS9SWtd500FQBa/GCgKij/buJJi9V9VOycpTCm3PU
	vrGgqaCkrhlIjXlspaVg6Je6usw5KAKbV5SAz9+GmhGbT/9JJPrj0QWr5jtH7kzYtvE=
X-Gm-Gg: ATEYQzyYRW7elbIcFzKnQR0IGSw6rK7s6PftPgjAVJZaOo6SsHeA2yfK3b+O7BaOwkC
	glJwQy+5DdouvsrnXZZIJSyfvTecHraBydM4wUtSjMfVknQ6kC1yaBS+VJXeK0lPHtXOuyjKvJz
	m+CQbcEtEiSpnyybxiDrRbRs6+g1YEtKzr2NJViwzjA6ahLt50z/XFDcw8IOM8dTHJLVVX3jBjn
	mH6lqQs+yAewogXmYeoe3Wo5BRVMh84awwmEeS+BLRXlJTpRW7+K30lYuEZJDLLUjnpii6/hbqL
	Bde27oFBdVOxTeRP5x2rm4zeLSUOCqm9Owgt0tzh9QC2JMsg1Sbkr1ixT/LacekPpGuLZKfQKQc
	dBxP4zsTAKgc8ShquAQfFjylLGLBsKW8xKktZ+3szc0QhjNRET+d+j1mxNcKHzvHrE6h+7usThu
	B7L5Mz6IJvoF7Yjygjou3on5xD2ekgnc2ceqggu8rLkclE10EOKIThYWeNSju8I7X2mtcjY+nHP
	EYz
X-Received: by 2002:a05:6830:7102:b0:7d7:5559:3d1c with SMTP id 46e09a7af769-7d9fad8c6a8mr9556898a34.1.1774962444499;
        Tue, 31 Mar 2026 06:07:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a335414sm7901689a34.6.2026.03.31.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:07:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Milan Broz <gmazyland@gmail.com>
Cc: jonathan.derrick@linux.dev, okozina@redhat.com
In-Reply-To: <20260310095349.411287-1-gmazyland@gmail.com>
References: <20260310095349.411287-1-gmazyland@gmail.com>
Subject: Re: [PATCH] sed-opal: Add STACK_RESET command
Message-Id: <177496244365.811501.16816774352932254478.b4-ty@b4>
Date: Tue, 31 Mar 2026 07:07:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Tue, 10 Mar 2026 10:53:49 +0100, Milan Broz wrote:
> The TCG Opal device could enter a state where no new session can be
> created, blocking even Discovery or PSID reset. While a power cycle
> or waiting for the timeout should work, there is another possibility
> for recovery: using the Stack Reset command.
> 
> The Stack Reset command is defined in the TCG Storage Architecture Core
> Specification and is mandatory for all Opal devices (see Section 3.3.6
> of the Opal SSC specification).
> 
> [...]

Applied, thanks!

[1/1] sed-opal: Add STACK_RESET command
      commit: 499d2d2f4cf9f16634db47b06dee9676611b897f

Best regards,
-- 
Jens Axboe



