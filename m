Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B49326299
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994925; cv=pass; b=bsaVVODRMJXxMCc9VV4dzPqVUha9EtM4eFXi1uylRjr0w2AKMgXuM0wOcIP9Wy4mcSfSQckmOZSXy+cDSe2z5UsS0po7hD140AFizMeLliQxWCi3hTCEjpBPeYEyEZKltDN+bCumW1xSh1GOo7OsPrPQfHxWVFhAE7RuRJFCirw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994925; c=relaxed/simple;
	bh=+f6pLDVxKmDdrAafhiTaO1qCMRLoArlFFjmv+gfeZ3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/nz2HgufGIZqW/ljZHJrMlSxcjYCyeh+Gce2Hs4c7eAFav7AzyTRYfwtUp1jfzHkUVOqV8Ax+pVpzRnSPD6yrpD5BCiBVxSzDFD2KiVWFLhrqcGYo+0/lDLCp0AXJjYXlAcYrzSsZswDM+7df9f2qcZYd4GUdzyRFgEv78fGcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DKxXI9t8; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DKxXI9t8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a2bff5f774so941765ad.2
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 10:08:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765994922; cv=none;
        d=google.com; s=arc-20240605;
        b=aNdRgKR+cGrUNJvc23XrNCzQCsTPHRA3Q336/B/Wp0k9zZGivkrjJTn90u5e0uWqY5
         0Nm8yCpVOkhgFmIWYggn3YvLTUWCZNvBH3O/ioo2BZ/58rnFjzpgRLKiObHUcGtwCoFC
         kEM1h6VqPz80PGQg7TIMrhKecNIvPFguRG8k2YCfQZ5INHBRkb24W1rtQDX81QV69VrQ
         HD0PDzOROX4oglntO0qg+D86roNy4Iw+5GKdAPZ6fmnheLOHz3B/yum7SI52b4ETCvWR
         8Phv+TDEsrd4bKHMwj6VQKGWBs0OuAmaM4JkyltbghH8xP5bJuzazG5oOMkERGSRW4y9
         keYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sqXX5V0y/GmAHw/j5eBR5l0SkO/n2/9GJRWX/yrGrAk=;
        fh=nv13D+l/BnWDgFn9K/H2KfF0WfE7sGql3rerFWGc0oI=;
        b=lMC6fwvrhOYLWEhiELKretDMosDJzuhCUPmchFN3UUlu7gkXOK+1FNYJCQmFWZr3vV
         D6mN+oinWJfMciC0EgIfWP5f56FZQq/gXSdBmGskKo+hI5GDhsvRccB8+2riamUPaUHR
         fwOuAxSf9bYLPMdU0i26jnFY+nKVTz0XXv2w97k9XYo0NJM1+oOoKWnUMlAk86OP1nI4
         vY0f+yvmMANSwd3/5XtvuIwKYJkULxzBk37w/HvdtB+AfFsAS0gm58w34nwg5Q1rHkO0
         Qf1SSLzC7a5nFtsIu7my8Tj4/yWtQfE+P6vxRCFsQPlWVB2+2npvd6iAOhaojUKfdXW3
         0Vkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765994922; x=1766599722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqXX5V0y/GmAHw/j5eBR5l0SkO/n2/9GJRWX/yrGrAk=;
        b=DKxXI9t8XJzVRUS0167Ks7m79PfxN9v7pEOD69gN9gE57SrISqETFDvbvUWBw2vK6Y
         kncb8UkkXDtIfj8I9c+aUjqH+1v95F+8mj3DNOlrWYJGuuszHPqs0OTlst2ZOTFvLmAF
         3XhSxgVUFik4IwtKUuc8mWDLofYyWWH40z7jEefY3zbJ0/CRlaMxC3SCWAq+IniDRln/
         Ghh1DLQfF/tARimFMI30tICquIXXd6nO1B76GdfDurO1s2O12eIFCjuPtutPqvXlwCCb
         eox5qfkGbg2o26JEsC7l07nmE5H7YxcoRc6z+QjE7bacnPduCmLxcOoI3s2P+jMnC45k
         b6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994922; x=1766599722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqXX5V0y/GmAHw/j5eBR5l0SkO/n2/9GJRWX/yrGrAk=;
        b=irf2B8ByHMkJ8jAGVxMAux4TSqYjA5fRU/YoYPkPqEKknGx4xvYdrLVJ+O+dC9v+z+
         913gCCBFKDXqvvyCAKRWZvoPp2PG7RjQToyorXnoaAR4D5AhwZca8Ojo9Puq8tcsMr0B
         E2CvabS3aT/1oH4ntbeyAfJb7FjlVIt9E+YcSWwvH2H0+igQZurdv6BttHENURlFNP5l
         KugxgwdpCXX/Q5UBMb3XZTf/k5GQuU/584LkmADGCny8i9ZYqlVlB3QmVTEpiD2CBgEl
         gYJ7zpizE6jahFiPUtejQeZ+Rx7BdPMsmBQGZ61tpGEoUkKU2ANv+XjjvikFK1Y2Rvcd
         ETwA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7gClValQ1aHlaA2n0dUm2TM3TubuaFMbfemvdODjOnXmQmM9G87GaQZ1vnaXGbPZRSFxI9uVQQcv6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2d4LNxBSDmOi/QGmAc1KG4qthH2iYRHTY+V2gdFcznQPpHZX
	2rNqGJwgMy9jAOT54Yl+WvTW/hxbiIcwaTyl0l3j+dht1My5b/EKkr7m1PGvwIp3Nofvlv4TU2h
	QPy0noGFw8DVbsx5XmTLVDz8M2bvecrNjqgkzcQC4ENUiS+QRAeGWIm4=
