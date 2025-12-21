Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA82F99BD
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766331604; cv=none; b=E5baxzFS+WQC7Zgs/TuJoI2qj26KfrtIUWMvmx7RCXhu3UmXp8yOhDd7518GnJgQQ879Hl8FHqU02YW2O9uIqiquZaRJV3+Ho/rWzNxkRe/sQBCnf0mYqGf/mm2ocK1tsCBmBWLxR04LCQld1WQTChGT6W+BE5n8mljf/GtI6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766331604; c=relaxed/simple;
	bh=mnZjXNK0u+HP/XUiaDYnE60D1RSlqmCcOGyEHMy6J80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYE7KsDIo+kEgiME61oaCiV1yHB5CLFH3134r7fUzFB8/v0/l28rHjlAgpN2u1ZXo5wKUl1G5BNdKcuRT47mWPISnFPzMIk+8wOE6nAlDrmOmkWVGRyDvmvTFiYP1b3v0XpIjgS8NqXIUnwcx/D/N/2sfmOx0w1XPRV9+aC9W8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fttG2Je7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XM/GWV4t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fttG2Je7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XM/GWV4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766331601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KE66w4YWw6ndgVPN9WJoeENuvGjofTuSeoIQ9xGNDM=;
	b=fttG2Je7tdPOfLijYFhXFq3PE3AKCw6AQNJoJS1mI71qQq+TxQDEPYBBt6SS1Dp57w5qD7
	UYCri/YFtUkTv2MRs6daOTYs5v2OUv8HvFYCcr7jN0dEfgATrZwVtAhZ4MNRg0LCX20bjY
	xUoPIgUQDJrr+9L+UnTYemEK8FkcUxw=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-2HSAi9BBMjC0b1tXHmC1NQ-1; Sun, 21 Dec 2025 10:39:59 -0500
X-MC-Unique: 2HSAi9BBMjC0b1tXHmC1NQ-1
X-Mimecast-MFC-AGG-ID: 2HSAi9BBMjC0b1tXHmC1NQ_1766331599
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-644716a6f05so4516156d50.2
        for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766331599; x=1766936399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KE66w4YWw6ndgVPN9WJoeENuvGjofTuSeoIQ9xGNDM=;
        b=XM/GWV4t5bhW/CXc1eTGegsHWhcSygiHGujZphzwTqn5/6LDn4ODMGWBYqzamq5ksp
         vC3eM6pul+UOVPqUTrkprLC8tf9JkXHTl7Kdn3U1GBr6YzfjaZfniBfGrZWa/k0vHVrF
         uN54aE+u+CAKKRVzWMPs692lPFF9Q6IMJ/LfE0fUhlo5vMqLo4/WPVwe/7QgKcIBTwE5
         ocq07T0xOWTLN4Zj90RAMWllVGvDaVmUEKQ5FPnjZ8bL3kEVaVlG5kj/3Bhu+tuooAMr
         wnKx5Flea13rb/gex/sDWE2cTe1ndirBUbbjZB3V4niqLfmun25MAvNuJyxvlHOTXozO
         4rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766331599; x=1766936399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KE66w4YWw6ndgVPN9WJoeENuvGjofTuSeoIQ9xGNDM=;
        b=lvzpgCX85Beanx33BN37vF9jAKlGwv42QwVTvh2gWzy/PQY7M8deA+pQzYA5Qblv2P
         5LHTStutckCuCKtJ8+YcEn+jkNJHKKZbQ0vYQXqatUx0Mx4PM8y0y+VZmFj5zVq/GHLC
         vC+GrDpzhV3MyiCynHf2XsdffVQDkfZIxaPUSlRnBq7+15TJNsDWR1hwUPc36B3aEsCF
         KXwUgqezNgO8DMPwmcMmIgGtV9zRjnjOlRnb1bDEVEWioe0leezkXwlQasr6C3FlmK89
         /qu7l6J1dWWAR6cS0+V08NEqdE7F0G1f6dbXAuCR8QCub4aFnLRQ5vq1zhjLE2geRC+m
         imdA==
