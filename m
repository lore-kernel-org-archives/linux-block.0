Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDC35FF58
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811222; cv=none; b=f36HUB7SNJ6KRX0K24UVUK7UMvlaUOi4oEuWtVYWf/X86r09QLwBY/nKPHitGUUu/aF8NSGzvT5B5wuF+b91T5xLwj0GEr1OXn9TeGhtqXZ+G/Mg7tJ6N/QD7IOSSi6v2aJ5xn2O8RQ+pHjC/ZME04GG9+Gano92jjmTDSFJhcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811222; c=relaxed/simple;
	bh=1HSgYboTRu6H27orjBsE1aFDVcS9z4TV/7JMPiRGVTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a3YEfKvkt41H7ur3y5l/G6M2f54BN/UvRav2Mh0ZLyhLfSzDG/YzzYOr0eC6TuIF8wmhZYi7GiXgcB6hwKT++7KaFJtWs1665r1illmcdpVh/v0I+z19p+2aF1DJp6R/wZtkKtAijS8NILw4256OAcjZkE7+cl1Yb7XYRfkDkDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=CsKqCerK; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="CsKqCerK"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-456d267da8cso1716526fac.2
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 19:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785811220; x=1786416020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=io4WL+YWrlpsFuzWq71yS+mK/D8qrSsnCYuW1KxwtOM=;
        b=CsKqCerKv8JDarWVh6JbnCzyEXb+3Lclfut+x3qZ06usSW8TnGRiB7L0ZOJD596TkX
         u2NREuPTy5z9BxyANdnUwKFsE3DnZof7KG/xAJvIOlPVvNM2VrqHoAiIOYpc6An/ZLqC
         0DnO+Knpejjlw0Dhz4zUTZGRLtkjNzOw4/fCEjepGk+NW4l3bENYRXPUhmrZljwjr91z
         JMmLB6ahml7X0FaAkZni6p5k1k+DL+qSJLvDizqlryDeO+vwSNycsty55oOQ1IyTZ2fN
         wOGScyW2cdb7TSCmKdZqGQQNAQJyaiZR/lo/HG3BvX0aU87ovQFqC++CTUOb0/yvNbqW
         6U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785811220; x=1786416020;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=io4WL+YWrlpsFuzWq71yS+mK/D8qrSsnCYuW1KxwtOM=;
        b=VowyHqWUZZZhnu69GdMZuvWmaZS/N/gZoFs94JtIp8ZKGBt8xIObzG/umFDhGflx4v
         0HH3ZGIb8fECbDE+7/2QHtZbpojSBbTPU2SsrxLneDD3P9Ll1fjf4PM5DA5CmRXoZjZ6
         xa9LJCtMFlq/nQqqqaQTSkISRDKjoSpeF2YI/fNxsPdDvro766KrPLOwDaXEMtT9bbPu
         /VwW0NtVKsyRbknXV/JTajo7c92rvSTBUV9xbA+d9mGTHbqacXOmSSaXbpZHvRqMI8K6
         Av4eI9RLE6kJ31vcHQR9ITEmadGXRwp5djvEIVcsQr7saQpbhbXcz/SXnYzj+wlP5l4j
         Rxaw==
X-Gm-Message-State: AOJu0YxkXV5l2z/xfUXe1mVk6er1VPPJxM3m/O8hjVG7L5y0y4l2p55V
	PA+EnZDDLzrCAEIXylJlfaV9jangdYGjuzTpVh1Hvba+QWTkiEqEs8ro1lahHWjB5zNzu9kxrPw
	V6hn1fkOXlw==
X-Gm-Gg: AR+sD102Natjj5tdKr+A631gO+enE2XweVAkpf78iV8fBsDjz5TSCxSwyzKXLpyuc1B
	euaa+zlT+Z9s5nY6fyYyDgIcpNNFHBnnOLC/J4FPsgdG35zcbTQfu0glDDLa8S9FE+dW0aBwqIO
	8kB0HlrY/hMAy+/pFeNXRlX9Vbco3l6CHyMDuJj0+wOH6OBxUVC8QVzndajp5SL81QkWifVI4Wy
	gFZtj2Ftk1IegYpRIOeZ6ccpsIobUGrVazqrj4Id5ZBwuaIJ0O4ZLkxE0pZT9Lxi/tyGTnDJzHp
	o/o+8ZyeFCl5W/pkfqRYuUGIN8Xu5Khy0qxhZwDB4BKYBlHcR/JDO4BnCrB4FdjD5vx+kPqexII
	q6cBzkyew8iEfvKQB6l2nQv/uR814rJjlfuNFg/ce87z19Nos2xfyxr8k+gSXqaR/mT1nFzk484
	pNU7iByy8kXZkiELEv+SMR423zhi4r5R5NxA5l7tiE4rpeJrojfSadCLsCAttvXu0F1cCKoX91F
	6tj8QDiG4XwrNXy3D9c2HNj7s0jtkvXvWuPphM/Lw==
X-Received: by 2002:a05:6808:2f0c:b0:495:fa73:2e44 with SMTP id 5614622812f47-4af5e227274mr19676806b6e.15.1785811220010;
        Mon, 03 Aug 2026 19:40:20 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58f25e00sm7725503b6e.14.2026.08.03.19.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:40:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20260730024050.1062354-1-yangxiuwei@kylinos.cn>
References: <20260730024050.1062354-1-yangxiuwei@kylinos.cn>
Subject: Re: [PATCH] selftests: ublk: add rotating auto_buf index
 regression test
Message-Id: <178581121634.578215.15829017092257405641.b4-ty@b4>
Date: Mon, 03 Aug 2026 20:40:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 30 Jul 2026 10:40:50 +0800, Yang Xiuwei wrote:
> Batch AUTO_BUF_REG COMMIT must unregister the old auto_buf index before
> storing the next one. Fixed per-tag indexing (A == B) masks bugs that
> clear after overwriting io->buf.
> 
> Add kublk --rotate_auto_buf so each tag alternates between two sparse
> buffer indices, and test_batch_04.sh to exercise that path. Without the
> driver fix, the request ref stays stuck and I/O hangs; the test uses a
> short timeout and kills the ublk daemon to recover. With the fix, a
> small write completes quickly.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: add rotating auto_buf index regression test
      commit: d507d3cb19e71f10336e41deeac517cdc21c34ea

Best regards,
-- 
Jens Axboe



