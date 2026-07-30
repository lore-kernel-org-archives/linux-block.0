Received: from mail-ed2-f0.google.com (mail-ed2-f0.google.com [74.125.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778D21254B
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390938; cv=pass; b=T+Y/EG4bJ6HexNXl5LH/F/FCFk0Gd4wcZC9AtUNyFqA90xfqKBhFq3E9Wvx/w30zMcSLHIODkQQuaPlYKwzQTID8Q0lX9SPKf4yKMl4zL/0DXAo/TZT2nz8jcKruZPV4jh+QAkyuu8hBDV5VlOQrSWK/YZ4OmIUhtcHDjheh55c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390938; c=relaxed/simple;
	bh=5GSsupOU9t54Xfw61NW7vN4epn1H+KVSXnQgz+Sc7aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpVtHixEe1Wn0dJRpBrYF/EQln+geX4kGVU0ucmi9IlnJRk0B3F2dwOkHEwUR9XLfZunPjCNzX+1cHA/tPWxvKntVjvKQ1gzxeHJ9xm5m2wtfiTQPIyDYIL4emwVZufyYYg1o1p9/MsThA9Ff+Jvw3BjE/1J5gxN0qeCm2+pi0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuDm4o/E; arc=pass smtp.client-ip=74.125.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuDm4o/E"
Received: by mail-ed2-f0.google.com with SMTP id 4fb4d7f45d1cf-698447ea5aeso718580a12.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 22:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785390934; cv=none;
        d=google.com; s=arc-20260327;
        b=DttsxOmBxo4giIVEINl4DZRZSNib5LPJBH+rr/xVoarj6nxL3ZFKb+PP4i3M+Sqx09
         iLUIXc4wg1TjTwv4TmtV8u997zGDWidys47edTNoaVlgAhsoHNN2n7CGkGnuCkd28edC
         e/uTfdBSsf+xD/lg1fbzZuuH5AN+I9tSahJ1Xn09hDyhdW0f+8UDMAgzuKtdIEsueeiY
         BZ0dD2DUR2cnkrFIWTON2USm+W+T7yNj/zeKwn6yzxTPvWw6IsSyid7wCxR/C0WlA4+G
         0SR+GVK7/aEuD6jo/S3DtrygPxIiWtOG3jhDNj9Ky2SojKhcNskYD+AhknuZ7gKcVRD5
         fyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zguOIVFeZ2tKGDsSUWKoGzpiZyFKgfHE9jucwOKdIAg=;
        fh=HUPFDc1uzYc2tWbvC/MTv48PwwlU91lsVLRSbULakOA=;
        b=nO8w1PuUEdH90IJZYLNZoJJvaVc3J4cjtg1juvTZ09demfPjaLoVN8khonCRVRItT3
         W0WwHB7Budra9m45SNHMaKq5ZRZk8lbIMnrZpdyna19Rw1hR9PImroAyWy5sVO4C0vYG
         uVHfMkYIMczs9jhLHaRcnxY9Rtf+GwhUQF0CfksfGKtlVwcFxsrTZdNIybsDqNYRks9w
         RDAGaYNebmSroBFzWS6Z/Gbt+9gFLGWQCXS5Pmuj5iNuNvgpp80ipMEf60CgntP1FbY7
         Do5gnfEEzUMLgsW0JGvop4VMJxKnNADGEiEkkhkyxWRwtDTr5tgUBuGoJ4wgu9GBRQvQ
         EUmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785390934; x=1785995734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zguOIVFeZ2tKGDsSUWKoGzpiZyFKgfHE9jucwOKdIAg=;
        b=BuDm4o/EDUhTYbOPq0kBzOeiHDJXQLBAxya7Mq9jNDQWdzDkowehJOJbSTneCONHKa
         S+AbnyDxIrH4b5gbiAE4aoCipUcVlF6zdp9mcUraUBDJ3yjhHx0dVfh3rsO8ImSTh23i
         TcesYXWKf/Zy2888GwgEdExSC+dPhXaHsBT8nKRFxnZevX5ewyjyo1CKB1bfTF0rAv8A
         FEb1fHf7nHQajsIfc8r2w3Zyay28Yey0goHnRSHvopr1L4YtzQ6T3SutC63n3/wkQHfV
         yt4/veGTNLo9+XAvXwYnH3Gw8udFGGyG6pgN+K1duyHnhBB0luFnkLpQtMxUtTg0lQ2Q
         4eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785390934; x=1785995734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zguOIVFeZ2tKGDsSUWKoGzpiZyFKgfHE9jucwOKdIAg=;
        b=fpP5soZns5TXNdO3g6KswQ1aPRqMlqcsbL4IXapp9CC5ClDMbJ9duhsls/npy3FFQH
         QqPa1TfrISHa/DDBr6ljRzfqSjQJL04+vWdzAKK1gFTw1b/P5DoXvdjrYErY41ElSC/c
         rJFg1ThM3wR4K/uFUwJXkoD24iR9YHNyTLEhKtwvkEIadY5IxrlOo1M/L70ZEoiC2cVc
         xkw3dpsH/0JcfOKpi/9YE8OFigsdBv8kqU3iAAdmim8IXCsur+SKSPHC62vuazZUcYTT
         AuZ4VDN5IOFzXvvin+pWMNOxkmFwEqSuDbpXGKdPgqWAEYe1TYo1SM+87Ji/eFf8bOVV
         NwFA==
X-Forwarded-Encrypted: i=1; AHgh+RrrZtYOekftrUgDkPfj89ZXhf1ecQJW11rCKkBdDFXU0sBVTL2O/VZvV/qlNE49QWupQUOPsUch9Vq5pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzpcXaZnFWMerRl1aHk/D3oYFaRRUQM3KQEGrGSHeAIeQmsLA
	ox1+AzMCt7rL2TCKvhNkR0MbBA0osvQ+k1FFNqkzmwR/gcXPFZQM7Cskc3bM0+DRJRDOlv18YfS
	XIyaMEhHFcMxCS1i8kX+x28qcov9JLR0=
X-Gm-Gg: AR+sD105V5B1/IrgfppohFIpV3TKrtrpKGxLiFXBK8/sm1MesFWrCp9WhfPtj1nz+NR
	/A29ig+U5WEfXIeUlu5AscPh16OB4oEfl5yaRQBCDHNBqrSFJwsstXHlBD2unC15D/DhdYUWeLW
	MkYMGPDj6gserjYwdLe+ByCJNrX/47KBo+8ya1nPZgdTxNxjBt4tR/Rq4Wk3dRhc47gptv2zfVb
	jyRxlzyeg3Q/mrFzczIjfiN4nt+XzRfRB54OWY6fEgPPQ/yZJVkpjcDxDpdy6zPowTJyId/i+pN
	LkyEHhl78o15l+jjkGf0kuwP+4SyqD/BoR7yC2o0ebxr
X-Received: by 2002:a17:906:1009:10b0:c1c:200e:ecfc with SMTP id
 a640c23a62f3a-c1fa57929c5mr33504266b.58.1785390934253; Wed, 29 Jul 2026
 22:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260730025240.17724-1-haoqinhuang7@gmail.com> <20260730025240.17724-4-haoqinhuang7@gmail.com>
 <amrAUPqAqrSzKoNX@google.com>
In-Reply-To: <amrAUPqAqrSzKoNX@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Thu, 30 Jul 2026 13:55:23 +0800
X-Gm-Features: AUfX_mzsG6ODNSIWnETTvtV68pwl2OXe7JtVATlVtteMz6cDfpcYi2Oo_qr2EhA
Message-ID: <CAEjiKSmMJ0C8Ge45BX0OgS0207AXFpa5dA6oP-K7yx9K1vVaJQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] zram: add level validation in zstd setup_params
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 11:10=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/30 10:52), Haoqin Huang wrote:
> [..]
> > diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/bac=
kend_zstd.c
> > index 2584f47c9b3c..6febb366f76e 100644
> > --- a/drivers/block/zram/backend_zstd.c
> > +++ b/drivers/block/zram/backend_zstd.c
> > @@ -60,6 +60,11 @@ static int zstd_setup_params(struct zcomp_params *pa=
rams)
> >       params->drv_data =3D zp;
> >       if (params->level =3D=3D ZCOMP_PARAM_NOT_SET)
> >               params->level =3D zstd_default_clevel();
> > +     else if (params->level < -(int)ZSTD_TARGETLENGTH_MAX ||
>
> I was expecting to see zstd_min_clevel() here.  What is this
> -(int)ZSTD_TARGETLENGTH_MAX?
>

Ah yes, that was an oversight, it should be zstd_min_clevel().
Fixed in v4.

> > +              params->level > zstd_max_clevel()) {
> > +             pr_err("zstd: invalid compression level %d\n", params->le=
vel);
> > +             goto error;
> > +     }