X-Gm-Message-State: AOJu0YyMH5ub/UtlXnj+JMYt+n7IFQARCmwh2LRH/wvYv3iaiu2Hxz2L
	UYU++EAAnSZ8G158BWmvxZ7IBaJr5pLhP6j+6+JTbh3AJveNGaxKgLGnyOt1lK2qe79ZAyq0Pav
	wj8sVVYbnTgrsYrYyUt5H/H676aJpwhgI30DoU6BjYw0xi/aHsGAHBWmfeDJLzFbgdWwEclEOrc
	DQpa4XnAutSF7Bqe3m5caKhk+sgcgrSO/E3XTLNZU=
X-Gm-Gg: AY/fxX7K6gmUt88sG2WxYWv7GaPG01rOuT5+k1XGPSi4W31p+5048KsQitDgNfSXnG3
	1aCP3c67rtlC4mgR7kbxgFmITWDE81X95c7CM32qrfYnfyr3wxLjnLpJzwp7MvG1vL4aBNrcKOR
	NtaJpKiKl/QM+O5W8cQuu75u2P2kcUN9hkTQyNIMEftIOA+/VDSh+xiKEPj99UAM0+3KauHheoY
	SZ7URW+S2w80ELHjAVsJki0Gd+3SUi/IgDgXBThq0O5WH7OSAyTdA==
X-Received: by 2002:a05:690e:1284:b0:644:60d9:866c with SMTP id 956f58d0204a3-6466a92dc91mr6656844d50.93.1766331599155;
        Sun, 21 Dec 2025 07:39:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC7mRAlf3U3160pFy0QO4PEVMCEcrUcemZaiGKUncjGrA9BOh5VcTiZvbH4/xJJSP0FWrca5aMSKuDJG3O3Q8=
X-Received: by 2002:a05:690e:1284:b0:644:60d9:866c with SMTP id
 956f58d0204a3-6466a92dc91mr6656830d50.93.1766331598821; Sun, 21 Dec 2025
 07:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221025233.87087-1-agruenba@redhat.com> <20251221025233.87087-2-agruenba@redhat.com>
In-Reply-To: <20251221025233.87087-2-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 21 Dec 2025 16:39:47 +0100
X-Gm-Features: AQt7F2o4CmeFGTIojqbpS0PVmjVAd-d4HUDEVdSFp54dsbxM3ZckXV6-nNPzQZs
Message-ID: <CAHc6FU6vAokT9ugX1DA8iQLbeu7=Eixr9bq6z0o77_Nq+PyXvw@mail.gmail.com>
Subject: Re: [RFC v2 01/17] xfs: don't clobber bi_status in xfs_zone_alloc_and_submit
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 3:52=E2=80=AFAM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
> Function xfs_zone_alloc_and_submit() sets bio->bi_status and then it
> calls bio_io_error(), which overwrites that value again.  Fix that by
> completing the bio separately after setting bio->bi_status.

By the way, this bug makes me wonder if we shouldn't just get rid of
bio_io_error() in favour of bio_endio_status(bio, BLK_STS_IOERR). The
latter would be a lot more obvious.

Andreas

> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/xfs/xfs_zone_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
> index ef7a931ebde5..bd6f3ef095cb 100644
> --- a/fs/xfs/xfs_zone_alloc.c
> +++ b/fs/xfs/xfs_zone_alloc.c
> @@ -897,6 +897,9 @@ xfs_zone_alloc_and_submit(
>
>  out_split_error:
>         ioend->io_bio.bi_status =3D errno_to_blk_status(PTR_ERR(split));
> +       bio_endio(&ioend->io_bio);
> +       return;
> +
>  out_error:
>         bio_io_error(&ioend->io_bio);
>  }
> --
> 2.52.0
>

