Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C1287272
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033732; cv=none; b=W5LoT++9M32F9GfR0xOB6YzvZgfvF6RzcXkW09MkpC9XmUAUgPTVeT+F92JBjUm15FhNHmiD54F7B0Hiy7QYj88QZykxYHsvDjSG02tF6HJTY77Sbo4oFAixw0lz+vXhD6Tkl/s9csZd0oxsBpCrn/RsGJvXksl7dKzOOXcLqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033732; c=relaxed/simple;
	bh=i+m3PusaxM6Zgin3C3En/lGk4W/S63Hvd6XwDnbd7Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V14rBKsZ3z1EzT5BRBg48HX1QkWEMNdOrVbm7jN4nEev3qn+ZjNzXN9td70SQRfeEQdVADdoA3Nd4RBF0ObhEFEbnYJSI5eZeZU9NAh9hsovGX8SLXtUh0mZedP08rxxTvfeFwePHBjCqpZcLwaFs1h1n5um/4oFkWd96ivKlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DRrWZumJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DRrWZumJ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c4b3a6f71so382338a12.2
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1761033729; x=1761638529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0VWPqCHv6+ZQuDCTFQQ2tUl50NtMLOJ2aVBSBufBxc=;
        b=DRrWZumJLWlQQYVAwwdZ9UjK/OX3tFtqQIygVaobmULxIhz8TsmMGwWjugbCyJG/TT
         n1DisF41E2n7SCCu5Ow4O85jzTnWfSXt8lKZihDJo8KVtRsMVaD2hKDmMuIhBsbaYTxE
         rEO04c4IOVa60P52jb5mBgRIvD3zpJn6BePYm34wJNSrHC9n/jM5CtHEih+v5cF8Vk0w
         UMgg7XcMxykPPAcbgYAfFVy+kn5kUR0tXv5Bmys+Bw4+gt9Os5YLpsLf+6i0/GutnOxM
         1gvVIP5sj2M1i3gRJOmmgiQ6dgBYKdI4BRFe3e5P8g8lEyZF2VfN2cR1LesjLs8Dd/vy
         MW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033729; x=1761638529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0VWPqCHv6+ZQuDCTFQQ2tUl50NtMLOJ2aVBSBufBxc=;
        b=hEU+CARJ6Aja70b3OFoEBRmftBaSyglByoKFTReFtOckYRVpmb6WV1x1im6jeF4qd9
         2+uAuOpf3Bcc+YZHTXqiWA341PrJfLQ+tno7FC2v1CPaQRJcuK5RcvCVqmbEe8atfHcK
         HhBxFIzq22/4lb2o008SY/T3umv/h9gDz8ELBSEqueEE59KTaE1QXvSHGJqzQvumsbMM
         7zetOe5+pcfkwATzKQGzwbw+cCnNuE7SgXROZeXlitJGM36hxZbgBqbYY3zX9BieNkjH
         yF1l4U2as22xj8gpNk6atkMh4Y2ywoGmhGIp05IfKutnMwjTblKawtW0G3n71GgC7UbI
         RojA==
X-Forwarded-Encrypted: i=1; AJvYcCUKTfH1+ehp5t6oyL4ByaV1vwhUBEyOtUwtip+D+Id/gOX4ZTagLZeU8wIbYU29mwBT9DWK60XVE0fuHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcB12XXNA8W/z34tgY6BPCJbcscrn24jcyGY+ZdyhYoPqs425W
	A0Rc7F6eukIfEIIhgCL3MGU8V593CFd+xkTVyMKte9eie3p8NifZAQZrg6ekLP8W0oJ0ASuBwTP
	CwWn2Z4JZJ3NSguFHeElPCSGgYGjqIwzZ/hpK+ouicQ==
