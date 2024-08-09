Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591818C93F
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210732; cv=none; b=L7P7Yo0DD4LqQBTy2h8E7A818KJZvLYJ7XZVPuDFULWxSvoZ3st6LUPNzHZbOEHTyHCBDdydI2N8WxKcfwnaPBdYh/ZU8bPlWGH8AqKqW+dPSE3Ps+/jaCRqxCRQaNl7Y+MRT/AkW5vtQMq8L4THpJGJbbsHEF+9fnGfb/TK3wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210732; c=relaxed/simple;
	bh=U9PgHMmXwArkaS49p8aX1dEbXHZP/CRcN0LvOlL7M5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4r5+OaDjWRLPRVCVx+X4aL9D0iiSvjEip4R6yAKl7IRZcCHTWMeSpgKRzJ2ZW61ZT1+dpBf9xaA4u232Miz/Ba+x/OnGP6bSRG6V70i2EvDCvkzknS0p6NZrl/TOs7ptlqURULvF/nGwzo5VVrWdtSKYIkPM4M+sQPGy4b+YXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3ew+NPR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3ew+NPR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso18041915e9.0
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2024 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723210729; x=1723815529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+NGAfmPnXsWwgUAptnJ+cd0Pt188Yd+YvqSzH2iizw=;
        b=D3ew+NPRUjJG7Xvl1GaRZYqEYe1sm7k6CyHsqKMyzebfFha+gvyPm0PSFUx4Rk5j7A
         m//CgC/GRFGESBz1zWNxVt9MPepsJSW72NljtWbjwyjW7a0W5q3w5HEbvG/XHsBq7RCG
         mMID2K35NBJmjIyRZu1Q3OflyDoihE3jaY/dDIzvSDkNrWZL8PDMjL9ZalJp2QV3b4XJ
         GETyyvPDcI61PSAoO8lsKJeSJELXidMmxHbKUm7inVbjJR0VGOoERWBe3ljcmy6lAngl
         WZqMzdcLwcRmnsb+tuK2ml+GR9XlAo/PZVD/HkYeAmE4w241JnLe5TFOznj2QGyE65nF
         9q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723210729; x=1723815529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+NGAfmPnXsWwgUAptnJ+cd0Pt188Yd+YvqSzH2iizw=;
        b=M+qXLQ7kTZ6HnHENrw0sCcpQ4v4dwD0WNpSvCw7Mu/PJQwFZsX6kEhhYsrKkrjs1aN
         NhdMpC4HvIZ5ccKWxqtan3kN0ucNea7xHeX63Jvpb2jYdOHsWhaXKEmZmo/fUUA7UZmV
         KdqU9/d0zLf8gu44uNYGlxZW+HonURk2HZv5BMpcG26eB3ZUeIXSjqs/AGw0Zy4BI+dc
         Bkmvjclcl/Zaq/arX+xLLhWPAV1gcrM4Dd4pOrITMI5bAXCekC2vrcSd2HuMGNJRgL4e
         rIJzbV8ZI/qzqL2TJRug87q+Bsxf6bCjRp6KYuA7mS/9B/MRXC/lcSh56QLe7w4+AN0z
         trfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbxzSCv9XKKKSJe0NnMQ6LjtPrDjZDmaXjcoGXzuWnsJmTVUm0fQMUQqBezffmUQHw9iLPr1ae/0+f0j51crH2P+7dbJR6RDqdlsI=
X-Gm-Message-State: AOJu0YwKeNfui8/UAWj0TdjdqhVKRjXtz+Do+fYoC5nxpbOoPCN/KLQS
	H4me8uVI3TS8mEDsm9FCqIHlVwH9hZisQpOdEBZiCsu/hx8TOo/Dkj/RSyU93nm/uLoSEswZaTB
	YbfC+QGogz0cW/plwf5B0CzkG7XqZ0K+dREiy
X-Google-Smtp-Source: AGHT+IGLCN0hdBaFSgURlEBmYzXSiLipHSTPGxPeeVAfZBF3FCClOKXB0C2KWuYJCS7FyPZ+RAPHoq/m3t48/wKHerI=
X-Received: by 2002:adf:f208:0:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-36d6a75842cmr1629625f8f.30.1723210728768; Fri, 09 Aug 2024
 06:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809064222.3527881-1-aliceryhl@google.com> <CANiq72nP+pL7fEvaB7HA-mHJFs1j9SKMoSMSCif61YCy4QDFoA@mail.gmail.com>
In-Reply-To: <CANiq72nP+pL7fEvaB7HA-mHJFs1j9SKMoSMSCif61YCy4QDFoA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Aug 2024 15:38:37 +0200
Message-ID: <CAH5fLghQ9dRqGdvRxGfiby9-xG4kY3QN8adyH2gVA5urZXpq=Q@mail.gmail.com>
Subject: Re: [PATCH] rust: sort includes in bindings_helper.h
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 2:58=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Aug 9, 2024 at 8:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > Dash has ascii value 45 and underscore has ascii value 95, so to
> > correctly sort the includes, the underscore should be last.
> >
> > Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module=
")
>
> Looks good to me (`LC_ALL=3DC`), thanks!
>
> I can take it; otherwise:
>
>     Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> I am not sure if this should count as a bug/fix (there is an
> recent/ongoing debate about the Fixes tag).

I fix merge conflicts in this file almost daily, so I think there's a
case to be made for taking it as a fix. I should have clarified this
in my commit message. I sent a v2 with more info:
https://lore.kernel.org/r/20240809132835.274603-1-aliceryhl@google.com

> (This kind of issues can be also opened as "good first issues", by the
> way, i.e. as a way to get contributors to set their email workflow.)

I didn't think of that, but if I had I would probably still have
submitted it myself for the above reason.

Alice
