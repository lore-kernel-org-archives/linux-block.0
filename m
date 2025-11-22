Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD527FD7C
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763793802; cv=none; b=d5IqiQT+cR80dARlVO6Tb68siUyijU2q1V9CUToIKfbB3cPefpk5/rHFS0m1Y2dpcghem5GjHMFq5316FjRHQR2YmUGRzW/PKSuNHz9z2PGY4ftsH214Bt8pu5iOwVF3joe9ZhdLorc7/04bhpIlnFkQmYQkbm9KrM42E26dJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763793802; c=relaxed/simple;
	bh=Y+DjqwAoCGZ7OJzLzIWqwIR/VPRlxdq59cBm2nqE3Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By5UMPjgJEqVFZgAqrjH0WPpU7NN4Cma0hwe1yj9ll/lp+wVNeGbN/wYaoSk053GKI+H3hQ1SxLKI9vf+wlSMiGdvC+YuZcyEvBFKNmAuJty0Y/a25Hf4prXuEch/w/tyV4yTPiv2l+dv+DBQSbSXOhie2LoFbY1qREilQoIr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS+x0QE2; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS+x0QE2"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee328b8e38so24835311cf.0
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 22:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763793799; x=1764398599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7QJI36T3DDFp93Xllsfs+3f9Tem0cMaXaPpBr1xsGU=;
        b=aS+x0QE2jGCbKUld/ea2AI0BIqXlmlTXMhG4gdtWd8IWXG5bDvUwncCmxUu6phD8U4
         Y1/z7pFwufgATBuGktZRyMfKRyQb+aHsazdLbOHlYI+x0QTEI7l4iy9C/n5HoteafJ5n
         wWwTuCy1zT1jVoLwQ+eoDvNsm6q145LG7NYGj8uaI/E8Sj3C5hpTtex6j7lKqRMALE0x
         Xk0/LHAt2KUt2KtoIZ8E2Wls/Y6jXlE/eJWhHU58ek3lsb/cknkOF9rMLGQzkmnQQIsD
         KxC/2jxdKSeslceXcDpZOd6QINCX3efHj3GecN7l1gAyWaWFi1vyLitn9nsbWAiADT6M
         Brlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763793799; x=1764398599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n7QJI36T3DDFp93Xllsfs+3f9Tem0cMaXaPpBr1xsGU=;
        b=K0tWUGBIVDQq+owE+4u1V1cNvXP6De3FrkYQyNfFljiw+eZ7AQaAe2U0oQJGS+JAiB
         NkbmvLxPacz/wyjJqTw4QsP2T/ExDb2e0lpnBK29uIUW2GOJUyu37lQ9gZbN6PocyRH3
         sHaKEcJbp6TavH3V8U6U67xNULVnn42q9FO4Q1l+Jh/+TIVRqOqAzxg+V1v6CenXJTFc
         PF8faMzSZRsEvlg6gBhLfj/4CSgL6PjNOxxgelOoqTXz2b8SKZGXOiq+TbY7JKo9TeoG
         ISEFhJ6bAp0V5RKUCjciUj6Fom51Y7NgWtK333GEygY7bddcAJ5xs7CuKl+uUBXAAqIm
         1OwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKTrhQ0mZvfBEocZvvMBPE7lmGoRIwhhZ4UXfK6Pf/13hvdUIsv/4OHpbk6h/digmGXqTWGlHsglhhSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPy3OB8OzbXhvZsuXDuuW2njW0Y+RzNBxrmzNDf6NAxuOjHPQ
	aZ8P1dYfhBadEQGq2iMD+2J0mLjUgWxaToNSNbjw2yPxTCEQtvVainXT+jsX1hYY7F8NGLdoBT0
	GNHfWR5Wy9E/eH9szFWlMneAr+v6XY9w=
X-Gm-Gg: ASbGncuKybMyrrwaZKzircWt3zm8lNnD+sB0Xq6VVge2pBy4ShxZBNOgvZojqgRORPU
	aFTBoKD/FN+McIK36/kOEbvW3oeJLo9l1hd9nXrw+dRf/2wurr85YOfh5C7q5BA+k58Itkkk4/r
	tKBTjkpTIAjJBI1RJ9nNR8JO/VVRbomifrzO08SlrFQe5DK3HYel3lUzKHRldoHr00j5x8jmDBJ
	+quH1+mhk6BqWfxOLj3f5Gkz3NsmJmI8AZoMqfzL7rzgjdHAwqoKIOJzHU8YuBLno8IVZg=
