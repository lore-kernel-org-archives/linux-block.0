Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="C4KxAwoG"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8196B19B4
	for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 01:50:41 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c51682fddeso28398131fa.1
        for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 01:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700819440; x=1701424240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oycrzPlryteHqP+ElQj2mM/HX5+6hH0VS5w+GwDvoHw=;
        b=C4KxAwoG3EYLB1F2yilsrJ4N+VYJ5GlCX7rhV/YWQwFOZikN3lrSrQZ0WvzOdN+DCg
         zzrSlUy63IRiMoRR0iMJOkGbbVraf3HlpkRcQ/zgKDTwbjmfPte4QJlt5xFuA+cTMQmQ
         r2P0K4EOqZFAnhispTYWl7dOYzcEBRP3105YTmc1ocJHF5lCuqL4I0f9a3wUUbdnmTJi
         9HDX/GAneZPTMVo7mdw/SProKn/rKnFmYa0GdFbn/rFRcbUoBaKA7hQCh41jv6YYnVeT
         uxHwfJcwnHAfFemstjkt+TJfu17Pbb+tEiFqnpFagnsr7AtyNTc+sLiaZJPeoPUUTtqS
         sm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819440; x=1701424240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oycrzPlryteHqP+ElQj2mM/HX5+6hH0VS5w+GwDvoHw=;
        b=Cjed93qjZ2i0AHqRYyoMeWIubYB6PrIKm4C5E56RxkHBhDFQGqnpP40cTjBbFwcXzV
         72HkI2uNuxCASJ+q3DzxlVsAnFeDddss8bl/iARZBliGyaVclozmtffNq6vi/HZNI0L2
         yJgn8V6o2FFBnlWd+6kyy01tCo4rTQ8k+83EXl9yxPmrfYxRT5kNmsrc+GgsM6YiOzjX
         mx4HnH1KAh8a61/NMML/33BNn0fLeQEX9SS9X8nz28lNmw4yWcFv6TLstDucU9fbRIjV
         yYI/6xzavnuGFwhJCofzAiDlY3RT6Sh/NnuwH6uw4d3l2MGTTgunlW8vdh0p5qSQ/RjO
         uHwA==
X-Gm-Message-State: AOJu0YxdI+JdYiV2+DuIly9BcrWB6j+VcQ1n+xSZPhaF5zpYXFi2N0QO
	r2SAV/74bLnIyXSezmd5LtnGzsB6oDzGGhEq4/Q9Bw==
X-Google-Smtp-Source: AGHT+IHnDI55prnztH3exNR9D+eAXjhSPFI3q8QWqk6B5r/7NhN6I9QZpIqm4kdl3M2bfWkpTRdtuV9JCAHOIeibMAE=
X-Received: by 2002:a05:651c:3cf:b0:2c8:80bf:977b with SMTP id
 f15-20020a05651c03cf00b002c880bf977bmr1984441ljp.24.1700819439512; Fri, 24
 Nov 2023 01:50:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115163749.715614-1-haris.iqbal@ionos.com>
 <CAJpMwyh-24qFt4U1L2Ki270oWis-GUBLRQVC+Lf4cG7EumkpPw@mail.gmail.com>
 <a27b66a6-7d3b-42f4-b25f-1dffc0d33a83@kernel.dk> <ecc3f0f6-4d9a-47d1-8fdc-e517a8c7bf14@kernel.dk>
In-Reply-To: <ecc3f0f6-4d9a-47d1-8fdc-e517a8c7bf14@kernel.dk>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Fri, 24 Nov 2023 10:50:28 +0100
Message-ID: <CAJpMwyjskJDaswJpLtEa+8KHA9qrW0B6BQKSLYwP4gZYa_X_5w@mail.gmail.com>
Subject: Re: [PATCH for-next 0/2] Misc patches for RNBD
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, hch@infradead.org, sagi@grimberg.me, 
	bvanassche@acm.org, jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 9:48=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/23/23 1:47 PM, Jens Axboe wrote:
> > On 11/22/23 7:52 AM, Haris Iqbal wrote:
> >> On Wed, Nov 15, 2023 at 5:37?PM Md Haris Iqbal <haris.iqbal@ionos.com>=
 wrote:
> >>>
> >>> Hi Jens,
> >>>
> >>> Please consider to include following changes to the next merge window=
.
> >>>
> >>> Santosh Pradhan (1):
> >>>   block/rnbd: add support for REQ_OP_WRITE_ZEROES
> >>>
> >>> Supriti Singh (1):
> >>>   block/rnbd: use %pe to print errors
> >>>
> >>>  drivers/block/rnbd/rnbd-clt.c   | 13 ++++++++-----
> >>>  drivers/block/rnbd/rnbd-proto.h | 14 ++++++++++----
> >>>  drivers/block/rnbd/rnbd-srv.c   | 25 +++++++++++++------------
> >>>  3 files changed, 31 insertions(+), 21 deletions(-)
> >>>
> >>> --
> >>> 2.25.1
> >>
> >> Gentle ping.
> >
> > I'll queue them up now, but won't get pushed out post -rc3 to avoid too
> > many conflicts on the block side.
>
> Well maybe resend them first, patch 2 doesn't even apply to the current
> branch.

Sure.. Will resend. Thanks

>
> --
> Jens Axboe
>
>
