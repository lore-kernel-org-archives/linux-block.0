Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46B522696
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168928; cv=pass; b=dJ543icoOySbxU/ajUrSedzlrzPSmyYrE1yaV21ZWfEqVmafTEZyZbGMqnYpEfyoau9oznrlAIG8gNid5a9s1HcCtnZuU01KqMqyGy7fnlrtwgcxUvDIP8t7Hi4MqyRc/gnNibzxgE44LDE4eQsSHaScwsfCuh1vaI/Wrqcqyc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168928; c=relaxed/simple;
	bh=afGZwUpaqGcjytcrknwNorYZV57gdzojPLTsyTjqLqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDBVynANJCxENY1aBTvSXIoGXsozMbOHF2s5XBVATt2nP5ZsHbRbyr4H9SNJFzAUXzFLyAPwXqdMfGTmny6cXIMFp2OaCp3r+kInpjIVwrH73UmxvBkwQSDn0PUJYXJKF3w1KeDcDUZhjlewE8ZASTbusrhAMFfdB1XzLf5w8C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=XOKa4ZVe; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="XOKa4ZVe"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25bf832368so9132466b.0
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 06:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790168920; cv=none;
        d=google.com; s=arc-20260327;
        b=bLoRT6IkczkYV3dnzCBIP/byDrf7sAE6TsaQYo/yyPH4DQh8k+npQ13sXGpPh+RMDj
         me2TFZg4CgvzE2UdAuO3Prrq5Ta6M7txBpvlOjPAeaigmqNTDe37BNrPMOGr2BqKT1bZ
         LFccABwbVYSUeqHOLzF1r5cPLMF4BOsWG+ylRd6CBLKm1FN4+3CQL9gtPj4UKkt0LmiG
         rAL7mYjc8FTwvg9uaTTihFUAkVxN01oPqyNsHtoEWliUeRcaNrL7UTF/RXB018vIuf+I
         f77fG9OuM97osxigprXtSUjoc0mgjqEv3ZhaZhuhaHubeIO0dL7ie29NNunP2xdOy/gB
         IAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=afGZwUpaqGcjytcrknwNorYZV57gdzojPLTsyTjqLqw=;
        fh=d4AwgUisd4teZ7zA0h/yA9lAkXDFx2tG6OKkytkbVAc=;
        b=Jfy2P32yA2v2mJV8mypEDX2T4hcmzNLv0hNCS3Bcy9IghNdfxgY6ofNyMdbYnUon9a
         swKK3206ey2Z4ZIriA38RcJCNhTaAgPPyeZ/aJ+J5aRgmNlqkYEXnq5Hs0E+F5F3hiu5
         dEJzrwXtJhHoOfA5IC4z7hAe3i7YUGmYDIr7KZfMRRV676ImVfD+319443o0RL42iLlW
         xbaPmdS8tDiKxdXe/pMHEBvStPhwnDIljcoA1x7/XBDxv/+OkFPT65ZVtnioOISUGNYb
         Epeg+478wwgbLHfAB7iO2bWfGu8MzfipUpdenm/Zc2it9ImHidHiHdSoiHYf19bHsZ1T
         DKkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1790168920; x=1790773720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=afGZwUpaqGcjytcrknwNorYZV57gdzojPLTsyTjqLqw=;
        b=XOKa4ZVe4onhAm9ODXkL88nm0nX8JIzZy/dV50kQnetqGc0dSFkLmuDU/OVSzMDemh
         0tkdgvLsGjxHBO4OYElk/zn0n294un/OpBKKazw0ZObiRWCzVTksL6KJFVkKnG4oBOaK
         bxfG6LxCEWW6w1M/6FI4BWEK34eMqu8mz4LYNxgNHwdS17wjxjJLOfdUmI80UeIRYO8s
         Pm33jFZMVu9FP456YKzY+Q6NTR27oFAeT/EonqRPLD3enVAXPHqCllP8p5nX6nD3i037
         0xn6FBRzqufSd3EHol5rX0Q7H0uG+H0scNMpfVYEpPTr+o6bue24Bl8m5TLAB9lJV+TN
         rYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168920; x=1790773720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=afGZwUpaqGcjytcrknwNorYZV57gdzojPLTsyTjqLqw=;
        b=XMI8vcCVrMMJuFH3fv7YZUs2A/b8bX26jZV+Zel3UUygzN/shZ91VSwcSo25LWyvzA
         2Lq7CBfo0yHPovASNIOK1UZ9a7XLQHbZPrI8OShvXaqGxXu7JCZWwePXYBdLPLJO2ojN
         l76ar3LvabMkcZmyZ96iYu9yfjov1Rl86nLUSZnYzFAcswNmNgTC5+ubpd2UsmWTfYZ3
         ap94JU70i8OSqHRnLbn3XHQRpviKzvPjgME3npB/UkNMvHrs2j6upDr7ZamJXqh5/zGn
         XyGXW6oWpoV8rUlU4le/ZaLhRpOQ92bXT+qn16r1h5vM27Ho0b6v1CmZ/r/2rmTS+lUx
         2SaQ==
