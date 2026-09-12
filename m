Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04347364038
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789205587; cv=none; b=gzr7p2R7q9DHYkQD9ELBMPz3Avdwk9t9kY6QxsLm4jWmoidEnYQuOr9bZ9bcaUzZh2cdXAFTvbeCqEZA5miTP9Op96V+XcypLQiP8xuv9pzIpgPrTgOz+sW+EWxJ0QEKGb+AX7/tXmUaJ4l9O8fczc9gVw/axLa85/+23rte+/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789205587; c=relaxed/simple;
	bh=tAqpRW5ptikvGBLcXEfBJ381reEYmJjIKCPS65RMqec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRD5mp37EwpZjsk0kUDNeIS8j+gHAevO6Z96tlGME9LdC4pRJqok8Amo0WjTt1Tlm3S/sibzbtMToySOU+t/8BCUaIYfYa9+J6e7NmAM64NlMGo5QAwMe+b9hhbbigKfoq5T+qFSc5o/sdWkWAq8+IMxifKuDrsfNUGkwFQupEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXSNKW+k; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXSNKW+k"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1157381f8f.1
        for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789205584; x=1789810384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2QTMJitCjsStUznpilHnMjzfzNZTGItPoTsN7Y7b7W8=;
        b=WXSNKW+kqFBOOK2mukoSgfBIFTs2tXGPghl0SF4J1FUfkr2zB8LNWft9EY8Nzo1Bkw
         pIkZJborAfBJoDpRiuKXdAgzMoAojQSBj4rfr2pE5S/ibYGkeN98WyiC71ug3NLQZWGN
         b7/wk7KFJkUn757reyJKeycPIG7XthkrcGxPRowVC9+15QzlZctnCmHlFm6UMVLXA4qm
         bkt9PgfIfpGSq0lCqpoOwB+a3N/tuQAgpeb1zsY3s0Szbr4xY5eZWgV7sDpLc9ZAXDFJ
         7P2gx89cmaWI197+E8YsoDFrVqxSuNqwdX9qhRft7PZx3mATB284Dows+Ofkd2XdDlTB
         VRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789205584; x=1789810384;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2QTMJitCjsStUznpilHnMjzfzNZTGItPoTsN7Y7b7W8=;
        b=aqdUQLfevxmM8MIO/MPAYOuNnic4e9BCoEFBfagtVbd8zXaqrtpQH0z3ezCC9o9L6c
         Fc9eTgBhfhrvQNtAr9VMc1t/ma95lUXLWJqwg3hi5MbX1rwqDp2+cyVd7N56DqGu2Z/J
         bu9ptHcHP2L0PLlk4sKOvknF1uSt2sBJVf7Nmf1lmVD7Pfm987jZnYVBbTq34BpdTE11
         rHn8S5y+EaMFk1E54aMFB/gu2IjzQn2i/sqNPmoV97LBwEySCNhiV8m08LpY+frulx5s
         4YzV4wthXVTK2JQ3rhMa3bLeN3dr47tbaj2XqPm4FZu9WTRREopdlZ0icitaI2Diewtj
         zlxA==
X-Forwarded-Encrypted: i=1; AKwUvBzeVrY2TE0OLQhEOy1NX3ItlmtFUiEcl8X7f2id+ZqwakLLXNYsKIAmfePnqdHjWJ2CaM6aHWq38uBvQA==@vger.kernel.org
X-Gm-Message-State: AFuF++m2StLIXkgfunkrNnrDotUVXMv2j9eZUNfUVQVRuGiC7f2z3cXF
	MVhepW6RGT/YgMBBkzZTVPvpG3Z7sanLW0rFwHMZv7oS4+BgWQJK1mw4yn576GGN
X-Gm-Gg: AYBFou2dvfQZVFinQ/vDlKrpSi0F2HDb4pGbxyxgnbHFSIJc53F9v+IdOGB28mRSi3j
	hTfms097cMFZFKw2SSSUK4hdpvlWgxvMFQ1ovpweWiDKE74CfJscrh+cJTvA46CkVxA5xUR0HPu
	Mlm5J3e+2khf5b/o2x1QgVE4rskClN5KXxcxfgbfUSWTCZF/dERcBYvDHQ2P63pwDFtCL3sd9rp
	Q83raLNygqeg/3uegwSc13GUnTgahHVibIvuwYHeeqMeljFeySpJj3YZZl7D4P8A3XQ0qox/ly1
	iwTWX17YwwSAZkAAQTETL6e1TCL1Q4ijrlJxAg+wBGSdCUCB7PfUhfADY+Z3vI7k78lKdO9gyMp
	zeay2E3ccutIQNM4OBMxtnZpBwTTyNXkPvXdxcMtxjbWrl52782JjxrsKoR7n3FHNrGI4Muqv40
	H/do5CD8tuGL+gVrajWN3Zb8lUjgKpH/teEuDTHiPmmDGnn70dRn3wI+Cg5umnebWLZKY/fbQ0C
	Hmk3v6gpDavmEU18erfOAFn0yEs/GYhlCSM8Mpwju/K3dDEet2sFlOq7+PPOPc35un8YMIm+Mo6
	TOjwS2m9nIvP1gQGqdProQWSywgf3lSma9LPa+MmylK2dIjnfrhQLJYDHlKqUUDniSt+y+493Yw
	=
X-Received: by 2002:a05:6000:2410:b0:484:3fce:6ad2 with SMTP id ffacd0b85a97d-486eb2fa66dmr10406865f8f.15.1789205583738;
        Sat, 12 Sep 2026 02:33:03 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34e74esm11895369f8f.25.2026.09.12.02.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 02:33:03 -0700 (PDT)
Date: Sat, 12 Sep 2026 11:33:02 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
Cc: Jiri Kosina <jikos@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] floppy: flush pending work before releasing resources on
 init failure
Message-ID: <aqUcNyP9DooWW9kf@gmail.com>
References: <20260722034435.13432-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722034435.13432-1-kmehltretter@gmail.com>

On Wed, Jul 22, 2026 at 05:44:35AM +0100, Karl Mehltretter wrote:
> The flush used to be here. Commit 070ad7e793dc ("floppy: convert to
> delayed work and single-thread wq") renamed the label out_flush_work to
> out_release_dma and dropped it. Restore it so the work drains before the
> IRQ and DMA are released, as floppy_module_exit() already does.
> 
> Fixes: 070ad7e793dc ("floppy: convert to delayed work and single-thread wq")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Friendly ping on this patch. It already has a Reviewed-by.

Thanks,
Karl
