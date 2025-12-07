Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E02C21FE
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765114233; cv=none; b=mAdTgf61TKp+yj8w6/IXo2i2EvYlnZiVGFKbAPu4O5369J6YGKi1/eJVL+Dmoa5W6i5AVtXYaetf5pXnpIRwspiRhQdLHkmibJIszmP1UbvHOQogUMhpnLs2cF90s4pGID7hcLLrOPhclUQeosekjEwkhNIPY3vV1OyAgixiPFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765114233; c=relaxed/simple;
	bh=W5VgE4r2CVWoGwWRjm61UM1/NAP7KmItMDhR9b0IcpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lxr7wCAMk/iPOFTd67pGc1uTj01Ifj1xdjTSKHz3UPLY9gRluST5pyDs/ycYql1lImnqEK69RpqsasvmSuO4z+mhx62Ir1NAbYAH1UW9PVjhY0clmwiZPLqO/AXQ+feSI33jNtaXswryO5ftFeMtJzmxYsWwy/U+mgFZ+0pXvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZFJo1WO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kjaguT/K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZFJo1WO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kjaguT/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765114230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dyJaX3Br1gUfDH7aDIFFQJYtt7YC2wra38Oz5IMJMOs=;
	b=QZFJo1WOTsyaImLV8HVeKpIRjyItQey+XcpZk9lHFViRVJ8xFuCtMjXY8D4MyqrDS83g29
	nK6FkQS7I5fRu59npaFFuPtgzIPN4eyDYoErauhin7NTWsPjx2TE1H4M5nDLdkakCRcSe2
	s7YyMLMULZOEGEnzbIeY2wVTzuJ0EPY=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-NiBoXWjDNWigSDeLjKhYbg-1; Sun, 07 Dec 2025 08:30:26 -0500
X-MC-Unique: NiBoXWjDNWigSDeLjKhYbg-1
X-Mimecast-MFC-AGG-ID: NiBoXWjDNWigSDeLjKhYbg_1765114226
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-63fc8c5b002so4274484d50.3
        for <linux-block@vger.kernel.org>; Sun, 07 Dec 2025 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765114226; x=1765719026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyJaX3Br1gUfDH7aDIFFQJYtt7YC2wra38Oz5IMJMOs=;
        b=kjaguT/K0p4P5MmSx6YhsbhXhFOISUHERO8XqV2ukuXbUIf4PK2vlw0CkOnHQFcWbQ
         M4nWqLwhO4KcJgKtTnmxkbq1/5SNAYyT8CLsAicuRwuqCLms4DglQJiBh7A0HwxbV6mo
         tCcTgfRe01HYiQ4qFZAhVZyc2nwCPAKc9TkpmNzxwoCjHk+xcSVroUO5q73hcYFWAm0T
         mWoW/iLxPKEg8urucctI2tYzcdHmlLm4HLs95wMXo3u4TVjc1JPM0qIdqT11J1RSc+kg
         ZKvpnwGqykHP+YI0rbUqsDwjlzKy0cBx2cSS9NaLgvSxS5YTScMyDqNlVw/dI0XX660Y
         LWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765114226; x=1765719026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyJaX3Br1gUfDH7aDIFFQJYtt7YC2wra38Oz5IMJMOs=;
        b=NuuD5BkxdptFJOKSzCBGgpiBX326IPEImNDG4Hblo3D74Rm5box9N6IFaFclK2X9e7
         7xphxNnIerS2QeTw01zoGHS/hq1wGNLV8I0ccbeYqhSB7yBULpHEOd7R77sFHlwLll9A
         99BlKGk8ziIvjsXHrcM7Wiirz2uHr6DN+LfrFiUqJd9VH4LmcrnUJw21iEab4nMeY6pu
         Sj6Ap0J4w22CC1fccAyjMpQJ6HWSGW+tImpeBg9xAWADP2dbubR5U+4kJ3V6o33SZjBk
         tMvANfQ6pEpj9M0sftH6+Gt3/pliaTDHRbcg5uRESr0fhJSCIgyzDG/mkpb2MRfbHEz+
         YEsw==
