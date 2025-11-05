Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B363231C91
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371956; cv=none; b=k2NTxWDCaMyoJrXC/qfJj0lxK9yQZZQKxEMP8S3WecT73V7PnDdKdVelSAvqr6c0RLaD6YCxkW7JzXut0lGj8jO6vTRs09DtO5vJsJsEabfveek7qga83mJW/Age4cZ63vKp8AD8ZCVhkPtYqrMLBuAH/O8Sa8JPooqRCX/5Nr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371956; c=relaxed/simple;
	bh=d5fb9eLkxRwWhqlLIqwFiRkzkDjN6kA1mPCzcJaqduU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iHw6e/zaOrEkA0r3oVTiS6qaWd5koxbdMojUSRttBxoEL5k38EZk3bhDjtSeLi4z9gEAKNaHgF68vdD+B+hN9v38W8GPhyuONb+J2rhX2a8bII3JG+ACuDswTZusibHdyX42ilhn/xYpEhLtxUo/0kGo8+jZNZcb0MyWCTkGAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fbvFjrVp; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fbvFjrVp"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-93e89a59d68so6328839f.0
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762371953; x=1762976753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tCxb4J23HHLQ1MBWRp++0m4A1lC64Eilk6Sk2yk6Ow=;
        b=fbvFjrVp/TCruvWRkW5pTjjJMC7VRu/63+nwO7hvJYm4qO7UYyG9BBgEPBBiuKifPJ
         GhjI6ftbpFzEY5Uu0AXplNtaN0dkLxgcNzqHDpGbv5CmFSKWdW/b/2S5cHJeYp4MdIC3
         Uja35appgP2DdnqK1wONx4NikV4SExh0uQflpWXImR7PYmQztkpZa3W60yWAU7vBLlvU
         vaDP1XiiKz26MCj1hBrLVUlBZOO6Pg3GCSd3LJalhU/gyYSg6DZBqeXv5+wIXM0gWm7E
         RaFGg6NfkdHr1+ikv6LvAzaIgSIadSRUvsLcLEAR0TQb3oGzekuaz7tInSwMYHbzFEFF
         C9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371953; x=1762976753;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tCxb4J23HHLQ1MBWRp++0m4A1lC64Eilk6Sk2yk6Ow=;
        b=pbDroiE6bW+a8fDorU0M94SLTX6Ge8a5uoIh6beykWhOl555U39eIgE6dnPlyGWzQO
         ZL9V08R5qVU5tjWUDtOugErmeFJOyq7gvABRYK9WR9zdg5NZE8QlakSQfa21I1CItP0F
         ru+DhLjtMkDt5WUXgCbUzJ2XRMkknnGOq5EQcWe6RtzoO/OFFomN5uOR1k9HiEgMjH6I
         LL/L5elfdvafqgbhJQ05k0uQqW1vQsloiIoT/q088v1JB8UJfpFYLDZmv5FHAQicEifl
         l1Uo+JZ3c8EWirpAEbyXqua8CQhWxHRRFntUr4xuZqu+XdRwuM/V3wx7retvNXXWkWZ8
         AUkA==
X-Gm-Message-State: AOJu0YxqMERpIkpH6uaYwHAuaZYJKUY55UsIixDSNIuz07m1Hb/6Y5JN
	J2HpYtkDy1mGz+7dTNutrB0jDi3DTnRMDv9VoCLj2aV5/AXNRnd/gIJBd+xVCq+FaPM=
X-Gm-Gg: ASbGnctzjtjbVb2cTEuLwwc13HaAEjAmZ6SNAAXuXgD3nLSyyk012J78UuqumD12UUb
	4aGX0tAUDcSourzB4x9dxjaZtoMcSkWHJ1jNd5up6Dm2euWpZ8eA0auJfQmaiDdFrw9Mkcrld4+
	tG/wdVpKKIDxkqM4U1QKzcVhz8NodNzm+Q87T8/QrfEm+d3fjkSPPiQmFPfhqQUd6SIwHV8R3oN
	qN24sNgb664dMPYykMEGk8XU+HAEeqhL0j+XJzYaxDJUb27RgZGj7yMM42+jBTPU7DVswyYUWy5
	/fKO6k3Zrszu82NIUibi6TF93hKb+AyBCWDAPDA8Tm6LeVQvXXTYvyCTjMkDrQLs8iXo32t8/GN
	pgu1+EPuBtEV6WljBgeIIb64DT1Tekvmtu24o8Vdh0iRd7dVeVA==
X-Google-Smtp-Source: AGHT+IHNht4RCnXWOIBAyVvk13gRGtRi3R4F3icxa3I/4TNWQFDo2MBPdQeywBwGxlCOHZO86w/S0A==
X-Received: by 2002:a05:6e02:218e:b0:433:23ba:2d84 with SMTP id e9e14a558f8ab-433407bd2admr63977025ab.17.1762371953037;
        Wed, 05 Nov 2025 11:45:53 -0800 (PST)
Received: from [127.0.0.1] ([99.196.133.153])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f4c891fsm992415ab.19.2025.11.05.11.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:45:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251105193554.3169623-1-bvanassche@acm.org>
References: <20251105193554.3169623-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Unexport blkdev_get_zone_info()
Message-Id: <176237194044.237526.11002027093233210694.b4-ty@kernel.dk>
Date: Wed, 05 Nov 2025 12:45:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 05 Nov 2025 11:35:53 -0800, Bart Van Assche wrote:
> Unexport blkdev_get_zone_info() because it has no callers outside the
> block layer.
> 
> 

Applied, thanks!

[1/1] block: Unexport blkdev_get_zone_info()
      commit: a6c78e2f9317bed8d3d00fce2188aaace6e948c2

Best regards,
-- 
Jens Axboe



