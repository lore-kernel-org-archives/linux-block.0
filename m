Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A2345736
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653565; cv=none; b=WXQYMtXhCZWc6c7R8kEGSPd/DXYg9BO7wtOhrGr0vcLY0yUApJYh7PcVyfoIL9tuaWdqbTJ4nkUPwrRgNE61G1oukVibpUoenDrpVdx86mMwzAxoktnfn/2k4RfBVzLLpHetxWbwXVYPVA+Rt4JyT8xp/gATJRQNriNxn6xKWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653565; c=relaxed/simple;
	bh=rQMG62klzk7My02okdNZGZ5OJ2y6Qu0CKZDTi7zTjZA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GHCJh+/GXMCnamliy4RkPLAbkrCuvzjCyqHTVnSNWF9UcOltmNKCEtUru5P63wgyUTT5TNYtUJv79gup1eq2dD+MK4qlvhU2qUvmRSu6bJxqrXB/2y3gKdeRntRw3pSwirMlMwxWjRLn8qdToPGtROXyQwwa0YXW1YYy6mhJa1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n15ShtoL; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n15ShtoL"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45c9f47e1e8so204047b6e.0
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 18:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769653562; x=1770258362; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQMG62klzk7My02okdNZGZ5OJ2y6Qu0CKZDTi7zTjZA=;
        b=n15ShtoLOVPomZIIvAoOSK9mhJ607lf0UQlFSX5mf9yGtXwuGtGHYNBguwxU6oGmew
         4fNpf2kOQQL4u3hAN1uI8xKceb7/emRRJh1fBIBkm70+u0SNJp75Cfv/hRY7wsEeq8QJ
         4kNUwKrW1YeLCtbKJuUygaPqcyZSD4hW2OnaxsMDbQCYuldgBbSW7JrCDOhJYmzj6AM8
         2Zp6CWqI3Dbbv5zYcGRN9YpcDyiU7nP78Bkxv+l0WbtK/zdJkWYnr8OlOm8MOibJNV3i
         fXVU0bFzrqiKb82Gy2SToHpBK8Lq/yjuoeIm3ylLu5dEIaQg6btL7ZBuzlpULVvrNFbL
         VGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653562; x=1770258362;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQMG62klzk7My02okdNZGZ5OJ2y6Qu0CKZDTi7zTjZA=;
        b=eI3WOi9rLYPuFiKxXmTjQ/EY56hT5uY/hQrzFB7MHoGvhLLp2D1aTDW+ju7t6coJOH
         W6Egp+nq8N5SxXma/iBQuKffO2COis8cia1nOkdL8Y6yaiNKDNVHPygQO6l4RxNzqV6H
         A03UQp6W5LnSIhLXC+uN/LRSJegH+Bfrk5csdh1ta2rG70lNQfARsR3KQMnRsyWbB9p+
         DECvvmd+ARPqCfQXW01NOxDK6n0j8W2quMCCsda4tKmHK6jN0pdAJvp4ePQS83Gd+yfL
         N1WnNPsKb/cPc9OeLkBzZumfRcpeIsApQshc71AlBDUOIepoR9IOauyX720z2EjKtmbs
         IMSw==
X-Forwarded-Encrypted: i=1; AJvYcCXyOQTefghR3Z0alMcTZWQUBtiwdwhceLx4II7Vqg6SMwoYYF6syDlnU/iu8snj6neNSUsVpKmrDM+mQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypxK6HVtTs67bLWUgEIBeAiKwSMtOhgRPcNneN/llzm16Wvigm
	MR2hHOaX76iAMwnR+pe9FNAXqDg5C8lbUNf7YbX8amvvs1BZeSMYYIu//8WEbNU8O8k=
X-Gm-Gg: AZuq6aI/v9ZCCLeiKSsbUnNE4OeleNB9QKurBwsMkUH5YdbKSqXmEgmywkR0+3vVvBX
	qNCBlIGzxX3tLQN1cZ+VXa84GZvMEE7b/QvjR3g+yTiHsXhm81E1FkSgYIW2wKvMF25BjoodvtX
	kOxpNUuFaorxW/bKaVt9hD7v9ZcEfX/guc5EHz3/lET59ejytK5WpaRxGO1wd/48NZPPCm1N7ZY
	pZBjEZrf/hkwMjjOKrmKRfJEIlVohe7C7irblZy8Awt0jq3KvWYZPlnrAaYUBIDFU/aQjJ4DSwt
	jVINxsdi2QGzm84RTuLIUD5mlG1vIGOAvy5D/LRwtbtQYWyo7phTlUQO7V3i+6dCkmBTMKq3oes
	b7dy54pAKdybew9RFaDG6XrfKiriw6qjm5P+7X7urbZ9BHE3KPLVC7bchaFYcMkZTryp1R7RsC4
	bXepUvU5rrUS+Y4kySu79R97n9kKYapfsH566Woygqtg==
X-Received: by 2002:a05:6808:221c:b0:45e:801c:a0ea with SMTP id 5614622812f47-45efc6d0628mr3467328b6e.32.1769653562137;
        Wed, 28 Jan 2026 18:26:02 -0800 (PST)
Received: from smtpclient.apple ([99.196.128.181])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f22b4e676sm483963b6e.3.2026.01.28.18.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:26:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jens Axboe <axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous when trace_async_init set
Date: Wed, 28 Jan 2026 19:25:46 -0700
Message-Id: <56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
References: <20260128194104.30051be1@gandalf.local.home>
Cc: Yaxiong Tian <tianyaxiong@kylinos.cn>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20260128194104.30051be1@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: iPhone Mail (23C71)

On Jan 28, 2026, at 5:40=E2=80=AFPM, Steven Rostedt <rostedt@goodmis.org> wr=
ote:
>=20
> =EF=BB=BF
> Jens,
>=20
> Can you give me an acked-by on this patch and I can take the series throug=
h
> my tree.

On phone, hope this works:

Acked-by: Jens Axboe <axboe@kernel.dk>

> Or perhaps this doesn't even need to test the trace_async_init flag and ca=
n
> always do the work queue? Does blk_trace ever do tracing at boot up? That
> is, before user space starts?

Not via the traditonal way of running blktrace.

