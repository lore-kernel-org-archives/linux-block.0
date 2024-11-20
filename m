Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6622EE4
	for <linux-block@vger.kernel.org>; Wed, 20 Nov 2024 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068390; cv=none; b=HnGwS2kfXI+n9258HiyQQV2Yd+xH7z8NjBmH6sPCVdzaLEvp7inhct1XZRYARGObRcl5DTrAUJw409WQYgXa4tY9EcWFTkwaR+LY02HpzfkzZD5QIPwU2OoYi37JrvZPiEcPW6SNcRK8290BgDqnzkr+FfLTzMnd5D24Oczd8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068390; c=relaxed/simple;
	bh=rdPIe6YcTqqJ83486ajEhfdbKM00wFW9wUCIKyOCzHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=komqjtXxG6G3Dz02DQShR7VMKb/x4xNjOyx0LBkF1wetA172Y1WGovyVGFZ5MwqFjA76K+vipdYZxaP0EKeNru9aj1Rna2S9XkPztQ0Oizrugz+m+G/uJGBS/mFoKafDGqwAMn9EQCAqY2puEBwqMKhaOvLCrSSv1XjGwvwm7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0a73mapn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0a73mapn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21271dc4084so83575ad.2
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 18:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732068389; x=1732673189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQM11I9q6a2A+hJ8tPsU0CaHYM4dPIcA+9p4rQMUI7g=;
        b=0a73mapnYSzYQvam7BEOgrX2TzdnBx4cqolKQNEwIVCORL5QnX2m1YGyqKzGCPhsr2
         S7hF4PncjWn9XN4Zy/hn+V8dVr2ejfxG2CDnKqluuLrVf83It0Od45uZ66ohUpKAUCFg
         i3qOecmrxitdJZjd8To5PE9k1jzCVMESOs2JqJtEO8EBOD1Xh78WBOhEeSgdqlKo+0S0
         r3233n1a6i+B7VHVP6XLT/dsIW1GXHQBYTEULiNt/cQxLkUJ++FdCP1ZQFhUIwwlj1tK
         PCIe+O755wwvfTstpjXm7RBOcecjY7l7pKir761iB4Dzp0U0QdHDtS6pUwNKwSxhYrVZ
         t/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732068389; x=1732673189;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQM11I9q6a2A+hJ8tPsU0CaHYM4dPIcA+9p4rQMUI7g=;
        b=mT06wM5WiJXk5Fmzrmtqf8pv1Dx7NCmOv7zNXPfXrGP/zXHBroMPKi71L8eJwNFJwg
         tujDsQKb66XrIjsJvuV7DvdBJJTTnxlEG1p8Oh4vsRHC5JX09ugQBcZUlyMUAF59a8hE
         VXWQlVvg1gNag8tiGM9NDM/rRBXmsGZqJZn1nYkZTe+EgbAkoehAB2IOsRgyCMD73ENu
         vbJlroAhIu20yvicBuTWkHmavsFRQQEQI4S7wzh6B275NDMTumJNujtjuJ7G5spe6vOq
         mxdLdly+20Q6Z1MF2DEfWn3cj5gmJHx4YUxAumFbK1M6v+WpveWJgDN+Snu96I5mdZOh
         L7XQ==
X-Gm-Message-State: AOJu0Yy1WygkRPjnsHiNyY38KEiT9aiVWZxdCxhYeNS36Lj9amtgJykg
	sSJkNBWLkGbn8Wb56bSehuCkJt+y1K+rN+YgGSuuCgMbLStsrWHDXRu5BnCHlRY=
X-Google-Smtp-Source: AGHT+IF/gM1QRl8VDd0PtOYnipnBYViZzqY7IIWXPtsh0/5xGQUtWRB8qM5KuJru7EG+dKc7x0vwWQ==
X-Received: by 2002:a17:902:ec82:b0:212:46c2:6329 with SMTP id d9443c01a7336-2126cb371f5mr8372895ad.47.1732068388721;
        Tue, 19 Nov 2024 18:06:28 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc312csm80961065ad.27.2024.11.19.18.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 18:06:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 hch@infradead.org, hare@suse.de, kbusch@kernel.org
In-Reply-To: <20241119164412.37609-1-surajsonawane0215@gmail.com>
References: <20241119164412.37609-1-surajsonawane0215@gmail.com>
Subject: Re: [PATCH v5] block: blk-mq: fix uninit-value in
 blk_rq_prep_clone and refactor
Message-Id: <173206838768.183842.958207443357457539.b4-ty@kernel.dk>
Date: Tue, 19 Nov 2024 19:06:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 19 Nov 2024 22:14:12 +0530, Suraj Sonawane wrote:
> Fix an issue detected by the `smatch` tool:
> 
> block/blk-mq.c:3314 blk_rq_prep_clone() error: uninitialized
> symbol 'bio'.
> 
> This patch refactors `blk_rq_prep_clone()` to improve code
> readability and ensure safety by addressing potential misuse of
> the `bio` variable:
> 
> [...]

Applied, thanks!

[1/1] block: blk-mq: fix uninit-value in blk_rq_prep_clone and refactor
      commit: dcbb598e689e30d4636201d35582e167d1b8dfa4

Best regards,
-- 
Jens Axboe



