Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2213AD04;
	Tue, 18 Jun 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696484; cv=none; b=ZGiRo6brXPRuH+lE4sVxfpA2P9S6PUuQhujhngSyWuQCQkK+BoUZtAX/bhEjALiChaxm55fxZP+odjDfVwP78lM30yCi+uAvA4dMRKy7zwIb+n20okkvFovnGuu6oKG4+V7vOh2vIoZQWK3m/7T95TBjCZDW8BRXDens//Igec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696484; c=relaxed/simple;
	bh=QUyX7m4x1EJUeMRxMQZtH9yOwSDPCuwZz+EG+U7QqsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiT2jyHhasJCZgykBtQ52tX/gThYkgSPH2PXo9ipMsiJu4QX/bAKct7S5x/svaHi9Si8YNd4N34m/jxQrxKHYaYpB+sVHbdnQMPhTrXQET4lxX4jj3lY1OcBT9KEUb46QJ+owGbSx74pI4cZIwFnRXs6DHveRHRnrzQ2OnOJkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfef7b13c98so5464745276.0;
        Tue, 18 Jun 2024 00:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696482; x=1719301282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoMlu7MLsmT3dUH1EyHiBP5bZpobTchIxYqN6vNhfv0=;
        b=YaXpKdv0K70sD5pP/PGmJGeclnskIy+Xly7YY1lVEc0oa9SLExrRi+0dj1SIyW74c4
         5S/9oyhjqkNqh6AwTM9YubBriRA41vXnkqSJdLakVQjerWuN8QWYbU2m4zqQdF+83h6T
         qgjAUB3cwye+ncTK5TGAyGhsKe9N+o9HJn+lWLJprwjsg5+QDX+V/BA4uxelunWR+hb0
         qYo1aTzxkM5hW3uZVe1spnbf+fHOiwItL1go4ivmxxpcVCADYT/qc4n2BD37QZz4cNJD
         EYWF5nlC1TQkVLAV7Nchj6J13BbxeKKjbv/Iiotmeru/6SEBULdxis4Oqsj14o8O2cQP
         LMgw==
X-Forwarded-Encrypted: i=1; AJvYcCU950BiFxvx25HEPAcoo8qbo/KT9sO+jRYk27OhsxW0mpWaAzrapdyC/1SSh4N6ax/wLVnQ+GQrNWA7jGIUQw/PJA8oA96DKXZQs308MIn/Bmtl0TXpSgIBjrEyCbx2+SNiGmMgRRlwXIrV9e8ZKdyCgDX+SyExhcd8b250RUTdQDzQnFKz0A7gvmI=
X-Gm-Message-State: AOJu0YxRG9S1KqB4BVrZXOCGGJVjJp65B1xr3Ss7DOadAmuGAooY3jvj
	bBnCWFUgWEQKD+LySSnDaxee9LkBG18wvdny21p8xhWDtyetoC4uoG7nDUlc
X-Google-Smtp-Source: AGHT+IFnT7T+gAYhJvbH0lyttQveZfNN628U2Eogww/DjWSG5+0W18mKUzgBatJ7Ffqqpz6MTqNfYQ==
X-Received: by 2002:a25:aa94:0:b0:e02:b545:1bfd with SMTP id 3f1490d57ef6-e02b5453014mr518998276.18.1718696482092;
        Tue, 18 Jun 2024 00:41:22 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e029f77236asm139036276.59.2024.06.18.00.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:41:21 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a2424ed00so59402457b3.1;
        Tue, 18 Jun 2024 00:41:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHDulv0t63Iii2udNJ09xRJEBLWBjQrz+YTIK10vXskBmpoQVuT4bnmok2N8OymwsksZQmh2RfQB2kOlvaG+PAwWzBfa8NjerJHQT7iyS6/mdEQAFoMBKXAxuWyJtvlMCWdcwEpxb9XlfwUuwODfN2nUmbAqQRE/Vvz1Vv1kZrAVLmwCwz8PiDfFg=
X-Received: by 2002:a25:8284:0:b0:dfa:85e4:c8bc with SMTP id
 3f1490d57ef6-dff1534634emr11457833276.6.1718696481744; Tue, 18 Jun 2024
 00:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-md-m68k-drivers-block-v1-0-b200599a315e@quicinc.com> <20240617-md-m68k-drivers-block-v1-1-b200599a315e@quicinc.com>
In-Reply-To: <20240617-md-m68k-drivers-block-v1-1-b200599a315e@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jun 2024 09:41:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXn8F_4Fi7XiUFGhQhJ19NBrCn7a=ofUZ3vGWeeTJDrjg@mail.gmail.com>
Message-ID: <CAMuHMdXn8F_4Fi7XiUFGhQhJ19NBrCn7a=ofUZ3vGWeeTJDrjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] amiflop: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:14=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
> With ARCH=3Dm68k, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/amiflop.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
