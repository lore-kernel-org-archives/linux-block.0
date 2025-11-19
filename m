Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BBA278E53
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563197; cv=none; b=EDz0E07XLSJWYZdK97vgKpVM/RcHwvNXFMKsSOhtdxHWld2T4a9vcZupzEaY2xN9ElMw13EEm5HzSdMHy5eNIUd7/vAg31WUo3m0U2rp91ixz2/cbr0M1whiYV2MmvDzAu3FGpfYQtKtsaOH2Cwk2rVqc9SpnkbNLKmL/FgZptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563197; c=relaxed/simple;
	bh=u0FV5tQoxhv43ZKlhawKkyPN4mK6dKr1bdr1HJEK0GQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ng6E0NwfEq2pDeEI7z4pT/ljs2N/VnoI/RDN2cSLcVfrkyf9O3+gv1LFyQINqEhRaUdT+XP6fe/xJlIId7Dn4Fd5ydyDgDLIrEgvE1kgASEFwoLT9znFX5M9GjCPg9U8395HYy3E03OENECm1tXMk5zY3BLpE76AWQ7+3NgFsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dDbvsQ0J; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dDbvsQ0J"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-948fbdbc79fso96239139f.0
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 06:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763563194; x=1764167994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg3/CxhKX/TTFEJdpO0jRDlW4Dd59GDI7lVElH83s50=;
        b=dDbvsQ0JRGkTMuy3Vh1+Ed0UIFQoAwbm86WPOVkYDAuEhwwQCK4XQdsNL5Cu9n1fBy
         hmrVcFP2AxvAYZf+bZYGG5OxDvVKzRboJ12Ux9sHewmH5S6Pwf6HgLKOe/YGkd1mkCdy
         dHd1ON992SXZ4j6b0Fej57Im/NtamHS0j2Lq99SdtT96tXx4lozqhQ8MY3po5Scs9jQL
         uFiPVD5j2q3Kui2h1kQUQ3agJ/0FZxV1jPJGtLHU2EMVR5d06RWKq1rgbUzxwNyp24cE
         8bOF60JjA6JIZSzO4Tkq5uQML7JNCWnaiNxw7qFPIvXYRGlBZU3bzL6mH1Y0kbzox+5l
         D4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763563194; x=1764167994;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sg3/CxhKX/TTFEJdpO0jRDlW4Dd59GDI7lVElH83s50=;
        b=kBQaKtVaw0QuUCG7r+CdSscHTIVT8XgS9E72p4vRolUT73Xr//uqa56gkSoYcETJJB
         K3osDyEMHv0iyTokiYfd7VQlRUILyOew11B/EHCKWVInUJvyqq6UThPyDEikErgXE8bO
         zY5mhbPNmqMucbU6MTIyHDG1JcGlz7sKFkgUbYYGFU/v7tMizC7aPUrFc6pnFtnf1gm6
         hDrCMtxoT583tVnVsdbExe989EkMGjClcUHz52gMU9Wlh/2dKbIjLb5TqzBT8sieRWGq
         QXWrBlYxONYbnD+Bws76eUQ9YQRsNxLOUnEVHb7MD3i1tuNMCkahW3rHy6o9ZTH+++Ou
         fSYw==
X-Gm-Message-State: AOJu0Ywqx8KvYWNz9l5RtKYUaVdECDtmilkvAeGOGcKog/qGemsg8oOv
	8o2MmE7CoTtohRcZXzCgj3jlJw29h/l7zFjwTCdiFEbY79l/1zSTEJ3sB0cZA8TKT7pZ6oFQzPU
	Bt6B/
X-Gm-Gg: ASbGncsbdZ1nTRf/dRz6a0eCEpx6G2AEB+niB5ZmO7Wxpn3YIWyu8hC4XNIsm1OtRBJ
	lPSknLMOOKi/6u6+4Eacj8KAUqk+Ry2F4SosRXwMvVxI4mXQGqwI43L9iz6DFfhkdnbLF2wpatJ
	JmFnwW5Lto8AQdD0+q+GJ342V5+3KJEQVhY0TWDWy8zS1nDRSmLd5+oCq0NYKSh3DItQ88+9p66
	uoyAZfpIaeqhRsjj4LegJoJ9ZZGcFF9P/5pNtqyUiulpNPrzgOzRwUXwhs5cYGFc1c9zjmVtQX8
	8jJrBSqy6fsXJTgLd6ayorySmjJcbA7kB+DYSMI+cEKmZH2ZX5ja79Lk3AaxaeLI4twMjl/2ICA
	dYhIMbGPDWdJZpGh/ApiL8lWErajU2/LtwUU+h4CJNqWPcPhHXV5u/Qg9OZTr9ZsxP8ZNhSbbGg
	3NEw==
X-Google-Smtp-Source: AGHT+IE8GISpmOhwZMNZGOh/bKxqgL4mJjBMHbsL9169zW2vv+KP5AwAItJLgNd88rPk6CppceuD2g==
X-Received: by 2002:a05:6638:ac8a:b0:5b7:be0f:6a1 with SMTP id 8926c6da1cb9f-5b7c9ea7a95mr12554827173.16.1763563193867;
        Wed, 19 Nov 2025 06:39:53 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd28fcd0sm7326094173.28.2025.11.19.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:39:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Holmberg <Hans.Holmberg@wdc.com>
In-Reply-To: <20251119043423.1668972-1-dlemoal@kernel.org>
References: <20251119043423.1668972-1-dlemoal@kernel.org>
Subject: Re: [PATCH] zloop: fix zone append check in zloop_rw()
Message-Id: <176356319327.450220.5350541369722485786.b4-ty@kernel.dk>
Date: Wed, 19 Nov 2025 07:39:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 19 Nov 2025 13:34:23 +0900, Damien Le Moal wrote:
> While commit cf28f6f923cb ("zloop: fail zone append operations that are
> targeting full zones") added a check in zloop_rw() that a zone append is
> not issued to a full zone, commit e3a96ca90462 ("zloop: simplify checks
> for writes to sequential zones") inadvertently removed the check to
> verify that there is enough unwritten space in a zone for an incoming
> zone append opration.
> 
> [...]

Applied, thanks!

[1/1] zloop: fix zone append check in zloop_rw()
      commit: a9637ab93c6cfdf7a80a299b7de691dea6a7d7ba

Best regards,
-- 
Jens Axboe



