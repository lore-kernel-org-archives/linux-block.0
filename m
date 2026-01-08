Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A684A13AF
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879456; cv=none; b=TC/4wuwDymXun2FJJsJeNJKScLcifYmza3yUsEJKD+ZTbKc4hTUu3Ln+B9j4vFDu6XheoG5WwhUx1NPvLCWuYegqkl3pJUYcf77zbTpvGnhaQE+Znsq6BiaBOOJEBtjoB8b9iabMXaKTzKWF8G3W8/j/QMn6ekjRp7LyeJxpP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879456; c=relaxed/simple;
	bh=o8g02gEAn1t+TQYPSvyJnUAMD7AhjCF7hGfQgEhYMiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlGVAPlAI0N9//HmsIu2Mo67toMIeA/qtWQpyeB/GWkaXjkT70p8yC35KfdlWyOISayU5OvS2CuAE4ihYM5bVjoDK6ewCQuP9ILt0CuF0SQDhSuzPLW28up61KwSGSz41gYKYACAhn7XGOPNZ2czsM2eX5H+Hl8IHE+Rfm51rnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGJyZAP5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGJyZAP5"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so4664592a12.3
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 05:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767879453; x=1768484253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o8g02gEAn1t+TQYPSvyJnUAMD7AhjCF7hGfQgEhYMiY=;
        b=SGJyZAP52uKPwkw3zQQwq8k1x5ysJIl13sSpidLWOB78BPuGt+m9LDqXct6A6faYs9
         uIHrVkx6UoZnVA/y3k32g0TtqJEnhTsHla2sdU/tbZJ7o0XhBDUmrwIS10MerbVRrm1F
         pOoOvniTH7IZBt4OuRkIxNoBHpWPn2QfrBJEjhpH0kHW9yqe+f/oqd6Baj62rKP33rSF
         LcJnJtQAUYb3kthqzKxLTK1W6Y8Hm8AwW6+pQT1HyYmXDG3ylNqXZA7Z+JxiROk+njGN
         aKNG5LvEpTcCsUM+06ClB2YZz+SLEnuwyhX0nG7LWS+aZzodhlNF71fKEYU7t8t1I0Qb
         +FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879453; x=1768484253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8g02gEAn1t+TQYPSvyJnUAMD7AhjCF7hGfQgEhYMiY=;
        b=b0fHwYuqheP4tjE/75zORTgMrpqFN/+Ii4p7Od1Zt3dRtQhljWF9wLH6btutIL+pls
         C76mdf6Hg9++CYsCsoEAbak1sOmpUmLMsy5tlJtb5EUujgEMZX0K/qO92V5MZv5kTVIh
         Arulk7KmRYHq4ya9YwoZrjHHAyN+tq/ntnY+zBa3j+A8EExGmrIjeNG2mwhApMnLxryI
         IfxIHJgsS1PyjfNFi+GxeG+60OaOhKZeMLRId/x/mVo3/WYBLP5cycIYAVU8HhrnnDZN
         hLGJYIJCjo4f5wxo9oQpBBdqZodVvmbQFuT3tDMj14Zvh0ZNS0YdpUip2pcguLe31lHQ
         iGLA==
X-Forwarded-Encrypted: i=1; AJvYcCWa4BOC1iOjCwTzCyBI1Jn7uXabMkC6bnSOO94/+vVywlOe9P5MvqMaHgp+RopCHwv1+DQamLWBffJWUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGI29ylNicWcANi6MVl3V0vUaRxIMTqA/zruRLfDAVkrINJHxB
	5+N7JoeKkVjw2xrpX8NCea8LLvzrgQntlM0fGHx6iuXYcCXcR9/Hp8loOrqSAqlS0pM1LTB3DxA
	q7XUswiVaweIgf2tSVfyTbcny+ToGBQ==
X-Gm-Gg: AY/fxX5ix5fyVu8roSSpOJBJBLuMcn+RGA4XgtrzHGRKe6Y/2QUIVhNSn3cPJSE+4xL
	LZDaSH1o6rivqahuUAhwRHOU+lweN7jKXoiiK1S0bN0+eJ8eDgcTjMwI2kGFCvhX4iAZENug3U1
	b9l104I5bAeVfJ2b8En92cfcPt3FoQG4k9Vo834lzSPRdtB9Cojn4AVgmWL2ScirbyyNWBPi9pn
	PD1iwnqmReLqKeXVfTeH88oYa5lQrvVGLxNRAhoGMwYK/bueQvFX7nfJCANo7Awg0t42Dxq+3Gd
	8c577x/t3dXJM9yL1MCGQkkBXfQWx8rOb0ujSWcwNGoS+t66eupJxDC70A==
X-Google-Smtp-Source: AGHT+IGEa0IKZhwPYOUOHsgR894VQ4LBHqUPzGJp4DlfoyxNKPVXjh0O2ER0HHQnA+BLI0vv9uqDMlfx9s/Awwr5nK0=
X-Received: by 2002:a05:6402:20c1:20b0:650:a098:ff2e with SMTP id
 4fb4d7f45d1cf-650a098ffb4mr3653832a12.18.1767879452813; Thu, 08 Jan 2026
 05:37:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108090401.1091352-1-csander@purestorage.com>
In-Reply-To: <20260108090401.1091352-1-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 8 Jan 2026 19:06:54 +0530
X-Gm-Features: AQt7F2phgaAocpqyz7LaHfMLOzJh4PnOf03blsPyxSNg8JsX7mQyCPiD66b7Gag
Message-ID: <CACzX3AsbrRWjFU8cirZ_Ey9O6kjAsC2HHBn1xPArx-6-cNA=nQ@mail.gmail.com>
Subject: Re: [PATCH] block: initialize auto integrity buffer opaque
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The auto-generated integrity buffer for writes needs to be fully
> initialized before being passed to the underlying block device,
> otherwise the uninitialized memory can be read back by userspace or
> anyone with physical access to the storage device. If protection
> information is generated, that portion of the integrity buffer will be
> initialized. The integrity buffer is also zeroed if PI generation is
> disabled via sysfs or the PI tuple size is 0. However, this misses the
> case where the PI is generated and the PI tuple size is nonzero, but the
> metadata size is larger than the PI tuple. In this case, the remainder
> ("opaque") of the metadata is left uninitialized.
> Generalize the BLK_INTEGRITY_CSUM_NONE check to cover any case when the
> metadata is larger than just the PI tuple.
> Switch the gfp_t variable to bool zero_buffer since it's only used to
> compute the zero_buffer argument to bio_integrity_alloc_buf().
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: c546d6f43833 ("block: only zero non-PI metadata tuples in bio_integrity_prep")

Makes sense. Thanks for posting the fix.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
