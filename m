Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3595C1922E6
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588914; cv=none; b=C5S1uGeZd1rPSnHj8unFw1dCPrhZ8R6A8G4MWnSV3A0l+Pu+xBKxT/pLbq33E4rtjMm6Gur2//K/Xp9/vdMMzjA6fFdUKVfeosFz/2zdTL7He17YiVrrlLZNDLNWs0c3s20RXWi6C65dJaoLOTgOKc+ffXpOZ7S6gOUkKE2tO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588914; c=relaxed/simple;
	bh=dTSPITE6kEPd/QuZwZhVdc4FwhjFN60qUC7K6wgLGyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ighfyO8Cueqk3YxPJEyOBF1Uta5KOE4vlllXad9jk50FMxQbpLKNAFQAtCTTxGBdjlYa0Yt40I/Lk5YPpyuqCyRMBto7gXg0XmGgUFBxsS4qxXSvwQuV293UwjejOnHxVCbwYsABfPEviDx6B1Q4bbz5Ej5hH518OzS6efvVOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcHjO4de; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcHjO4de"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717588912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMRqhaPyHN4csAzL/75DeO1tOaUHg/Zb9U9prwcVRgo=;
	b=VcHjO4de03I6tOBi/m+UShtyepNH9RiBEq13Fz+ANuljFEvA1HBUAnT1sZNwnN/D+uT52v
	PJN3VhpkyyCq7lRofCm8t0T2cetXzxPh0xbf1LOoWaaFwDZGGD0zVlSa9j6GIhwifBRgAG
	YtKwgOIoRD/fLK13qnhM74nJ7TCv8dk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Piu8FEirMo6hZ2dY8sp6GA-1; Wed, 05 Jun 2024 08:01:50 -0400
X-MC-Unique: Piu8FEirMo6hZ2dY8sp6GA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c1b53b0038so5951483a91.0
        for <linux-block@vger.kernel.org>; Wed, 05 Jun 2024 05:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717588909; x=1718193709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMRqhaPyHN4csAzL/75DeO1tOaUHg/Zb9U9prwcVRgo=;
        b=b/fH2sZ5e9uOQ9gjXadxygRzA3zYP1F1p9gdrbAlBylhZSfn5tJ420WgSubxlQcYRR
         HurCDun83kgEt4SUlxhtZzJqxRulK/9IWoow7uQQX9B9CPpOPLUr2YDrpFFpCENy7mNG
         7kyMglLrglyd3MfoIf3sYuZewGTZNDmTr+6gkHTPQpsLK6MqAL76+xHC/gwWbA9h7UUT
         3hjIgkFJxFh6aMk8AXW2Od5Y/1+JIY/AykNpse52mdH0n5o7105cYYHlTD2+hSgdcUJ+
         MKKl0q/a9pjNCSAdiQnpxrikORNAigMAUCW+XLrzK/bHyCMXX/4PV7RlYEU8bnIA1hLB
         xe8Q==
X-Gm-Message-State: AOJu0YxxgZny6VD7J0lFvoJvm7xhmMNeRvs0968jUC9hSqiaKyNLaNmH
	4AjcyHkq56KMaTplhWGQQps0oG54Su2QWNOKwdcGjVH1bMjH9IN3eib2bO+sR54OzIHQeKYYuAC
	fwRONSiwR79CbyWpMGbAeQyqaCTWYwvtXDmgGANKKGdDzVqp3IH1yLrjwCsQVqBW09joJhgsgwA
	w8u0o8W2k0rGDEPfCMEjLvW4o8nbA0lNehUS6Nj3XG5BBDTg==
X-Received: by 2002:a17:90a:cf03:b0:2c1:e9e4:c6ea with SMTP id 98e67ed59e1d1-2c27db591c5mr2504539a91.31.1717588909162;
        Wed, 05 Jun 2024 05:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIH2qwzGQVuwroF/qUNH2KgSqP3BJTvvThYcLQWE5+uHoaaPwXzoMeUqPlRiuJnkdscQvsFhDkeGqX6Fnxb8w=
