Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676A3A7F54
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056544; cv=pass; b=qCUQJfmc7kg+I61xtGT7uKokXM7AUcNrtSIdwJ4CStB1mMVj6YXl3wrUzS2fVOvTwOCx0V4iSeay+veIjU3cL/OiHiwM/BUYqMF2y3WWTkRN0TYBfOAcMEGiVCaZUXvLZNBxvOwsZOa6dzyAai4xnTwYWIEfqT2cMqcK2CJBCTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056544; c=relaxed/simple;
	bh=0yG2dc6853NehxlMBj7gvQwc469xs0sgQBHv5fQqk0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZHR6ZKC33XPANglFgp8RJb+BH1t5puI+S0x7KLLIcA+GG8188cUfJauOnWTAIEL1U7q1j0UpJGiCA6/W/ikDcYB3facs0faklazBMD8Vbd+0D6sjVk35gPmNS+jvw8pBtuaal6WKQI2LIO8TVBMe9yV/iOUxyDdwt/OpoFwiHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fT4w1ecE; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fT4w1ecE"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d74872c5b1so480993a34.2
        for <linux-block@vger.kernel.org>; Wed, 01 Apr 2026 08:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775056540; cv=none;
        d=google.com; s=arc-20240605;
        b=TW4hp0s9syPD5K6IosP67AVWGFP2kpYVoTsaXWJTxZXQgGGACpE2fNuBabc25XLr25
         bFCWMj0Nrq/oPop4V6nekz526Jk7hIVEbmo8fZqNckP4G2D4wxB5cwTT5BJsSXcWkMO+
         vL0l9a/RT1GCCGl1gfBggE3MhNlVf06ClB4lqJkpt54hiGfR3eKlwSYBFTMQOm+J5ejg
         NwB71lx+43WCgGjAomTHh9Q60EOqcad026GutTNXZtuBI1PA/eLPXRQ2yQldrcQHiMqY
         9QPcsAN70gAtuv/3J0gHzVNKZKSnVn+Gl4lnFe5/j+Mdhc/XJUZKadm5KqQmqqZRc0sf
         jzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pwjhrFgpgjvrVUUm2pugqLVQkP7/K/w7OUmyJWkCH5E=;
        fh=q9982tpK7lTYBUA071ukmea5DGmF1IgUZn10VZ2rmgE=;
        b=DSiQGreX0m2c9torf++9vc/vdkgtUVWitk+po5MtPiCbo5OGM31bbTveUtVRcZXxg/
         tmZh75c36o9Jp2BHrLpvY+ZjydRaftZIq1Xcmynzy5NBhFNmREyvOzJmw3oLPoqG702J
         8hqX3O6m+DxiHmmHwYuCDMl0D4ODz2umy8lTBnYDK+BvlRFHluKhHABQzeYBp3jth1An
         Mui9eOi+GwFCSqpQ9sdpM9TgX4HjIfuw9YX8aCj2eIUwynXQZ/KejZyfmuxNjWWByDXE
         AJxbKKECRsKfVLxZXXhOdnful4M2J6r0GEpj1S65c4YLE8JkNQf5MNadf5/ztTM84bxM
         sy6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775056540; x=1775661340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwjhrFgpgjvrVUUm2pugqLVQkP7/K/w7OUmyJWkCH5E=;
        b=fT4w1ecEuLKxi8zjCWZ2bN/4im7aDDOA4MipGWIHQYjCtMfFweUeGdBfGBe//sBdxA
         44Z0UYDaaVYMnE6wYecs/oPlGyyx574POvktaVXDE25JW0XPzobhwUcI5nrEo38rsfVb
         bO0oWC/masdI2C6pGee5RZx19QbNecu4VlmpucAI9yDiCLfoqsUy6klXm+QG7Id9Q4Mf
         rYtbzKiy+H32F4SUwMpAVd0nfgXRBIBSA+7eLgXJSaxt7yKKl/qccXuSAKfrVkF1HEdZ
         BMzT8hVOux7+t3WRWB9ubeGeD2WHnCTPUQSOJr9v/Fzv5oT0dNTygxt5nVhWU/tnWJ50
         e5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056540; x=1775661340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pwjhrFgpgjvrVUUm2pugqLVQkP7/K/w7OUmyJWkCH5E=;
        b=Y2ONY0gSHtagDYV9924jbSCDlgsimRzeZMmymm2bevGgTFcAMFAxNoxxZ3MjS1kGO7
         Ghqrmix97onb6gvUcWkr9eUxc4PGEiSuIBGYfmBGznuNtw8nE4jkTv2mYeWRbqfs+X+o
         MvZKFOxNAGIA0AYLQsblt9BgHRktkkwwx4JshD5fTTl4Wq8KL4cA3jzNo12uoSeljZky
         icyj1C831QUE7KJGhyqdGPhGE1287NAGtzxCOSV2OZ2JxwR88ywply99HhBzG1DdLzLQ
         Ytdm7p0NWe6DCJf5WrpAl9K4P3g5cxagco73vgRLyZ0nvQguV4IanShpIYLmOr2fFhg+
         eWbg==
