Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA536C581
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786396381; cv=pass; b=KBh46IW38TK/7mBnZpzfILGdOeKNBIaP5y62k3mndghoP7K5l6721pH70AJfg2kx39VqQFq77IBgoXBOmynbFv5kLpVL0wM5T+EY91K4Sn8StR9I7RbZVnjrLZlI2ztnJe2dx5Opzy4JIlCqp8edi1aIwwavwRCP8vU6+G/6rWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786396381; c=relaxed/simple;
	bh=f8GfeBohCHWYFat06tO5BjRXSUJwYHC1J/dpM2VvgkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCsy8TQe3f8mvPYEUqFKTnfp27n47gNWHzaVdt/YNRsWvYrvMFRl38boFsM5sUAAryqNTu/kmupSVZRNTXHwyUXliFPvSBHYfSJg6aeWwQeARrJOC37BgE0EDvXeJa19WZDfGySnqumWBWL5LQB/6n+RZJ6uM1lxqukGHlz9WaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nyj6r1aI; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyj6r1aI"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so3653404a12.3
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 14:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786396378; cv=none;
        d=google.com; s=arc-20260327;
        b=OPKnYgU9Fs3xMVHlYPkYRQS+VqKk5JcP4V8b/oENQ9s14giQ/bBAimLIsN3cYe0tfO
         whh3aKDVWcWg9DeOwD/Z8s40usbSWbIT31x/XARwwfJmy/Y79mjOQcK1QboI/awGi/vo
         VEem63cITY9Dq6rz6d9NC3R7OYGSgmQVvj49/gBHpFZ9uLcx1mo1XbsSiaBoPLXhJ+aO
         7y+3qTcIGRckO7y28MubROcnMemb05ykBAXm6oEwz4OLK26C2goQM+BGdf26UgN0hLA9
         xpyGtxY7xbHXjtcz+8V4aWTR6XO0mF45ny+x0fUX337vOMqrnV8GUc1afHWzce6olmBC
         vEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4s9mQ3DkJJifPOKJnOS5mdERe/d6CjgCqbbWdO6jwj4=;
        fh=K85UXy/05wnR64EefsbR7kRJzZjvn75GTiufZVQtZXw=;
        b=ssjvIvyP8ih14omB7mrxkk0fWtKlnki1Vk5Ir96GGlnDw3vApIxr/QVV703Rbw0VfO
         fyK9H8DaJtLQX0oaHqTn6Rg9rHiKxjkBAkpWmj6XDqxepe66W0yTk+DklOBTfysrRX5G
         NPIENytITB/gI8U6WB0WSbNpbVqMAw+4WZNbeLjgaTTgTb9W1T7DBNIl2D0VhmCKQRF/
         cucvuB0WyS+3b/pGzM58AuXXxOhU+RVmEzVjf1L1CAaGZ9Ho9zpfDCb4IDd4eRFKoEYR
         DnlNgrenPciA0R/OVbDxmdGA9PVSGwW0E5tSJUSjiMOcvPCO9TKdsBAN8UQqq7mzaWHw
         S7mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786396378; x=1787001178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4s9mQ3DkJJifPOKJnOS5mdERe/d6CjgCqbbWdO6jwj4=;
        b=Nyj6r1aI+zovkhVh+UPq4+YmPzBW2wb1AAqlygKrD9zpBMjiSdCOrtAfujvrS2Rv3b
         B9uOfUpg5bCNv52qfzFSiuudEVUvX6k+EElkpIzDg/yKVVGPi5NxP/vZnLFHOLsuKAmK
         QqGgZ5BlPRTjdPPgKohtPZiL+LT+C7h4fxO01jK5BTqoYhaLuiYxJzdipLhAhkqLPQmb
         KktalEZepBbiLpe+c/HgP/Qo2AtDdthlcQIcoc5aLHpmQGgBebYg9k/rx7QilE3CNJom
         1kQdh6uHlWNt1/XkoBcFcInRM05bqY29YFYRJYVPS0/p5TQoTVzEmO9WCKTNUOIcuPWu
         GZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786396378; x=1787001178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4s9mQ3DkJJifPOKJnOS5mdERe/d6CjgCqbbWdO6jwj4=;
        b=fcihz8nJLooZpJosw8SdReXb0V1kTmubkcbU18BrAWxrpUIHT7EqnXuVUS5sjfiJyz
         hWPNIEoQdNF4nTfI6kQ8Dgf7Tu47T9c2kFcPNlp1OlQOTLkMo0EytbKEZ6Xa+YXde+UU
         0IjrosVk+xjf0wLZBfwHszQ8TjRT/DJFoJt/9AY79by82R7Oep28s2xqHbW/sdzV7dr3
         4ZwlyPjf/WMP/dB9+SS1C26c37iQ15bC8tFWd7zzdZLuQ4wXn2gB3Ly7KwuBdTNXEO/u
         bAsSS+uEjgHJb1z9Wy+dqAQnL31kU//bp+rHj+erdK9NbWtvbbQBBdMw93b8JZo6jfzi
         WJ6A==
