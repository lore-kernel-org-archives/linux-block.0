Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A3335BA
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753233057; cv=none; b=TySnqX9qNF4hTYS21I/apEyc7SODR8PwMONiSj7vxg83VFFLmCZvY7Ydj1BBEySU9586CjscIwfYvp+WQ3b5vopRLlbnkZF1YEJFjh+0y7iT3bbaPS7BSz02JMnOKoRDl6pLRcTy16HeOJGX7tES2GOipMZffddCYkY1fNnTALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753233057; c=relaxed/simple;
	bh=O2cLLDnRJXHh2AKpILww38Y0YgjO0hf76mm3Tg8VtcE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TcGFCQdKBTOWe0ssYjG5NkUZkTq36CxYV4sTBrfgIUjaBg9ULwlDD4DuMyRa/TgIzoO5fvtWAYT1Z1bg4peYCRa/0UjJIBKjr0mau4gEPncQAcuwsFp2BV2kRbI2hBkZMrEvXb/iDWx/aw6rVyUDGGnXQeKcVba29LYW8giXfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qBWB9+wk; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qBWB9+wk"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-87c420ac179so112394439f.1
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 18:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753233053; x=1753837853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMeioSeoLLVCX+QQEnBPgQrlZDtfj238PIFn9zdvAZQ=;
        b=qBWB9+wk0+0QICLCDi1Yeqim5W67s+MmDsxE5PV1c7GTMMXo1m6tdKpog0c/npxNV6
         SSnxHMviBWebNiK0RQK3K0XK6PK+suscN9MN/8MENH0ORd1tJ2j+585NSXr6P4S7PuFB
         Cc1JAqGKqbAMlH+EaO6SoPbhj5mVrWoumfKpejpT0xpVLmMQLArMaKpjZ6e+7MSBrjO4
         +5+fTiZiHuHzlkXnuKI0BTZlT1FzIoDgaYWlKqs3xjLyMyGXi0Ru9dgNhgUdoGgqmYlo
         UJ8+Mg5bOWFp6ZmSaYJqjnM66dTs0oTwtPtqDKKpPsaTFTSAKd60Ux1cKoNHtNTIWl2K
         VZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753233053; x=1753837853;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMeioSeoLLVCX+QQEnBPgQrlZDtfj238PIFn9zdvAZQ=;
        b=dC5CbUhKXShYjBQZ6gcNA00S8elSOE262etJjDpKDTrY/dLqqLD5i6RRO8EEuwPLmM
         KQzmtq03rnd5dJCnmWBXRIfuxguxVAWKxLDvDG5YKeb+kyxhzVvNKWpBr2UwwfayPHg6
         IPlMdG02eY2JABKWXZBGWZ8gTAP8991mC9/teSGB7lM7dAXuElKGibyefJbzW14fWXJq
         lSGI3KvLun+U5oIDXZyhXpwRrs3ijm1DN3wVEH2gMEBKCkZehbhzgA8D3Srrod4gSyhs
         muiDookAGltITS/ce0wccH/oIF4PSOi4ouWfzuWwp/kab1gPeViGMPyarM2XnBSUTftJ
         Feqg==
X-Forwarded-Encrypted: i=1; AJvYcCXb5Jt6uYlU5hIWYmJ2aI4IT2ZaQGoWK+hd5X+d13iEUKxq6rPGPX3qWTO24K6mWSZPG2HWLgmRosiOjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+uwsOUYjh08xqKcs6G0oId6CRHiPEgsfeGpb6l6kZ+Yjmuj/
	aXHxxann24s9yYPsElHoFU3lH30eNIoGor5BNTK/eY8iX7NjPgTtmR5Drqg40sCvHO0=
X-Gm-Gg: ASbGncuwvYSVeQK3QoKaEJY+MxIRtCXPs0vyoINouNbxbAsNIqKp8rzypApP5aqaHHO
	BRPnW19gpuP4G/UWqRyn3rnkz36guFGxQ/VCuX3C6IGemMXdbqW+lJi2p+D/PbroBlmSJ9dlbC+
	LuQoEHrE7mfZUVsltaahl30VKnttQpY0+skbSb0gAJViZkvVZ/qKzKbXcHoeHjkD+jFf3p4x6RT
	FJqbAq7/N0nAh15aTNJafr3zrh9nYrgDIQH1JnSwDdYjb6UGjvQ88CHKO4NrTswxUKq4lac4Bkg
	deBOHKXPW4qHzK24S9BK110JZmL/thugFdsKoE41GZyY35cLwKHEby3LTlArOAqNXqBTMLLH/U/
	GO4E0jST866v4GWecPlby3k3I
X-Google-Smtp-Source: AGHT+IFn+5ZL76WVMJGeIs14YLA4vnhBQYiqDA7c4GpwNj/OF+ryxNElOqS5GOkhfx/iiA6Y5DbX7g==
X-Received: by 2002:a05:6e02:2706:b0:3e3:a1eb:4462 with SMTP id e9e14a558f8ab-3e3a1eb4985mr6482215ab.6.1753233052867;
        Tue, 22 Jul 2025 18:10:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c7bf781sm2857423173.38.2025.07.22.18.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 18:10:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: senozhatsky@chromium.org, linux-block@vger.kernel.org
In-Reply-To: <20250722231900.1164-1-phil@philpotter.co.uk>
References: <20250722231900.1164-1-phil@philpotter.co.uk>
Subject: Re: [PATCH 0/1] cdrom: patch for inclusion
Message-Id: <175323305207.246647.208696758551846344.b4-ty@kernel.dk>
Date: Tue, 22 Jul 2025 19:10:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 23 Jul 2025 00:18:59 +0100, Phillip Potter wrote:
> Please apply the following patch, suggested by yourself and credited as
> such. I have tested that this call does not make things actively worse,
> and indeed that optical drive functionality (and in particular release)
> still works as expected.
> 
> That said, I've been unable to replicate the issue seen in the report
> thus far. I have tried a variety of approaches including just yanking
> the cable out several times, and in all cases, my kernel does crash or
> post a BUG, and properly unloads the driver - this is both on the latest
> 6.16-rc7 and also on 6.6.98 LTS, and including when I am specifically
> inside cdrom_mrw_exit. I plan to do more digging regarding this, hopefully
> this weekend when I have some free time, as I'd really love to replicate
> the original crash.
> 
> [...]

Applied, thanks!

[1/1] cdrom: Call cdrom_mrw_exit from cdrom_release function
      commit: 5ec9d26b78c4eb7c2fab54dcec6c0eb845302a98

Best regards,
-- 
Jens Axboe