X-Google-Smtp-Source: AGHT+IFYY0hB1AT6+W29RBnT+t78nVJtbCkr0AJ7fjgv+YE4gLfc5ZYb5TuO0P1olfjrCgZ/JHFnyc+OtjdZpbL7HYc=
X-Received: by 2002:a05:622a:653:b0:4ee:1301:ebaa with SMTP id
 d75a77b69052e-4ee5888fd9fmr61705651cf.54.1763793799235; Fri, 21 Nov 2025
 22:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn> <aSEvg8z9qxSwJmZn@fedora>
In-Reply-To: <aSEvg8z9qxSwJmZn@fedora>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 14:42:43 +0800
X-Gm-Features: AWmQ_bntN_rMHyZMaZTesMCRvMp7VgMi9_ZfkRlzVtT_jBUQrddcI4xac8nvuc0
Message-ID: <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=85=AD 11:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 21, 2025 at 04:17:39PM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Hello everyone,
> >
> > We have recently encountered a severe data loss issue on kernel version=
 4.19,
> > and we suspect the same underlying problem may exist in the latest kern=
el versions.
> >
> > Environment:
> > *   **Architecture:** arm64
> > *   **Page Size:** 64KB
> > *   **Filesystem:** XFS with a 4KB block size
> >
> > Scenario:
> > The issue occurs while running a MySQL instance where one thread append=
s data
> > to a log file, and a separate thread concurrently reads that file to pe=
rform
> > CRC checks on its contents.
> >
> > Problem Description:
> > Occasionally, the reading thread detects data corruption. Specifically,=
 it finds
> > that stale data has been exposed in the middle of the file.
> >
> > We have captured four instances of this corruption in our production en=
vironment.
> > In each case, we observed a distinct pattern:
> >     The corruption starts at an offset that aligns with the beginning o=
f an XFS extent.
> >     The corruption ends at an offset that is aligned to the system's `P=
AGE_SIZE` (64KB in our case).
> >
> > Corruption Instances:
> > 1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
> > 2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
> > 3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
> > 4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)
> >
> > After analysis, we believe the root cause is in the handling of chained=
 bios, specifically
> > related to out-of-order io completion.
> >
> > Consider a bio chain where `bi_remaining` is decremented as each bio in=
 the chain completes.
> > For example,
> > if a chain consists of three bios (bio1 -> bio2 -> bio3) with
> > bi_remaining count:
> > 1->2->2
>
> Right.
>
> > if the bio completes in the reverse order, there will be a problem.
> > if bio 3 completes first, it will become:
> > 1->2->1
>
> Yes.
>
> > then bio 2 completes:
> > 1->1->0
>
> No, it is supposed to be 1->1->1.
>
> When bio 1 completes, it will become 0->0->0
>
> bio3's `__bi_remaining` won't drop to zero until bio2's reaches
> zero, and bio2 won't be done until bio1 is ended.
>
> Please look at bio_endio():
>
> void bio_endio(struct bio *bio)
> {
> again:
>         if (!bio_remaining_done(bio))
>                 return;
>         ...
>         if (bio->bi_end_io =3D=3D bio_chain_endio) {
>                 bio =3D __bio_chain_endio(bio);
>         goto again;
>         }
>         ...
> }
>

Exactly, bio_endio handle the process perfectly, but it seems to forget
to check if the very first  `__bi_remaining` drops to zero and proceeds to
the next bio:
-----
static struct bio *__bio_chain_endio(struct bio *bio)
{
        struct bio *parent =3D bio->bi_private;

        if (bio->bi_status && !parent->bi_status)
                parent->bi_status =3D bio->bi_status;
        bio_put(bio);
        return parent;
}

static void bio_chain_endio(struct bio *bio)
{
        bio_endio(__bio_chain_endio(bio));
}
----


Thanks,
Shida

>
> Thanks,
> Ming
>