X-Received: by 2002:a17:90a:cf03:b0:2c1:e9e4:c6ea with SMTP id
 98e67ed59e1d1-2c27db591c5mr2504510a91.31.1717588908754; Wed, 05 Jun 2024
 05:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605010542.216971-1-yi.zhang@redhat.com> <a4djmoku2cxfxhxrhgdu6b7vqyi4idqdzza7fx37ps2hdyorld@ababkd4e4zzd>
In-Reply-To: <a4djmoku2cxfxhxrhgdu6b7vqyi4idqdzza7fx37ps2hdyorld@ababkd4e4zzd>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 5 Jun 2024 20:01:36 +0800
Message-ID: <CAHj4cs_QHjtLjsmZs2myDQYzzFfMeTQTCEoXY_huiPzUD7BoQw@mail.gmail.com>
Subject: Re: [PATCH V2 blktests] block: add regression test for null-blk
 concurrently power/submit_queues test
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:52=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Jun 04, 2024 / 21:05, Yi Zhang wrote:
> > null-blk currently power/submit_queues operations which will lead kerne=
l
> > null-ptr-dereference[1], add one regression test for it and the fix has
> > been merged to v6.10-rc1 by [2].
> > [1]
> > https://lore.kernel.org/linux-block/CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+x=
T7AP7TPnEjStuwZA@mail.gmail.com/
> > https://lore.kernel.org/linux-block/20240523153934.1937851-1-yukuai1@hu=
aweicloud.com/
> > [2]
> > commit a2db328b0839 ("null_blk: fix null-ptr-dereference while configur=
ing 'power' and 'submit_queues'")
>
> Thank you Yi. I ran the test case and it looks working good. It passes wi=
th
> the kernel v6.10-rc2. It causes the hang with the kernel v6.9. To not con=
fuse
> blktests users with the hang, I will wait for the commit a2db328b0839 to =
land on
> the stable kernels before I apply this patch.
>
> One more thing I noticed is that your current patch requires loadable nul=
l_blk.
> To allow it run with built-in null_blk, I would like to suggest additiona=
l
> change below on top of your patch. It,
>
> - calls _have_null_blk instead of _have_module null_blk,
> - checks submit_queues parameter with _have_null_blk_feature instead of
>   _have_module_param,
> - does not call _init_null_blk, and
> - uses nullb1 instead for nullb0.
>
> Please let me know your thought about these changes. If you are ok with t=
hem, I
> can fold them in the commit.

Sure, I'm OK with the change, thanks. :)

>
> diff --git a/tests/block/038 b/tests/block/038
> index fe3c7cd..56272be 100755
> --- a/tests/block/038
> +++ b/tests/block/038
> @@ -12,9 +12,10 @@ DESCRIPTION=3D"Test null-blk concurrent power/submit_q=
ueues operations"
>  QUICK=3D1
>
>  requires() {
> -       _have_module null_blk
> -       _have_module_param null_blk nr_devices
> -       _have_module_param null_blk submit_queues
> +       _have_null_blk
> +       if ! _have_null_blk_feature submit_queues; then
> +               SKIP_REASONS+=3D("null_blk does not support submit_queues=
")
> +       fi
>  }
>
>  null_blk_power_loop() {
> @@ -36,23 +37,15 @@ null_blk_submit_queues_loop() {
>  test() {
>         echo "Running ${TEST_NAME}"
>
> -       local nullb_params=3D(
> -               nr_devices=3D0
> -       )
> -       if ! _init_null_blk "${nullb_params[@]}"; then
> -               echo "Loading null_blk failed"
> -               return 1
> -       fi
> -
> -       if ! _configure_null_blk nullb0; then
> -               echo "Configuring null_blk nullb0 failed"
> +       if ! _configure_null_blk nullb1; then
> +               echo "Configuring null_blk nullb1 failed"
>                 return 1
>         fi
>
>         # fire off two null-blk power/submit_queues concurrently and wait
>         # for them to complete...
> -       null_blk_power_loop nullb0 &
> -       null_blk_submit_queues_loop nullb0 &
> +       null_blk_power_loop nullb1 &
> +       null_blk_submit_queues_loop nullb1 &
>         wait
>
>         _exit_null_blk
>


--=20
Best Regards,
  Yi Zhang

