Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7A3B19B2
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831082; cv=none; b=Sb/I/BcHC/1BO4+2xRxUxCtWoYXUw6Ohu58+5DKhfJfi82vUUcT221tvy0f5y2fnEmudbQsAMJ+ZaaTOUnQG8QSBbJNr3iWCPCfaAuxliJ4UJgk62qtPOwDRSYIT1eD5oG+vvthT2D0iphLq9s4dwoQ/JNLfdKPp0GMJ+p0fRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831082; c=relaxed/simple;
	bh=3WpCOKLM5eH0ofgWhYMhdkbzvcK1n7FYnumuHOxNnC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k3BzIeKZOJDYdD1AqEf7Ypze6BOcF0yFI6u3A9VaKvmqMZdZZF9WtH84LGLwbouVAh8sMDum2xNH7k0edE+ZzlJ2xmM/9cetgRU5clApObmUG/+vks76ieLQN5krAE+m9D+ZWmPkuXsAHC83U4J1ofLiORu+rNh2TyizIamRaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Sdvnn7l1; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Sdvnn7l1"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-170135e43c7so1197415c88.0
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791831080; x=1792435880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XN1DukgqKuQofhM9/wBf3QCNQ1gztt8YbKc/xQVj+XY=;
        b=Sdvnn7l1m6Ryn1QlZNpM0FYfy92iqFgBmEUHjjSK/P/NrJAsUo+vX9hyi6sFzXJ9Sg
         kk4OXllz+xsAwOyMGiy+JQcSe94Ru96wVWCr9IIVCbn/Axpr3eMEGzHmZ+wxlqQfr6zR
         +5F1We4jmFfMsQgCvxNiCMJ319c2uBd7DTqRpao3NelubAzj/i8KLQeeJ1B9X6Z3PjKy
         sOQQXavI80ajhsXhU/QgTtr3np3x+FvETEgxcSgvTuD6WxYUite+Ot907IImehq9jE4O
         xrWtxbGuGr5ch1yBEJE76s4IxqG2a3HdBOZ7Fxbo/OXAxJTrXM935uiX3RbnzpfsChrT
         Ye/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791831080; x=1792435880;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XN1DukgqKuQofhM9/wBf3QCNQ1gztt8YbKc/xQVj+XY=;
        b=x0+WGPQ8Aoi65gCkJ8Lxa/K1OZxvfMN6bQrNiC1x20HtJ26ZToNuo9Hz/YItHruD4X
         GFleRp7EfXWTmagPKfUol3ud9pgyLZJ8yndJ4iiHBkTvZhWjwCDynoaxddMhCO2kdrjG
         M6QfC39d/h+bqu9Z1VwRCzkDAGPv7uv6+GDGayUPkPVZC6xUDd3soNq21WAFvGUD9TVV
         xCnIARhPuZvhrBlYPguOIBjzUsUU76hqSTGETKsiAiQGotz9NOWVxDblOiGJ42s/SrD2
         NfX79F3Ukze6FYl8Z3zAsLHfdeBF7Em39y10oFjg0oMcV3uTDXTEh7Dkm186KUqqtwHq
         MorA==
X-Gm-Message-State: AFq9FYL2mFPlq6ocEUu6ikMCUPrZka8cXI4JOUWCq9utCkCIdxU7Vy5Y
	SGzC9Rjw2q0+2HLbe9CJ91laGy09SnJdkh8TgfA1N8abjza/U/lka2xdUm4gNN9Q4Rju/PGOrYZ
	gvSeORwg=
X-Gm-Gg: AYBFou2+i9TyF6Uk0VyWWWWZK+/mcuete3PI3KIxPejtjbT3cD5juuGv5bY13NY8Xwp
	n+Op5sjcJRNe3hI6lUO0Vejny9Wwt2wwdYw65kE7WXMuTudotZonFqibJKCXek4EqzfxZeTKNo9
	l+9oohP1EwzGZfqxh9QA0oUEF0ZcJJQ0hXTbq2W9E72N7cCaGsRQlQXwfoBbKuONQhZv4k+b7qJ
	YK97OxE5u0r3pU9mwLQrtI2H5vodyqEx7JFmYvc6Tq4C4MBjkhVmTI4qgY8N9Cekz1bqSApC+lA
	kIUtWgV+h846kMrZlwfcjLxLqJl65fTvpWS3ptUpmGp778iI8ACxWpy9izGeBfpcYfX1zn9QM0m
	vg0iudIFT4YMer+4F9M26T52PZYzSjSSSpd6JgEembjMABrr6z7pKi00nd5aPi3BaOl1oWzY0K2
	Ruicl/ZMnhV1eE9oxM5QWXT5F5goos4a+RfVeNQ/iwHuSmJ1vVjFFQzEms4Rtoblyn+qLnn3Nud
	8ArnU7bBuD45G/aLYYfrkqo/AXwuycEVOJllxKyPSiS8Urm4KPWlzvz8w==
X-Received: by 2002:a05:701b:2094:20b0:163:a197:722d with SMTP id a92af1059eb24-172d6173e24mr6676813c88.4.1791831080431;
        Mon, 12 Oct 2026 11:51:20 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2f17feasm41738221c88.9.2026.10.12.11.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:51:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20261012141551.1336261-1-hch@lst.de>
References: <20261012141551.1336261-1-hch@lst.de>
Subject: Re: [PATCH v2] zloop: explicitly mention zone condition when a
 write fails to it
Message-Id: <179183107974.215281.8699580955682245557.b4-ty@b4>
Date: Mon, 12 Oct 2026 12:51:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 12 Oct 2026 16:15:34 +0200, Christoph Hellwig wrote:
> Don't print the impossibly large write pointer, but directly mention
> the zone condition when a write to a zone in a condition that does
> not allow writes is received.

Applied, thanks!

[1/1] zloop: explicitly mention zone condition when a write fails to it
      commit: a408a6e0745ab5b75bd5f1d79ae4dc73d80ea302

Best regards,
-- 
Jens Axboe



