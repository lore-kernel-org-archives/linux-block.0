Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C6313E30
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590194; cv=pass; b=Hxx9yvaICbR/QOgfYntjs8mASYOcSeKIHUc9LZIJid6E9TUQDGmkTgHK+WL70lKlMMHQwEGbFwMxMYeGSyDdzbv/I+LvqncA4nqya76nPTbrVsATtgDv+kO2Aorj380Hr838u4X9Lahbn37HkMp0oEt2MkfDFLr2FZrvx+UO7Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590194; c=relaxed/simple;
	bh=Yqit0RXhZE5LjaMLr7gSNOceIXw5KXawIr2+vgeTo9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3di9CKYtFcyIlVHz0XPUY1yrwttqRZf1KTzFhMx5ppO+nzGOt/tr27fL77XmZZY/RMrQwMRrtaShxwBhltzHucf6JEOh9yXHlBWmOOeNhae91xNw1GvWBwT/aXghp+GH5/mbgdUDs2ZsuPuKuWcYhOvgYTGQqOUl+UdAUuJw5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GSUP2Uuk; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GSUP2Uuk"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbcb45153cso480199a34.3
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 12:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775590191; cv=none;
        d=google.com; s=arc-20240605;
        b=O9q1n2/v6lsWkkY35V7TZG77URhxHmB4XG0lF0oHLjqaksVd/YTskSowalEXYKNx8P
         20cWjWpOHWkxAfdyO6/JcczTfHf8ZwjsVBqii7AsF+REst3GGKSrv6ezviZbs+hIn+il
         zfkaGjo1NpCrPb7JlKDX6mlJK+cJWpiME1rvisnNhLtJ1Os3UMw591V7ZcBrXC/cMT2Y
         2h/b9XJTYFMsynieh4UpQNXgAW/7LuWOpek9Ha6JWWCYawj9kWj5jQyQINGJOI3RDln7
         Wz7FlJbvDzY6/mFifyF6Nu5iTE/FKn9wQtz7yECIzkkjXvdVfdVSehg5vaxF2BD7oGRl
         mKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WxldJiP4yQjqWDnxZQT4yStOG9EQDLSCYz3bIdj2fME=;
        fh=KBZKO8W9Y0Qfj5lvobCVNhHamNe6ZJfaftWijHUUjQM=;
        b=OTFhTP9ZQzZBq8Fz3UlkEwVXvIe84nqH2RdWubrHhijSEbp+pQL82yAjTOgNpda4Ie
         qIgUmULyqDvSwh7TP2j+8QA8JN9aSQZ6XEcZZa33bNOQLqeXshzWGk5Q7ObyIPaBuO2m
         Fo6OOaTb7Nsrf/ejFllHoHIS3k3CuAcodjrW3u0yDVcZ2jtmZ2Ym6zv/32EtcmaENpq5
         QUv+eZzAAkzoWPBEEGC3afD6+cpQoqu4SVT3fSHwWlwnB5EHQGurR/MwDYt4Si2GjP79
         G5iZXe8HvnkKnUbjJIJ9Bqv8sqoqEKovxkrsCMk/4R8REZt31myXe1Ux3hnXBIzUa7K4
         pbBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775590191; x=1776194991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxldJiP4yQjqWDnxZQT4yStOG9EQDLSCYz3bIdj2fME=;
        b=GSUP2UukT7bv/wNCUO4p5/bP1GR1y1JO502EzqSXBfkf+kQ1JV+iox9ofW6DVZ0q8s
         NDG12hiiSqLr0/yBqaUhe52Ad4z0Zu3jkP47GK2emM+Ut5qPvFSW2whkbUu2Ny2oeZIE
         Nzk5cX53RBNFpYYupdCHH2/T0KmHkeVj+yhuUrEkOU38LY2M/OhYUT0WVGUVijZ2H5dC
         RCwA2gEm7t41hB8J23DxC4kQLlOSgN+78BszSK3Umfxk6XQVv8rCR8MDEb3kyp3btdUj
         yExTQ9LI8uu+xU1XYFkr6I7OlsqR32oNoj3O8mwFZENg3tleVuMxbZTnQ0n12Xlg9/ED
         K3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775590191; x=1776194991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WxldJiP4yQjqWDnxZQT4yStOG9EQDLSCYz3bIdj2fME=;
        b=SQ6pAk7FKUYq1GVTxnFJ+T5/8txOSrpw8uZGSy0v8C42ydeDrGjC8qwmY8idRlLnwJ
         pDO4ka/ItJTE3vuJT5/GVkF4C+s7Dk3DKU+n8bDmqgt+zJVvDynI3SJT8HkdMaSFPQ2z
         JC70SjGazlEKkgjcGztaXqswUhg/U7uF5iFx0eWLARyR2IN3d7noypAzTqm6Ziis3kFX
         pCtDZnNLLbYmIkhSwqc8ROkmgrRxR/5pRquzHxQq1cc/jYxkoV59pBy/Rts+ekP5NV8k
         9mCgb7C0wkaQTBJioruueWJsqDaZwyz2o+xGk+Wq/gOfoE4qJBrTAuywuO1j4x3yZeNG
         qqRg==
