Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9B6359A65
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018913; cv=pass; b=LVHChegfliyn+iSovruHTA4QbkslQ++RnjX73ZeB+uAm3l+pABhOiso7BMNxvIlWI8X0Q9SBjjrJ8lX8GfOyctvTOqrVDpeYQQfaGspgYah0IzM4TzwMMiF1oQE/iLPdWTtkhFdij4xRnoeSLyZyaQT4nomQF1hpH1Jpk8PDzkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018913; c=relaxed/simple;
	bh=cXI6glnStEfzLsa56OjL6HPhWnVMVhzXzV9Py23EY3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqiPg9voy48Ogm7OKd0jhnxkafIuRyi5KAu8wGizO6HN2oSTovSlgyj3JtHqWFpaGtIm2rme0oEj9xipVAL+HFizXuAlpBn+gvJO2AVNoho4KCtIjaNLclfhSiI9+vTtx/9m7wztUABdwygsvewiQvkpZQ6H43r+Rd8pHaWNj70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVsPu8nZ; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVsPu8nZ"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69d8091533bso2197990eaf.1
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 08:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781018912; cv=none;
        d=google.com; s=arc-20240605;
        b=bSMmzcHEA+O3i8vYzFp4Kc77jhOIKrWl1t+i2J1uH5DT+CToy9liH5g2yzsb+9K5jV
         MIPqClxCGJKx1cTsB6K9St2Xepr7jlerbOnJNmEBfXIMZFD/syi6PZIJ4eWlV+6Spi5a
         q5uXOYwj/QCsaFrHUzPnvpnQy1t4Kh6g9ThxnCryQ0N+J249gD/hiWWS6P+ZWGBawpGF
         XidOq0lkxnm7h10XDkIxiIVkYHUAjsmOan0sh0g8CVE1q5KoahJuQyFYVbQPgv+vTn7C
         nmzL06JSfRZk1Ktkv5kXLptyxxDE6p4EHGFPF2Zf6rKf5+4zC1s3E8RmxTfYuc+c4jp8
         1lLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cXI6glnStEfzLsa56OjL6HPhWnVMVhzXzV9Py23EY3U=;
        fh=a5XxeBYxYZADeZxw4dI0NtZ8UGW+saCCrNKp4rIOVkA=;
        b=QjeNaAuY0Lvsq6QIM+kAHAbsldqr8eE+TsjYTxAeFXgCMvGr5JSVK2QeZtfNCf8kGI
         Qq+0Xc0yVU7Z3+D3z2YTGiGJ+/lyIeOgm+c/Ukwh1hmXyIKg0Hb+Ix+3hjrnXrf9HL2C
         oRvGUDJ4mlaBb3JDHtK/WJFn74Z3Tb7E2w7FgVF4sWXad9cTp+xhnd4c3AfhbMgxhbOG
         5OebRtCc9pLDUFofUWxkOhne1fWedFsdsNxiC8r8rVGCE0IvtPCW+GBYPwZ+0MfMGIlr
         AHYzJVSNwbsWsK/JUbvembGveAIAtdxFt+bwe6wggypoljhIMg30fQp3kvRhZTelCkp9
         eKYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018912; x=1781623712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXI6glnStEfzLsa56OjL6HPhWnVMVhzXzV9Py23EY3U=;
        b=fVsPu8nZZLjuOubcONLR0JhtSVAWx0lJxD/ceVIOx9UPb8z+c7A5e7lJmkKdx06fXB
         dQ3IEQnyWWoi7fB0SZ21R6CRwwI1vVaDtrdM6/x4rykmr2Rqx5o7KSbfcb0gf6Gimi1e
         KQ+TGjA+eJFaASyhwQfegPNVLeKs4d18YW2lK89OILYbKXGbvU1hVbQTl1/3qYAkPxxg
         zmhTdE3C/mD8/kh1pS+bDmmcCNUWgASr5rYrBm60VOTSf/OBXJdjzs4y8vlL6ZT0UsdG
         ZPVCwRZdtSk8n+Nr38cNG7yvrJ4WSeDZQIiy+FyKNxs0GuPJ9vZnTVA5aw7B48UMURoH
         k90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018912; x=1781623712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXI6glnStEfzLsa56OjL6HPhWnVMVhzXzV9Py23EY3U=;
        b=E5WZSO295KTXWC7HdKl0R+Rqgd/zaJJ8hHYzuNJa8PB9yPem1q7UPUy+ngaZyTMJ2r
         6Hbc4miKPcISfWdJLpG4iqWxEeWtiWsVK3U/qkostMzGOJjfYAuZEqapSlWWU07hEQDz
         ocD5BTTLt7bftGt9ofIXGlY7g18ygYld9H+0ys7xyFWDghAna+JL9XtfO1bGsIgAgVpn
         aRUFBl+MiTfthvNCWvCnO9EB4DGsvOoPuZVzyO8Pf+dRVG8WVS+JGuzRLKqxagS40zII
         T2MSjazQeCyrf9MLS8AwFO9xsKlr0MfN+ALVLONafLjZhEWalwYwEk4xlkkxC+ecPMM7
         6BnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8142lQrT3LrjyMameGDHt6GQ6otMXni+eOKvQNDoD5Mi4A99tTt5hBUIjxklZ4onKsaXEAsttP/jiYdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFhgrlKDzY9WBOwd0djIZAEXolMHV2l3Nih4JnmBe37PgR8U4
	vZJKYppwqKOO1Ljo1CT2d9zp0ZBcmSCjU6xOO9ULxIOlL3dSqXvYbQxzibr2OW08ayd0dXdChPf
	x2LbYLl8m4OZ0R6qwey1E+QwwSabtg4s=
