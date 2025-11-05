Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44812641FB
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357075; cv=none; b=PVULa69nFSdRFG9ftX6Wdpky1OfXY4alyHVMAtrFeuU4xCiCO9cWVknketYLOya++q94XOx+0of4Z8MR5OscH+VjDNodAeixmFbueeqwmnMtN4waFdUe5ja7YRf34mdCQ+fv+2u64gzwklnUTIohhanyTyLdSFnV7eJ+KC7s+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357075; c=relaxed/simple;
	bh=Hrtwr+OvIPoqONQSZPSg43U6tcdzazTxhomZ6ZCqZhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEsn8iWU3e2EuCluBWnod9BKmRWoGmVPzlNAZShZmOQUp55eMI6AcgzoCUrWa6UjzCeDxpPllBMxx6r/adt3WnO6I/RtPm11Gc3R2ZbFGEWYzD/WFGMFjFnMxcktKtqN+e6/JKvDbQVs3MD2AUs54Pg+snfPxvnlwkGuxGA8REg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A8TEWHZe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A8TEWHZe"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295351ad2f5so5276865ad.3
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 07:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762357072; x=1762961872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z98l80RASzMLq3W9xClOY4agvDKw8ZVI+GsRz5Frd3k=;
        b=A8TEWHZeincZ9dGvXfjDdFsV7Nj9DsGDk6PO6V6A7RNFs551J9s/F3GZs0/6IUjoDg
         0EMRvrLX5kkgplBWrT1bZFZc8RKgr+NjZKNJE94MIOM8PRBRNjSIA37sRQGpKfke4B2/
         +IleLuPAKpFE60ulE191Qhbww1rM1ORDrc0+59aZxxzY89qPE2VaayBrZiBCZ281K5Ql
         K/coGERtCXxTFIhBurg0HbVHSk5os3oknv1McRHfhbO8N/q1RiE30acg2ExJ69iV3cKp
         SdJKXF/JZ+vLb2JV6nLrnCSRnvyQlDGTiCcbwbbUEWw6qbxe9EzRubaIHkDg1aqP9jdv
         zwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357072; x=1762961872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z98l80RASzMLq3W9xClOY4agvDKw8ZVI+GsRz5Frd3k=;
        b=bSMHIQyP/GNQ0cCWDmG+XS2UGaRY7PIKeHiFVkjhQouN/rJ3uTgCC4MuvdOUHtExfG
         PfXYU/IWIHpvmiYqHYnQYe6HmppCorsc0iNXtZxAcrwfOcZbk4mgLmUGnxsBzeuee9vt
         QNoWLx87IDKVb1Z7qH9P/XxTAbi1oIGw++BYwT2Usf4sUTq4jOhGurxuK7zz5HODc55R
         vai4wlXizjVux0+tBPR9NeA4VX45KC2W1SULosiMdYhubR3HexcVWlHAgI9hjdyQ7bzT
         vjJQYoOUArBMugVxTecuo7Eb9VAqAe9z8DZNsVmBfPw6tBiL1f79FBPIicLY9MhLVkAq
         4Cgg==
X-Forwarded-Encrypted: i=1; AJvYcCUR/zduH+bbVA0GtGcd+D6l9UJ+ihBCdsVZNqlCQFp4IIluU6O8IIOFeUiu6mKDtFl2qIMKhvdjh/1ZDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGPv2rClPyt/W0Ahg10RKCAs+0p377IsalXxGzbuNj5prY7mX
	r18pS+R9BvjSETWfdD5QlT15iHg5u0pAe+tn3OI1AwHeHyYTyIfKgOsP5pZOyvPv3/tZK7L5dYf
	SzAkcxGnEy9Yqb3nQ7pdvA/vcnClpex0dgahNHXgZ1Q==