X-Forwarded-Encrypted: i=1; AJvYcCXy44GcKYcys/yfLd9SP9qXgekLk+mQW0POxyjvnoOWuJe+wWn0Gb7YWG5OjK5IKoU38x9ZoVDXPI5fcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8dzdIexniQX8pIVPggHwyFXGyhvOUWlobsxa0jt0vlaNk5/V
	POGFGNMAWIf47dnvy5nb4/lOVcqpubxjiLdIjFsqLShBna1yiIg9LSwtF1x936jLFu90wFqDFin
	g8IO6V0XFWEZ/Wc3PZgLnsS/Kf0yIwobNTJEdHuu5fQ==
X-Gm-Gg: AeBDievOLmPGdYJM2wmDyvwuskLtyOAAB2GDcBJUlHmnjiJ+yTIXgcWxP/zBg2OSMLz
	6XGXXm5ch0vRJWx0+3NERXce9bS0ASG5ZiviixZqVTIcMdykNSLq7pqx0XbBeeird5H54uJhZSC
	IBT7Xso8XJkYK5BXOSOhRxp81RSKy6nZSVJzqo2UVoP3B5EuexqzPWNQSpiVTFo4r31oVU3dPfv
	QhVykOxuM79YfRL42U6QWBidRNmGvID9QKRDoaMdV4cw6O499bNf7nmvuV8xqQm422j6xOsVnmQ
	ZG/AmE8U
X-Received: by 2002:a05:6830:4429:b0:7db:c7f6:e6ef with SMTP id
 46e09a7af769-7dbc7f6eb40mr8498525a34.6.1775590191102; Tue, 07 Apr 2026
 12:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153207.3635125-1-ming.lei@redhat.com> <adRuN7V2KDbTJLqd@fedora>
In-Reply-To: <adRuN7V2KDbTJLqd@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 7 Apr 2026 12:29:39 -0700
X-Gm-Features: AQROBzDOQ2nUILN6uxhyAW_ImMdGytaF777TEp8wcR-n0cSoYRbEyZk3gSFUYTM
Message-ID: <CADUfDZoGGUcZ1_ifsXrh_8uy-7DVH30xrbaA+sH8ftwYxB-0Hw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] ublk: add shared memory zero-copy support
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 7:39=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Tue, Mar 31, 2026 at 11:31:51PM +0800, Ming Lei wrote:
> > Hello,
> >
> > Add shared memory based zero-copy (UBLK_F_SHMEM_ZC) support for ublk.
> >
> > The ublk server and its client share a memory region (e.g. memfd or
> > hugetlbfs file) via MAP_SHARED mmap. The server registers this region
> > with the kernel via UBLK_U_CMD_REG_BUF, which pins the pages and
> > builds a PFN maple tree. When I/O arrives, the driver looks up bio
> > pages in the maple tree =E2=80=94 if they match registered buffer pages=
, the
> > data is used directly without copying.
> >
> > Please see details on document added in patch 3.
> >
> > Patches 1-4 implement the kernel side:
> >  - buffer register/unregister control commands with PFN coalescing,
> >    including read-only buffer support (UBLK_SHMEM_BUF_READ_ONLY)
> >  - PFN-based matching in the I/O path, with enforcement that read-only
> >    buffers reject non-WRITE requests
> >  - UBLK_F_SHMEM_ZC feature flag
> >  - eliminate permanent pages[] array from struct ublk_buf; the maple
> >    tree already stores PFN ranges, so pages[] becomes temporary
> >
> > Patches 5-10 add kublk (selftest server) support and tests:
> >  - hugetlbfs buffer sharing (both kublk and fio mmap the same file)
> >  - null target and loop target tests with fio verify
> >  - filesystem-level test (ext4 on ublk, fio verify on a file)
> >  - read-only buffer registration test (--rdonly_shmem_buf)
> >
> > Changes since V1:
> >  - rename struct ublk_buf_reg to struct ublk_shmem_buf_reg, add __u32
> >    flags field for extensibility, narrow __u64 len to __u32 (max 4GB
> >    per UBLK_SHMEM_ZC_OFF_MASK), remove __u32 reserved (patch 1)
> >  - add UBLK_SHMEM_BUF_READ_ONLY flag: pin pages without FOLL_WRITE,
> >    enabling registration of write-sealed memfd buffers (patch 1)
> >  - use backward-compatible struct reading: memset zero + copy
> >    min(header->len, sizeof(struct)) (patch 1)
> >  - reorder struct ublk_buf_range fields for better packing (16 bytes
> >    vs 24 bytes), change buf_index to unsigned short, add unsigned short
> >    flags to store per-range read-only state (patch 1)
> >  - enforce read-only buffer semantics in ublk_try_buf_match(): reject
> >    non-WRITE requests on read-only buffers since READ I/O needs to
> >    write data into the buffer (patch 2)
> >  - narrow struct ublk_buf::nr_pages to unsigned int, narrow struct
> >    ublk_buf_range::base_offset to unsigned int (patch 1)
> >  - add new patch 4: eliminate permanent pages[] array from struct
> >    ublk_buf =E2=80=94 recover struct page pointers via pfn_to_page() fr=
om the
> >    maple tree during unregistration, saving 2MB per 1GB buffer
> >  - add UBLK_F_SHMEM_ZC to feat_map in kublk (patch 5)
> >  - add new patch 10: read-only buffer registration selftest with
> >    --rdonly_shmem_buf option on null target + hugetlbfs
>
> Hello,
>
> Ping...

Sorry I didn't get a chance to look at this earlier. It looks really
nice, thank you for implementing it! I have just a few comments. One
is about the UAPI (can we just use virtual addresses instead of buffer
index + offset), so I might wait on landing this patchset until we've
finalized that.

Thanks,
Caleb
