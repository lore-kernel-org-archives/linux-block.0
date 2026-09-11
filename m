Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F2A36E466
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144909; cv=none; b=qK3M99R3F/O98E+MgxraSL+uoRcd60DLrY9aSudHbNFhl+pC2Sl581zqJu6ti24RPm1XCFednD7jsEk3UvnCanS3cm+tRQppt0xMK6ojOEdzxtIf33xr+HyPPifPbQMqAVU+fUiVk5zSOtgfFjqll6wHMJGOijanufah/fmhBNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144909; c=relaxed/simple;
	bh=wc+uX9jas9g+aWU6LktoUDtWMcz9ilikb8aQQT6Jq+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pKHFCNIihDONU+WIlVjpQ3A82poV1seQOpF81Vtr4mklGaoDlqwITPhElHr9KQaYFHv8YDjRmOyKExEu8HG8977aGr9jVOYhTFgDOAeUFlTe6vaqHjUCTENBPCf6MeElYeONhkk3WAfgitx+IwBpf5w9Xqeqlwo21JRFPwyklW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=hX+yE8rE; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="hX+yE8rE"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-46f53c8a5fbso420806fac.2
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789144901; x=1789749701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=10YQ6NAS0fy89bPXrV7uR3YQg2Nzd6BRWwWwEi8Rmc8=;
        b=hX+yE8rELsae+nu7TYEAwUsQ45ZBLTuK76oaRAah11V5lDZfiYwI4WGlPVOMSVKrgd
         1TSZytrUe+OBQhU+WyVLJQiTDeo6NedhCLgpDUTcD24257qaICbGh+DJWFUuPHfRxzgD
         t8PLFxQa4pNsWVZBVL7mV6D4qZqPlbnSdb9QZukkPDC62ePtHvs26X2LsO8bMVtQhvCW
         MsTHXOg4M450wLQy8gcp2wuL1j0gVq0Crvl/iChui7dHDZGyX4qScutYaHHXtza/vJWL
         7Rhv8NTbdlGv8qwwwPfF2PTZR22BbaB4rKuoi4omjQlwFPkwiaXSS5XIQ3c21tYc1iKp
         ZyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144901; x=1789749701;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=10YQ6NAS0fy89bPXrV7uR3YQg2Nzd6BRWwWwEi8Rmc8=;
        b=tEaoXYkeldW4g6MSZFpD7s0vkVhkvuS9kJGZ92ZL9q5xWR+fZr9lYGS64c0Z4u1h6b
         B1r0wQwbpgkhHMMduXybpQFMamnLUF9F57vsDkGOBpfwSWIj+h/zslhZybUMCOnwgYFs
         eQdpUaJF2gB20cFgtGDqVt/nwwN5K12AzBCYEC+LrHlN40yhINeicAMHhANmkHQJdAkr
         WGAu9wNMM5GWkkRB29voUWWN+xxYF9ZkMXvuh9hej4930Wsa0n3FbvDMzNar8PJ4Jh1d
         8csO+VsAq69dDtgg9ECv222eTIJ4k8rTWj4FPfBK+x2QlX9tGHOF3In+AkB4rJd252M2
         BX1w==
X-Forwarded-Encrypted: i=1; AKwUvBz/L0MbVvFxt/Piht/iM01M1WPodMQVs5S44JobUMpIm8K/55sivFEWAhQXm4o/qczVha2oPvaNmeZf0g==@vger.kernel.org
X-Gm-Message-State: AFuF++lBlJMi0V69ydBq8JeBQV2WhVAHnV4SvMXMmsKnORZb55/0Y7FL
	UZnmb8Ro8lVlCaVBcVE8wC2xb5EPg6CbfoLNp2Jk3cFqzI8xo7Tl1b+pBjTR7vVaWBE=
X-Gm-Gg: AYBFou2O6DdYcdpeNfSQkEaLZcywnZE7P3i7NeDgN+93vHcR2QJY+fzE3NEszVds91S
	8jNhguH+XymzZUih232Z11oHC1oe3pK6lKwUgRTDTd405bJWSQ+QW+qbHEMGrouR40mnmwNwrGY
	Mcm9aXIzSb8E8rqKRqlE2bwscQbtSyPeVACR2Fam7nhf77kwU5LCkyMwMaBsR5VlyrkAksfO+7i
	5x7ImE0J37cxMYTbHXMtmt95adf2XOPP4j7i9pcI5ewyCmJxywKI5smXEdMrtRSHgYHQZVJwZ8d
	Z6S+CbiJKpcsDmghtksWrOTrpWNfp9XhWLXHwSN7WYsweDIuQlLVf2jVz3f09ASfU5LZvExH5Or
	IAz1Nd4YYV1WNOTVS6knrqj+m9KVHq7YJk9JjOvwJFt5uMPURAb+6rv5N+nPqvHsrP+lVIbQ+GN
	OfQ9x4lX7rRe9VptGspuSD26NVYt2CDZIQwLfK/XuUq4nzKwrlh4q34Sz0OJ8qj0dNr4tZGV2oH
	nf2a6y4TTopymTS6DfS2HmadwxiMzW4K/SrbcoPlbGvwo8T9Lk=
X-Received: by 2002:a05:6871:4ca:b0:475:a112:1272 with SMTP id 586e51a60fabf-47deb9c4edcmr3955392fac.31.1789144900999;
        Fri, 11 Sep 2026 09:41:40 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df8bc8884sm2242126fac.10.2026.09.11.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:41:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20260907074111.721054-1-hch@lst.de>
References: <20260907074111.721054-1-hch@lst.de>
Subject: Re: misc block PI / bounce buffering fixes
Message-Id: <178914489939.653766.218849362864166614.b4-ty@b4>
Date: Fri, 11 Sep 2026 10:41:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 07 Sep 2026 10:40:51 +0300, Christoph Hellwig wrote:
> this series fixes pre-existing issues found by the Sashiko review of
> the lazy bounce buffering series.
> 
> Diffstat:
>  block/bio.c            |   11 +++++++++--
>  block/blk-settings.c   |    6 ++++++
>  include/linux/blkdev.h |    8 +++++---
>  3 files changed, 20 insertions(+), 5 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] block: avoid integer overflows in max_integrity_io_size
      commit: d952f6acb7acc9b94c8c25014b1f468a680c6c00
[2/3] block: cap atomic write size by PI buffer size constraints
      commit: 1418b5633ca973723fd20db5c394e5b031f2bd85
[3/3] block: improve aligning down bios in bio_iov_iter_bounce_write
      commit: 9dd2351aef70512373f79ace94097a32e5ed0f70

Best regards,
-- 
Jens Axboe



