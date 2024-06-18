Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D26BFAA;
	Tue, 18 Jun 2024 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696525; cv=none; b=C4HsVWdsN766uN2oo7mbSQR5g3quWGRKDr6WXGdHeGpjL3IbgSStDKSTcjVK1dVMONZ5qUPIORLq08XkypNWZtu4wjpCU9TV36WEizTMxgvovmkgEUN47YOtAcdpKP0My/SgbRlfL0VyG3IC6fOaZxcePziBN+o8r0nSPXygS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696525; c=relaxed/simple;
	bh=En/qOun4pGlvRDOsaRvXRfj2nWr1itzK8qNGWTXDOAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfRYRTxzIzJewWv8h0K15l2siXpLJQzMQ/ZItkzfSIZJxcKe1mQsdrY2Z1XnPYVSOgyqVWnVsshWQYRG6kF1QqOQqSmv5DgyilXqDsjs7xsCoTu2Rsq6BvTqH567p9Gwz4cIBxMqC50IixJ2YSAX5tDeNSHniJWIpYRYmfg3oeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-632843cff4fso35891887b3.3;
        Tue, 18 Jun 2024 00:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696522; x=1719301322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT4qm+dhp71oqgQ38TIEnnfM7fZp1cv6y1BPi5+98xk=;
        b=qxpxWPk5RdbcgWYAtZiWp6NeVQ0R2PslvKQ3hNJ10c8GFNYRisEYDniFXouCOGMS8+
         ESy5K63ax5teOMqmOHACzeOmyH8f2xYWxDnQilhGQG1BERReQUnDa4ssieKpkOff3AUL
         unKqyO/2z9VzRmsl0f1F1g2K9OtVl6VYYtOsgp7QejWRFRsIOH1IKqiJ3kOKprXCvxvG
         B8I0UtNtRM6+znzwCTjDEf6bE0buj7gWS3c5wdnndmeXltDdfynPWt6ENwgh/p6l85Fg
         8S/2++8GOTs7DJZ7MIt+i48QvvTHT5bnC6RIyBTgJl9GAkzr8Yp67zOVR5Og3hbEcsQe
         IGZw==
X-Forwarded-Encrypted: i=1; AJvYcCUmp8Dhb82QPXSSEKE/DI0AtqUUDv73l8KIYUotjknGY+jb6ElwqvIewup0yrvt4FLupON8km7kDUUPj14oIfZMjtEYQSbMkVJLUD5ptO7RXP1CtVAAKPzwXwU64FrS/2VlN3WT1fneh4XYVxS4k6zzdhjiajDq3O4R/rFzBqK9ZmWnpAUf7+Ov3m8=
X-Gm-Message-State: AOJu0YwE6LzSGPr2IHpo/VFqukLmTGKvVlqAxLBnyOFkZZqrw5R/wSlJ
	H1Qq86xnL5HUb3c7ZfYk/JRaQk0bmyXhrU6u1E2YMgASI0yO9COoj2nxVEnz
X-Google-Smtp-Source: AGHT+IH9SziESX0KaWPEB7Po5jgO5iF8Mc+COnhI1J1Y+RCEf0q3+JvjD/3qp4TC/DnwsBnaCGvVRg==
X-Received: by 2002:a0d:e746:0:b0:627:e1cd:5c53 with SMTP id 00721157ae682-6322206f571mr112631647b3.4.1718696521543;
        Tue, 18 Jun 2024 00:42:01 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-631183d7ac3sm16970167b3.6.2024.06.18.00.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:42:01 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a0849f8e5so51688057b3.2;
        Tue, 18 Jun 2024 00:42:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsABPBUsQWnnN0X6SqLzUbe6BMK1ZcEtCWHUd216kv1Q7jSEowQOSeE/EPWy6YgHFrinWT8higBgFtlVdFs7fyiZ5dxF+qmi1n5C5XdEQzy9HQDgrmFFdouwxTteIMF7AhvCDj4peox4b//GIbi3dTJWzUsan7ypi54VENT7afzl2vuhL9tMxgO/k=
X-Received: by 2002:a0d:d792:0:b0:62c:f222:8bc0 with SMTP id
 00721157ae682-63221e861b1mr118081787b3.7.1718696520861; Tue, 18 Jun 2024
 00:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-md-m68k-drivers-block-v1-0-b200599a315e@quicinc.com> <20240617-md-m68k-drivers-block-v1-3-b200599a315e@quicinc.com>
In-Reply-To: <20240617-md-m68k-drivers-block-v1-3-b200599a315e@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jun 2024 09:41:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVSxpe_xVYFFo6+s0SWmNBux3F4S8Md4b3dJ1f8FdDUWg@mail.gmail.com>
Message-ID: <CAMuHMdVSxpe_xVYFFo6+s0SWmNBux3F4S8Md4b3dJ1f8FdDUWg@mail.gmail.com>
Subject: Re: [PATCH 3/3] z2ram: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:15=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
> With ARCH=3Dm68k, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/z2ram.o
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
