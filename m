Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CF3FB1F
	for <linux-block@vger.kernel.org>; Mon,  1 Apr 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978163; cv=none; b=Lmtsl/+c14n2UA519b5lHFKzSlipnAeSIXyq6ioWphiYwHhDTyEJDizT3NqNNoV5qEmRAFkNua0tYp6dXrcuA7LhDkDV1PjxjQFta6+p6CRbNNmTsg9bYEnfFhpdnCYpzMex/Wl9OBsw+LwPEXnbaYarYZRsw+ffjmpljf31PH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978163; c=relaxed/simple;
	bh=4M4MuUubQSIRKLZKPgzJza5Yg3ff1EyhRlATBvU5lQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHm3k7Y1egug4mr7uqJjtBsH4yf17cnPpkjCEfrbcH0SO1uro++KbxWSWCqSLAeM9GaNTbf3Q0lPVHdVCV/sVuOdmyCIR8qDfQfbemEKqaJeNLk9kqJ1L+g24yT4RllcaYFzLI/dcCmfPhJHJTtpOd9dSiT5RiQIucYtmNokA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nN+Zhx0/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nN+Zhx0/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29deb7e2f7aso2545610a91.1
        for <linux-block@vger.kernel.org>; Mon, 01 Apr 2024 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711978161; x=1712582961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igZz4DG2aBo5XlteLJPBb/+8rJIvsiKaHb3GZJV4VP8=;
        b=nN+Zhx0/mUn6v0AT9QHxjp28ti4s2HWrU1GY3x3O6yk3kbom7aBS0JBJmaZUdKufvq
         plthsoBvzFVyA1fjBxenWvAGQcHuPFofJ/5SnVlRBrp4bcQVQAumf+x7YytfShTko4O7
         tfLCI7uYjoJdfmdQY4UH1p29TlllMNdDB7njaPsRVwFqMR739RCsY/dHJysPBPKOLHqt
         8Nm+lIz00jhJrubxNWXrdSjJRol4pC+PN+gfjJvtg2prsamgDf88JOIM8E840Zmsd977
         DP305iCtsqhqA0/wvri0zzsuE1HTNZui9sLzQS0iONYnES5iTXJiJ9kLrOaPnx4z/NP5
         ++RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711978161; x=1712582961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igZz4DG2aBo5XlteLJPBb/+8rJIvsiKaHb3GZJV4VP8=;
        b=LvdwWCwHg5gWF0SlJFw2/rJpRqlTUelEPs9a6ivIE0Nz9iQDlYSS3tdSArkTYFCgEX
         pcOER8ZXoyQvKMAhr6jMQCQO+TtUnbCF9e1BQWEBNa3inK4aIigVI1wZywOpUmbKh9v6
         hTyBvgemPEMkCtN2/jVNwbKfqIdzy4I7VTpmTy8KomU4Iws563Cmp55Q3f8hZLbUJG7t
         rgCaHdTwZurFsoh2aFWRJ9XPCssRLOjiDv18/Fj0rcL2atTMQ8SA2w9/CGFupJN2UN3i
         6uMSLdqt3didejzK20NuB/ghYgl4OG6yqbrc4SES8J/iqoPNEMlwAZK7e8hvV4AUH0uZ
         IWAA==
X-Forwarded-Encrypted: i=1; AJvYcCXfiwnYqNvm+9P73fh1alr+jmSz7w144neoNs1J/5PbSWvhFRC/BOZ9BZ2wk4uz2z5S60b16cYUmrDdrk3oFygoi5wjF/zZKFLbwTs=
X-Gm-Message-State: AOJu0Yz59qCFMmIXcUbjyAAH4bQp4jXE5HkomY6Z7EDyviC8Oo1HhS1G
	l4nIQyiM3ztI84/SJyThBBkgz8Ahl0jb0DRr4C5SfhDG48+uTxaWsTNc6+JI0CQelPHHbDHecL/
	28atHjcZUzhVv7auABtN9zh1PLYoPmtTrx4rZ
X-Google-Smtp-Source: AGHT+IEBPxB5PgFKwWlCsDWhkUrlsbgYprPrx312H7gGuiVcbcCCEQOB9REDtm9NTjOiD8q99cvt+KkK7MiZtFt0GOM=
X-Received: by 2002:a17:90b:4b04:b0:2a2:2dad:8026 with SMTP id
 lx4-20020a17090b4b0400b002a22dad8026mr3558868pjb.20.1711978160771; Mon, 01
 Apr 2024 06:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094050.2815699-1-senozhatsky@chromium.org>
