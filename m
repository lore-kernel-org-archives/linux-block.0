Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16071373BFC
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591429; cv=pass; b=hp40ozfxtAACzyICMANMK1H0jzppWZEbL5x9O1T9sdoZ5Xzk2cOoHTA1goq9XKS+DY3pnZ+Jr90jBKHaD7OdCWlVL+7iK5D29PQqkPU4hyzuYUyompYpLETJ+eBWKMTL2WOS3iXKxbpJ5GnbXOSr0E/3o9UrWymAncEQ1xbW28U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591429; c=relaxed/simple;
	bh=nxXg8ZjDTy5euimDKPmBAGVHIBoQA61IqKrzlQd6tmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eef66oMlNijMxTN/sWZQ2BSo3nwwMwKA01nIi8Lc3SAXvUNtnvSaW/1JdMC/HmiwprOkkuILJH5fG3MsjE8Y5rVruQMQJ5/5ZQ8XQkbMCKACguf2BZdHuUfFYvEVacI0nTgRfRy7cNCMQM6OjrCXFBQQceFArtjB2iKTvxhx3mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Q4u5H9UC; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Q4u5H9UC"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dbd7a1e989so447051a34.1
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 12:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775591427; cv=none;
        d=google.com; s=arc-20240605;
        b=jd4B6hr8PHbMi/VmZU3ZXxUmYdo6T1lcAo7JFPhqF90ZnrnKmxlWOip9i8hEVPHCbT
         PoYkTysZtCnNhY5WBYqlScZAvzGTls4zATQill8NxtYEFEwx2lEckXGQvvJjJirQcUge
         RMoEcFGgMLDjHuNARPD1iU2v9PHFxC/F5AWVzV80GQ6/hpFMtUXJbcSfSlbIjpjHu99b
         3LSzabqvK6o1hza4pNHw4MQzqbM7cRRuBRh3sbwlmYACZ4Pf7PWxsoYkH3w3/lySu8qN
         r/cf5BGvzn+jv35Ii+kjKi7mbZEOxZxUuXsskKPtt3Yrpxl6nAV4gqFGMvX0U6c1CXys
         BkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lN2rqgQtMSakNfu3wzBnaSjEsLx2QLE8HgNct2INBH4=;
        fh=7wW+3hm5TzNEaChY+Bb2AlJ3Jll+jhxIb52Fykk25aU=;
        b=Wiu3yNV0andlN5V18AMvnnNJn3TRTOKqi/RiFeJvU/WbbJQkR3h1QLqFreXw6T7Fiz
         cMYcodqpQWuFhjL15yXCNlr9yhwVJjqhp3dJQyTAjB1TcDjgWyxEHKre2BbKNWNr4fxB
         6tMe1Y03ImIamuXODf3rqSl7TYkAt1rY6SNntQawINoYfxyKHOtvj8qLFtAIiTGpVGwC
         HcnFaH9Jlz7TNvOViMIXUeHB5wpo6CtbADfQwIZ/grAqqyJ+7Tnn6qdLKhzE4LIc6Vet
         UGFkNp8s0l756OH5xzzVH4m9SsABHUjRaTxtnggb1oay/WM4cw6TmtrPf8K4b0QyzCv3
         TVfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775591427; x=1776196227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN2rqgQtMSakNfu3wzBnaSjEsLx2QLE8HgNct2INBH4=;
        b=Q4u5H9UCHCbTVWUA4pfgjoU5NOd73yWABc+hVgcexthXGsMeCdJlUb70k7C5zYkvER
         B7IRrF/A4JbGJEM0YI3GNWi+xBjjO6fhWJw1lNa8KBHZQkliMmqEmTYtJrcHQ9d/ENTL
         Xzrj0r6PfD0j1eYnlUQNzfZkQAJhalVU4NzRLgn902TQMyRODqQMTNRD/UCMzPLI88A5
         U7sRz8yHkjLt7fheIMx3y0lhjLX3BDxAGGoKbXBlmaU8Vptx/w+O4iya4MIFrn1FL3wU
         qhBFOcJnOLH5c3eBhSqMHheqUUKUtvTst4QheOpIBeyU1bzRR18sluZGslBHTLvIxrf8
         Hbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775591427; x=1776196227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lN2rqgQtMSakNfu3wzBnaSjEsLx2QLE8HgNct2INBH4=;
        b=lhvfPYCaMgX8QT479iFAQ9bIKSoM0lXBDpIWXUz86CtKouBG/jkZq/JQPw9C6uhADy
         wx2pIToRst0DXTdR+8tmYKT+/xrmIB1VkOcqY/Krrnqw3l6XOR5a9KfTTCNWq/zBQJeg
         0qameMKYeuZS90ZUquHRPkqAKi0lk8rf6Tsxz3Pi0JZwdhpt18RBbNbseobSpFm6d4x6
         eW3dOsVDMPia1qBY+EOmyJ1n9leiM/4k+0R2LxiCV0pfyv4nADzGWmGCMYWpVFBU7Pez
         PGoatYb57G6jS7A4fLtl60lL/f5B4NQa50WuS1c5aiHzQBhqW9A3093zbePGieeIeH9+
         xfew==
