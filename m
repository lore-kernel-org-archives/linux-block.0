Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882A1E25EB
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102596; cv=none; b=NOeloOdz4V9jC0/cYwTe9SRLhLwCG5msPy/8Ls9I9ynusUydsLwgpGMUCZ+IjVkGmo4o7lTqAOd1C182p0kzZZYKwiSeIW6fymdcH7wNusekVVU/AsetTIq/XmM5hiAQpxd/oDdZQcZihUYyXSTbqCAd58df4iLg2yXdgZr9L6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102596; c=relaxed/simple;
	bh=UhqKArA3mQltFfnUF2tcX+pV3IabnBmzdBC2jT6MdCo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F8JNj4Uua/VyYo+4ar4OhX2xUZ5jdmvewUyELDDeqePO1z5nTpZG2QJE0ZtYvW/pAxrhYrWMYHo1Frgzbv/mgXz7AW9CpIiea6mwkGfq2AdcPQJ5zEjKSuvbdHbZttO0fuPUxnCm75WMsB0xDoOff8nJJ51rOXbaDlD1ArNaqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MdPK9mVz; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MdPK9mVz"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9cb667783so14812225ab.1
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 07:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734102592; x=1734707392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxKtYNm+o7Qqldvs4k038B4Y1fztU6/dUSELdpzM86E=;
        b=MdPK9mVz69zFqRdMu+U7GAqmd4R5DoLb5NqgpAXMdvCQrXxPhcSFw9fwHVQ66pCl3V
         +fNs0MPJ4cpP+C2vI8wg03h4+4LsxSMt2P5Uy5Qb9orKwV+I5FHnki9tqxSWmzK6VV3B
         4xhy3Wllw96hNnUJmOaSB1Alm/dedIksPKHNK0JqbpOduDR9SAfgw6Zyb6/L5uneMA3F
         4bHvupA+x4fTFPP4jC4vPlu6qp3HlHLiowtu3nxcjqGWmucm7gZXsr+Jf+h61yfytv0j
         q5sEIWyPkYdUOZC3vOcKdNtwc/B1AXjxcwLNI2sZlXOErkNlL9bAX9X/1V/oP9N+cpEP
         k4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102592; x=1734707392;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxKtYNm+o7Qqldvs4k038B4Y1fztU6/dUSELdpzM86E=;
        b=Aa+ceEIs2bnR5jnJrQR6Hg4A5FV4cwRZxsd7hAv5D+aOOlPmFu1ZBIh0XEYDK59VUf
         eZdX8+69lWC0+A2VOEU3kiBqHC5N3OPx18rEHN5q4SLaIU6Mn/7ar0FSZ6F1Sws8GWbL
         lQISkTLtdT5EjedJoB8/yljS4+a1BGXFW2azFNFKYccDZrrVyNgvJZc+p1M66qgcpkWV
         11b7bqenMVdWOEPy8OqKg68szsdlPnhWeR0bXFMii/mY7r33m+ck6RC0BZw+58gpi3Ga
         pKJaCjPS8b2jv6EPrFk6uDAGqyz1Ej5E5lb04qOPRnd+CHtgK8N8w88PBigHOSMxoUsT
         smyA==
X-Gm-Message-State: AOJu0YxuVl9sbFAUIeTUCKIII6IiE/tnjn7CBlIb659sX6F60X81H0PI
	+FSKJQO5D6Cbzk7d484H2SYzYg5ECsVp7mLGyguzbyljVEOn2tfuWNzePLNyeUmtHVaYE2dLojb
	I
X-Gm-Gg: ASbGncsrtcb351sye85Jy7ssGNfjtLU9/Dy2Q3Xsq9QA9/t3xYw8Euw+HFPw1U2bR+I
	1vqeF13k54XVv2A2ZUBFQVnoJVmmyGe0VOWWmlMGPFFhuRKS/kFKePFzT048T1IJsSOlwMWFLhE
	F+4HS01RjGGLxZBd3we3glVRIqM/OH96Ds6AItEaCQB2b1jGC8mdnJ5mr/poZ5inJn1YrMtzFs7
	dfHAnXg3LeCQulYXE3+P+SJMPYCOc+JtibvgF/AwTdrAXA=
X-Google-Smtp-Source: AGHT+IH2+v3oEn9vDQYTnc/rsgmweHif+WFAxL3LKl2ws3acYhLHE5GLHKG8L4oseAmBeTxaTVumQg==
X-Received: by 2002:a05:6e02:18cd:b0:3a7:e047:733f with SMTP id e9e14a558f8ab-3aff4613b80mr42090075ab.1.1734102592385;
        Fri, 13 Dec 2024 07:09:52 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2d08c1cc2sm1969605173.52.2024.12.13.07.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:09:51 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20241212212941.1268662-1-bvanassche@acm.org>
References: <20241212212941.1268662-1-bvanassche@acm.org>
Subject: Re: [PATCH 0/3] Three small block layer patches
Message-Id: <173410259165.85123.3274530523792619700.b4-ty@kernel.dk>
Date: Fri, 13 Dec 2024 08:09:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Thu, 12 Dec 2024 13:29:38 -0800, Bart Van Assche wrote:
> This series includes two code cleanup patches and one bug fix.
> 
> Please consider the three patches in this series for inclusion in the upstream
> kernel.
> 
> Thanks,
> 
> [...]

Applied, thanks!

[1/3] mq-deadline: Remove a local variable
      commit: e01424fab35d77439956ea98c915c639fbf16db0
[2/3] blk-mq: Clean up blk_mq_requeue_work()
      commit: 312ccd4b755a09dc44e8a25f9c9526a4587ab53c
[3/3] block: Fix queue_iostats_passthrough_show()
      commit: a6fe7b70513fbf11ffa5e85f7b6ba444497a5a3d

Best regards,
-- 
Jens Axboe



