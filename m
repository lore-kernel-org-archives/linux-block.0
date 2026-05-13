Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643A2C326C
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682787; cv=pass; b=pIP7u3Fq2bGw3X5w0FfMh7xsQ+ZXw7mgKLFRtrz1FcKVAR7JIpk5kxGDn/CDcIpFy041iz4afvwaGQbZMiXBcuJKYJTxVhYq7WDK4TIsIV5FNIjBNYktgK37OyljG8kbbKKLJuTBYqEnfZpurPtEdMaFFVycN+0CqA3FezL267w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682787; c=relaxed/simple;
	bh=852X0+cxQ2cMuD8cmqzYKR36zVSzB6hN12faI1aAuNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaWVyYLFyecpAN58g5paagWSwCBjBU0LlzjsKkf2ELgHzmOKOmA6pUPJuWpb+HSOZolkUb8bx0tkXnwEQk3o3tp5P5v6WKcsNWahPolKEDX4ZfcukJyE3CL9XeCkQ7nXo1jus1cU72jsNpUSH9rRdNKa875EzhQzoxz9GuzlELM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M3x3m2bq; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M3x3m2bq"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69b7d457c14so22305eaf.3
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 07:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778682784; cv=none;
        d=google.com; s=arc-20240605;
        b=aA8M1A8oIEz9DdmlMuEH5zCWML7+DmRDq+YrabPokq/BWG4hN2UjBDhy/J0axNTGFU
         Mho1Q4AfJgUAo1aT+wSG4YOCostvbfM8Lj0CobgYShu1mNuVw1me0svDWhZbfn0QGs7Y
         vEqyk8JSHfIedKNhm1vZvugYArdPF2yjZSt2NoF1XwqzJQSqXL20T199j+mHzYmQroaI
         lxPP+nZfTiJDuOGoisdk8nwb+HQBGEA69+zwXtv2MB9OLTwgl84cN80LpA6AtNm/ELpd
         46oOVAZ+sx5OGmdeLZUABkb2/ZOW2vhdKaRj4HIz9HY3DFGTyFjGdqIpSB6Q9IYyBs2E
         tyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HkysCSkgCDM4WOFFSjxIFqCI/HOESNwZ2+7MdN8LG60=;
        fh=v3tzMcn3FvtxRom8t+NG0bDNOY/Xqf33AgBT6/g4mBQ=;
        b=SHB5kwyBf1xO2U0m2qicm2ira3FLO3gYiEid9MhhIqejA4XHMkOKfgJAr/biNk3r4K
         QdFIx1OoiAtLc+3GZ3ZcSE7aYHtGAVy11no2THKa5P28IKWyvwst7FuTtjT+3kCZywxh
         99UyjfFeyL8VYnp+uibixsZNaMsyydu0gfJE1w1kEM5U0CLpIsPtgLEKGwRfPMK6+NJJ
         uPCg5nM6VQUGyg5zKv8HCIYTsSfnuhVJSaeoqvgXH8X1GNHQJT3+Cn43rLI1NdyE2fOp
         4WX2ZVdLTnT/lyCSdbi8h9qZXCiv1zlN48FHuFY5zm/8KOu3GXhd1fK78U2yytTyc71U
         mV0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778682784; x=1779287584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkysCSkgCDM4WOFFSjxIFqCI/HOESNwZ2+7MdN8LG60=;
        b=M3x3m2bqdR2qKgKIOPp04KMgbksK8QW0AzfTMVtInTxnmoA7UawxwFzG2oIc3YK0Ph
         I/0M70AUQHjQApD61uFKcIO6p0BgsfAj1PK8CZMgSUwlcFway1TO8Q8wgRzllDnUIlGt
         u8n/g/w7m57W/4rOPtSdlOwcqGwU3UDQlo51tg3pU9rgj5E+/h8Pd/kwRskLBkNUmZqQ
         ykC+EVpqfhYiICYfZvh7SMxn9MyZ2D4NUxi+DFTPR9U5scS/78NSBYvn2pTiS6Hbfnbc
         22yMslan/a8NWH6eO9ueOCP8refIMoOCuMDAXlig932H4AfQGGBT5opAIt4osOEYK/RO
         Lqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682784; x=1779287584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkysCSkgCDM4WOFFSjxIFqCI/HOESNwZ2+7MdN8LG60=;
        b=FFuEJJp4DLJG/ThOwt7/nFoKNbLirQaiNtbjZXfBJXGMXBNV1/LhzwNOca86cbVJ1Q
         29ZqrAcGinOz6VXPCF/BlE1hJ0HtHxzpFDuw1qpNyvIVrN2kV/QRR3OHi7NzsBJ8PSgj
         JQ0UaPOgQyFTg0GHopNrC3AOjPpT7LAWxi9qkNqToQVrN1Eu8qDl5YK1PNM4r+AmTZH9
         F9zqALyVVI3UB5Gtf6P4MR18D7g4NRuk+jXiijh/NF1jEDC0sYiVxmD5UB5vwDIYHZAP
         DEF2dq44dIc3/l1ZA2bwYrQ1ekP6LwWVn4VAb6nhSD8xRAOQz9f7ySMMNsffeYbdJ23A
         JByw==