X-Gm-Gg: ASbGncvnU0e3aujCxdw8A5nFuWYXNMaCXW26WYN+OlqBkqRuSqAZyHVBexn0aj0MdOj
	IsFb9IgBlfSGosqS2Y37rvxsCX0LuV49K83k8zuJVwuhnt2h6h1fLxFCFVP59X4h8JtGhEFy9Ta
	UW9dRPqB/tPEJ6SgppcUeqpbirqCcQyxYNxBe97NyOrtPRQ8fDfcTD/6PfQ6AyEhrhyuYxbb5K2
	mwL7w9trH73fAmIR4iCfQaGe37anYUy5bhgOS8JhCCrxloJNIBCvNCyud8W
X-Google-Smtp-Source: AGHT+IEQfgvHZuihlbBSJlVb+dcEnjFV14dIS2e3QeU28hCgVySmEX3k7+tkYGmNfEgLKxBR2Hkp3zdbZ2HHX0oRDVA=
X-Received: by 2002:a05:6402:2115:b0:638:e8af:35c7 with SMTP id
 4fb4d7f45d1cf-63d16af7935mr1354397a12.2.1761033728661; Tue, 21 Oct 2025
 01:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-rnbd_fix-v1-1-71559ee26e2b@gmail.com>
In-Reply-To: <20251021-rnbd_fix-v1-1-71559ee26e2b@gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 21 Oct 2025 10:01:57 +0200
X-Gm-Features: AS18NWAjr1vMpIROYlrNqm-3ej7s5Tkh074kVV9erysvDSTuNEiz5Pc19hwQJzo
Message-ID: <CAMGffEmsJjeqW8DGnKapVyM0Gporn_UuDB2xNosRmD2GduGgzg@mail.gmail.com>
Subject: Re: [PATCH] drivers: block: rnbd: Handle generic ERR_PTR returns
 safely in find_and_get_or_create_sess()
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:21=E2=80=AFAM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> Fix the issue detected by the smatch tool.
> drivers/block/rnbd/rnbd-clt.c:1241 find_and_get_or_create_sess()
> error: 'sess' dereferencing possible ERR_PTR()
>
> find_and_get_or_create_sess() only checks for ERR_PTR(-ENOMEM) after
> calling find_or_create_sess(). In other encoded failures, the code
> may dereference the error pointer when accessing sess->nr_poll_queues,
> resulting ina kernel oops.
>
> By preserving the existing -ENOMEM behaviour and log unexpected
> errors to assist in debugging. This change eliminates a potential
> invalid pointer dereference without altering the function's logic
> or intenet.
>
> Tested by compiling using smatch tool.
Thx for the patch.
But I read the code again, find_or_create_sess -> alloc_sess, which
only return ERR_PTR(-ENOMEM) or a valid pointer.
I think this is just a false positive.
>
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index f1409e54010a..57ca694210b9 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1236,9 +1236,14 @@ find_and_get_or_create_sess(const char *sessname,
>         struct rtrs_clt_ops rtrs_ops;
>
>         sess =3D find_or_create_sess(sessname, &first);
> -       if (sess =3D=3D ERR_PTR(-ENOMEM)) {
> -               return ERR_PTR(-ENOMEM);
> -       } else if ((nr_poll_queues && !first) ||  (!nr_poll_queues && ses=
s->nr_poll_queues)) {
> +       if (IS_ERR(sess)) {
> +               err =3D PTR_ERR(sess);
> +               if (err !=3D -ENOMEM)
> +                       pr_warn("rndb: find_or_create_sess(%s) failed wit=
h %d\n",
> +                               sessname, err);
> +               return ERR_PTR(err);
> +       }
> +       if ((nr_poll_queues && !first) ||  (!nr_poll_queues && sess->nr_p=
oll_queues)) {
>                 /*
>                  * A device MUST have its own session to use the polling-=
mode.
>                  * It must fail to map new device with the same session.
>
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251021-rnbd_fix-9b478fb52403
>
> Best regards,
> --
> Ranganath V N <vnranganath.20@gmail.com>
>
