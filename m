Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB573A7588
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571763; cv=none; b=ffKK6vSI73mBFfVCQPVbiuZX54wrGe+yFmBW2/8VxAeamU6J2NdI5HfN4tlIp/26evp9a9uGc5Cng6ULsY/OVnmt0VeBUvfa8c1lVbSDDaihQdGGdlTLgdfELoWHeY2yAAj8Whf8YDHfykApGyGDqLvNWuQfXEumfJOs8vakXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571763; c=relaxed/simple;
	bh=XoiDLUNNgyg2xEAnhOKD0CevZrrQ5TaDHiK2JbsgF0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lEbioapnmVsuSRGQhi8r9B9mWnPONN4PP4Uq0N5mYcJsl4dm21y2qjdbWiJhqCkA8N9jecYyXdI+qsYiIP7u+07DUrK5KGEulMT7GqgZTyLOWQzH+9b/vKdRIkg+OXgchRRxR/U2udornChlnE8FwH3FqdbFBaglNmtSasAKim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=JCs4ej3v; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="JCs4ej3v"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4138136f02eso3359532fac.2
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775571760; x=1776176560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2+0a4Es20L8ZKKeR0LXCGBpUxoc39KcuZeJSpi5LyI=;
        b=JCs4ej3vq+AUdsXGXocKip8w8JpYzlb2dHYAbUEqRzbLiL4OKkutfcyyXTAFPRDhqU
         7KmwmQOLRvafQBISoFM3I3llfwvDRenAciPJadspsJB8Ot5SHI9euINRjBjOLlMn/kvS
         SpSHuVVJiwBcJm0VMSWJvoAimjSwNOyMCE1pw1cA/i9wlB7qiBr6cWqp2tJU6sbxehV4
         8NRn2lRxDZqr4xWAx3QXTpGf/ju195RjP+otJJ2mRnpY3fQS1jYHeev9rhAXLVSsuz0y
         hSHY/6GUAlRGVavLVaifmACVWU5UwWQAhJeIK0p3naniRMlfU5DzzOHF6obG81ZjzD4K
         +pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775571760; x=1776176560;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2+0a4Es20L8ZKKeR0LXCGBpUxoc39KcuZeJSpi5LyI=;
        b=pqBAhxJ55jquvcuoJEY6Q7it+ampHCGHpA6sjHnsDFwVqOTgS9ZMkyOOsuI5kbcIuW
         mKWx9FM1VMvDDKAXMzKEuTrr7uOi2q636lAv0ZErqf0CYNT626AvzEZHNx1PjCuGDsMo
         GXFfOkUe8yRbqY/gb44xp8F0uRLnSuz5lcUujdLU9b31TGRIHl+/JyCOTtSDW1hyPU6f
         bWUEYROkQE5crZYXT4NlLiSNaBHSLQJkn953Y0y42r4EAYWsVBGKIpR7CPtNAfJ00r9S
         QtxEywuF0NIQqb0QCYoG3XLumnw2F9NgRu6A7zdcfnu0UHmzw518C/Q8IlHHPQNl/K/7
         VS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdlebvzAel6k6bd8zuCcCOcezhNluGa9Ma67GCqLKTzyH5ERDmQDZEDpUun1JGZh1leTUfg/4VV+ruJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwwZqYRo+U863l1wpc7/9ur0eDkz7ImjadxV68jCYyieETSPz
	uNmgj7L9pNxaKUTP1p8EYajsEll0G4AYR+oKSbgArELTZoipLrPestVJvXgF3rvIR94=
X-Gm-Gg: AeBDietq3DVltVPJn3frEfXudvSJ1p7eO9dNezRdXZwrMI2ZNmSz0vU+/tZI9FkdfiX
	xAiIrUpYb/HjE3tpNdoODRqy1P9zcMjIVzW1cmXpZmWMTrl5Y01r2O0aXp8RItS4XM42/HRx9AN
	KlH+zMyF17y4P6HSx07LATilLdXrPPWkJCM0IBl5LS6ezBXx0vxFUfnxs7CPsF/dduiSDs5pSHj
	pcbWVeg1WcFB+MU5wZnYcC0gKOGCId0ZCIkIZ/cYV/9b05TGFzeMkkffAkdVymksS2GSClXe76Q
	OZLE3O8wmlCEKgYnfHlvdiR9qhga+HV8HeKTwEKeabtQQqr7LN6sFA4J4BtljA4AVhMcY66krvU
	sB1HNIQ77b4pDfComJfPAXhBs67XFU7rWKlEWEnAlM6T4vj0wFddLITAVlGtK/JhgEHC3Q9jNDq
	bxccodhS+EE66OxhGxXyFa5+GhsbBcvXtdLa3FZ2h8eV+wWNQjtvct5kskiTlIEjhJ3BYdGIBHt
	7U5u7MlLNQHBg==
X-Received: by 2002:a05:6870:71ce:b0:423:1d96:70fe with SMTP id 586e51a60fabf-4231d967d91mr8601881fac.21.1775571759601;
        Tue, 07 Apr 2026 07:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42368e39eedsm3906866fac.9.2026.04.07.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:22:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
 Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org, 
 linux-xfs@vger.kernel.org
In-Reply-To: <20260407140538.633364-1-hch@lst.de>
References: <20260407140538.633364-1-hch@lst.de>
Subject: Re: refactor submit_bio_wait and bio await helpers v3
Message-Id: <177557175878.180843.3112896567038730737.b4-ty@b4>
Date: Tue, 07 Apr 2026 08:22:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Tue, 07 Apr 2026 16:05:23 +0200, Christoph Hellwig wrote:
> this series factors common code between submit_bio_wait and
> bio_await_chain into a common helper, and then uses that in XFS
> as well instead of open coding such functionality.  It also
> cleans up the submit or kill logic in the ioctl handlers to
> share more code.
> 
> There is another places in btrfs that could be refactored to
> use this, although it is non-trivial, and I plan to add more
> users of this helper to XFS in the future.
> 
> [...]

Applied, thanks!

[1/5] xfs: fix number of GC bvecs
      commit: 452c8f6cbd0ef1408474a875c5c4149a02c7610f
[2/5] block: unify the synchronous bi_end_io callbacks
      commit: 65565ca5f99b42fe62b9a10117cca04f4311dc66
[3/5] block: factor out a bio_await helper
      commit: 6fa747550e35f0a74e649b19d97055988a25b2e4
[4/5] block: add a bio_submit_or_kill helper
      commit: 92c3737a2473ff5b83f90f5c1b353a27492a10f2
[5/5] xfs: use bio_await in xfs_zone_gc_reset_sync
      commit: 2d148a214b24b4a2525f649cced0c3e9e57281cd

Best regards,
-- 
Jens Axboe