X-Gm-Gg: AY/fxX55h1ESC+HBDoacEAJd+YL3VvgibyEUUhpWWeSTsyoS60nkAhy2twHnSUcJDss
	sR3PMUOrDhKEy3AHykQnlEMkiZhVooMFw2Eazd/Xp42lEIiiWQ1CnBiMPCuwfpudGI+fw+D8YE0
	cAapLCmwZjhn4afg1jKo4qEucsUUxZne9ldwwjVE3KPTKIVXUVmumj9SpTn95Wm+IdMw7csWPVw
	+nAl7FjkUNMfrXbvv6usWOzF6i5ofdzalIDo0EJThlUJ7/fK1ZZPp69Z8ZyCwU22lZ6vbNt
X-Google-Smtp-Source: AGHT+IEfNta51hA9Bsp9+wHvIltb3Ow9dR8JiCSw1SA+Wjc4E2sA5J/3Z5FAvbHFP6CbaQhfWrshugEFb0ZeTze7pAw=
X-Received: by 2002:a05:7022:7e84:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-11f34c4b85dmr7340619c88.7.1765994922256; Wed, 17 Dec 2025
 10:08:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADUfDZo4Kbkodz3w-BRsSOEwTGeEQeb-yppmMNY5-ipG33B2qg@mail.gmail.com>
 <20251217062632.113983-1-huang-jl@deepseek.com>
In-Reply-To: <20251217062632.113983-1-huang-jl@deepseek.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 17 Dec 2025 10:08:30 -0800
X-Gm-Features: AQt7F2rHioI0XR9ah-g8QyUNuTK0I0VZ798gZ0CP1QG-6M9_TEXfhBxzPdt27WQ
Message-ID: <CADUfDZohpg7RUdHfWL2HPFcNwmvSDGz3jMahaT2jD6poCDE4Ug@mail.gmail.com>
Subject: Re: [PATCH v2] io_uring: fix nr_segs calculation in io_import_kbuf
To: huang-jl <huang-jl@deepseek.com>
Cc: axboe@kernel.dk, io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 10:27=E2=80=AFPM huang-jl <huang-jl@deepseek.com> w=
rote:
>
> io_import_kbuf() calculates nr_segs incorrectly when iov_offset is
> non-zero after iov_iter_advance(). It doesn't account for the partial
> consumption of the first bvec.
>
> The problem comes when meet the following conditions:
> 1. Use UBLK_F_AUTO_BUF_REG feature of ublk.
> 2. The kernel will help to register the buffer, into the io uring.
> 3. Later, the ublk server try to send IO request using the registered
>    buffer in the io uring, to read/write to fuse-based filesystem, with
> O_DIRECT.
>
> From a userspace perspective, the ublk server thread is blocked in the
> kernel, and will see "soft lockup" in the kernel dmesg.
>
> When ublk registers a buffer with mixed-size bvecs like [4K]*6 + [12K]
> and a request partially consumes a bvec, the next request's nr_segs
> calculation uses bvec->bv_len instead of (bv_len - iov_offset).
>
> This causes fuse_get_user_pages() to loop forever because nr_segs
> indicates fewer pages than actually needed.
>
> Specifically, the infinite loop happens at:
> fuse_get_user_pages()
>   -> iov_iter_extract_pages()
>     -> iov_iter_extract_bvec_pages()
> Since the nr_segs is miscalculated, the iov_iter_extract_bvec_pages
> returns when finding that i->nr_segs is zero. Then
> iov_iter_extract_pages returns zero. However, fuse_get_user_pages does
> still not get enough data/pages, causing infinite loop.
>
> Example:
>   - Bvecs: [4K, 4K, 4K, 4K, 4K, 4K, 12K, ...]
>   - Request 1: 32K at offset 0, uses 6*4K + 8K of the 12K bvec
>   - Request 2: 32K at offset 32K
>     - iov_offset =3D 8K (8K already consumed from 12K bvec)
>     - Bug: calculates using 12K, not (12K - 8K) =3D 4K
>     - Result: nr_segs too small, infinite loop in fuse_get_user_pages.
>
> Fix by accounting for iov_offset when calculating the first segment's
> available length.
>
> Fixes: b419bed4f0a6 ("io_uring/rsrc: ensure segments counts are correct o=
n kbuf buffers")
> Signed-off-by: huang-jl <huang-jl@deepseek.com>
> ---
>  v2: Optimize the logic to handle the iov_offset and add Fixes tag.
>
>  > Please add a Fixes tag
>
>  Thanks for your notice, this is my first time to send patch to linux. I
>  have add the Fixes tag, but not sure if I am doing it correctly.

Yup, that looks great. That will help figure out which stable kernels
the patch should be backported to.

Thanks,
Caleb

>
>  > Would a simpler fix be just to add a len +=3D iter->iov_offset before =
the loop?
>
>  Great suggestion! I have tried it, and also fix the bug correctly.
>
>  io_uring/rsrc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index a63474b331bf..41c89f5c616d 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1059,6 +1059,7 @@ static int io_import_kbuf(int ddir, struct iov_iter=
 *iter,
>         if (count < imu->len) {
>                 const struct bio_vec *bvec =3D iter->bvec;
>
> +               len +=3D iter->iov_offset;
>                 while (len > bvec->bv_len) {
>                         len -=3D bvec->bv_len;
>                         bvec++;
> --
> 2.43.0
>
