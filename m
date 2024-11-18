Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA88199234
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946286; cv=none; b=eKJ1vb64NkNdFLSl80FSm5Y3EnScnNS5CZI5HVV2bD4l9p0LOkjJK4z6Rg9Wv9SLyjgcW7vPoozguYQpqCKVMI00aOvxg4dGoJSvOqkPQCOTsBH01nHKvBeZndiGtckFVeGtaCWdkGwp69un+klOHPG5gt1CFiDbdp3boLN4THM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946286; c=relaxed/simple;
	bh=4jmd3ZaXjdZbqF8xYXNZM8N/IiW30oETCd7/3Ob9I9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SWWHzDJzsHmJUOGssH4krCk2zZ/uq5HlxNknQLac8u661JMAJGfm8Mt+Ba+QJ68gTQMQ6cdqqNSht5qbkF265+crDZOXHOrXVCMmscMRRn7618kCVTWc02nwxx3jfk1byWb/3dfJ6f45nrGyeGrLXHBsxD/x5zcZ1eSS3zLnlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h0UJf/Lw; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h0UJf/Lw"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29678315c06so613200fac.1
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 08:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731946284; x=1732551084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFX176F9yddCmt5Wh7Oy+culie2TS0hzJxcolb5yYc8=;
        b=h0UJf/LwLdOuxCkQA+75IhembrHSY1uoTJTLj5OFH7sAutX+URIeH3fcIXky24piFv
         R2wCTWvfo3PXzUPKMHn4HXD9EM+wvFaLAfUUFAfsh13xOOJffyl5opB+FfuDEkZ+C4N8
         mA4637ArOwCUTj5sEZp6ueoAs1mMWUoC6Q7eT2Jm2ekUF2cf7cJNtPt4fifx55UCSVOn
         UJX50AQWNMWjbSXYJAaHVpVTbHp0JpL6ONMe/fqrZrql8XiCOgPMVswJjEmRWKucwoN8
         hRoXvZx3OsoTgwo5UJXUbZeJYhZ0YU50bsKHBTcwEFOwdYqwVh4bjK32p3UvclNyJCX0
         kMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731946284; x=1732551084;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFX176F9yddCmt5Wh7Oy+culie2TS0hzJxcolb5yYc8=;
        b=F/n0L2b4wojUnfcPZ5bno2HSrqOoGHt1J42JJbbuWD4EcBNaPwb3+D5nnuUmQVY74s
         xLqrEf3ld46NVvNv2KHsUkn8dHojyZHOvhNVniXjczCNTxwwr9p0SkxSBYP53vT2v+Le
         r76naZOw2Kqp9Wbn8lEQoxgrkyjU46+cX2yWS1C5YMthH9+NvaRiMqF82hp6rQvlj+NL
         0GMiYNmirNjE/zHrC40buCs8NYwMMu96rKt6uIjwmvXmgheM08H86Inkv23VEOCUg/Jx
         BgR4VupeILRKMkjX033Q1V3dovlR8Y0bEXgE2XiFR8Z+grNA1BOpWV0UX7WygGVGZsxQ
         OijQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu2+jvDFkD9e/C3ms+HtjTW3enToJ7VS5RpA6l/8RlQDlatyxf7O6WHHuiaTM0eqob/QstPd1JQJVMMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFS1DcEsDfmnANrF2mAj7aXehWSwGMEtVBKh04r5IY60d5dXQV
	v7pYH8WWyzCJghtZTy5tAA85FjmEdxKwS+exFrBI9iiUP7QGPvAraJTpnerZP8c=
X-Google-Smtp-Source: AGHT+IHLWogomQKFv4+SfGMqqx1r5l5JiprU9vd4VIYsYuahESKBVj2a/6Ge8gIxXEGYSL2BWBgL+g==
X-Received: by 2002:a05:6870:b508:b0:288:50aa:7714 with SMTP id 586e51a60fabf-2962dddc768mr9653303fac.24.1731946284080;
        Mon, 18 Nov 2024 08:11:24 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-296519331c1sm2676223fac.23.2024.11.18.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:11:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Manas <manas18244@iiitd.ac.in>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in>
References: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in>
Subject: Re: (subset) [PATCH v3 0/3] rust: simplify Result<()> uses
Message-Id: <173194628221.10763.15458685063715699206.b4-ty@kernel.dk>
Date: Mon, 18 Nov 2024 09:11:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 18 Nov 2024 20:06:57 +0530, Manas wrote:
> 


Applied, thanks!

[1/3] rust: block: simplify Result<()> in validate_block_size return
      commit: a3f143c461444c0b56360bbf468615fa814a8372

Best regards,
-- 
Jens Axboe



