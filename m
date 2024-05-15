Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D138FA6
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799613; cv=none; b=gkQwmwu/+HZqF5QoNvyi6qAsJkrx4dpCxLwbYXOZGAT1ourvvo89LyKmAGZe+8sbkHZo82gPot5+Wr3AnetW99UKkDW6M5cnSJQB3ElebP5cWcmrTjPS3zRFR9qJzLixlGdQSzQFta9rXGcpF6rQBZQD8hA0/N8HSZZYsoCW9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799613; c=relaxed/simple;
	bh=jaTMCpliYa58QvXqV3pMPAR4eF2IWFG4iXnt82z7cDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bB8fIBxDZPU/bqxhdNCj+EiQCdG+By76VQGNKeToCGwh5y6oQBZZjf1/9trMDOuGfObMHvCo1WTsu7LC20g/DGxP3kZUIz/EiEtQTq+t2xR22L+bsCJLX8tjDmtCrlveXwKcPlpONlqoeEO898nrriCtv0jatxp7BX48Rg+0ULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q/iPQqnn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q/iPQqnn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ed82d37dcbso1441685ad.3
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715799608; x=1716404408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/3uJsdBbnZz1Z3+KQAN8U1TxWyVKpiQRHRgXw9S5Tc=;
        b=Q/iPQqnnRdyHhj+ScyVgoXEm4FreSLyGFAqkwI2BpKbPQ5bLe03UsWHHyXOP5DEoHX
         GSMbDaHkQkgehL3fEQ9lk1XMP+9yS2E87YvLhDS6BhSCxFdH+J3/pwc+IRK8e+4QhMj4
         0KcJUW5hO8WI2K+uJy29uaYBNRxBkfIGkjZIogGcy4sCIhlCQc7h+P/g2ODOTbPP7yVy
         k1H2IvK+E6UuyZ2YnhwUKz8LkZvVEoPYFVgpDkAYPxkzbMR3FVgZJCwSUWEPLlv1aC4o
         d7QGwxmGaGTo4BCzC4DrEdksvufmRO+EsJHIp9AY2olbVY8DJwcgACEpDdWh53LiE7Uw
         BzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715799608; x=1716404408;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/3uJsdBbnZz1Z3+KQAN8U1TxWyVKpiQRHRgXw9S5Tc=;
        b=EgvZ37OOx3mi9iucfGp8o776ck9fwpGd4AP770J8bvMlveG1rODEmJmJiCUoc4qAox
         5Zuu7secLAywDQnmaBKQS9PrRDn9pcLrHygRH3rD0s3ZDD876QuxZn+tcVmm0o7/1q5j
         wjU8WkLXNca+f+hReeRV+9/oeQl3n7ZNDXnUlVZaGOtlPQrqLFMMhCKW7QYtoVfiBkon
         juLvVkOxltXgj4DXkxIlusZy7qUpnkFJhn7JpaCKLjdg2/qk8hozRJfGglqeS4/R6Rca
         R2DA1DOjSG2qykhg1zN2uKBk6ylK1wRmTEihG1fCWAC3/+SJbk0m6t2OPfyiGbZVnZaM
         8krw==
X-Gm-Message-State: AOJu0YzISUXdQupRlhfkscsLceC9uLOeMz/hKP3lk2Gjdc727XLN1LvC
	WtV8VPh0tLyMdcYg9y+48++dKf0yrbtUecV8hnCvtkAGSUq9L3VveoEh2gEVkngslc//cT2hSdh
	s
X-Google-Smtp-Source: AGHT+IFHaWEMVRnZmG86FK9Qho1mQesYuK6si7V79a2wuRHWqBO07TvEOq5IrXU9JxU5tWKjcLwTKw==
X-Received: by 2002:a05:6a21:c92:b0:1b0:111f:2b70 with SMTP id adf61e73a8af0-1b0111f2ceemr4138504637.3.1715799607549;
        Wed, 15 May 2024 12:00:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0d77sm11477435b3a.106.2024.05.15.12.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 12:00:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240507222520.1445-1-phil@philpotter.co.uk>
References: <20240507222520.1445-1-phil@philpotter.co.uk>
Subject: Re: [PATCH 0/1] cdrom: patch for inclusion in 6.10
Message-Id: <171579960632.171640.15923003704981684226.b4-ty@kernel.dk>
Date: Wed, 15 May 2024 13:00:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 07 May 2024 23:25:19 +0100, Phillip Potter wrote:
> Please apply the following patch to your for-6.10/block tree from
> Justin Stitt, that changes a media change condition in a sensible
> way to not require a subtraction anymore, thus no longer triggering
> the re-enabled signed integer overflow sanitizer in Clang/UBSan.
> 
> Many thanks in advance.
> 
> [...]

Applied, thanks!

[1/1] cdrom: rearrange last_media_change check to avoid unintentional overflow
      commit: efb905aeb44b0e99c0e6b07865b1885ae0471ebf

Best regards,
-- 
Jens Axboe



