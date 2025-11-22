Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477825A642
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797609; cv=none; b=Dpv/fCQBkTAo2LclqNhaWP3NoKM1vhwRDvf/XAojrqFqVykAQkHk/3//1s72BHx+ZwpESCLUSTf5rqpoVZ/6As23SM1Qux99yHUVecz3aX1bBcQ9bseGORLpjGslmp+DVNhH8mTYhAPspQdSq4keQlhl6ADXoUgo9g3OBe+0Lz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797609; c=relaxed/simple;
	bh=Q2I4fYvh4oepaGQS7zTzvtbJbgRyZjD4TiTFO6vRTII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr5uUh0ccdWx+YuHX9q8SHzSt3ZdDqPAelj6ayISiwQeBQk2BkGT/bhfRU6YBW0/w82Vuqc2kH3U0L9G9Ps2C8ypwh40ZXS9OLjWusYa/H+nOhYv9Xe2NZnhE4lanFVnnLtUEqhjP/vhrXa7OrF3D4NehXT8ZAEwOxeMhpRGbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btVQHxpN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jvBE+9Ki; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btVQHxpN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jvBE+9Ki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763797605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzKDrDr19qM8qzMg2r6gHYZungvxwnQDvei/yhzW154=;
	b=btVQHxpNSnXvvHDWf/zdL3mq9DNbbGHXc547awZeTjsutml/uogLt9G2FpIvCXesqcFZK6
	tKAfZA7j/mkNgaiywFrzRtEzLNfln7VjkpGD3oXPBtYmblXbwqKTLqH8/n8sKSC9lxDeva
	33rtHDq61SX2fXorzgoWucC/AhX5h78=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-5kORTRCpPM6YddEW8wJ0vg-1; Sat, 22 Nov 2025 02:46:42 -0500
X-MC-Unique: 5kORTRCpPM6YddEW8wJ0vg-1
X-Mimecast-MFC-AGG-ID: 5kORTRCpPM6YddEW8wJ0vg_1763797601
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63e1cca3558so3234558d50.1
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 23:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763797601; x=1764402401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzKDrDr19qM8qzMg2r6gHYZungvxwnQDvei/yhzW154=;
        b=jvBE+9KiR/qk0BjuwJj0M63YlGTxc+AwlmsBRL4RydplaE2XnAz2oJZXIyKmud4oh9
         V5gHw36tYQaYrV2aN9HmMDnp+fYLSbvr7EgEcvHR+7I87ODi+pikf0jOJnvZcGIbj4ki
         AmLOlqN57QdknXt2jCMMujRawo41qw9qTHDmVASodllliXI0mYh5yyK33iAVokggdI5H
         HsWzlomfPfkbPm2qbN7UrMzip//2zW0wtsJcf9YYqFnWD1K1MhkNv8TeCC4chOiGsP0b
         meqNmQnn7SYCKUfP0gCOSo+u1zS0QDVxFhgmOwfEaJDF+jrgw4oEAq3Upl5cFT3Ik0nj
         maLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763797601; x=1764402401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzKDrDr19qM8qzMg2r6gHYZungvxwnQDvei/yhzW154=;
        b=Tn1rNhxB1xZfieyEiMZcBfVRg/cZpp8pWiVWKBYmBHQnQIk+pW9e7KOJqnsas261tj
         O4AxjoSHLPJWNSF4RRhOF8/Q/+yvUhBhWpxZ30Fm1MADyYV5gdWXywJjYY2RnyO/yyHu
         yjEFzRvn2TyutNC7lWZiwWmocaEaDwSDuAyjs758c4sd6D1TKRupbOzPshMOv/uHkvUV
         rVTwJ0WvVPJFm6sKJxj9OCRK2L9AAi6ryqvkRnsuUOIGs7VIhklspSEQk7HckybJG/Lq
         HSXTYNDM6bXo6Ls3WVuC8Bmik19kxu3uTu593S0S3AW2YFQP9RQ23L2ixGHMqiDP97YN
         8GKA==
X-Forwarded-Encrypted: i=1; AJvYcCW/6FrAam/Kh1bXUhqMqrrYCyVlbbXhjC0WecrfDo3Vqydj5CUTpjNZjiv8V3jRgdEkR3W/0y2L7q391w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzadtlegO6tGRtOVFhRxTQOkR+KirChehf5/CX0wopJ965FzCDe
	vbTJ9YXyhmee322FCwAOiojm4ohvkb2/0Z7bhXJ7XmlXWguiOJUCsl1sFcOU0QnUeDLdMUeelNN
	jTcwKFl9KcYiKU3DBL/s+oV8fPlABnEJ0K1eOxktBGwJo4OySafdzBzJ0yH88nhJvT7tu4nbjCQ
	7NAzvilrMLwF4w2OqLgXwmRnavTAOrCUoeVN6RAwY=
X-Gm-Gg: ASbGncuRS0RJDXp3SOPx5jj8aAienSAk7pTKSagJ9dSBJTQn7gM+8O56RANf5+ESuCc
	V3Jh16nBXxEvB7PQ4+sQpO6LqaTglyuJcUsDOdhfOA/eo8f8Ax4Zmuogo/PF6LSQqwX9mB7LlZZ
	J/+oqMMHGIFzBnm0YYQk6c9Ic8d77snfbn3hNwWK/QqqPHx21oGPfbh6nQ3HUhVC5M
