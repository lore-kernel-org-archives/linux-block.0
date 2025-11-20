Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90434403E
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650377; cv=none; b=qgcm08KSwTNuGdJcimA8ZT5S7Mftn1WIoCoIdqlDrCb5uQKvqdXReJCCNdQi+P5X6Psi7IAAvvAlr7dhcCX54d0zVyqx5AFEK5DzVwXShkNxEuEStn3VL3yopXXRn9yAwwWRhQjR2ICoiRe+w1jRZ7YfT497laMHrtAdIZLkHx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650377; c=relaxed/simple;
	bh=l/Hl17ccyEKJ+drcSXmwodd1cT2WmN6u3xBpFnrM2s0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O8ZsKMLsR7lZHB+6dbaAslmUpHFDqrJVUgfX9GTofbznQKcRWGPCpREjRbsUVmQsN6QPV13EtW7KkRSZ8F1DqVsUfKrCXuoJ8iCIa/khzRl3U0yklLxqFKASVCH0wNSTkSyqSzdM4k/9bNFhEUCDm6vWOD9go7kS+xiZcW6lZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kmv2JgWK; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kmv2JgWK"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-9491571438cso43117939f.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 06:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763650368; x=1764255168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMlcXFH3jslvGm0AuLGN1rdhcCi22oTjck4ffuNviBY=;
        b=Kmv2JgWKTJODqCPbQCmAVwkbpHtzifBWydMI2bTE06BeY7Q49hnAdpnJo0rdnylQpU
         36tJsnKrZRUnu47a7i3cXIFIkHnEyltBqiH9CcahvQCDEggAvmAedd4PaR5NhlzLUOKq
         LatmUtQfKJfw9lkMRsEEeFclrlHhMi1AJD+JiuD3w0xJy4i8/c3xPAGU8hdGe5j/dye5
         TqO2AdgUxngddn4hUrqSWlF1+i6kA5jZA8z6i44v6zxZ75ZogNxlKJyBCLjKd6k8ah7b
         tCZZVdLSbvD+mPNXRK5ThyX+nm6aGe3sWlgzwvfmkVW27YSmlOANlY0ts/vRTr2VTU+Z
         54qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650368; x=1764255168;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMlcXFH3jslvGm0AuLGN1rdhcCi22oTjck4ffuNviBY=;
        b=nOoe9nc+qUPj7cvkfyPtbFbuNZeErdj1adoYIXKJlmJwBVmZniSnqw+y0CqyDL1+rU
         pAb1rZoXdgQJBOcT2W2rFRdGVQmmelipGPHAl/Xey8eTCgigirRXUxtKNe2annMLgXRl
         jYADuh0+ZaKAl0Of49zCaoiCSMt+jZq1j/vVXSzrbTPwLJPDf4V/bqUw4LPk6KnaAZdb
         3pbgPeesFO02N2KMsV9aGmEfqUlTpjGZTQv6F8/Ho+JGIKBjRUKnHBvN2FmTNGE63z2a
         L+umzHQy3lddCQsW9WEj4/8JzUV1M3k5hpLTpI1RC8itsnk9DVuSbodd0kSWzNyOwQ+w
         7X7A==
X-Gm-Message-State: AOJu0YyBUUJ3L3BVjPVa7GoazZANGKNGrUb3hWEGjavaHMPPntle25Sq
	g+pRAKyL335Jwzmzrt6mJ4MVXES9LQMKF5M1+3aQ72ZxyiIrUNTG0cS+KNn3PioH19M=
X-Gm-Gg: ASbGnct/TRix+5S08DAxCPe8FqRG/o05PSF4d/X3QNVPVfBoXtZpvuNEyWtYyVAZ0Gf
	GhJB7MTjYfc9XOFaLcKHOSGDxr66evH0rzegZ0+/JiN2dqxiShL4kmAV696wpsUvYeSDzxAnUKZ
	Kttlo2pDlub3+JR95SVkVvKGK4NY/NV7xHt1esTjCod+bNO7EGiNxV/i70wQHWy7xHRFxdpP3Dv
	zbY+japQmk4JDxnDLOFAWpqkPEYbVjlRHIpU5GlzDy4ieC1NdA/3G5OLUsvL9j9Uv47w2BjKLrL
	bDw2FI6ySkTAmDTmUlsq0L/fl3APfN+dPt133+U4EBJulrtGOZvHI1/N8Nnb/W75gR9OyJ+5YPg
	ZKqA3TMlFOlTy0WLNf71xFgiC1a+ZeBN82SyIwlSKlxtzCzvxu//0Tm0LsEnx1cwZOZcyqCnOyR
	OFpA==
X-Google-Smtp-Source: AGHT+IHpyJxDTPgPvA5uSnFKBx2eenXg/cSUHpqpFzspGQpS+E0PNyTR3Es91yy0PbSr4OtbCuNVVA==
X-Received: by 2002:a05:6638:2211:b0:5b7:d710:661e with SMTP id 8926c6da1cb9f-5b9541d7337mr2679877173.21.1763650368210;
        Thu, 20 Nov 2025 06:52:48 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b207d7sm1008611173.33.2025.11.20.06.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:52:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, hch@lst.de, 
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20251119232234.9969-1-ckulkarnilinux@gmail.com>
References: <20251119232234.9969-1-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH V2 1/2] loop: clear nowait flag in workqueue context
Message-Id: <176365036730.566630.1797291060556948800.b4-ty@kernel.dk>
Date: Thu, 20 Nov 2025 07:52:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 19 Nov 2025 15:22:33 -0800, Chaitanya Kulkarni wrote:
> The loop driver advertises REQ_NOWAIT support through BLK_FEAT_NOWAIT
> (enabled by default for all blk-mq devices), and honors the nowait
> behavior throughout loop_queue_rq().
> 
> However, actual I/O to the backing file is performed in a workqueue,
> where blocking is allowed.
> 
> [...]

Applied, thanks!

[1/2] loop: clear nowait flag in workqueue context
      commit: b11e483a1cc32e7b557ff680e9bfb4ff11dea9c1
[2/2] zloop: clear nowait flag in workqueue context
      commit: e8f0abdd49baacee3886d5827f113514fcd9fd05

Best regards,
-- 
Jens Axboe