X-Gm-Gg: ASbGncvo5cx3vFfJGm/oWSA/cZLu2RU9irU5/gEm6lrwRhCJE2IYDr12bdxKAq1ZG8P
	dPmVaQs4HV2zdWAsJgw5lv+6dsRz/MSKCxozVNRZfSZcVJGaUcZl1pjkKmAL/GK854uoev3OAxQ
	GiLkjW5dpeW/bNL7OVbdOleEHk8rx9qPuzWQ/ZfOFLRX456m7YWwpfK8mW8tgb+XQ6PwiIVIpHJ
	ITLNB9JsRaCH+N9GACa7I0cZVpFLem8pC9Qdw1HXEtw4gDOqJ8CR7YfelbWCw8CU/YrRIxUN1FJ
	jql38/e5QTYHCgYZ5Oo5oZgODhrIdA==
X-Google-Smtp-Source: AGHT+IGKSPTPtsfyzUQ7CTT+3b9yrZZRx+i0pNBy0TWzb3nNrWkAuCXmFZaWGRT+4HWX3HpJwN9RBOKFdQsgiFcvGVU=
X-Received: by 2002:a17:902:ecce:b0:295:ac6f:c891 with SMTP id
 d9443c01a7336-2962adaf9e8mr32333525ad.2.1762357071851; Wed, 05 Nov 2025
 07:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora> <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
 <aQVAVBGM7inQUa7z@fedora> <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
 <aQqs2TlXU0UYlsuy@fedora> <34e94983-3828-469b-bb87-6a08061c101a@kernel.dk>
In-Reply-To: <34e94983-3828-469b-bb87-6a08061c101a@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 5 Nov 2025 07:37:40 -0800
X-Gm-Features: AWmQ_bmiZXqpzQreXjGPIYwlUfbRst6wBvAJte0heP6tR1fvcJrjKWQSSP9puu4
Message-ID: <CADUfDZrY7v93aDtZbD4-qKAaJHcGUbWTQinEVRG4Tiiy6m2BFA@mail.gmail.com>
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:26=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/4/25 6:48 PM, Ming Lei wrote:
> > On Mon, Nov 03, 2025 at 08:40:30AM -0800, Caleb Sander Mateos wrote:
> >> On Fri, Oct 31, 2025 at 4:04?PM Ming Lei <ming.lei@redhat.com> wrote:
> >>>
> >>> On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote:
> >>>> On Thu, Oct 30, 2025 at 8:45?PM Ming Lei <ming.lei@redhat.com> wrote=
:
> >>>>>
> >>>>> On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote=
:
> >>>>>> ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> >>>>>> iov_iter_get_pages2() to extract the pages from the iov_iter and
> >>>>>> memcpy()s between the bvec_iter and the iov_iter's pages one at a =
time.
> >>>>>> Switch to using copy_to_iter()/copy_from_iter() instead. This avoi=
ds the
> >>>>>> user page reference count increments and decrements and needing to=
 split
> >>>>>> the memcpy() at user page boundaries. It also simplifies the code
> >>>>>> considerably.
> >>>>>>
> >>>>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> >>>>>> ---
> >>>>>>  drivers/block/ublk_drv.c | 62 +++++++++--------------------------=
-----
> >>>>>>  1 file changed, 14 insertions(+), 48 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >>>>>> index 0c74a41a6753..852350e639d6 100644
> >>>>>> --- a/drivers/block/ublk_drv.c
> >>>>>> +++ b/drivers/block/ublk_drv.c
> >>>>>> @@ -912,58 +912,47 @@ static const struct block_device_operations =
ub_fops =3D {
> >>>>>>       .open =3D         ublk_open,
> >>>>>>       .free_disk =3D    ublk_free_disk,
> >>>>>>       .report_zones =3D ublk_report_zones,
> >>>>>>  };
> >>>>>>
> >>>>>> -#define UBLK_MAX_PIN_PAGES   32
> >>>>>> -
> >>>>>>  struct ublk_io_iter {
> >>>>>> -     struct page *pages[UBLK_MAX_PIN_PAGES];
> >>>>>>       struct bio *bio;
> >>>>>>       struct bvec_iter iter;
> >>>>>>  };
> >>>>>
> >>>>> ->pages[] is actually for pinning user io pages in batch, so killin=
g it may cause
> >>>>> perf drop.
> >>>>
> >>>> As far as I can tell, copy_to_iter()/copy_from_iter() avoids the pag=
e
> >>>> pinning entirely. It calls copy_to_user_iter() for each contiguous
> >>>> user address range:
> >>>>
> >>>> size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter=
 *i)