X-Gm-Message-State: AFuF++kFKi27sXCifXxvRXoVQBO+IzH21tz8XPEJjWdGyjYKg/bIftJr
	CKkhnnWcqkmn4vN4obddLG8eeuiBEKOh0OVK3sTVGFnyuzKg6GnFYKsxCjIzpIPnCc+R0kxLDL+
	v6NccP7nNMDGUazCNiBNg3e/abYYD7vN5YpIdIjb9K+CaP+WFOfTIz5356w==
X-Gm-Gg: AYBFou1yXeHUiUAxKb5IeO/VZEUIJqb63MV4LuLymGuXGfCFXLGbiK3iAU6c+JrFQwj
	WowjaCm4cbTfsCE5fuFTt22IPOLpMiJTjBQTec/lRnzvq3JeDaY4BN4ktSzBCDygN/4JaBJet3i
	roAOIvgz34AFGpGhA7gMw5xVZXVDqeYNF+QYRAfTjGjTtfwvT0wFMwhqK4zaUZVBd2xbtI/ZDUo
	tAk1zLhmE1grLbPv3K+eC/kZt8KDoYs9Kq7DTkWBkC5ERjvkQJJHNgGQaaRnOEFEtXLtavK/FUG
	EgCUaaVVKLuEYIlWxntk6GUYWPMJYEVlUt5/QLGRA66nryTOUm7Cv/evrsCEGOtr9ExZYjyWNl7
	dMRJqvjw9OnC95H+lm3me4g==
X-Received: by 2002:a17:907:6e9f:b0:c21:7bf1:2c88 with SMTP id
 a640c23a62f3a-c2aae248f74mr227648666b.2.1790168919633; Wed, 23 Sep 2026
 06:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910100916.1638378-1-jinpu.wang@ionos.com> <arNiSSZ37GJF431J@shinmob>
In-Reply-To: <arNiSSZ37GJF431J@shinmob>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 23 Sep 2026 15:08:25 +0200
X-Gm-Features: AclHuK91o-Sy98b8W4mZfhlEltA0hjUnLxePARoSbPTVghPt9fytQObaDxc2ef4
Message-ID: <CAMGffEkRmc1e=n6d==biaUyt8Sc-MB44B6pcw4H2v1cV89yJ-w@mail.gmail.com>
Subject: Re: [PATCH blktests] tests/md: add test 005 for raid1 deadlock under
 I/O, limit changes and recovery
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shin'ichiro,

Thanks for the review and for testing the patch. The suggested shorter
description sounds good to me, please go ahead and fold in the change.

Best,
Jack

On Wed, Sep 23, 2026 at 7:30=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Sep 10, 2026 / 12:09, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > Add a regression test for a deadlock reported against raid1 with an
> > internal bitmap, where concurrent I/O, queue limit updates
> > (max_sectors_kb) and device fail/remove/add (recovery) cycles can
> > deadlock.
> >
> > The test creates a raid1 array with an internal bitmap on two brd
> > devices, drives it with fio while repeatedly toggling
> > max_sectors_kb and cycling one member through fail/remove/add, and
> > flags a likely deadlock if any of these steps fail to make progress
> > within a bounded timeout.
> >
> > Link: https://lore.kernel.org/linux-raid/CAMGffE=3DheGA3y8FjQ0Sm1jj-kd-=
=3DH9Y54WozKASSEZhc9UNKjA@mail.gmail.com/T/#t
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> Thanks for the patch. Overall, the patch looks good to me. I have one com=
ment in
> line. Also, I ran the test case on v7.3-rc4 kernel, and confirmed it avoi=
s the
> hang. When I applied the kernel side fix v2 series [*] on top of v7.3-rc4
> kernel, and confirmed that the test case passes. Good.
>
> [*] https://lore.kernel.org/linux-block/20260910081114.1605746-1-jinpu.wa=
ng@ionos.com/
>
> I will wait for the kernel side patches get settled on Linus master branc=
h
> before applying this patch. Thanks!
>
>
> [...]
>
> > diff --git a/tests/md/005 b/tests/md/005
> > new file mode 100755
> > index 000000000000..5493d0edc933
> > --- /dev/null
> > +++ b/tests/md/005
> > @@ -0,0 +1,142 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2026 Jack Wang
> > +#
> > +# Regression test for a deadlock reported against raid1 with an intern=
al
> > +# bitmap, where concurrent I/O, queue limit updates (max_sectors_kb) a=
nd
> > +# device fail/remove/add cycles (recovery) can deadlock.
> > +#
> > +# See: https://lore.kernel.org/linux-raid/CAMGffE=3DheGA3y8FjQ0Sm1jj-k=
d-=3DH9Y54WozKASSEZhc9UNKjA@mail.gmail.com/T/#t
> > +
> > +. tests/md/rc
> > +. common/brd
> > +. common/fio
> > +
> > +DESCRIPTION=3D"test for raid1 deadlock with internal bitmap under I/O,=
 queue limit changes and fail/remove/add"
>
> This description line looks a bit lengthy. How about to make it shorter a=
s
> follows?
>
> "raid1 internal bitmap race among I/O, queue limit changes and fail/remov=
e/add"
>
> If you are okay with it, I can fold in the change when I apply the patch.