X-Gm-Message-State: AOJu0YxmNkBgYQMbY6KvI0RMtT2At0EsNEkWX5uvVX9mtmcIxbIGCAWs
	1jSPRxpZ4bdy3q+CnvQ1stTs0aOIGzwkWw97OH+qLdmnqqCzP9Sog6KxEM7OYIZVGuSMsL+Y+O7
	QPY32fAhGKAO2NNaYDkOuYo9J/hch7n8=
X-Gm-Gg: AR+sD12bt2P589BeoR+WURpd6ba5e44V8fCwDmUk02rT87TbRm5xQJVtot/92bdjVGm
	thRao3FSPaSf21EeytvjV5E9qnuXgwULRO/3iSKqRlA5dtltHQq6ZaaSAge9+zV4uV3qaqBxmKz
	KZnXAtGdlB81WW0CTVRyAeBGdKJHpmQ3HF41DbYyMuDxPxMX2gGsSU0HiG1U9KkyPPIeH8JOZsi
	hK97GuRLjYxLtzFPX54nHAWFlatZNo1NE6FavcR0sxZRFTakCf9ZXIh0gKKx3aOM5ZqHOk+FVxw
	HmLVrRPmcaBDJBnjZ1oZMvkAysIGoXijUSCXnowL049e
X-Received: by 2002:a05:6402:504e:b0:69f:2c1d:d83c with SMTP id
 4fb4d7f45d1cf-6a1e62d8b29mr12930000a12.21.1786396377743; Mon, 10 Aug 2026
 14:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-4-kbusch@meta.com>
In-Reply-To: <20260519172326.3462354-4-kbusch@meta.com>
From: Chris S <coshi036@gmail.com>
Date: Mon, 10 Aug 2026 17:12:45 -0400
X-Gm-Features: AUfX_mzNv25W_1qVDbnXAMrPYIPaAVX7Rm_Mr4yXO-SFDG25EsvlS7LE2Un-0EY
Message-ID: <CACd_6n2jNS9Msd_N-idPx3ijgN8NUxT1U1m2OrJu=e+GToB+ZA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] block: validate bio bounds in the queue entered context
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, Igor.Achkinazi@dell.com, 
	dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2026/05/20 9:25, Damien Le Moal wrote:
>> Should this be a pr_err_ratelimited() ?

FWIW, I think pr_info is deliberate and worth keeping.  The comment this
patch removes together with bio_check_eod() gave the reason:

  /*
   * Check whether this bio extends beyond the end of the device or
   * partition.  This may well happen - the kernel calls bread() without
   * checking the size of the device, e.g., when mounting a file system.
   */

So it fires on a legitimate and expected pattern, and pr_err would be
noisy for it.  It may be worth carrying that comment over to the new
location so the reason for the level does not get lost.

Keith, I checked this patch against the nvme_setup_rw() WARN I reported
(the second link in your cover letter).  __bio_split_to_limits() is
called from blk_mq_submit_bio() after bio_queue_enter(), on both the
cached-request path and the newly-allocated-request path, so the bounds
check is now serialized against the freeze window in
nvme_update_ns_info_block().  With the capacity forced to 0, the bio is
failed here and can no longer reach nvme_queue_rq(), which is exactly
the race I hit.  Thanks for picking it up, and sorry for the slow reply.

I'll drop my own "nvme: don't WARN on I/O to a namespace revalidated to
unusable metadata" patch in favour of this.

