Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CCC233724
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405281; cv=none; b=acch0grHd1jKbK9+4idY9Is4P0g9G9WJn8wQla4X+H8wh4x9X7B4WXZqFT5/hFt4dlC2FS31HDnpsXPv2c9BvvjYdObqxQRF6amYERiknvNUNPVKRXLdyOtHJ5m5j5VEhNHURnToJvwemMSXJQOKKowGIqSz9KHjcFa/URt9AZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405281; c=relaxed/simple;
	bh=GtPw08BlWWEuEkoFTOw0O+DygG26EN3QHGDgCeLNVkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eN8v4rW0yGfJ/+yfYL/6KkHuIPjPCEWuxovCp0n9YrxHeS1WTJlu8AH6Crk0s8qHBud42l3XpAcx+JKE+Nt1ZLH84jnnQK7duR/LjSzd3/oO7M1FrqpSasF6tfjkDTfy1lmYRB81o8G0uNbXTH7xY4uH8qJYklctVwqdmxNxUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvuD3aFY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvuD3aFY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740405278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULX4w1uAU3ZlWh8iw+YD6YOfd6ymfd3DDuNiwZiMSKU=;
	b=hvuD3aFYI28s4ErTKsGCJ0TY8Zwb94+iCh5c9KwCAv3XVMuqlDeXDUhz4RRMjC6ZPOXn8d
	dPJVZ6xbUVVHoMhiCpOsoXXApGNFw6Y0f2Pegca8XxBQGzkcGz3ffCyrOU8t/MWdCRXGPZ
	6nLAaz8QUt+KzyBKrE5p5/mJ+87iKh8=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-6EjegkSHPDiq1ZfTKSx77A-1; Mon, 24 Feb 2025 08:54:36 -0500
X-MC-Unique: 6EjegkSHPDiq1ZfTKSx77A-1
X-Mimecast-MFC-AGG-ID: 6EjegkSHPDiq1ZfTKSx77A_1740405275
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4be5253cdbeso766416137.2
        for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 05:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740405275; x=1741010075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULX4w1uAU3ZlWh8iw+YD6YOfd6ymfd3DDuNiwZiMSKU=;
        b=YbiN7fLQ3dfhJIdazk4c7GfKpEAfHR9qgoiRkVOw5HnRn8GLIlHH0t1zwOSIlj57+a
         JHaVtRZcUGRunay7j/xwfLhSs65TIm4AhirO4mYkp9CFQVF0bfe5JbiZoZDS35QQkptz
         LauG8Rpr0IjdJJejy0VxQgFWhpo0fxb4suKnVOv6aDln2aAxWgIn+rmNbM7xCyJJuQDi
         yhjbA7DMI34N6MUFwn7Rdedy2RA9kHteyXCXLgYZCmklng710Hpw0b3hI6TjGuM4V1Va
         Nu/IwRfMzJEHvnNHyX2rdhILpQ47ktw1qjo5VcbfdPSJYjgluuRKVjj7xI21k0eOO5aj
         SspQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEr9c4ajA/iVKCQfoX/S8pZ4/VriK+MwjenHtnj1ubFgIdPxM1dsPHLJw0OKZEpPyCUVlAQOCUnS8U2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5AQTR0XGvcjW6p3qiz1taDUN4AmWe2++rWUOE37UgoByIn1h
	1Z4KxS043OsF2gTkgdxDBUlYJQd3nxJNpIpF8yKFtuifls8r+XWUN+KmDpcsxFooTnBTunIhyzN
	POSPOhBSAN4R2YyjspkgJJL864FQcu6qb4dBAaAoQ/xDES38aqbY2Q3KoRRUogTVNwTc7RZ5iZo
	XTLaF3PoeER3K8enm+mAnybyqScJNG14yHClM=
X-Gm-Gg: ASbGnctf369k4UzRv91Cf1EedErc0RI2gH2TUz2RY3P12113SH5YQvqdvUKlb0ru45o
	QpiFOV6l7Y08j/ckOwWpIjT7QZhSD5o3EbL5ph1e9r9NgMQ8gLrlNSya1CntxYLMarUo/A/2MbQ
	==
X-Received: by 2002:a05:6102:3711:b0:4bb:e14a:944b with SMTP id ada2fe7eead31-4bfc023cc30mr5079561137.20.1740405275422;
        Mon, 24 Feb 2025 05:54:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5de19xekJKazZ6nOYhT1xxSdlWeDd4SZ3AxqCurIG09OkMXItodCUs2gQblPNYKbzt7R1g4cye3hB6Gnvse8=
