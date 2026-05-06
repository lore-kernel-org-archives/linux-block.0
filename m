Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5C0846A
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083704; cv=pass; b=rjVBi1nkMaTByPkDkTbcrguP6g8ctUg/mWpu3tkQGZk6FzaamYyHwNB6zswIZVj3EhI0YiLFRTYmdv0fsGetu+RLMHm5IrY2CZbV4HXD8Ed3Lvpv7XeO7GEr8aiP66uoH8vd2XwLHe2PEb2bEafcdoM/xrNmbRmnxyCFMrFlYGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083704; c=relaxed/simple;
	bh=iLAEe1urBByOXWSv5xp49D//QdaWE/qohEdlG31vM/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r37Zun12ku1RHoSXMmt7fvkxgyKo6wp30FEPLEhW5stXfsP2K7vM7Ugow77kUr5yUS2NrVQkYXeZkHgA8GUJFWWlnjoAA/VvqLjLArGpwaryYlOs1Flfh4CoUTcndpKoXcx8gxUNM0ZJ3bSAw58nFJ686TtSiuf7JlTTxZlGc0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XJxwAlD2; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XJxwAlD2"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-47bbf1341fcso338559b6e.3
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 09:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778083686; cv=none;
        d=google.com; s=arc-20240605;
        b=KmleML0yM5JX5okGbLMvV4ZhPRBFJ3+16m4mZp+oa/Uk0Otct0X1MEIP0bSmXdJyJe
         WUYREiAkdUwtmKVfL5QNb9XrM/tSYvPyVjvulSJVvBf+6AUiqZUqMXWOPK9hNTppPbW6
         kZlT69pHV0TPzE9uWa4z8wyvjhL9YPt3DnlKotuXugEZ73p/9tK/sESN9X8Uj7FmptdI
         0cAfSTPiWamemUDNY6M9wD+2Vg7+MXG8jVYkGOuMUCRK8evl5hS/ysO/FcUJSTNcfJhR
         sRJBAIKBD+vGAVVeSRH+1ompUkG95hm8kyqImH4MiKS9/kY5gb0rF8NrnE8I78ysl6DL
         mzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iLAEe1urBByOXWSv5xp49D//QdaWE/qohEdlG31vM/I=;
        fh=vu+NOfMmkqTL7zAejC5rcxVE2rbwBvDUFq6gCkIC5tg=;
        b=N5WCaw5KYiJfy3P2q7KVS2ncn1F1hDj/y3nDBOm7SmMie3gaJNg7IVXPgRuznAOR7Q
         cHBeKCDFUyRAj3pAzV921uwFkR+3+g4feb8Yqin2+XxhJuNmpdc86yN6lg4kFnwiCDqw
         nqhRRPDZI23oxo841w0yTbn40ybGhQAcxTBHv6QRhtSQ62UYHSInaKAxHS3yPfrdRyS0
         Dkwkeqqd1N3+gI+toZRycjBJlPOxpa21yFDTWHiDKV9zWsqEZnCLJ7ny+iemEozhbCIf
         ywLDKJjGzB13a+Q7l9fMgXFd+7eOfZmLxOR4Ccc4HJIXJNyd9uTsUEzgeZ7nB1HDYHVu
         fVlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778083686; x=1778688486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLAEe1urBByOXWSv5xp49D//QdaWE/qohEdlG31vM/I=;
        b=XJxwAlD2Wi6bxcmrCvycFl74asAUWbd2rm43fbMGFwRztVZVgkOEwgwYbHzbvcz8zF
         YY+PdOSjXgzsAn1m0iKjduqpu41hfs4DOJfQXuMIfYIwVs3hAPJ1AelkirlxFUXDMkTE
         omZ9oMlhntLa6rvIzqJqaYrmmru7JByMYquxYaek35+6ihRzuWBLEMXJv2NVdSHKHk0U
         Cx7kdWlhEjD1rnsdGsBbrgAcDfkZAA54nub1n3djlIQl7XEX43HwtuxHQ6bKEE1VN05W
         pbLWHSno4LgcwGZvDCulB1XrRBB7PapdKoD+Iqfi7DYPuiuwA818Ymk4QCNOpO1PYZLQ
         Tlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083686; x=1778688486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLAEe1urBByOXWSv5xp49D//QdaWE/qohEdlG31vM/I=;
        b=KtL5G1OWtB3u2p0kLW3XykbO/a7RT4bP2rCjKnTya6YC8ds0CH4aKRvQSzzwu6hzIe
         K1TVFtJKfzMn7T+zKZrdb7mTjIG9HvTyDS2vT1pahCBP0ttB2m+jEIzgjqNAVJKmaUQq
         fxrRsEa++o0CVb3zJMOLT8pxsMFXIvpCG9Dm/UCathZmaUZ16N/saqcKj4uk6H6quexc
         IMibDZvvcCA1NFHRwhT/GUuEkeP7CgHt5cf52cwi+PhpLjqNJfg+6WevxRwmLbUjiNgX
         TPxDV0jATGm7DfUOWnYO6j/4nKfOjlzSQq35HVEwAXV8B6qxjldIf7GnIgsKne8CAfRq
         AepA==
