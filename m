Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9D346E60
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425820; cv=pass; b=kyGnXCnHbpOWJJmxS9p32yhoq3N5y0xtdzcagVc/oZg2bphkLCfCYW8SH2eDMRTEraOUl1bOdCtEl5ec/mIsLYlwiCeX//6RQ5eMv0kpnyiYmhmGRfhgjJ7Dv0xBe5jBH53BR0cG8JHgFo5fKbdzVkE+zaPOCL90qQf2w0x1yS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425820; c=relaxed/simple;
	bh=81sp5zNkDtyZLrdzHy5yloVVn0+NQgQiuMTp78Oi9dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZfxe0O/XVj3zPDdohpSM1qUsEzCkEC0NSPOGTuhTZZaKxUlGh/3YdvWDT/kRsO7yXZ9MbmsDvowtqBANI54nMXHrwXQMlE7IvRR2nvps6yEpP9zChSjnH4SnDHkE56q6TCYrx6Qh+CUC/sJ17LcCalEGAzoOZFIff8+Ntt42Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fqZRp3H4; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fqZRp3H4"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-41540f23deaso127510fac.2
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 11:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773425818; cv=none;
        d=google.com; s=arc-20240605;
        b=BdsTQx5dSnW/QlB7vqK4P80YpmuryT0NOsRZhyH2RdYQm/MpUhLognWyFdpcdPkcpt
         Iq8z9woQw19kYgtydiFgW+IxRBvIwG7FB4Cx/gasoW9H1+egE8AGWzfcZ0MqOT3ma8nd
         +UJj1VFnqpZkZkjOUuQEPWoMIeVJlOCYiY+ybH+HBWk4SIYFovHEh7chiihUH2nBQyMq
         axzTG5rJb3ZWCRLzlHuZnnlApQ0XhWjsc7l2Fnyrh4v+X6vIuRbp34SKeZrX9PiV2bDi
         GizblzeFjLqzkydhwi/r3JMKrXd+LhTcfMU8XOPTtY6U6v8ymT7NbIGTyJztG9aZ6h+m
         ugeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xJh8pcYYm6MwFOo/3jxeUJum1ZJ3UrkzGjcdUD3bWUY=;
        fh=YivqABS9eKIRse4SM77RDyXcTGOwLOAUxEfXjGPmdAk=;
        b=c5VUoZpPlvlcdL9YVBpCvvlC2JawwgPaMEXXF/edMVuKF0Lqy1rZso27RaQkO8X41I
         nZoubywPI9B66bjIv9ABdYi+X8zXfYlCpXHCI5Gh4VZYCnxpVCwa+PQIg7ujwib7yGUN
         cye28ZuzTMTccezJZQo6mSJaB+/ksX+HBmR+0Zcts6HF2DQGIC+jTCZeQEMx5eQ9UI8H
         u3SIzPG9aoitXq6+afZ+khokA7Qpb51b9kpiGEqtdw/J3+W/KVPtUOogGOjCie2hyhTk
         wIR+rHJKqhHEq539RowZcRwuDcAJ1kaCa5sgHz/GAwszE6vBYPtwhKW2Vx0PA+yrFEMg
         z1pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773425818; x=1774030618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJh8pcYYm6MwFOo/3jxeUJum1ZJ3UrkzGjcdUD3bWUY=;
        b=fqZRp3H4badoIgOP7mVMTCfYx8U6W7Jw4zUbWA2BQWba3T9XM4a+INz/dssQhlP7sH
         bKfD9JHOr70kdAwxy96gjG7awVh/RHilMiW6ZfMQN8syr2xj+PDmGaTLxg94XYoyGPSl
         uu4Nc78ShNN48U8159m3aZqQUM40sgYcZIx/xGihTL2/efJFdKRkzMtWHu2+3hSm6IbQ
         dSHIYbQs3cCnqwoyvMppFpXp0D6eluqUCWGvxnC2aJ5u+JuSw+BTxgsRNTrZK+91reRg
         tyoqaMFOLNzVbIpNprmLEKyOymc+ZdpCUElk2hH/ee0qRSLwGLtirfUnNAqGP4tCDhbC
         gUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773425818; x=1774030618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJh8pcYYm6MwFOo/3jxeUJum1ZJ3UrkzGjcdUD3bWUY=;
        b=WLwNZMxmt4JmkbUzsF1e+4Hy3oYNRUPcw/Ejnay+wQuBznHLNKz6aLFSQkIwfzkWf3
         XDyylPunqxCnbqZmIhtZUewycDC22GcUxJAotNyHJYp9tnzR5ltB7tUEVgwBiohcIrhX
         52bEB2nUTuu6/1wlxwHT8cdQmzxsluWaBqoAUMQb2VN1AMtfNicAkWwZUuynpdw0H9Qf
         3SSlpQtTm829u00AHpBXxHvWN5wvjFFlC4dG4WmJ+VyA0MLMqGvh/RiDq6GFf5bKJpwg
         s209Y0TAr/iQJuNLu0bPwKYrltYE+5VAQbAGb9qWmqpyQGGOUcP5jPWfkSeTNNpupMg5
         1JDw==