X-Received: by 2002:a05:6102:3711:b0:4bb:e14a:944b with SMTP id
 ada2fe7eead31-4bfc023cc30mr5079554137.20.1740405275184; Mon, 24 Feb 2025
 05:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224095945.1994997-1-ming.lei@redhat.com> <94ad8a55-97a7-d75a-7cfd-08cbce159bed@huaweicloud.com>
In-Reply-To: <94ad8a55-97a7-d75a-7cfd-08cbce159bed@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 24 Feb 2025 21:54:23 +0800
X-Gm-Features: AWEUYZmoqL8VL9tKfbh5FLVW0-AuELofjAU8BkYrfwdCOVjzOHE8uq0eaUL3XMk
Message-ID: <CAFj5m9KZqaVb_ZGgtdHxNxpuccuBcAVxcYOxaTGkuvuAQSf5Xw@mail.gmail.com>
Subject: Re: [PATCH] tests/throtl: add a new test 006
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, linux-block@vger.kernel.org, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:26=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2025/02/24 17:59, Ming Lei =E5=86=99=E9=81=93:
> > Add test for covering prioritized meta IO when throttling, regression
> > test for commit 29390bb5661d ("blk-throttle: support prioritized proces=
sing
> > of metadata").
> >
> > Cc: Yu Kuai <yukuai1@huaweicloud.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   tests/throtl/006     | 58 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   tests/throtl/006.out |  4 +++
> >   tests/throtl/rc      | 19 +++++++++++++++
> >   3 files changed, 81 insertions(+)
> >   create mode 100755 tests/throtl/006
> >   create mode 100644 tests/throtl/006.out
> >
> > diff --git a/tests/throtl/006 b/tests/throtl/006
> > new file mode 100755
> > index 0000000..4baadaf
> > --- /dev/null
> > +++ b/tests/throtl/006
> > @@ -0,0 +1,58 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2025 Ming Lei
> > +#
> > +# Test prioritized meta IO when IO throttling, regression test for
> > +# commit 29390bb5661d ("blk-throttle: support prioritized processing o=
f metadata")
> > +
> > +. tests/throtl/rc
> > +
> > +DESCRIPTION=3D"test if meta IO has higher priority than data IO"
> > +QUICK=3D1
> > +
> > +requires() {
> > +     _have_program mkfs.ext4
> > +}
> > +
> > +test_meta_io() {
> > +     local path=3D"$1"
> > +     local start_time
> > +     local end_time
> > +     local elapsed
> > +
> > +     start_time=3D$(date +%s.%N)
> > +     mkdir "${path}"/xxx
> > +     touch "${path}"/xxx/1
> > +     sync "${path}"/xxx
> > +
> > +     end_time=3D$(date +%s.%N)
> > +     elapsed=3D$(echo "$end_time - $start_time" | bc)
> > +     printf "%.0f\n" "$elapsed"
> > +}
> > +
> > +test() {
> > +     echo "Running ${TEST_NAME}"
> > +
> > +     if ! _set_up_throtl memory_backed=3D1; then
> > +             return 1;
> > +     fi
> > +
> > +     mkdir -p "${TMPDIR}/mnt"
> > +     mkfs.ext4 -E lazy_itable_init=3D0,lazy_journal_init=3D0 -F "/dev/=
${THROTL_DEV}" >> "$FULL" 2>&1
> > +     mount "/dev/${THROTL_DEV}" "${TMPDIR}/mnt" >> "$FULL" 2>&1
> > +
> > +     _throtl_set_limits wbps=3D$((1024 * 1024))
> > +     {
> > +             echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
> > +             _throtl_issue_fs_io  "${TMPDIR}/mnt/test.img" write 64K 6=
4 &
> > +             sleep 2
> > +             test_meta_io "${TMPDIR}/mnt"
>
> Do you run this test without the kernel patch? If I remembered
> correctly, ext4 issue the meta IO from jbd2 by default, which is from
> root cgroup, and root cgroup can only throttled from cgroup v1.

It passes on v6.14-rc1, does META/SWAP IO only route from cgroup v1?

  static inline bool bio_issue_as_root_blkg(struct bio *bio)
  {
          return (bio->bi_opf & (REQ_META | REQ_SWAP)) !=3D 0;
  }

Thanks,
Ming