X-Forwarded-Encrypted: i=1; AJvYcCUliQxxkP4Hbm5Db0q839favy8lp7utQMChmAEArfGqfk4hNc1Isp6qJzisXAib7wAtterfQZynu2FA+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD1+x8QoisI/sJBN1PA0y+sw1hSzHSVaxOLIS5WfeS8rrsM/lR
	ZwAc+LOhPINBuQbEHgKbI5T0sVuwLby2SPjPwjBz5q8ORtiasFDcFwZTqLSrxwlXWEfGlUQeC8H
	zWXomJWGC5CJ07Ns9w1t5t+XB+bmRDYoMz5+D7bxStQ==
X-Gm-Gg: AeBDieuJgKepwXg5+gCljlcgQqdJ1JmdzyzYWZtDcbv1F4IBywbSRDzJNeHNEQ3+qen
	rXZ3ScDpfmrkaCoAecwbOXcwD9Zleb9P5dK+MyvC44/dSgoxPvGOoawowpxpVmwKV+hHKuJlJr2
	bNbQcPVPTn23KD8ROXBdP6bJB5nUSQqngNYKOufShJJicwA8W/vw1usVmwsrjYVtXITmVs2tybE
	4uJsvAO/cLJ9ndX/S/hMRPQaAkOEGOup3x+q5rq1HzyQyJFzNyho8cHagrgOeEyhEvRQgQ//ar7
	xes2jLBm
X-Received: by 2002:a05:6830:2549:b0:7d9:3895:563 with SMTP id
 46e09a7af769-7dc0484a82cmr689720a34.7.1775591426812; Tue, 07 Apr 2026
 12:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153207.3635125-1-ming.lei@redhat.com> <20260331153207.3635125-5-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-5-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 7 Apr 2026 12:50:15 -0700