Reviewed-by: Chao Shi <coshi036@gmail.com>

Best,
Chao

On Tue, May 19, 2026 at 1:23=E2=80=AFPM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> bio_check_eod() in submit_bio_noacct() validates that a bio does not
> extend beyond the partition's available sectors. This check runs before
> bio_queue_enter(), so it is not serialized against queue limit updates.
> A driver that freezes the queue, updates limits, changes the capacity,
> and unfreezes can race with a bio that passed the early check under the
> old capacity.
>
> Remove bio_check_eod() and replace it with a bounds check in
> __bio_split_to_limits(), which runs after the queue usage reference has
> been acquired. The check uses partition-aware arithmetic to validate
> both partition bounds and disk capacity in a single comparison that
> works correctly on the post-remap sector values.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-core.c | 26 --------------------------
>  block/blk.h      | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 26 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 92a802dc8042c..c200d0fc44fe7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -547,30 +547,6 @@ int should_fail_bio(struct bio *bio)
>  }
>  ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
>
> -/*
> - * Check whether this bio extends beyond the end of the device or partit=
ion.
> - * This may well happen - the kernel calls bread() without checking the =
size of
> - * the device, e.g., when mounting a file system.
> - */
> -static inline int bio_check_eod(struct bio *bio)
> -{
> -       sector_t maxsector =3D bdev_nr_sectors(bio->bi_bdev);
> -       unsigned int nr_sectors =3D bio_sectors(bio);
> -
> -       if (nr_sectors &&
> -           (nr_sectors > maxsector ||
> -            bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
> -               if (!maxsector)
> -                       return -EIO;
> -               pr_info_ratelimited("%s: attempt to access beyond end of =
device\n"
> -                                   "%pg: rw=3D%d, sector=3D%llu, nr_sect=
ors =3D %u limit=3D%llu\n",
> -                                   current->comm, bio->bi_bdev, bio->bi_=
opf,
> -                                   bio->bi_iter.bi_sector, nr_sectors, m=
axsector);
> -               return -EIO;
> -       }
> -       return 0;
> -}
> -
>  /*
>   * Remap block n of partition p to block n+start(p) of the disk.
>   */
> @@ -802,8 +778,6 @@ void submit_bio_noacct(struct bio *bio)
>                 goto end_io;
>         bio_check_ro(bio);
>         if (!bio_flagged(bio, BIO_REMAPPED)) {
> -               if (unlikely(bio_check_eod(bio)))
> -                       goto end_io;
>                 if (bdev_is_partition(bdev) &&
>                     unlikely(blk_partition_remap(bio)))
>                         goto end_io;
> diff --git a/block/blk.h b/block/blk.h
> index bf1a80493ff1c..e70acb2d358e3 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -423,6 +423,17 @@ static inline bool bio_may_need_split(struct bio *bi=
o,
>  static inline struct bio *__bio_split_to_limits(struct bio *bio,
>                 const struct queue_limits *lim, unsigned int *nr_segs)
>  {
> +       if (unlikely(bio_end_sector(bio) > bdev_nr_sectors(bio->bi_bdev) =
+
> +                                          bio->bi_bdev->bd_start_sect)) =
{
> +               pr_info_ratelimited("%s: attempt to access beyond end of =
device\n"
> +                                   "%pg: rw=3D%d, sector=3D%llu, nr_sect=
ors =3D %u limit=3D%llu\n",
> +                                   current->comm, bio->bi_bdev, bio->bi_=
opf,
> +                                   bio->bi_iter.bi_sector, bio_sectors(b=
io),
> +                                   bdev_nr_sectors(bio->bi_bdev) +
> +                                       bio->bi_bdev->bd_start_sect);
> +               goto ioerr;
> +       }
> +
>         switch (bio_op(bio)) {
>         case REQ_OP_READ:
>         case REQ_OP_WRITE:
> @@ -442,6 +453,9 @@ static inline struct bio *__bio_split_to_limits(struc=
t bio *bio,
>                 *nr_segs =3D 0;
>                 return bio;
>         }
> +ioerr:
> +       bio_io_error(bio);
> +       return NULL;
>  }
>
>  /**
> --
> 2.53.0-Meta
>
