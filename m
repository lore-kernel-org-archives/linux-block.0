Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93815A86D
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780273537; cv=pass; b=AoVRuoI+HIcuLTUHdaFk3em9AgW3A16XWArJViEFx6DLGAwY50uOOxG8Gy+/xv77cuE4ZGIWaTqxOhid4arHxM/bwkpIafIalwnJtW86032qP4eawTVQFEOLX+BHuFcsrXQZcfyuhiwpKGALB27aFgcrRGsF3Cp+3p2H8ntMHuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780273537; c=relaxed/simple;
	bh=yZxWlTamZEmEoJ47wP2D3iddfaJvsVRh3YhK/2wojGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cW/lJFiBNl41zdLcmdoPkXrXzp9STPdfojoohkBSd5GoGnroyoT0MV7v5Qogf48r0h2YwbZj0GereL1qXEx7MdOasbqPu2ze4zY5bTxcEyv+ZlfldFZ4XsBf0dfYGP0N4maOk8KE4eslnXyPgUg8uBJJ2spgH4AD8JtJARa3NwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbJd11U9; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbJd11U9"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa5edf347eso1386748e87.3
        for <linux-block@vger.kernel.org>; Sun, 31 May 2026 17:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780273534; cv=none;
        d=google.com; s=arc-20240605;
        b=RIHrSVRR+hqwt6gbVMiBXaPA3QUiG1FlEkMLxH+ocye+pF1rWKd6cJ/Wcq9LlaRdFM
         D9oQTaJi/5UrNDRPtm8QGuCruqWOiLf3gxRmFbpBGabEyZXHhMmByQuTKlm7/srpE23W
         BNjtZVge83O76yRK0+KBJT5Bx4CycilEqyCHqZfotNyZjUSnFptayD10oD4tqh0Mgg8d
         Dhn5OleLfKtHtlx1lVxA3PVfpBydsnf5nQfUFXjk0ONidLaXdrp7MWFqdaFSZPz4DHND
         rrw+fc3lVKTfEIwALcQEvRSNsaZcbcLPDn0jRi5aUW2jaZ7AY5DuMXpB0dJk8E5xb/34
         KFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iqgK1wg2ERDyOtfs5+7z5PlMWVVQC+GT9AiHeZIUsyY=;
        fh=Wf3LF9sF9s4mlbjDzRzBs9yZEn2PBHsLjm4bI0x8Bsk=;
        b=ffGws43U7QX/ttiBfp29Pq6JpTjfC1CKlRzSCTebmitJd2Zshv/aCuFFu9LtTMecBC
         8uJg8B3GZ5ujfEbYGYTYYhC3gLQcjtSgBor8NjzrkixC5sqWoJog1p1VRXNNsLr1lZDo
         Z3y+Ja9WsD4b89BuO2WD7L2aVQW4hUBKbhqHFzjKOQDwb3+ZX5nuQfzAyCoCRZSDb5v/
         HLbN7Kdyzp4Akb6IlOsq58aXywQSZIzecqAfj5d/J6B8EQsh2rRdjp6WJS7uOE7iQ6iB
         xKPCn0ryUmGHcfclENUljl7GGBye47fFP/UWPrbWCgNRXvg4wb8Q56klHthhbB8FNMfC
         SiZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780273534; x=1780878334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqgK1wg2ERDyOtfs5+7z5PlMWVVQC+GT9AiHeZIUsyY=;
        b=pbJd11U9YW6NRpCWKK3sk5lN87rQHhg84ZUtVeMLps3aDswLCruTyqL8uvfXaJ8jMU
         K2XV2XoCOoA+/wiO1W27VotywrUBfrY9AwPQWuHg4zZpEFRQBkR7FZgk7ObSdOxarHRh
         DRRNE34/kLr/vEMV91smaSP+hQKMqZCEGWUK3cWAiJd2VhZWG3D9+MpZW7m+YA16Q2CZ
         RXyylwV4YNovC4NoImQswdwFVz7mJ2X7+DeFWA9/1XofQ8my5xI1Q94EaznfHZRgGTCq
         chAKbSGnTf4dFahfwKy3c65chi+7Fz49YZ8xaKjQ7LcLpjc3C/sTqQvZrAumlzs+eRSH
         F2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780273534; x=1780878334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqgK1wg2ERDyOtfs5+7z5PlMWVVQC+GT9AiHeZIUsyY=;
        b=ogkamiVgRjf3cNg/Mqhc1yZChFnxtAgsgBf8DDJAH8bcuTr3aohCQRKJ3bzL9Q117z
         bGGY6i/ZhECbPLG1gQ1lQ4yWlabsJ2c0RN80ZzED5S08Rs71IQve9d8gDlMVqHndcRJ/
         GVMp7OQN90jjo4qDUzqR6i9hHpqtwilVzU9z6yQut+pcBBacstrTqF4+2BWFsYv68Kff
         INPjFKQUKcVYUUvAJE+31BuczpOcMnx3VfcXNy7icfsSG7dT74IZ9HnzrFDBGYgWgxNZ
         dzjuA+NIbeSYfLI5KPnvdp7Eyzvf9cSJDfb/o2a8V1w6HLTSrkNLkp+Y89N7NzoSusF3
         0Rnw==
