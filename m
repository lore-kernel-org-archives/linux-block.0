Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5812163B1
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704556; cv=none; b=KSbQ8WSybe36822msQ12LspBfIinGWutpAU5Jq3aEG0PIwJ17xWgK19MH4wIGWJB9OjSO9qn9otUjYRH4trG1lhghYCEgCUF38jb01ytoeAeo1dYoesBa50cJDT/oVjMGi11ACkTvg3f7c6pT/T/hzaQ9uaz5n6oWWw41CQV3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704556; c=relaxed/simple;
	bh=7RswRtRrTlNx5IE2ZzGOy5P9Qqg6ss56dP92rV3APyw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nXbuO5YcTSsz1erCPbounbfddF0EX8RjUcHNOY8j/u1iLObjpGDaMM0aDz4s7mkpZ7cpCDjAUn4zdGC9kv8Z4pspBZqZBwvvMpOVSHmij0a0Rpto/F8VPfwhY+qGp4kvXNrexfRovUv6roeW81VIsiNBFcHp3z9DPJaX7Iz1L30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fzgegj6I; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fzgegj6I"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9cb667783so13909525ab.1
        for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 06:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734704554; x=1735309354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mnQbwYdX7A7JeiPdTaAYP2wIDAM1JErLj2ggs9cY+Y=;
        b=fzgegj6Iz6B5ErLN0DIW+vjLA/GQPVUxycQY/o937dGyRPEwJZnujhuLifN1ewNYr2
         kQ7i3KX83e5FxjKOkJglctiyBUF8IIAlves4A/0hrYlZEfcnUMnU0uWglvgvlcStY3qW
         PoOYQ2wAxF3uOrPT6nqb7DwWcmN8HSEDjH1oEfhPsSSnHimsRA9a1mFKWd37EYglggRT
         JWTU5wg8MoEwg8ib4KjQDlX/slmQtLh5KNjhKeeBHy8aXDH+6/30k9UjIv1+9ynPquVw
         An1yLwO+4T134LcBXAumOOYTxRudh9zZsTC/8Nh+Tjwrdbd6ez/LP80dXybpr9/GP17/
         qJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734704554; x=1735309354;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mnQbwYdX7A7JeiPdTaAYP2wIDAM1JErLj2ggs9cY+Y=;
        b=hlULUbHWhMnRbaskt8WRzarn10stdYgoXCChjA6kug6MSyK68ZjK+GZAgCc/ojqUpI
         hHQ/LJyC4S8X00HAUsW20fgQ9EC8VgE509PudlLk2u070t/86bz3ayQq3AceybcBTEJS
         2KKKEXnNiYO2dxSNBpm15ToE8VbLV5Z8qV3j/ivOmsn36Q2hF/CumW/YFpykOcIftDzl
         lu7jZpvQtlinbRmb6Y7MEneqDZFnEC6E8HeJpyUyoDfeShd6s0FXPz23WTLPhyQlYIKL
         HvC8I7NCdQajP9JAPb53fiFtvuqLJiMB+HuUYzCgVIocohF37gsA5TaiLHfLs4lp+zgD
         J5FA==
X-Forwarded-Encrypted: i=1; AJvYcCU4UgQKIrKo3eBnWK/nG4POGQxELY8ye5UTKjhmFSQ2BIe0Ng6aQo1yW3jx+J0rSXffCyBWMKj9kYiKMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67d4OOdJgA1NP+3uY/xPQOkmZ6rCMUQLwcnS5bonqUjhnQlH/
	PRfs0Loq/LvKFg53vPKFODcUruAZBX4z8hM7H26v/FDeIKgJRJq33EzpWdqkYdc=
X-Gm-Gg: ASbGncvb6SlzP2FAt7vpIr5y6lRdVc8zSyYAL5aId+5lRZNT6k6n3NHv2h3pon8diTb
	5W3cULN8RZtxRKJrqfLusSJXVQKVQrP3eUN8/lonzcVD4ZYUkHN9c/prRsCNBP4f8rAZix1ZEV2
	mRVtq9T1zVS6P1Y32f0+idecG6kcZdOm1npkmSsZPyC8RJWmtlMEc/g/NlDjJxUD2FvYcPhsb9M
	Q9nC2lXNamhJzTPAtg29Cg657cna8pBj4SNFsxpJcI82uw=
X-Google-Smtp-Source: AGHT+IFPxMJPlAfSJUbAKKYUQwyjJ4jRL5yVjPl41sdnKAlYG1Kd6O1j0Ernd94CpqGnqH/NowvFyg==
X-Received: by 2002:a05:6e02:16c8:b0:3a7:d84c:f2b0 with SMTP id e9e14a558f8ab-3c2d277f25cmr36374295ab.8.1734704554467;
        Fri, 20 Dec 2024 06:22:34 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66f74sm803185173.49.2024.12.20.06.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:22:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241220-merge-flag-fix-v1-1-41b7778dac06@kernel.org>
References: <20241220-merge-flag-fix-v1-1-41b7778dac06@kernel.org>
Subject: Re: [PATCH] rust: block: fix use of BLK_MQ_F_SHOULD_MERGE
Message-Id: <173470455315.1029314.14508539794048190580.b4-ty@kernel.dk>
Date: Fri, 20 Dec 2024 07:22:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Fri, 20 Dec 2024 10:37:57 +0100, Andreas Hindborg wrote:
> BLK_MQ_F_SHOULD_MERGE has was removed [1] and is now in effect by default.
> So remove the flag from tag sets of Rust block device drivers.
> 
> 

Applied, thanks!

[1/1] rust: block: fix use of BLK_MQ_F_SHOULD_MERGE
      commit: 67489f4bfb02cb86751f168bb57af250f21cd1ad

Best regards,
-- 
Jens Axboe