X-Forwarded-Encrypted: i=1; AJvYcCU19zVY6+RrnrTj5gW3mSb/1MS4DgxqPM311Vv9J0+voEDXLRtMBBE0AcB2GIJHEXJywr5zw/TpEI6GQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yypr31Jc2mXCE0lV2M9Ipe3EIL20Li1Utf+CGfAULt1dtPqnYqu
	a+rV+tVkcUaKKdX2CJPIXP9EcfQ0/RjYtsP6IBfqGatY44nLE9JDTDhy5RM1hFgOYU/jWEoL7iC
	jgWwm3sRkiCWhpMbvSLZHXhD0Nt01pwjF46NLWAKcbw==
X-Gm-Gg: ATEYQzz3PvxewLgadBNVxuyFuCICj8MppFCv4UEQxmj4GkrG96NhzoYqRA7pu5f48vk
	mMlTs9yuap3cTG1emB8OX3lWtZBEC+kBG/RaPN3OG8EDhwfi/Sira83mPyItAy8GzvLN97DgQKF
	C1xNbbwYVtjdC+spzYjUEHpB+bCYxC3Q5BtACQfQhY3yILFaCOiL1JHc+AgxWWPNMx9pfKMIJGw
	Ko5KLkhlWDixAvqSunG9yKjLRMAdiGr729BD0w5AgrrRjmyb4qljVRd9YlO2PnXqpnQYTyNw2+q
	kSOl8Nu/
X-Received: by 2002:a05:6870:e186:b0:417:a04:483 with SMTP id
 586e51a60fabf-417b917bb56mr1813486fac.1.1773425817616; Fri, 13 Mar 2026
 11:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313181038.30018-1-objecting@objecting.org> <20260313181038.30018-2-objecting@objecting.org>
In-Reply-To: <20260313181038.30018-2-objecting@objecting.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 13 Mar 2026 11:16:46 -0700
X-Gm-Features: AaiRm53-iiRo_M1nzFAeOe7YzEsf-F26qWNLVbcxgzTWdi6WMPQJIZGAwqXxCTs
Message-ID: <CADUfDZo0L-ZkkSRwAumA5Tx2oevBg2qKKGM3uN3vpFKburqJ7g@mail.gmail.com>
Subject: Re: [PATCH 1/7] lib/iov_iter: fix missing allocation failure check in iov_iter_extract_bvec_pages()
To: objecting@objecting.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 11:12=E2=80=AFAM Josh Law <objecting@objecting.org>=
 wrote:
>
> When iterating bvec pages for direct I/O submission on a block device
> under heavy memory pressure, want_pages_array() can return 0 if the
> internal kvmalloc_objs() call fails.  Every other call site in the file
> (iter_folioq_get_pages, iter_xarray_get_pages, iov_iter_extract_kvec_page=
s,
> iov_iter_extract_user_pages, __iov_iter_get_pages_alloc) checks for this
> and returns -ENOMEM, but iov_iter_extract_bvec_pages() does not.
>
> When the allocation fails, *pages is left NULL and maxpages is set to 0,
> but the while loop still enters because bi.bi_size is nonzero.  The
> subsequent (*pages)[k++] =3D bv.bv_page dereferences the NULL pointer,
> causing a kernel oops.
>
> This was found through code review comparing the error handling patterns
> across all want_pages_array() call sites in the file and noticing the
> one that was inconsistent.
>
> Add the same !maxpages check present at every other call site.
>
> Signed-off-by: Josh Law <objecting@objecting.org>

Don't think you can object to the Developer=E2=80=99s Certificate of Origin=
 if
you want your patches in the kernel.

Best,
Caleb

> ---
>  lib/iov_iter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 0a63c7fba313..852f9ed40e5c 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1628,6 +1628,8 @@ static ssize_t iov_iter_extract_bvec_pages(struct i=
ov_iter *i,
>         bi.bi_bvec_done =3D skip;
>
>         maxpages =3D want_pages_array(pages, maxsize, skip, maxpages);
> +       if (!maxpages)
> +               return -ENOMEM;
>
>         while (bi.bi_size && bi.bi_idx < i->nr_segs) {
>                 struct bio_vec bv =3D bvec_iter_bvec(i->bvec, bi);
> --
> 2.34.1
>
>
