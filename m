Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFCD233149
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659613; cv=none; b=rtkCucOqOu1RvZ5MH8cwDlgDH9DA13s2uYalYndZUlQ9Ip8q51y+2xjzoMZbbRatb10tbIwAx40QOwU5JLH8qav7E0v3KGZHFxi6t3iVzecQ5JwvvzBDKTJApjtwxpx63ni3cJKsTne+yvam08VV1cERYR8PplMhR38GiFHcfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659613; c=relaxed/simple;
	bh=7UwiJZAArm8JmCEJeHhvUn7NllcPI7IXe8Yvs3eKY3A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S+BfMbL6VoFVj880Yh9hzh4Y59D1LWSnTNB44qsxyGk/l2wsCT4WHEUhHCluZ3UcDVY2r0+nqw+f+diT/vxX6upSqaxLEmNZKLkQgfgoChg+s6W/rjtyG85AI53L0CEfUJh/x5ngfF5kTfFrJPH23pNqNb/SIJR7q1CfU3f5EpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3RAydxDO; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3RAydxDO"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-94359aa7f60so384704739f.0
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761659607; x=1762264407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Nb3h+I9r3eVKgBEZka7IhQ9jkoV4w7ZeARyH9Ccd44=;
        b=3RAydxDODPbrc/0HyHKgVKuaoaDIrNfA0nOgyt7ZhstKeU38pTIyGwCxB+1MfikEDj
         HeOkvsYr0WvXDtc3WbOivNx12S0N2boMxrfrFcjOzSWwy07rqmg/4AeTSLeJCW44zSrX
         IMyXEvijzy6Vl0rGCYA1QMnznkdZx/nymA2uyls4e/cciX8rETenCR/ePgmt1ZUFUzND
         AGcvcIvCVNe8ZZLt5EURyNgVkOqZZ2ckUMV/XE+cNy6zX7hcVyRYmY1qMe4r9FF4jNY2
         VuKdEx1aECbZEbfKGuExYiLfzsaObPtZl9mm/fC8/S8qEYh+Xetjl4FyxrukPJXZbMb2
         4pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659607; x=1762264407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Nb3h+I9r3eVKgBEZka7IhQ9jkoV4w7ZeARyH9Ccd44=;
        b=kTa2cP9eVkCXDbGXPRtvrOgc+Pyu7CGDkh0Fy/u7PGknq6wEU0sU11Cgr3e3uzfgv3
         v5JPfx1h3n5CrRxuX4Lt+6e/eJs+hNpvPgkN7yyhFEvl1JQD+brAMinv0w5E7mfB3PMi
         DTpX24gO4JU6VC9xs04gi0H3x0O6Wr7Mcp9lixW4rrp+hQKNAR2QZ10yRyEJ21FjQv7F
         ui5ZlXRPWGBfo5gImpTWDYTwvR0h1Ps2oFbchdVawCiF6LzJohQCNXCR7RV24FBIbpxx
         T44SfB2Lb/BNloLoBI/fQC2v+KsbQ62867jgZyOBl6+/XmhzsJKPUoCazCrhpLa1Jy94
         usSQ==
X-Gm-Message-State: AOJu0Yz1vgEtYV8N9MrvihhJS95oJzZFFkz2ICA0IIx3Rh6uXuc2pGjF
	d89zG5c/5GiECaJWFzUp70N1SsTw8IXTfQtOyBJ++YL1gNPGa5NFGhbfTJd8Cja4OO4D0A1LU6v
	JO1dRmp8=
X-Gm-Gg: ASbGncsrvU1ce2uMKdVJVQcBBjAFOU2hZl3cBySgpotu0Q22meW8AGLNqd8oerS7qMu
	coCQzFDhD1mpPgjZsplRzmfBCEuwOlPU8qX6RrrvloX0vq+gS8mPM3q8ZZJLyTgAGOIoPea8wwF
	x+lwWI8nYV8/LfQrb+xWy6yfRETdCb7KFj+1lPEnseUk7El+DcP+QJKWmsyGzpEWV/23l0xlhcJ
	qG1ULCWgdAWe3+Rq8bJhuQksgzwCBNBnewAJkNLkmU2bcMUz8PWB0trJsMMGFtWv1qigjEcqjli
	lUtK0p+yfkat+GNR90kIDko/umPfhkTpICJhVxJI3q8zjiPjfQg0zjNDw9tU8DuZh0f0/vaNsC1
	uC2a2C3H9qphk2PyQcmLfpHmDquKCvzEGtx6cZHvKltjj9etPXjpli2V47Zzbrp4L/cs=
X-Google-Smtp-Source: AGHT+IEivRlZe0KpNjNxRPKGwOg7QIcJ10LcVZ4NW1yNoDerzdW7sqtcWm/8i69j+dhs0RFOX5Ftjw==
X-Received: by 2002:a92:cdaa:0:b0:430:a530:ede2 with SMTP id e9e14a558f8ab-4320f842c93mr49258275ab.24.1761659607216;
        Tue, 28 Oct 2025 06:53:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995e701sm4287485173.49.2025.10.28.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:53:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20251027002733.567121-1-dlemoal@kernel.org>
References: <20251027002733.567121-1-dlemoal@kernel.org>
Subject: Re: [PATCH 0/2] Zone operation fixes
Message-Id: <176165960624.274653.9187095828796238088.b4-ty@kernel.dk>
Date: Tue, 28 Oct 2025 07:53:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 27 Oct 2025 09:27:31 +0900, Damien Le Moal wrote:
> Jens,
> 
> A couple of patches to fix zone operations definition and handling.
> These are not in response to bug reports, but they certainly fix things
> that are incorrect.
> 
> Damien Le Moal (2):
>   block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
>   block: make REQ_OP_ZONE_OPEN a write operation
> 
> [...]

Applied, thanks!

[1/2] block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
      commit: 12a1c9353c47c0fb3464eba2d78cdf649dee1cf7
[2/2] block: make REQ_OP_ZONE_OPEN a write operation
      commit: 19de03b312d69a7e9bacb51c806c6e3f4207376c

Best regards,
-- 
Jens Axboe