X-Forwarded-Encrypted: i=1; AJvYcCU8AB3y8oyZDMctc/eJIDL8E9aaEjLPe5ZpxBx9D6qptLH9KxwwKTvkOc0RqI0psmjdI5LB0hWDI5s+gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RZTOvQdbHFC6fLMDzzTprgK1U9eG+pseOIOsUkB2L/hty30l
	qqLHW86l/LIpArDbmuqWUIl6j12fxHwVyn7n+JJwktgjfsGNJgVTOlqgIYidLcsGUi4Hj2RXFZM
	Kvle9xzw7uC81g4vNtR3cegn42b7+XDUa5t+OgL9tkDwLDtnW+hG9RBsQ0g==
X-Gm-Gg: ATEYQzx/W/NBS30/pd87aunMCprG7El1wr4nwo93F49Ha6v13QpscX1lU9PvuGY4KIO
	uw+gB407wMw1fi3mrASKTi4nDBluZy2G6BDItnasnKqL0g9s+rpnvmFiDuENHpKVJ0ji959ToBP
	oqr0ceQX9qJy5bj8jvOkUpRPCeyO22AlJIR8De+wlBQko18Ttc+P59V7OLO7LHRG3rfA7x3qJ0A
	/qE+ZLy0mvdaHlu7huOGobgaOJMnTScmtkSjsfcJgZ4RxYLiI9sSap65eoFaYOXO2cdzg+wdSCG
	5wFKLEuS8i6bO3G4Ug==
X-Received: by 2002:a05:6830:4410:b0:7d9:3895:563 with SMTP id
 46e09a7af769-7db993fbc70mr1704623a34.7.1775056539515; Wed, 01 Apr 2026
 08:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401012401.3653194-1-ming.lei@redhat.com>
In-Reply-To: <20260401012401.3653194-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 1 Apr 2026 08:15:28 -0700
X-Gm-Features: AQROBzCSe_1942evdn0XA7IXmX5RNgMGaPIWvKsnGb0kRpeltmSB6t-Ec--cJi0
Message-ID: <CADUfDZrecMcb_C3UiTh12e4YK62XbZgd14FGEpxPopTih9QM8Q@mail.gmail.com>
Subject: Re: [PATCH V2] ublk: use unchecked copy helpers for bio page data
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 6:24=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Bio pages may originate from slab caches that lack a usercopy region
> (e.g. jbd2 frozen metadata buffers allocated via jbd2_alloc()).
> When CONFIG_HARDENED_USERCOPY is enabled, copy_to_iter() calls
> check_copy_size() which rejects these slab pages, triggering a
> kernel BUG in usercopy_abort().
>
> This is a false positive: the data is ordinary block I/O content =E2=80=
=94
> the same data the loop/nbd driver writes to its backing file via
> vfs_iter_write().  The bvec length is always trusted, so the size
> check in check_copy_size() is not needed either.
>
> Switch to _copy_to_iter()/_copy_from_iter() which skip the
> check_copy_size() wrapper while the underlying copy_to_user()
> remains unchanged.
>
> Fixes: 2299ceec364e ("ublk: use copy_{to,from}_iter() for user copy")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
> V2:
>         - update commit log (Caleb Sander Mateos)
>
>  drivers/block/ublk_drv.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2e475bdc54dd..3e329906ae19 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1322,10 +1322,18 @@ static bool ublk_copy_user_bvec(const struct bio_=
vec *bv, unsigned *offset,
>
>         len =3D bv->bv_len - *offset;
>         bv_buf =3D kmap_local_page(bv->bv_page) + bv->bv_offset + *offset=
;
> +       /*
> +        * Bio pages may originate from slab caches without a usercopy re=
gion
> +        * (e.g. jbd2 frozen metadata buffers).  This is the same data th=
at
> +        * the loop driver writes to its backing file =E2=80=94 no exposu=
re risk.
> +        * The bvec length is always trusted, so the size check in
> +        * check_copy_size() is not needed either.  Use the unchecked
> +        * helpers to avoid false positives on slab pages.
> +        */
>         if (dir =3D=3D ITER_DEST)
> -               copied =3D copy_to_iter(bv_buf, len, uiter);
> +               copied =3D _copy_to_iter(bv_buf, len, uiter);
>         else
> -               copied =3D copy_from_iter(bv_buf, len, uiter);
> +               copied =3D _copy_from_iter(bv_buf, len, uiter);
>
>         kunmap_local(bv_buf);
>
> --
> 2.53.0
>