> >>>> {
> >>>>         if (WARN_ON_ONCE(i->data_source))
> >>>>                 return 0;
> >>>>         if (user_backed_iter(i))
> >>>>                 might_fault();
> >>>>         return iterate_and_advance(i, bytes, (void *)addr,
> >>>>                                    copy_to_user_iter, memcpy_to_iter=
);
> >>>> }
> >>>>
> >>>> Which just checks that the address range doesn't include any kernel
> >>>> addresses and then memcpy()s directly via the userspace virtual
> >>>> addresses:
> >>>>
> >>>> static __always_inline
> >>>> size_t copy_to_user_iter(void __user *iter_to, size_t progress,
> >>>>                          size_t len, void *from, void *priv2)
> >>>> {
> >>>>         if (should_fail_usercopy())
> >>>>                 return len;
> >>>>         if (access_ok(iter_to, len)) {
> >>>>                 from +=3D progress;
> >>>>                 instrument_copy_to_user(iter_to, from, len);
> >>>>                 len =3D raw_copy_to_user(iter_to, from, len);
> >>>>         }
> >>>>         return len;
> >>>> }
> >>>>
> >>>> static __always_inline __must_check unsigned long
> >>>> raw_copy_to_user(void __user *dst, const void *src, unsigned long si=
ze)
> >>>> {
> >>>>         return copy_user_generic((__force void *)dst, src, size);
> >>>> }
> >>>>
> >>>> static __always_inline __must_check unsigned long
> >>>> copy_user_generic(void *to, const void *from, unsigned long len)
> >>>> {
> >>>>         stac();
> >>>>         /*
> >>>>          * If CPU has FSRM feature, use 'rep movs'.
> >>>>          * Otherwise, use rep_movs_alternative.
> >>>>          */
> >>>>         asm volatile(
> >>>>                 "1:\n\t"
> >>>>                 ALTERNATIVE("rep movsb",
> >>>>                             "call rep_movs_alternative",
> >>>> ALT_NOT(X86_FEATURE_FSRM))
> >>>>                 "2:\n"
> >>>>                 _ASM_EXTABLE_UA(1b, 2b)
> >>>>                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTR=
AINT
> >>>>                 : : "memory", "rax");
> >>>>         clac();
> >>>>         return len;
> >>>> }
> >>>>
> >>>> Am I missing something?
> >>>
> >>> page is allocated & mapped in page fault handler.
> >>
> >> Right, physical pages certainly need to be allocated for the virtual
> >> address range being copied to/from. But that would have happened
> >> previously in iov_iter_get_pages2(), so this isn't a new cost. And as
> >> you point out, in the common case that the virtual pages are already
> >> mapped to physical pages, the copy won't cause any page faults.
> >>
> >>>
> >>> However, in typical cases, pages in io buffer shouldn't be swapped ou=
t
> >>> frequently, so this cleanup may be good, I will run some perf test.
> >>
> >> Thanks for testing.
> >
> > `fio/t/io_uring` shows 40% improvement on `./kublk -t null -q 2` with t=
his
> > patch in my test VM, so looks very nice improvement.
> >
> > Also it works well by forcing to pass IOSQE_ASYNC on the ublk uring_cmd=
,
> > and this change is correct because the copy is guaranteed to be done in=
 ublk
> > daemon context.
>
> We good to queue this up then?

Let me write a v2 implementing Ming's suggestions to use
copy_page_{to,from}_iter() and get rid of the open-coded bvec
iteration.

Thanks,
Caleb