X-Gm-Features: AQROBzCjGo6ygNQNj4o8xYTjp_BB0S2BvZuW51WJ_O5Uif_DOKsfgcKfigkwveQ
Message-ID: <CADUfDZow_gmwzQk41kn=Hw4w4bhsF9ogm2ZPGNgRuz9d5aF_kQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ublk: eliminate permanent pages[] array from
 struct ublk_buf
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:32=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> The pages[] array (kvmalloc'd, 8 bytes per page =3D 2MB for a 1GB buffer)
> was stored permanently in struct ublk_buf but only needed during
> pin_user_pages_fast() and maple tree construction. Since the maple tree
> already stores PFN ranges via ublk_buf_range, struct page pointers can
> be recovered via pfn_to_page() during unregistration.
>
> Make pages[] a temporary allocation in ublk_ctrl_reg_buf(), freed
> immediately after the maple tree is built. Rewrite __ublk_ctrl_unreg_buf(=
)
> to iterate the maple tree for matching buf_index entries, recovering
> struct page pointers via pfn_to_page() and unpinning in batches of 32.
> Simplify ublk_buf_erase_ranges() to iterate the maple tree by buf_index
> instead of walking the now-removed pages[] array.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 87 +++++++++++++++++++++++++---------------
>  1 file changed, 55 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c2b9992503a4..2e475bdc54dd 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -296,7 +296,6 @@ struct ublk_queue {
>
>  /* Per-registered shared memory buffer */
>  struct ublk_buf {
> -       struct page **pages;
>         unsigned int nr_pages;
>  };

It looks like nr_pages doesn't need to be stored either, it could just
be passed to __ublk_ctrl_reg_buf(). Then I think we could get rid of
struct ublk_buf and the xarray entirely. We really just need a bitmap
for allocating buffer indices.

>
> @@ -5261,27 +5260,25 @@ static void ublk_unquiesce_and_resume(struct gend=
isk *disk)
>   * coalescing consecutive PFNs into single range entries.
>   * Returns 0 on success, negative error with partial insertions unwound.
>   */
> -/* Erase coalesced PFN ranges from the maple tree for pages [0, nr_pages=
) */
> -static void ublk_buf_erase_ranges(struct ublk_device *ub,
> -                                 struct ublk_buf *ubuf,
> -                                 unsigned long nr_pages)
> +/* Erase coalesced PFN ranges from the maple tree matching buf_index */
> +static void ublk_buf_erase_ranges(struct ublk_device *ub, int buf_index)
>  {
> -       unsigned long i;
> -
> -       for (i =3D 0; i < nr_pages; ) {
> -               unsigned long pfn =3D page_to_pfn(ubuf->pages[i]);
> -               unsigned long start =3D i;
> +       MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
> +       struct ublk_buf_range *range;
>
> -               while (i + 1 < nr_pages &&
> -                      page_to_pfn(ubuf->pages[i + 1]) =3D=3D pfn + (i - =
start) + 1)
> -                       i++;
> -               i++;
> -               kfree(mtree_erase(&ub->buf_tree, pfn));
> +       mas_lock(&mas);
> +       mas_for_each(&mas, range, ULONG_MAX) {
> +               if (range->buf_index =3D=3D buf_index) {
> +                       mas_erase(&mas);
> +                       kfree(range);
> +               }
>         }
> +       mas_unlock(&mas);
>  }
>
>  static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
> -                              struct ublk_buf *ubuf, int index,
> +                              struct ublk_buf *ubuf,
> +                              struct page **pages, int index,
>                                unsigned short flags)
>  {
>         unsigned long nr_pages =3D ubuf->nr_pages;
> @@ -5289,13 +5286,13 @@ static int __ublk_ctrl_reg_buf(struct ublk_device=
 *ub,
>         int ret;
>
>         for (i =3D 0; i < nr_pages; ) {
> -               unsigned long pfn =3D page_to_pfn(ubuf->pages[i]);
> +               unsigned long pfn =3D page_to_pfn(pages[i]);
>                 unsigned long start =3D i;
>                 struct ublk_buf_range *range;
>
>                 /* Find run of consecutive PFNs */
>                 while (i + 1 < nr_pages &&
> -                      page_to_pfn(ubuf->pages[i + 1]) =3D=3D pfn + (i - =
start) + 1)
> +                      page_to_pfn(pages[i + 1]) =3D=3D pfn + (i - start)=
 + 1)
>                         i++;
>                 i++;    /* past the last page in this run */
>
> @@ -5320,7 +5317,7 @@ static int __ublk_ctrl_reg_buf(struct ublk_device *=
ub,
>         return 0;
>
>  unwind:
> -       ublk_buf_erase_ranges(ub, ubuf, i);
> +       ublk_buf_erase_ranges(ub, index);
>         return ret;
>  }
>
> @@ -5335,6 +5332,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub=
,
>         void __user *argp =3D (void __user *)(unsigned long)header->addr;
>         struct ublk_shmem_buf_reg buf_reg;
>         unsigned long addr, size, nr_pages;
> +       struct page **pages =3D NULL;
>         unsigned int gup_flags;
>         struct gendisk *disk;
>         struct ublk_buf *ubuf;
> @@ -5371,9 +5369,8 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub=
,
>                 goto put_disk;
>         }
>
> -       ubuf->pages =3D kvmalloc_array(nr_pages, sizeof(*ubuf->pages),
> -                                    GFP_KERNEL);
> -       if (!ubuf->pages) {
> +       pages =3D kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
> +       if (!pages) {
>                 ret =3D -ENOMEM;
>                 goto err_free;
>         }
> @@ -5382,7 +5379,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub=
,
>         if (!(buf_reg.flags & UBLK_SHMEM_BUF_READ_ONLY))
>                 gup_flags |=3D FOLL_WRITE;
>
> -       pinned =3D pin_user_pages_fast(addr, nr_pages, gup_flags, ubuf->p=
ages);
> +       pinned =3D pin_user_pages_fast(addr, nr_pages, gup_flags, pages);
>         if (pinned < 0) {
>                 ret =3D pinned;
>                 goto err_free_pages;
> @@ -5406,7 +5403,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub=
,
>         if (ret)
>                 goto err_unlock;
>
> -       ret =3D __ublk_ctrl_reg_buf(ub, ubuf, index, buf_reg.flags);
> +       ret =3D __ublk_ctrl_reg_buf(ub, ubuf, pages, index, buf_reg.flags=
);
>         if (ret) {
>                 xa_erase(&ub->bufs_xa, index);
>                 goto err_unlock;
> @@ -5414,6 +5411,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub=
,
>
>         mutex_unlock(&ub->mutex);
>
> +       kvfree(pages);
>         ublk_unquiesce_and_resume(disk);
>         ublk_put_disk(disk);
>         return index;
> @@ -5422,9 +5420,9 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub=
,
>         mutex_unlock(&ub->mutex);
>         ublk_unquiesce_and_resume(disk);
>  err_unpin:
> -       unpin_user_pages(ubuf->pages, pinned);
> +       unpin_user_pages(pages, pinned);
>  err_free_pages:
> -       kvfree(ubuf->pages);
> +       kvfree(pages);
>  err_free:
>         kfree(ubuf);
>  put_disk:
> @@ -5433,11 +5431,36 @@ static int ublk_ctrl_reg_buf(struct ublk_device *=
ub,
>  }
>
>  static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
> -                                 struct ublk_buf *ubuf)
> +                                 struct ublk_buf *ubuf, int buf_index)

ubuf is only passed to kfree() now, maybe it would make sense to move
that to the caller so the argument can be dropped?

Best,
Caleb

>  {
> -       ublk_buf_erase_ranges(ub, ubuf, ubuf->nr_pages);
> -       unpin_user_pages(ubuf->pages, ubuf->nr_pages);
> -       kvfree(ubuf->pages);
> +       MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
> +       struct ublk_buf_range *range;
> +       struct page *pages[32];
> +
> +       mas_lock(&mas);
> +       mas_for_each(&mas, range, ULONG_MAX) {
> +               unsigned long base, nr, off;
> +
> +               if (range->buf_index !=3D buf_index)
> +                       continue;
> +
> +               base =3D range->base_pfn;
> +               nr =3D mas.last - mas.index + 1;
> +               mas_erase(&mas);
> +
> +               for (off =3D 0; off < nr; ) {
> +                       unsigned int batch =3D min_t(unsigned long,
> +                                                  nr - off, 32);
> +                       unsigned int j;
> +
> +                       for (j =3D 0; j < batch; j++)
> +                               pages[j] =3D pfn_to_page(base + off + j);
> +                       unpin_user_pages(pages, batch);
> +                       off +=3D batch;
> +               }
> +               kfree(range);
> +       }
> +       mas_unlock(&mas);
>         kfree(ubuf);
>  }
>
> @@ -5468,7 +5491,7 @@ static int ublk_ctrl_unreg_buf(struct ublk_device *=
ub,
>                 return -ENOENT;
>         }
>
> -       __ublk_ctrl_unreg_buf(ub, ubuf);
> +       __ublk_ctrl_unreg_buf(ub, ubuf, index);
>
>         mutex_unlock(&ub->mutex);
>
> @@ -5483,7 +5506,7 @@ static void ublk_buf_cleanup(struct ublk_device *ub=
)
>         unsigned long index;
>
>         xa_for_each(&ub->bufs_xa, index, ubuf)
> -               __ublk_ctrl_unreg_buf(ub, ubuf);
> +               __ublk_ctrl_unreg_buf(ub, ubuf, index);
>         xa_destroy(&ub->bufs_xa);
>         mtree_destroy(&ub->buf_tree);
>  }
> --
> 2.53.0
>