X-Received: by 2002:a05:690c:b98:b0:781:64f:2b1a with SMTP id 00721157ae682-78a8b56828cmr79989307b3.60.1763797600938;
        Fri, 21 Nov 2025 23:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT6ReihqZuKDslp4v6LlKyjNYk5cYZ5oqfMTnv4XvlKobsBj9Saq/UGtRReN9JAQWVmvP6mmp+/fX9V/OmqWs=
X-Received: by 2002:a05:690c:b98:b0:781:64f:2b1a with SMTP id
 00721157ae682-78a8b56828cmr79989177b3.60.1763797600562; Fri, 21 Nov 2025
 23:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
In-Reply-To: <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 22 Nov 2025 08:46:29 +0100
X-Gm-Features: AWmQ_bkNPMPKGc9hcr0WMHGjLmVXZ8Lp-bk_Jm40n6CY0-WAnMeo9R7n5uUvirQ
Message-ID: <CAHc6FU5ofV7s3Q4KBGFJ3gExwsMpbaZ9Vj0FEHqrOreqvQMswQ@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 7:52=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.c=
om> wrote:
> Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8822=E6=97=
=A5=E5=91=A8=E5=85=AD 11:35=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Nov 21, 2025 at 04:17:39PM +0800, zhangshida wrote:
> > > From: Shida Zhang <zhangshida@kylinos.cn>
> > >
> > > Hello everyone,
> > >
> > > We have recently encountered a severe data loss issue on kernel versi=
on 4.19,
> > > and we suspect the same underlying problem may exist in the latest ke=
rnel versions.
> > >
> > > Environment:
> > > *   **Architecture:** arm64
> > > *   **Page Size:** 64KB
> > > *   **Filesystem:** XFS with a 4KB block size
> > >
> > > Scenario:
> > > The issue occurs while running a MySQL instance where one thread appe=
nds data
> > > to a log file, and a separate thread concurrently reads that file to =
perform
> > > CRC checks on its contents.
> > >
> > > Problem Description:
> > > Occasionally, the reading thread detects data corruption. Specificall=
y, it finds
> > > that stale data has been exposed in the middle of the file.
> > >
> > > We have captured four instances of this corruption in our production =
environment.
> > > In each case, we observed a distinct pattern:
> > >     The corruption starts at an offset that aligns with the beginning=
 of an XFS extent.
> > >     The corruption ends at an offset that is aligned to the system's =
`PAGE_SIZE` (64KB in our case).
> > >
> > > Corruption Instances:
> > > 1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
> > > 2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
> > > 3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
> > > 4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)
> > >
> > > After analysis, we believe the root cause is in the handling of chain=
ed bios, specifically
> > > related to out-of-order io completion.
> > >
> > > Consider a bio chain where `bi_remaining` is decremented as each bio =
in the chain completes.
> > > For example,
> > > if a chain consists of three bios (bio1 -> bio2 -> bio3) with
> > > bi_remaining count:
> > > 1->2->2
> >
> > Right.
> >
> > > if the bio completes in the reverse order, there will be a problem.
> > > if bio 3 completes first, it will become:
> > > 1->2->1
> >
> > Yes.
> >
> > > then bio 2 completes:
> > > 1->1->0

Currently, bio_chain_endio() will actually not decrement
__bi_remaining but it will call bio_put(bio 2) and bio_endio(parent),
which will lead to 1->2->0. And when bio 1 completes, bio 2 won't
exist anymore.

> > No, it is supposed to be 1->1->1.
> >
> > When bio 1 completes, it will become 0->0->0
> >
> > bio3's `__bi_remaining` won't drop to zero until bio2's reaches
> > zero, and bio2 won't be done until bio1 is ended.
> >
> > Please look at bio_endio():
> >
> > void bio_endio(struct bio *bio)
> > {
> > again:
> >         if (!bio_remaining_done(bio))
> >                 return;
> >         ...
> >         if (bio->bi_end_io =3D=3D bio_chain_endio) {
> >                 bio =3D __bio_chain_endio(bio);
> >         goto again;
> >         }
> >         ...
> > }
> >
>
> Exactly, bio_endio handle the process perfectly, but it seems to forget
> to check if the very first  `__bi_remaining` drops to zero and proceeds t=
o
> the next bio:
> -----
> static struct bio *__bio_chain_endio(struct bio *bio)
> {
>         struct bio *parent =3D bio->bi_private;
>
>         if (bio->bi_status && !parent->bi_status)
>                 parent->bi_status =3D bio->bi_status;
>         bio_put(bio);
>         return parent;
> }
>
> static void bio_chain_endio(struct bio *bio)
> {
>         bio_endio(__bio_chain_endio(bio));
> }
> ----

This bug could be fixed as follows:

 static void bio_chain_endio(struct bio *bio)
 {
+        if (!bio_remaining_done(bio))
+                return;
         bio_endio(__bio_chain_endio(bio));
 }

but bio_endio() already does all that, so bio_chain_endio() might just
as well just call bio_endio(bio) instead.

Thanks,
Andreas

