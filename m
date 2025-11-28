Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50732ABDB
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334791; cv=none; b=M0JCeC5PjvjtDCNAMNvqv0NuLSpUonbeDUmPMS3Bg6UraVoddTJ04vT+ITh/XSIBBqBEAeDLhiScRmfyrsSTWNBsJeYZ4CbGKsnK92CU5pYrhodiOorsKXhtsVL3UBrd/ZoNtRK/PdQEF5SjmAVyu/Sc6dLpUHZHY8/z2eyqxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334791; c=relaxed/simple;
	bh=5QcOkFfFDyBXYDnDanyoo0Sx7zR4bMbvdaWPFSIL9Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bz6feMz7eIA8wFCLrthCNdvnO87bbnvw0cgRxFMw0dqa7FPtXD6NSXbhx6M3hUIyjaYabLVuRJGOvPcTOZaGE0QwLSUbveQhpQBPEGmq+CcgxPk7X0ujahtGhHpn6gWMkMKBgngr8FSZAMASM3VAZ/AImMSs9cb9DCoShMdj8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8pS4d1f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ae0aAH+x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8pS4d1f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ae0aAH+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764334788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbnViGm0SST3AIOO/NDK6ivARfPGgq8UL5FPgRGsaTs=;
	b=T8pS4d1fsn7qpHmykIofedKAKHqMnz7z2Bf20HHr2qMmMEBdhtGyDn36ahbecBKsPT3SYW
	K8AUU8mP2p5h8n2vBsSBM58V28eqr5oe1oMWGzdfO0vFT5S0J74SCPE77ImZE/GFGnu+p6
	fiOcJvJLFu5he4MzFdDh+bNCBIvEqXw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-rUaeeBs5Nvu7HsLeQBejNg-1; Fri, 28 Nov 2025 07:59:47 -0500
X-MC-Unique: rUaeeBs5Nvu7HsLeQBejNg-1
X-Mimecast-MFC-AGG-ID: rUaeeBs5Nvu7HsLeQBejNg_1764334787
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-787cf398a53so19485287b3.3
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 04:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764334787; x=1764939587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbnViGm0SST3AIOO/NDK6ivARfPGgq8UL5FPgRGsaTs=;
        b=Ae0aAH+xiZn0M0AZmsB9h871+6Wu2K+gwh5ossE977XXwsjldRXf6TILfNAwR56yfg
         QRZKF+COItBlNzPj9+tsIjZZ6DPC+TV3ZTMrho/TAYYyEja0TiQc6CGLkLXQpPWzqD1v
         vFEHLTWc250lQ8Rt3HTp+cIpWxZyc2R/VLlAexZe01jEB7f7VSTy0x5SE28aSysBJ+mt
         9pMcAyRcvByJyY6jUdnHyAJd1d+QZSCi4TzEk34+Mcq3mkbXq3R9ePPB1SyrXVvJnQsZ
         nagsi+zQTuAuVJHN8ZnB3l0Y//P0htTsUYpZUeB//hVe6MbXA8MAX6myp0fzB8bzTk4j
         KAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334787; x=1764939587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbnViGm0SST3AIOO/NDK6ivARfPGgq8UL5FPgRGsaTs=;
        b=g59fokkopqmG5hJf6aHy0LyaBGtjQVov5dzYPvwkm64CRc5It/0nqqgIYfm74RfKm8
         yU5xDihn66fJxZtmgn2Fh4JGvA+yhnxRtQI5deFET2wdSq02tsT0CrM174qU5lLHWR+q
         9hHkYgWVuonIlDhFl/TEtGUVTNYsqgzueqkLC7hVp7rej1E7r2FUpxEkmDyaVJfi1Mph
         +miIfWqPb07rvi0LWhg15Epwa/C77UQTalfV1FTdaIXQ9yMoPo53FNoe4UOKN0pp7qKV
         b7EKVIszu1AXMwx3ko5y0DEwFsTgn27cXUWiHKKswVL6k0TCDYt9qwFaaN8fAoD/DTFV
         W13w==
X-Forwarded-Encrypted: i=1; AJvYcCXPMymIq8B5LCzcvcadijPXy4D1iqm99jFupE8Bc/srzXJjvUWLs0lC+zkpHDeMjT5OTT37nVHmj0lC4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOnnf3jRulV4UFEAe0R7On08gjn5Xoa6yWG54jXjO2baudpaD
	pVwygdHJmVBn37ZvSgRR1cuiiZgTQucCis3swbzj/KU7ARmFdBMk7ctVqHHom0z5+amub3Q6et6
	PJxfSKMicAsoraFIgd8z91N0RiAxJMovUUp7fgP+dIykQ+la+zoGazgZIJGmtLEohUfx4l3nEWb
	LuIENLZ7r7S/3LTs6YLnakE4pdZg1UL8PisCaLzxY=
X-Gm-Gg: ASbGncsxMyRV+UmbZgw0WS2SS8JWd46ctNcPAg1zKnsag3vo62Ern+BXZT2/bOhjCED
	f7v6Al3OZsaBkN4nj7+wz7u+EbHExYD/bH+LCscMYy8loVvmpvBdM+6hP6uvXw+ZGNWoPndKmdx
	ISt2W40usgIJkEw3iCZLNWu8j3D1TA/ncvx+63qAl7bVQT1dPbZqBgJ9FZ6RMnYHOq
X-Received: by 2002:a05:690c:6f03:b0:786:78ab:72d0 with SMTP id 00721157ae682-78a8b47a179mr234771277b3.7.1764334786911;
        Fri, 28 Nov 2025 04:59:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGesqVOsUJELcTkEGN3hauFQ6kd2TkNnYcjHT4c1bgANcOfukNB8/4Sre15bHJPI3DpWDPFXhJhMME6PGLKN8M=
X-Received: by 2002:a05:690c:6f03:b0:786:78ab:72d0 with SMTP id
 00721157ae682-78a8b47a179mr234770957b3.7.1764334786528; Fri, 28 Nov 2025
 04:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 13:59:35 +0100
X-Gm-Features: AWmQ_bmJ3AOy1Ou64bzbzmfYJle8eXItasxBb4QbS7GrXBYKV503HxVqfGGmAks
Message-ID: <CAHc6FU6H22GEQTaOh4tm_=yL7CZ-Ck4EkXtmdsn_oyAW7OWB6g@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 9:32=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Andreas point out that multiple completions can race setting
> bi_status.
>
> The check (parent->bi_status) and the subsequent write are not an
> atomic operation. The value of parent->bi_status could have changed
> between the time you read it for the if check and the time you write
> to it. So we use cmpxchg to fix the race, as suggested by Christoph.
>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 55c2c1a0020..aa43435c15f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -313,9 +313,12 @@ EXPORT_SYMBOL(bio_reset);
>  static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>         struct bio *parent =3D bio->bi_private;
> +       blk_status_t *status =3D &parent->bi_status;
> +       blk_status_t new_status =3D bio->bi_status;
> +
> +       if (new_status !=3D BLK_STS_OK)
> +               cmpxchg(status, BLK_STS_OK, new_status);

This isn't wrong, but bi_status is explicitly set to 0 and compared
with 0 all over the place, so putting in BLK_STS_OK here doesn't
really help IMHO.

>
> -       if (bio->bi_status && !parent->bi_status)
> -               parent->bi_status =3D bio->bi_status;
>         bio_put(bio);
>         return parent;
>  }
> --
> 2.34.1
>

Thanks,
Andreas

