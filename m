Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10573E9F96
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946853; cv=pass; b=QBd7aG0PyeAfjI7bmAv4M4vgdw8RbfYxwSuCtyVJwIFOtOKMn7ZGFltN0DAlDYDptITBiQPAQK/DRKjsyKQ2FqTDBuC3d7nVvG018zqADlBkAT13IpdWBTxGJUEmzAosEKZJZOAb1xi7aNeJqaxUvE0LaGlaHtNYIxOL+YjzNq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946853; c=relaxed/simple;
	bh=kuNCn6wOxoa1SQOTgaIh18ujsN9G9V2IoPBJSzgxPLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jv/VLYZhzGuAbC1r5vxZfjDKCeWG/gZ2RtbPV2p9QkDiS6fR46SnyKhDUDRX+KhnIB8dXfVmI4WSYLntEiUbGy/p/jeiMjo6hFvX8VX6Zp9TajivhnSX5qqq6956LwaDmDg4IZhqi6yK+xoMu9BwHukt5oIo8wdQRZma1b3lQeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht6npZ4D; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht6npZ4D"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64eb84d1e37so6411221d50.2
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 01:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774946851; cv=none;
        d=google.com; s=arc-20240605;
        b=RHf34Q2IU3jaAWahiCTVWMPyaIf4+bTCctKHN9weB+V5rQ7oD/hDgduNXW6EwwzJNR
         ymapzfEUE8eJ5qnmF6WzFIeESZv5GVSuoLDiYMQ6zcLDbX88mF8x2h+6VzhVm4ZYHq7n
         nIEsVLbGtmE/G18Z7iDmGqwWaM3zmJOMfwG/kaCsIcdMgJg0B7TB75Fce4CLUvwtW/nU
         qw0WJ1yOn9aT5OF97Sh2GRUEGr9llAfiVyhvAbSPUpTF/EUUZRtbV2s6oUETqx42ioP7
         sM0l7JVgmfe360A3QdOxbALN26/XBNLLYFEeNILL4+GAqqspAI216vdoS6+Uxhq7CIcr
         4OyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sOnUXSfoLr9p4W8JWwSlMQ/IRgYhKp2a6+ozlc4iWLA=;
        fh=TmmmctC9SqUPSW9kGDwXHtd2SkwnRbZxBQabsLDy5MA=;
        b=KSZQosgD04lXl/rRjMVt/C7yLibyyftbVeY2JBSS7nqWIxUosTlnpGl89ZhR0hTlvw
         BUqruz1Tb79VgWKm+lzjNUeVvhXCqo7unEEb/ehVbiXaVV7c2b3PFVCc3lkvf9f5WtDt
         uxveT9278eY/d9sbY5qD/nkvl+ok7W/nqSlLBNq49AMFInb8fN8HfSHLiGNXm6AqeRyV
         RiaaicC/ma8x/2fxc23Xlrk75GTivaTUqeYk2jKPYYK3XP+hHqxeVscRvjXKaig5Tsuv
         uG/v8512sKbBFutAXC07/Rzixjn9ujSurqvopqX1iXsBfJgkQyPpwlQuYR3aptz7FCRy
         Q+Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774946851; x=1775551651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOnUXSfoLr9p4W8JWwSlMQ/IRgYhKp2a6+ozlc4iWLA=;
        b=ht6npZ4DgwZJKiOi44gz46F35QF2fEthsLCzEUAUVAYpoLFPl+cq3NE4Ix4zoTd0OJ
         hT05y5NUuTQzv8Q/TDvphpo7b5lHT/DEsT8Vpsq8VeKWAJnmwa5x4relEaeno3uTYsGr
         dOEU7avYj37yh4Pr3O47asLSngiH+UB9SbFuRw3jfXDycXTYILc+GzDWhq5NsDaCoWX8
         zzbbKdTCFs07IWvyPB6coVICgOcMc0PeSRqxQCsM5WsiXYf2enyYQXnCB8EXwpQMrs+p
         Tw150HZKaez5lfZcFSQZlk0UHO2TG4Llt589wk3WasWmwhImhG59axyxH6tlWNQ18aXN
         v1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774946851; x=1775551651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sOnUXSfoLr9p4W8JWwSlMQ/IRgYhKp2a6+ozlc4iWLA=;
        b=IGydWV4gK1N549ASIxJCQNo7ZQx7yZ4djUfX/CRRBWhgv/VoSdivWgHubYWAD+ie9X
         xNH24Au8TArabT88BZv9RAAsIjX9KSdE6s05XOSFNLWk0/0hsfNiLb8oTg7A1M7rZrMy
         voMV4XAXbrSEST4d4Anb7XvsxE5VdblDpW9LN9G5I1Co+NpRq5FFU+55OU+YV3DThPqB
         ArTp+oRmpTc7HuwblBOeXRkIv9qhd6cpYR7xUJfFcjsaIURJGXvKsDINcMRMGIcat4uB
         X4YDa2LfXkW3vWxr/N6qBh1lGsM1diWqIOYuJZKUHkwf+ofdPKTD3Pv0WEWm6vSXMMdk
         LYXg==
