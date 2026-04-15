Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3A38553A
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283394; cv=none; b=k5INysK/gnspFYZZafbLKxtb8ubenP3yzEbKvJ9iO44fMtiTUxrLrd4bc8OEiwjuADk4N2gsUkd59S7a24g/gITBh9yEQV2eCTj/TTscyBRcjC0QueP3PwpQ04HVwL74AzEpau+A0ud5lISjI6bLnDmBVN0XwAKTQkWVUiCkVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283394; c=relaxed/simple;
	bh=QwnIoSx+NFa26l883A5GU6Qyv8g81u8hotNjjQdwuns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tt9cCivpBnkoQsXxUcVLHa5WKpmVdv4LRWax3Zj9rFUg06PAzKyf9ZQPrLO3MkflEIpnSP8ZcoQVDGqLpFDcP8lZZmAzcnKLZVxxkeYzySYyJQcNSMv6ejXTb2pVj5a47tq3OSK3tRFt1Dtk3KTZeNoEzvUCmhE83/6eGa7LxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ZQH2nBVJ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ZQH2nBVJ"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-46f0fa0e398so4087881b6e.1
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776283390; x=1776888190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77ONDZQCCftX3XxcbFt9tIQsnnWoI+QubP/0FPx7tMU=;
        b=ZQH2nBVJsNg1sgFNuVU7284Ym22ikzS/XCmalRyqXetPWQsK+8ZK4r1Zew5vPysuJ0
         b48SavcerRwPPMJvYGd4uXpdi1fj+IaTe7F0ObeiAbzHBHpDpWVPpvI2dFSqsv5VJgXR
         W2U0wOE8yJJr5LX2/Wrm13iCl0QRuDW8BR5NhNm+B43jQ6ykz/27exfMxA6648uC0CiM
         libG3zQMy27EJV/nIhZoAD+AthDiQsxICDCPaxqYd0jMWPOe1fBFckp+8LX2n9eTCHZk
         T4PEOXy9s9CxjOFq5vVVoYoF3JoIYcuoP+9UrjTjOZchiY9iYRq5EzSMO2RyX+vZT++M
         pjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776283390; x=1776888190;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=77ONDZQCCftX3XxcbFt9tIQsnnWoI+QubP/0FPx7tMU=;
        b=GyutIdf0qd0j6B8nZcg92KYwXH1Pnw/MIlEpfZwOwsZD7cQg4v4JK/clqh2VH2Tj8I
         Yu28fzYGlEbs9sX2b0AMiZuKuO3EhlFRPxxitTh59K3S116oX1Vi1dnVf4UmJIQogtlt
         o2axsHjkXuoejPiTbvOJWbcgbUzC4k/ibrdroRxSFEQL2S/efK/fjknaMZ43nBCM+1gZ
         +/BJXzdOMoGYkkr/aUlqeFFkDVFC1BL/o7L+TPit3g5XWSQzfvE+R/pjMjJ9+1BdSBaU
         hHEjzX/YEsfr5Rdjmr4PhhmSzFWWsQGQH38J4KnYCby9RlsCV/4qocfTC5Y7KFlfeW/X
         b64A==
X-Gm-Message-State: AOJu0YxIUaTkQ2QSSouj6Ts+p4ospz7GjWBgTma3FxZBiTzikj4+DkUi
	CJZoLDry/EXHr/RKm7aHOyGWB5BGUr9ioeyeVksYvCHqL0sksp10qGGyk1tgX9uNzURi+IqKPvp
	8K1vG
X-Gm-Gg: AeBDietXJzQAkJSKuSQ+d1N8AeAlDnn18wJ34vuU5lhcn7Y/eYfITPdA9/rj57a2k0e
	Rl76IF/ZZHnTPorsHRdMhfYmj9becN4CkqNpTgSWQXGk6qvx4Fd9vdL+6QB3PUwRGB72D1xrNAN
	gpuDBk/aDQGJSJ94PILtxaGgkbPy8oU38VXxfJQ7xCwFv8rtnh4qkkwc3Gq9/D+yYNrdpcEyb52
	Nb2UoMx0v811a2LAFgkkYGVb+T6CP2RSeBzSdlm7lHGO6+IQiFHQq4xf1e+eqW2jp42jCb7C43K
	IbN+J/ndgZ68sMSN0RI+M74qitO7nqvzgIYA5VjEbjWY6woR5T+F3hDgSzcL/0I03s87QcvtJx2
	7ldnKq+WESgvZrXEc5wDyv2zIyhK0QR0soo1DwlKkD8Z9pk55d6Ye4DKRTCYaOkTow7hqK28SA2
	l8FonynMRTV7MQGdDhZKmmgRXULU5mwj9+yuqrzprJipg2XsyVZzI759GnvbJntaJLA3m1QgNYB
	f+6yaJQYAyjAElQPi3zQW7ORr+2nzNpOIUCtaG4
X-Received: by 2002:a05:6808:181d:b0:44f:6a19:433e with SMTP id 5614622812f47-4789d14fff8mr12493909b6e.15.1776283389578;
        Wed, 15 Apr 2026 13:03:09 -0700 (PDT)
Received: from [127.0.0.1] ([72.170.223.83])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4797a07cfe0sm1396321b6e.0.2026.04.15.13.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:03:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260414081811.549755-1-hch@lst.de>
References: <20260414081811.549755-1-hch@lst.de>
Subject: Re: zloop fixes
Message-Id: <177628338575.677272.10107205640807328326.b4-ty@b4>
Date: Wed, 15 Apr 2026 14:03:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 14 Apr 2026 10:17:45 +0200, Christoph Hellwig wrote:
> this series fixes a bad bug and a few minor issues in the new zloop code
> queued up for 7.1.
> 
> Diffstat:
>  zloop.c |  123 ++++++++++++++++++++++++++++++----------------------------------
>  1 file changed, 59 insertions(+), 64 deletions(-)
> 
> [...]

Applied, thanks!

[1/6] zloop: fix write pointer calculation in zloop_forget_cache
      commit: 32be3c01c3b8e948a4326ab7e76c1c63dd3e27bc
[2/6] zloop: use vfs_truncate
      commit: 14e0077911e3d5e11e94417861e700cbb521a107
[3/6] zloop: improve the unaligned write pointer warning
      commit: 6466b211f797ae88073b5826dd764a6a98b67edb
[4/6] zloop: set RQF_QUIET when completing requests on deleted devices
      commit: 5b680d7afc4a2fefa0b4f584462c7540de56e2e4
[5/6] zloop: factor out zloop_mark_{full,empty} helpers
      commit: ec5c045f6cc879637cb52c9902d5fb7d419bdf47
[6/6] zloop: remove irq-safe locking
      commit: 64b437c4a96ae088d46c7d9930c35e77ee1b5b21

Best regards,
-- 
Jens Axboe



