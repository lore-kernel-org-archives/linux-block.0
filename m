Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8BF17920E
	for <linux-block@vger.kernel.org>; Wed, 18 Sep 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653438; cv=none; b=Bui+9/2o0mW1v7st/mocLnlVH9eE2I5f+Pr2250N5DJ7Z6jndOj56vG8LdnYoJO84m+kGU6GA9fVIBOezDwvdy5F4c4onq3h//BGhIp7jdTkHGCvqNrPjKraX8Iw77FL4zIRd49pmWsjO1TCgM0GcYkWUtX0KI+rQCqfLtq0Ndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653438; c=relaxed/simple;
	bh=aEqJqQ0vfTH55PbtK6DICNgoEj/MVMbz7QyQlBQBPKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ4xfuNsF6GFbDNTdiUIL6agY4SxbH7APyOYxFoKNe9q69gdHo0cOXAKKAJHTv6WAY2aQ9hIgpW0Uk57olO0BpDB7SKKFu9rxLPS/2LeeapnevRC/iGDlR5JxY0fQCdUecUzFcJbCCH/UxtpPQ9d4WChy4BlMGepsSrkI03h2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=pWjsrlsV; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="pWjsrlsV"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1ce8a675f7so5698111276.3
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2024 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1726653434; x=1727258234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIx4pdRT/KSGss++ze3hxTvzw9zHVXZXZfsOwRj2D3Y=;
        b=pWjsrlsVcXWVVoMWDu4OlsK82ij14Xjz6KR6kLzYE6CLGE480rv+DvQd6Iqf7L29KC
         28gjeaPgHSSXn6WPpuH7ZDuYCZkbK1dUkTe6e8CgR3OmrtwBILqRPdfHOnckchevvyOc
         p+s/3nx5B2QTIowzNX4OuUX0S/D4KVt3jU/3LFJ8wJs0BeANr65l8EsmqKHRgf4xWSw7
         WbnoYQZoDcVlcsaWl9tkyBcoZUFcI8O2l434GqknSfKHUg2Cj8MFjiTALahIQt4VMAJO
         3/bigMpUNakJVJFU2arqJ28ZHCb8oy68gPcBlF/uvzFGenAoeQJtJtXKGVaORVQ95fqH
         57cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726653434; x=1727258234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIx4pdRT/KSGss++ze3hxTvzw9zHVXZXZfsOwRj2D3Y=;
        b=fa8we1IAfeQn3rIZeTGz6gY4eGrE24Mdp3YdQL+gMpMGTSvVgarUbCjr4Uzbgrc7qP
         bfyV5cK702eXmWl5PJyJYmLkFGfIh7MysnbBawA0BbuNa5ngr19QJNeTN2pZ3rmMDoBK
         cO+6J4yNbi4i8dXYLA+PMk8+jQ4lf3zllM7XqTOohYj8eEXkFcbkAIXAam3NwhTS8p5w
         /frQQD6ymJ4DruwYvx5yAL/DDi+gKZjYBVdPRv3VaQrYFwRxTIGnjRA8xog/7ax+kE/Z
         a0LvzMeVlrjHSV66zv426dA1Wh0OoneKpMl8FywZd0Jzom8Xeva6MyjDtW7GISn82Afn
         JoDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQkQbLhDzyYwm+lrXaZ8bGSGtXGu126fRuHEVji/0V9Rdl1AqErx1cvxv/arq11+S7n5ukWtGHbGixOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7RI3KQU9HeFDYO0In6nGPVDhE+Fkb4UfDm4KNTSdSfDsS5qNV
	wKNuaHirGZAmH1gtUIypkkc/2yv2R8p7AF+Fdd4AzZbF4/8lhYYENK38VZFc4gCO9gU14VMnHmb
	ZT0l/Qr586FiWB0aOU92fltycES8Gh7SMn/UttA==
X-Google-Smtp-Source: AGHT+IHKpu7IV4bd4CPt8Iw9ri5vOZYDoXO50FkG8TLq2+PTVeUoLayDJEH63zGUtyeaY5AvRD4j8/cMEDxNpzcidho=
X-Received: by 2002:a05:6902:200c:b0:e0e:cd17:610a with SMTP id
 3f1490d57ef6-e1d9db98c4fmr19075343276.6.1726653434435; Wed, 18 Sep 2024
 02:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913083504.10549-1-chenqiuji666@gmail.com>
In-Reply-To: <20240913083504.10549-1-chenqiuji666@gmail.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed, 18 Sep 2024 11:57:03 +0200
Message-ID: <CADGDV=Vhx79JmTSzSJ+KN_236vKD0mZD6u3_23WRmte2wXW3fg@mail.gmail.com>
Subject: Re: [PATCH] drbd: Fix atomicity violation in drbd_uuid_set_bm()
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com, 
	axboe@kernel.dk, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Qiu-ji Chen,

The code change looks okay to me.

Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>

On Fri, Sep 13, 2024 at 10:35=E2=80=AFAM Qiu-ji Chen <chenqiuji666@gmail.co=
m> wrote:
>
> The violation of atomicity occurs when the drbd_uuid_set_bm function is
> executed simultaneously with modifying the value of
> device->ldev->md.uuid[UI_BITMAP]. Consider a scenario where, while
> device->ldev->md.uuid[UI_BITMAP] passes the validity check when its value
> is not zero, the value of device->ldev->md.uuid[UI_BITMAP] is written to
> zero. In this case, the check in drbd_uuid_set_bm might refer to the old
> value of device->ldev->md.uuid[UI_BITMAP] (before locking), which allows
> an invalid value to pass the validity check, resulting in inconsistency.
>
> To address this issue, it is recommended to include the data validity che=
ck
> within the locked section of the function. This modification ensures that
> the value of device->ldev->md.uuid[UI_BITMAP] does not change during the
> validation process, thereby maintaining its integrity.
>
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs to extract
> function pairs that can be concurrently executed, and then analyzes the
> instructions in the paired functions to identify possible concurrency bug=
s
> including data races and atomicity violations.
>
> Fixes: 9f2247bb9b75 ("drbd: Protect accesses to the uuid set with a spinl=
ock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> ---
>  drivers/block/drbd/drbd_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
> index a9e49b212341..abafc4edf9ed 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -3399,10 +3399,12 @@ void drbd_uuid_new_current(struct drbd_device *de=
vice) __must_hold(local)
>  void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(l=
ocal)
>  {
>         unsigned long flags;
> -       if (device->ldev->md.uuid[UI_BITMAP] =3D=3D 0 && val =3D=3D 0)
> +       spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
> +       if (device->ldev->md.uuid[UI_BITMAP] =3D=3D 0 && val =3D=3D 0) {
> +               spin_unlock_irqrestore(&device->ldev->md.uuid_lock, flags=
);
>                 return;
> +       }
>
> -       spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
>         if (val =3D=3D 0) {
>                 drbd_uuid_move_history(device);
>                 device->ldev->md.uuid[UI_HISTORY_START] =3D device->ldev-=
>md.uuid[UI_BITMAP];
> --
> 2.34.1
>