X-Gm-Gg: Acq92OECmbH69cXWXyWBJwVBQTIemdzDw9KxMmYUt5JxkhnBEnmMcxmqlWClVtY/n0a
	bSrWn4mHx4aKh6OQd5IkPvE+XCdP/g//w1wDfvf8ikbok8VL+lbdTqlZTjXyViK152tJDT3oPOR
	p94nu/g1/qwDsM34fAX3MVqyPEFLnTF3diXg0QInneVJxL1Rma+AsdgH7wL3c4zCLkQA0KuTdoV
	pyWM5einX3XGmK0UJD9ON9XSZo81wXEZhAylymkHCmKjIf7EZi+3VC8LCi3o2Hsgp/N5EBZQ0r/
	Q7EOOMTusCsvdOqAkJ08Q+Mc7gwynuc/S3fRg6/OF90I0gqa4m9Z
X-Received: by 2002:a05:6820:4c8b:b0:69d:e5f6:cef5 with SMTP id
 006d021491bc7-69e68cd569dmr10449235eaf.55.1781018911703; Tue, 09 Jun 2026
 08:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526021555.359500-1-yizhou.tang@shopee.com> <20260527141057.GA13345@lst.de>
In-Reply-To: <20260527141057.GA13345@lst.de>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Tue, 9 Jun 2026 23:28:20 +0800
X-Gm-Features: AVVi8CdX5pp2zKIqeGTCt3WtoXNjCnQsykLx0bNKmvPOuuJyH7EykZLPv4edfCM
Message-ID: <CAOB9oOZ4c6ZD34-83YdKbJ4C4VZi7Y+deRH3BysHq0nVEBJSoQ@mail.gmail.com>
Subject: Re: [PATCH v7] block: propagate in_flight to whole disk on partition I/O
To: Christoph Hellwig <hch@lst.de>
Cc: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, kbusch@kernel.org, 
	yukuai@fnnas.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Leon Hwang <leon.huangfu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 10:11=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

Hi Jens,

This patch has been on the list for over two weeks without any new
review comments. If you have no objections, please consider picking it
up for the next merge window.

Best regards,
Yi

>