X-Gm-Message-State: AOJu0Ywi+J74kfV0WimL8Hf85lD7jRlHOkiRhhkZZCVBEAgJy/coulEA
	edpesP7xXgMurqJ4UOF8nFseASoTyS9BqQxWdGT+94JbZnmte1DhurwwT5x83JUGJG5ioV4cpf3
	0093jvpMZjPRC/BoPGgBcMiNld/VUSFY=
X-Gm-Gg: ATEYQzyGbqrVJW6dDiE6Dkj8JJ17HB5rllB3JheSsHv3aKMRlryJRtCFjqdl40hXnNd
	KwaKK+EvO8DlzLfxO4glQyq+6iV3KJb3DMCxTM1wngYWS8TfUdOuJ2wnL0EPWIk+XBkay9D8EFK
	HXMuIBKUHW1PxLAE1jBURuZ4Hzp0Fowul8BhLywMD7WQb7ie0zVL3X0uc7KdPK8mJwiD/drYi+i
	UQdl0DcWh8P0x3psCOaiD1jJIEzKFZy9s2T9aUn8gdnvrqSTDhActWTO5QMegupUgsKCU9wLxHK
	V8PCdaaOO7vtfO+U2p/AkkARBq7XO/qSOdLPB3weNtMqVaIROBSGFozapg3k4vmf9ZAswtoZ
X-Received: by 2002:a05:690c:6e83:b0:798:704e:9d7e with SMTP id
 00721157ae682-79bde084586mr145117167b3.52.1774946850880; Tue, 31 Mar 2026
 01:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322051838.1137822-1-kartikey406@gmail.com>
In-Reply-To: <20260322051838.1137822-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 31 Mar 2026 14:17:19 +0530
X-Gm-Features: AQROBzBf8oZ8e-K8DIlKCcMfIXnkjsysbUo_OLg-fzEEorcrxoKDOF6fkk-JJHY
Message-ID: <CADhLXY5_TRgWvA3PwfpoPB=4RiZ3Ujqtcpu8LMDBcU9Rj=roVA@mail.gmail.com>
Subject: Re: [PATCH] blktrace: reject buf_size smaller than blk_io_trace
To: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, 
	syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 10:48=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> blk_trace_setup() accepts any non-zero buf_size.
> If buf_size < sizeof(struct blk_io_trace), relay_reserve()
> always returns NULL and all trace events are silently dropped.
>
> Reject such values early with -EINVAL.
>
> Reported-by: syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ded8bc247f231c1a48e21
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
>  kernel/trace/blktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8cd2520b4c99..6cc7d83ed1c2 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -773,7 +773,7 @@ int blk_trace_setup(struct request_queue *q, char *na=
me, dev_t dev,
>         if (ret)
>                 return -EFAULT;
>
> -       if (!buts.buf_size || !buts.buf_nr)
> +       if (buts.buf_size < sizeof(struct blk_io_trace) || !buts.buf_nr)
>                 return -EINVAL;
>
>         buts2 =3D (struct blk_user_trace_setup2) {
> --
> 2.43.0
>

Gentle ping on this patch . Let me know if anything else required

Thanks