X-Gm-Message-State: AOJu0YwFC14GbRiEp1ScIl+vKhDeuQFvYngn7ZlBsiEVkhZGt9tr1Gtv
	oi0tPc1tNqN+CiXxnyrCIBvQ4pGXkLGqRxw1yUsCKhgu8ylar9wrzJ3fHJtlwLvTMhBkGKTm00A
	zF2j2eWz9cisR3nuYYXy95pnem2xI0asL+lVjTUrWoghkM+F+lSoD6SJrSA==
X-Gm-Gg: AeBDietdELgHgkI9WtrILJbUYyft6ffNpY0rgO0Fe6v3eWkOmk3/OlO+44hYfAOa440
	MNoWH67N2xw2+KqYv8EO7J8TFK66SOtmYMPXjmQj3xf4vhp1a/+G4sdnbQEx73eHFvbGlsrOY6e
	2e10CnjU4sBndCxPXe5oDa5a18mOPFq/NFgGVid7GTtIadJpDp4DyE/ZS4X5yFx+vowcjeko55u
	tOWQvUN5IGTVKTCtF2qzvINh0oDK2HO0jlaleWozE5MHSpkBx7qCgoYVRq/V0I1TbIQ20vT6ApX
	pxBHUEhWpy9sAkz87Io=
X-Received: by 2002:a05:6808:1483:b0:47b:c013:1524 with SMTP id
 5614622812f47-48044f3cc97mr1245538b6e.2.1778083686420; Wed, 06 May 2026
 09:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64e053e4-24aa-434d-9b35-794d3b292628@kernel.dk>
 <CADUfDZq11PnyH5Vh8VjUzsV9Mxq6=0poGw--umMxccfwXiz54g@mail.gmail.com> <be3d5412-ec7c-4abf-b890-22c0b7295cc3@kernel.dk>
In-Reply-To: <be3d5412-ec7c-4abf-b890-22c0b7295cc3@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 6 May 2026 09:07:54 -0700
X-Gm-Features: AVHnY4I4Cvbz_xKAKumaQRDhlvXZTwlDRhiJ-cP1v1eILEKhAKJVlJXQ4OyAqN4
Message-ID: <CADUfDZoBeHme=7MrSxm1dtGu7f-HY6EFDVcZZQRhaSdFAukTmQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: only read from sqe on initial invocation of blkdev_uring_cmd()
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 3:43=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/5/26 9:32 AM, Caleb Sander Mateos wrote:
> > On Tue, May 5, 2026 at 12:38?AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> This passthrough helper currently only supports discards. Part of that
> >> command is the start and length, which is read from the SQE. It does
> >> so on every invocation, where it really should just make it stable
> >> on the first invocation. This avoids needing to copy the SQE upfront,
> >> as we only really need those two 8b values stored in our per-req
> >> payload.
> >
> > Maybe I'm missing something, but how does this avoid the SQE copy?
> > Won't io_uring_cmd_sqe_copy() still copy the SQE if the command issue
> > is delayed by links/drain/forced async or if the initial issue returns
> > EAGAIN? The code change looks fine to me, but I'm not sure I
> > understand the motivation.
>
> Because the alternative would be to copy it upfront and then using ->sqe
> would always be fine. But we can just ensure start/len are stable. The
> patch is about the latter, not adding any further copy avoidance. Yes if
> you use async or it's a link or drained, prep will always copy it.
> That's fine.

I see what you mean now, makes sense. As for making start/len stable
in the first place, is this just hardening? Currently, it doesn't look
like calling blkdev_cmd_discard() again with different start/len
values after it returned EAGAIN would cause any issues.

Best,
Caleb
