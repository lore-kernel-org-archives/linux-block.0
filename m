Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6935F8A7
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875582; cv=none; b=klyx/FGGw6qlkAEL4pln8NfvUssfpv6aKgGpm7YZoVMYeRX5Uz+q7mwoPgUkLTMhZzFtqvKzt/ca9TgGKbqISDsvufXI3SIWXbmHgIi4gkiCt/vKlQnuXOuQeubs49e+vkNUpcGmuXvtQnGqvFwKj7HnU/qxansEZ9KyViEsd4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875582; c=relaxed/simple;
	bh=cEH5jKud37Ut4uAau2wbec6Mi8UBb61QRGB2ASEBwck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WHI67C7PQ6Fh/jIxbTChnbR2g+2AzPU0p2sL4qObbCkeOrhkx18beL1cUkOP8qMOPPdG+sx2r0e+aP2yEAlblGvFxOOv88yp4u++2s/vEO1PUfeZ7CxefIddKF4Z6Ren7Yj48+3ALJhX1YBsl1TP2TN0KKErtroUHRVQAwZygbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QazHqZyj; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QazHqZyj"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4331e9cb748so3690915ab.1
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762875579; x=1763480379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLrTWxuYaH3EU6gA0gU55ZOBwqFiNvTbPI5shGJZ/Vs=;
        b=QazHqZyjAF/FRldg2XwA9cPDDRd7U4GG0KLoW42e7GqigksMrQW7S+sl18mOyncTks
         fx2/Zasa9h6aeQATfyY2LksKa4R/H9r9BLyQPM9y1ImT/M8gYMmW9lmen9cR+Bg9e0/H
         YFhOnXA48bDqLRdNznnwOuWLn/UMe+Z2pCjgyXJBchUCJQWEQ4pKKlKISGLkUPofhgSQ
         EyzIlI+0hNoZzXZ8m3RveKGrMpl5Jlj3hO+GLvt2xJiDLOVxg2JtdrksH4tKTqbqlCXs
         X3xmYSSf3fGDG1Ic9qUwkTkCMRmFgcFdrFo4Ua38JNBvxBqOdxDLXwBE4jnFFy24hU8g
         5h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762875579; x=1763480379;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLrTWxuYaH3EU6gA0gU55ZOBwqFiNvTbPI5shGJZ/Vs=;
        b=w2wWamYJdo9+OEzv+8Mgxtp9zqwPL/flZwRKI4k1UvcBTjl30U5FM6BNACihtVL+5S
         +cC0gNARfE1x4b8iG87aynkkKMHrfSy7VDD3Ia1PQVO3ebULcslmwNv+5LFfFxnhx2mJ
         0pYT/J09wwBoWOKdNgRqYVcg7Np/Lm8oR+H+5N+IpPAzgnFVJYqh4SVsNAyAH5GAZG2M
         QQJyPqTeg4hcTJ/r4LLCIDfm7hH1Ru4QanAS8HeWwcR8XPchPxZMYPFrjNmB8884MIB7
         uuyQrGSMApZvWB5bJCB+qn02by9rExD1qJza74O5yQR4pm7HHphUpa4nI8YXFoSLt/mf
         PcHg==
X-Gm-Message-State: AOJu0Yzchfz1owq/fuC6KNT1DJs4bdtV485+XsYvQzdaGAX2pnSyxAVs
	ch6CHIm1AE7kwAdhRTYgA9vObnsaVmG1zwOawark1UeGj9iJ2wEaN8Qkzq3cyjbquuw3hGQ1lix
	VYkVi
X-Gm-Gg: ASbGncss2Qo5OZae+nZE+pk2C6gk577Pgi3bK4uuaI9yaZMJR7AVJaJZ2eCxJeZ+WzA
	IxlTUjtXhIKncHSa5idto+xgfnYWtynA1I976noqngmjLJV9dfgWr50WuVcJlr+C4MjTw8Wrvce
	OHEQWvUngxaqPMppPl94f3KZ82WLqu6VORqj9loAXT15ed79E6EBTrklUNaS3z1y+o+7M0K5hru
	yQYa69fhpEAhjI/+j4L+rmjFfJclScGpRtVGgzGBYBxu9YDqaWgexBTWGwhmutBC8cwN+8UyFVT
	ZOa+94E+4KBFXe4pI54BeQuAMXtlAG//ZZ4LKleFiWW1SYNe9/QQAYobp8f2wSm1UQplt27Bqbt
	MbLN2hGL2Yuz8bPKvdd6jvExZZHGbwI3gdF5ZckDcmTMnejHVYrUAgT6xYYeRmvoJbl8T+nflNp
	HVEYo=
X-Google-Smtp-Source: AGHT+IHFsM5Zl0GGE51bbx2dgFFwizRiJUsR67FF2A6HSsCKq/X0xIJ2XJp1FbG+RSFGG3MnBlWa5Q==
X-Received: by 2002:a05:6e02:ecd:b0:433:3060:f5b with SMTP id e9e14a558f8ab-4338beed058mr38487015ab.12.1762875579296;
        Tue, 11 Nov 2025 07:39:39 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43473301539sm113695ab.2.2025.11.11.07.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:39:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251111115810.2320857-1-kriish.sharma2006@gmail.com>
References: <20251111115810.2320857-1-kriish.sharma2006@gmail.com>
Subject: Re: [PATCH] blk-mq-dma: fix kernel-doc function name for integrity
 DMA iterator
Message-Id: <176287557764.181573.7380138449406423011.b4-ty@kernel.dk>
Date: Tue, 11 Nov 2025 08:39:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 11 Nov 2025 11:58:10 +0000, Kriish Sharma wrote:
> Documentation build reported:
> 
>   Warning: block/blk-mq-dma.c:373 expecting prototype for blk_rq_integrity_dma_map_iter_start(). Prototype was for blk_rq_integrity_dma_map_iter_next() instead
> 
> The kernel-doc comment above `blk_rq_integrity_dma_map_iter_next()` used
> the wrong function name (`blk_rq_integrity_dma_map_iter_start`) in its
> header. This patch corrects the function name in the kernel-doc block to
> match the actual implementation, ensuring clean documentation builds.
> 
> [...]

Applied, thanks!

[1/1] blk-mq-dma: fix kernel-doc function name for integrity DMA iterator
      commit: 6d7e3870af11c2b5966b2769f9e8a0d4764f52cc

Best regards,
-- 
Jens Axboe