In-Reply-To: <20240329094050.2815699-1-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 1 Apr 2024 09:28:42 -0400
Message-ID: <CADyq12weZHtQaV_muEOe-gggu07hiun+xDuMJmqaxv8oyz9pLA@mail.gmail.com>
Subject: Re: [PATCHv2] zram: add max_pages param to recompression
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:40=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Introduce "max_pages" param to recompress device attribute
> which sets an upper limit on the number of entries (pages)
> zram attempts to recompress (in this particular recompression
> call). S/W recompression can be quite expensive so limiting
> the number of pages recompress touches can be quite helpful.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Brian Geffon <bgeffon@google.com>

>
> ---
>  Documentation/admin-guide/blockdev/zram.rst |  5 ++++
>  drivers/block/zram/zram_drv.c               | 31 +++++++++++++++++++--
>  2 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/=
admin-guide/blockdev/zram.rst
> index ee2b0030d416..091e8bb38887 100644
> --- a/Documentation/admin-guide/blockdev/zram.rst
> +++ b/Documentation/admin-guide/blockdev/zram.rst
> @@ -466,6 +466,11 @@ of equal or greater size:::
>         #recompress idle pages larger than 2000 bytes
>         echo "type=3Didle threshold=3D2000" > /sys/block/zramX/recompress
>
> +It is also possible to limit the number of pages zram re-compression wil=
l
> +attempt to recompress:::
> +
> +       echo "type=3Dhuge_idle max_pages=3D42" > /sys/block/zramX/recompr=
ess
> +
>  Recompression of idle pages requires memory tracking.
>
>  During re-compression for every page, that matches re-compression criter=
ia,
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index f0639df6cd18..4cf38f7d3e0a 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1568,7 +1568,8 @@ static int zram_bvec_write(struct zram *zram, struc=
t bio_vec *bvec,
>   * Corresponding ZRAM slot should be locked.
>   */
>  static int zram_recompress(struct zram *zram, u32 index, struct page *pa=
ge,
> -                          u32 threshold, u32 prio, u32 prio_max)
> +                          u64 *num_recomp_pages, u32 threshold, u32 prio=
,
> +                          u32 prio_max)
>  {
>         struct zcomp_strm *zstrm =3D NULL;
>         unsigned long handle_old;
> @@ -1645,6 +1646,15 @@ static int zram_recompress(struct zram *zram, u32 =
index, struct page *page,
>         if (!zstrm)
>                 return 0;
>
> +       /*
> +        * Decrement the limit (if set) on pages we can recompress, even
> +        * when current recompression was unsuccessful or did not compres=
s
> +        * the page below the threshold, because we still spent resources
> +        * on it.
> +        */
> +       if (*num_recomp_pages)
> +               *num_recomp_pages -=3D 1;
> +
>         if (class_index_new >=3D class_index_old) {
>                 /*
>                  * Secondary algorithms failed to re-compress the page
> @@ -1710,6 +1720,7 @@ static ssize_t recompress_store(struct device *dev,
>         struct zram *zram =3D dev_to_zram(dev);
>         unsigned long nr_pages =3D zram->disksize >> PAGE_SHIFT;
>         char *args, *param, *val, *algo =3D NULL;
> +       u64 num_recomp_pages =3D ULLONG_MAX;
>         u32 mode =3D 0, threshold =3D 0;
>         unsigned long index;
>         struct page *page;
> @@ -1732,6 +1743,17 @@ static ssize_t recompress_store(struct device *dev=
,
>                         continue;
>                 }
>
> +               if (!strcmp(param, "max_pages")) {
> +                       /*
> +                        * Limit the number of entries (pages) we attempt=
 to
> +                        * recompress.
> +                        */
> +                       ret =3D kstrtoull(val, 10, &num_recomp_pages);
> +                       if (ret)
> +                               return ret;
> +                       continue;
> +               }
> +
>                 if (!strcmp(param, "threshold")) {
>                         /*
>                          * We will re-compress only idle objects equal or
> @@ -1788,6 +1810,9 @@ static ssize_t recompress_store(struct device *dev,
>         for (index =3D 0; index < nr_pages; index++) {
>                 int err =3D 0;
>
> +               if (!num_recomp_pages)
> +                       break;
> +
>                 zram_slot_lock(zram, index);
>
>                 if (!zram_allocated(zram, index))
> @@ -1807,8 +1832,8 @@ static ssize_t recompress_store(struct device *dev,
>                     zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
>                         goto next;
>
> -               err =3D zram_recompress(zram, index, page, threshold,
> -                                     prio, prio_max);
> +               err =3D zram_recompress(zram, index, page, &num_recomp_pa=
ges,
> +                                     threshold, prio, prio_max);
>  next:
>                 zram_slot_unlock(zram, index);
>                 if (err) {
> --
> 2.44.0.478.gd926399ef9-goog
>