X-Forwarded-Encrypted: i=1; AFNElJ9wUx3f+4PyDFxqrekPQHdCY9w2WMxmj3uC/EeJtt4kCh4r22Hi11mHA08U5wx2J6t92g6lGBjBtjXjOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywQRYVvezcvKQX0vxEjwOt5NHYEGzH4RscsDbT9mnobtEjOck5
	vAyV0DoL2b2I6JIhcIeUFilYvG5hgm/Afc65Vgs4HjkgihBw63zy5wkmjln9Im965SEFvZ6YNnt
	23wJrLcDSXfUMYZXu3HShgJz+EcFSEGk=
X-Gm-Gg: Acq92OERam+5GedL453ltF08cx+JfcIOXmszH5agX6E716b9ZGA9jOK6lY/t2+XidwE
	mGMuVlG0vi7Q8RmUYzTakGMKP+S9Z1/40Gy1QWKu6d7435dgVUdFiURFvIPjEix3oX26jknmpSM
	iky1Lc4d8Me4DXidwIb9TEfB7ScgjG4VeCNDLo1rwweBcrk8jYDVrhzaflmYztdorRrXBRouKxY
	FjaKXo+kgBLUDmcdGd31C9+dM8O1CGHMNmiZziMj2s7I1hNJ1nER4swQm8VD0X7vOIt9Yy0QJ8z
	At0QU1goS7baRnVImnwBGbpzm0Bso/heo8tXrvNlLgCRuh8=
X-Received: by 2002:a05:6512:12c8:b0:5aa:6bb5:d5f with SMTP id
 2adb3069b0e04-5aa6bb50e58mr595558e87.13.1780273534044; Sun, 31 May 2026
 17:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-zram-fix-partial-io-config-check-on-akpm-v1-1-eb085d98faea@gmail.com>
 <CAGsJ_4wB5XyUrPpg1O-pkySxo91RsHxaaUkR+Kt+heP4_OeeqA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wB5XyUrPpg1O-pkySxo91RsHxaaUkR+Kt+heP4_OeeqA@mail.gmail.com>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Mon, 1 Jun 2026 08:25:21 +0800
X-Gm-Features: AVHnY4LCEnZxVatPf--playUbBj6ZV7jG8LbCfwqfDtwHwTtx6N_h4IJfVPbylU
Message-ID: <CAJxJ_jgk8o12OYAi68JznpwKYTUJOUizp2PAZvNz2VdVGJWstw@mail.gmail.com>
Subject: Re: [PATCH] zram: fix partial I/O config check
To: Barry Song <baohua@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 5:38=E2=80=AFAM Barry Song <baohua@kernel.org> wrote=
:
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_dr=
v.c
> > index 6e1330ce4bc1..72f89fd5572e 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1510,7 +1510,7 @@ static int read_from_bdev(struct zram *zram, stru=
ct page *page, u32 index,
> >  {
> >         atomic64_inc(&zram->stats.bd_reads);
> >         if (!parent) {
> > -               if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
> > +               if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_ZRAM_PARTIAL_IO)))
>
> However, I don't see ZRAM_PARTIAL_IO defined as a Kconfig option.

You are right. ZRAM_PARTIAL_IO is a local source-level define, not a
Kconfig symbol.

Please drop this patch.
Sorry for the noise.

Thanks,
Jianyue