X-Forwarded-Encrypted: i=1; AJvYcCVqqxFJVdIXGp7waktCJlqyawP5CVaQrKYTqZAn9MhmYoNmEjzaIOK1UKpRVC6bKrYOsyqwoQGyQ90n0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTDaMmoo3D2oxFAm10BPfCOgSXiV7A2DWADOPwRuKK0Xh/xLc
	QEMFNUIiA7vXvK0Y58ramPVZaLH3FvYjIXUTGPMtiQrizkdkqD/cDey6sSTSHsoniknwSpHPB48
	aJeaQmlg4B/fDxMNFUxm8hTx3PnRpbCA54+bQxFYqfMR4bLMSWNv6TlerpXQKYZeaxua/nFynJs
	GjdMWtQwDFmkWe8NWaGc3diFLuwVYpbiATJXxDAEY=
X-Gm-Gg: ASbGncvWFZyQ93VNeql+OcQaENDqG2cjQiyeLDSUz9ZswndSIMOC4VABuhTcro5YEHG
	0aHUTsjy/VeDhmIUxW0KwjDutCdXMXQfR+rVpUwrtbtO/cQnbbAsVEaZ45j7qXza0JQHlioUrXq
	Q+s45RBWSMcFDR/xTE8P54tHM8xZvw6lrMx9w75cQcBuaa+AgzVuSaynWtKlWMv7/E
X-Received: by 2002:a05:690e:1558:20b0:63e:d1f:d685 with SMTP id 956f58d0204a3-6444e7a7349mr3378294d50.51.1765114225824;
        Sun, 07 Dec 2025 05:30:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsn94jBMoBtCfC8cOMR7Xi5Q38jNQ4OxAQtSaZJowhI0RPQWMyYAHpWjEOclJ1tIBrXif951eLBGPvNrNBnac=
X-Received: by 2002:a05:690e:1558:20b0:63e:d1f:d685 with SMTP id
 956f58d0204a3-6444e7a7349mr3378279d50.51.1765114225448; Sun, 07 Dec 2025
 05:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207122126.3518192-1-zhangshida@kylinos.cn> <20251207122126.3518192-4-zhangshida@kylinos.cn>
In-Reply-To: <20251207122126.3518192-4-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 7 Dec 2025 14:30:14 +0100
X-Gm-Features: AQt7F2prHqWgr_4RxHUQSeBpsi93bplDx1qYL7XLgoYg1x8_8EqR7WBy3ifdzP8
Message-ID: <CAHc6FU5urJotiNOJEC4hyJz8HsNechZm9W07e_-DhgkYJmuDmA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	hsiangkao@linux.alibaba.com, csander@purestorage.com, colyli@fnnas.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 1:22=E2=80=AFPM zhangshida <starzhangzsd@gmail.com> =
wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Andreas point out that multiple completions can race setting
> bi_status.
>
> If __bio_chain_endio() is called concurrently from multiple threads
> accessing the same parent bio, it should use WRITE_ONCE()/READ_ONCE()
> to access parent->bi_status and avoid data races.
>
> On x86 and ARM, these macros compile to the same instruction as a
> normal write, but they may be required on other architectures to
> prevent tearing, and to ensure the compiler does not add or remove
> memory accesses under the assumption that the values are not accessed
> concurrently.
>
> Adopting a cmpxchg approach, as used in other code paths, resolves all
> these issues, as suggested by Christoph.
>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index d236ca35271..8b4b6b4e210 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -314,8 +314,9 @@ static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>         struct bio *parent =3D bio->bi_private;
>
> -       if (bio->bi_status && !parent->bi_status)
> -               parent->bi_status =3D bio->bi_status;
> +       if (bio->bi_status)
> +               cmpxchg(&parent->bi_status, 0, bio->bi_status);
> +
>         bio_put(bio);
>         return parent;
>  }
> --
> 2.34.1
>

I thought you were going to drop this??

Andreas