X-Forwarded-Encrypted: i=1; AFNElJ9/PxDF06cbc+QnjslDPilpICtByMiFiPh2wqhLNzsj6NxxjvJ9pPIVxLMyY8ixv+EdZSRxGm1TtmcWFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtOuzMZLRafkt7OzBdVpePYDigIuQdnf1N9zFA/Zi03zGzNWI
	NnpQwxJABOSSd4Bv48bUsmFWwXBeZF6TaT+O5gzoTLzP7jVAkbvcIKUy6YKzZUbZdrSDTHs/lQa
	jWZtgoayfbX5z4XNcbQ1OdBjEnDI7R/7i6g4Gw/DGgQ==
X-Gm-Gg: Acq92OGk2dYo6BYEhf4j0LDEbzHwAdI8kJrHl5qw4aq2mD6Ywh9fnaTGsTCOcOLD14a
	4EusWGfm8sn1QvQP3JJ3ZH7HWCpJLbCZkMDDySMCYXxZ1rf20jLtuDTk42HDUlpBBfxNSWPV1y0
	ge0HYRmgxJUk9yn6+wRzxpl77bv0+CCjPLePJ4gmM/V6Ax5D/fTHyCbIlroqU2HraXO/zlYvF2M
	8FUWJEO18Gv+6h1biqJBlekcld6Y60SK8TR/Zq+KyUgwI9oTxcpNVYGYLzrxBjghBkWT2CKykB0
	Obt1s+k=
X-Received: by 2002:a05:6830:34a6:b0:7dc:c5e9:b99 with SMTP id
 46e09a7af769-7e3da702bc0mr1353241a34.7.1778682784470; Wed, 13 May 2026
 07:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513070515.528861-1-dmantipov@yandex.ru>
In-Reply-To: <20260513070515.528861-1-dmantipov@yandex.ru>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 13 May 2026 07:32:53 -0700
X-Gm-Features: AVHnY4LceWVVstVwzxkKW0GG-i9SwVQVNFhQ6rtI7EksBMYEesSSocThCQkZenA
Message-ID: <CADUfDZo972nK0iE79ogjob5_VN2-i-7L5XypDbdW0bupNfTo+g@mail.gmail.com>
Subject: Re: [PATCH] block: bio-integrity: fix memory leak in bio_integrity_map_user()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Weidong Zhu <weizhu@fiu.edu>, Chao Shi <cshi008@fiu.edu>, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 12:05=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> Since 'iov_iter_extract_pages()' may allocate new array of pages
> even when it returns non-zero error value, matching cleanup with
> 'vfree()' should be performed on all return paths afterwards. So
> adjust 'bio_integrity_map_user()' to ensure that both 'pages' and
> 'bvec' arrays are always freed on return.

I preferred your previous patch changing iov_iter_extract_pages() to
free the page array on error. (I left some minor comments on the code
change, but the general approach seems good.) Even though
bio_integrity_map_user() is the only current caller that requests
iov_iter_extract_pages() allocate a page array, others could be added
in the future and forget to do this freeing. And it's conventional for
functions to release any allocated resources on failure. Is there a
reason you decided to modify bio_integrity_map_user() instead?

Best,
Caleb

>
> Fixes: 8582792cf23b ("block: bio-integrity: Fix null-ptr-deref in bio_int=
egrity_map_user()")
> Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  block/bio-integrity.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index e796de1a749e..53fb04adb09b 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -400,7 +400,7 @@ int bio_integrity_map_user(struct bio *bio, struct io=
v_iter *iter)
>         ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs,
>                                         extraction_flags, &offset);
>         if (unlikely(ret < 0))
> -               goto free_bvec;
> +               goto out_free;
>
>         /*
>          * Handle partial pinning. This can happen when pin_user_pages_fa=
st()
> @@ -414,16 +414,12 @@ int bio_integrity_map_user(struct bio *bio, struct =
iov_iter *iter)
>                         for (i =3D 0; i < npinned; i++)
>                                 unpin_user_page(pages[i]);
>                 }
> -               if (pages !=3D stack_pages)
> -                       kvfree(pages);
>                 ret =3D -EFAULT;
> -               goto free_bvec;
> +               goto out_free;
>         }
>
>         nr_bvecs =3D bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
>                                    &is_p2p);
> -       if (pages !=3D stack_pages)
> -               kvfree(pages);
>         if (nr_bvecs > queue_max_integrity_segments(q))
>                 copy =3D true;
>         if (is_p2p)
> @@ -434,15 +430,10 @@ int bio_integrity_map_user(struct bio *bio, struct =
iov_iter *iter)
>         else
>                 ret =3D bio_integrity_init_user(bio, bvec, nr_bvecs, byte=
s);
>         if (ret)
> -               goto release_pages;
> -       if (bvec !=3D stack_vec)
> -               kfree(bvec);
> -
> -       return 0;
> -
> -release_pages:
> -       bio_integrity_unpin_bvec(bvec, nr_bvecs);
> -free_bvec:
> +               bio_integrity_unpin_bvec(bvec, nr_bvecs);
> +out_free:
> +       if (pages !=3D stack_pages)
> +               kvfree(pages);
>         if (bvec !=3D stack_vec)
>                 kfree(bvec);
>         return ret;
> --
> 2.54.0
>
