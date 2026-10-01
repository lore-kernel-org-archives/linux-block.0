Received: from mail-oo2-f23.google.com (mail-oo2-f23.google.com [74.125.231.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B751120F
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862867; cv=none; b=AQixocZUYHTdV0WlsDF6o0jZcw/obVyZseZ3S4Z2Id7JX9iM/WGexwdOxiN5Livb1NNNCwNzdUknvC0ojUIKt3/UfFoA0WZCXIvtpsBodEUghNcBFDfgqmyQjc3Hv4BDK++hYOnTp67F1vaSvSKDORj4122nU0tVzWDFngz5ll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862867; c=relaxed/simple;
	bh=qjW8hwIoElWxA0iUFDq4qI6cCoaWjoffu2xCTdl55CA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PZk33nrUn1c42N7Qqb2pL10Ahfdy4BgnaEaj8diMat4RPsBmoW3IGukiQ/JqBP1X8kh/+KYj/l6LXChtTHYhV2HG2HLfB1v580iklhQStYudgI+J3Q1Y6rHIeiLN4Ku32X2P7ajJn5fAZQyFyZRjP6x9dl03SoQqEsMiBoUGUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=IUmV1ZsJ; arc=none smtp.client-ip=74.125.231.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="IUmV1ZsJ"
Received: by mail-oo2-f23.google.com with SMTP id 006d021491bc7-6c72bd8a02fso3554209eaf.0
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790862857; x=1791467657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1q33kSEPPj9vs/L5DXTf6JcpgngvKm5JTS+mJu9VGq8=;
        b=IUmV1ZsJN82AWuQ9LrabVy6OBSTm1XupN0yzyFSsxFC2L/jAFcKm75c8kbC+s+ZU5F
         F3joDewuGaTizkRbgxeXodeSmO5qxOzsf9agFHWmWEeZOSEkYPeI5GihQiPNdsmhefty
         DdseqsJVfDoT7Tt+oukh9vVhHiZjHXKe6k87Df0ogjviuGMkWRfzP7woPPx2cH0b7/hp
         BWCogj50ff1vY/OrHgmys100QQS2XBCillebAvpiYnrs4U8+cfT/0RqTxy7I4g8LDrU1
         QV0A7LUGUTNDe82WTmoorIEt/ZquzeFen00kwpTvi09uioXSPmNAO7FJvkwb5/sFs3kD
         61kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790862857; x=1791467657;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1q33kSEPPj9vs/L5DXTf6JcpgngvKm5JTS+mJu9VGq8=;
        b=Fvy8GemOp3VApTa/DbkqdPzhic0IZQltHlX7Y4u5qRsciAo1y7P+TYvan8JvE4Jim/
         0zxaJyT9flzzGa14urNwusTKCvCb/kL8A0JDyHE8+DrX+2QRYo3wiJu2pOxMweMqDmNs
         gjw/Pz/w21750QyQ+/icUUveTMYFGn+wKfPMooeS6fdFvVb/JS7DIbcBHkGpsIDvg7nh
         tlsgrNEzaeQ6BHdcwf+gcbDiS+Cs/mglmVNjur/c9/xAdHTPgoHYtTrkIc5rWKe6XtZK
         Lo3wdhCvlpytMVjGmVyMFJQKwCs+KndKg+FUTUQXe6nGdEt/9w8NXJuVU4/TwsYhJoiu
         pzhw==
X-Forwarded-Encrypted: i=1; AKwUvBzOlBs82kppsMNSng5hHy28S0hlfRMxucKZCDATu7EOLFJeConMAD1uiKOaI5Df0Hb7YOvGUfk4bD0Mtw==@vger.kernel.org
X-Gm-Message-State: AFuF++lQVzgqUTaXOtWUmoOXBb+/uRh1AhPa/zQ2JI793dZnAG6LhtjA
	iIpLBPVQo5DAbqtTUiWkoTQ7gdxopet9Rhhra8XfxBhxj1aVmsHxzeZzE0+ys2YW64+wtdTwrB/
	G68SfTLE=
X-Gm-Gg: AYBFou3WK7szoDhA0J6yt9pqVIei8c+iiA0g8Ov7NI8klzuIOF8BP+rPXOjx0yMTpIR
	NgqmfAFO1dbzR9XErSvaqKypYGvJrG6U8EEFST2Je/rY0T3uPnW41TTRpYwBJ40NyMZLA5WBh2j
	YNGhVsvx6PHvPwnsDTu5YNRnYFi09Sk4bE3NGdsAQNw+XRFIidqkWFXdHFzVUxukidgzkn2Dnx/
	Jl3wfZzVUvZF1+Lj8wlQTUjieRq0VPFtsiUyH3AOkWBoNgVSdFZcre1jV3QkAckXxhdK4NLvt1K
	okbB3qUIaZ+o0PyKiJ07fxufTLpms2DB11eQlG7TyPvQt0lMmSqzKilBEweZ1Fn2KCNb5hyBLWy
	lJd330w1qgl8rwyH95EleE86TaUI7QLpFknd4QYBTlUVA9o1YMmoHztsifloOo4K19IJNCSKX9+
	IL+LyNCMYt7FL7Bx6xT5tC9vMkJt3x57bkzNP6pf/8itgit0nbMlVVYh1yA24tcCiQN1E+kvF7K
	bZkkDUPaN9dFOElwGWZvoK4l6mPUAoJqSMaHl/E5Bkh52TwO4lvbzg=
X-Received: by 2002:a05:6820:4df3:b0:6ba:2927:3661 with SMTP id 006d021491bc7-6dcf514de6fmr4675732eaf.18.1790862857501;
        Thu, 01 Oct 2026 06:54:17 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd985dfee1sm2647663eaf.12.2026.10.01.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:54:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260930-tag-set-send-sync-v1-1-51acdb36f4bb@kernel.org>
References: <20260930-tag-set-send-sync-v1-1-51acdb36f4bb@kernel.org>
Subject: Re: [PATCH] rust: block: implement `Send` and `Sync` for `TagSet`
Message-Id: <179086285425.1662570.7711958272817795555.b4-ty@b4>
Date: Thu, 01 Oct 2026 07:54:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 30 Sep 2026 21:43:55 +0200, Andreas Hindborg wrote:
> `TagSet` never implemented `Send` or `Sync`. This did not matter until
> commit "rust: block: fix `Send` bound for `GenDisk`" made `GenDisk: Send`
> depend on `Arc<TagSet<T>>: Send`, which in turn requires `TagSet<T>: Send +
> Sync`. With that bound unsatisfiable, `GenDisk` is never `Send`, and the
> rnull driver fails to build once configfs requires `GroupOperations::Child:
> Send`.
> 
> [...]

Applied, thanks!

[1/1] rust: block: implement `Send` and `Sync` for `TagSet`
      commit: 06dad60393f20985cc5f24eeed63f965d366c4a0

Best regards,
-- 
Jens Axboe



