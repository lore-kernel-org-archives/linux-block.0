Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE764EB4C
	for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713407499; cv=none; b=VabJeFr+9GX3wlWnNOv5LIaKWgCJ6n7OygvkoYVgHX/SoGp0lBAvguHc6RgTA22aiaxuffIMhXUuiweOSelZKTyMx5f2acXn7m1qfNY8RCxstGPt0BHILUNeEeg41dUvdH0WyGuUZeqg5UBwb4elodrc+4grP7LXuO/CSNSi5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713407499; c=relaxed/simple;
	bh=ZzXqgNnkmorXkOsSEkRIKDuwf8NN6G+/uM7U/AMTiYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srEWaUp7YgyL4IiLeBprQ3LteknGRoOoamMJRixrCag9nzzVRX1n8NhXpk/uSxm4LQgu5ztyQB9ZmwJXeS/enYzrg5tJgcZvW05VbzhL8NdRpTSt77mhqUxDxeGKdcJOV5sHy53fA2tAqN0rWMiEsqAKZu9srTyMqKfFRhsWNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0gRF1D4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0gRF1D4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713407496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Awz2kTTfMqqBzH4TtUWNSORUe/UT2+kahfVjhpGyyTk=;
	b=S0gRF1D4kWRZhUogvP4WvIlKRY91u1ZEen4vRni5bml30jxl5+fj/mxhkiGrEFadj3wa4i
	AVoMj0qPeT18TuMnFTvO1aIfl/0FD16Fr/OhOccv0dBfbDFSo+wJQrL2ybyf+nroYr4+pi
	qFO0dszno1dlEKav4RZj3J1ysCPPPgQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-dHQX5wWBOR2ok1a4W0FDkA-1; Wed, 17 Apr 2024 22:31:32 -0400
X-MC-Unique: dHQX5wWBOR2ok1a4W0FDkA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a5e1e7bab9so530712a91.2
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 19:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713407491; x=1714012291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awz2kTTfMqqBzH4TtUWNSORUe/UT2+kahfVjhpGyyTk=;
        b=kqwcuVYfkQ2z5wZr9Ka/iZKdoWmXNLqByl8Je2xd/jF3zGWt1jkx0piL1jEkHOkNst
         s1y4ll6nt3TTATrKCT/6fgqgwIkDduZH9sxYF16FFqTO3YhByUsKlUXh6tRNBRks8ck2
         IEDmDg3lo4fDN8Czl6TfEwkAVmm2cQbtTIrP/NFglT350k3sVVsOrpE2wAogUL9bWZGA
         lFy8nyqaYO250iS78VrZKk4iSsWfSKQvYc1GAKW1nZiKYbi9Q7pUj3gLF9fVx0dbyr0R
         k7TxaVuYW8QaWuYrhwDyMllfRd918fAFkMyMDV645aJIkTUvby77YINxF9hLgi/kk30y
         hA1A==
X-Forwarded-Encrypted: i=1; AJvYcCUqVP9HjBD/DS8EoS8qZ0+pIUW2AJUyX3ENi796a78/6wPvix+NeU6tg417VRR8zNQOTOgV10KBV2+I/7f692/Yg+4LfhzgukBBWRs=
X-Gm-Message-State: AOJu0YyLd6ZHptz+lao4xymV0jJ1yLw62mhkVFdvzP1b7oa4G/iFWAQr
	NuAcx7zR0Bd5sbx0t1qwkYmQmjqwXO3+PyW/9EnM1shp/8KGNQvJdEHi4paklOXrlZmTO3+fL4V
	whFkO4R6SD5/Zq/vCCzAc+UmWMiTXR8CfmTs6U9bynjzg6gAm5l6Wsxb1crSVuhzlNXm7Ys9UFy
	eQ2p87jJn+Cm+nHzoK5Hn8AbwW3rafmFfPqxY=
X-Received: by 2002:a17:90b:1bc6:b0:2a2:9464:f58 with SMTP id oa6-20020a17090b1bc600b002a294640f58mr1129961pjb.49.1713407490905;
        Wed, 17 Apr 2024 19:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnorOhtzN9DzmOb6hJ7LymsRXbDxRYLINkfCBWSe3RVMRVZM6kGOy3ngSC0BlmDvLVemNDuumh+7Wl3xj/YOs=
X-Received: by 2002:a17:90b:1bc6:b0:2a2:9464:f58 with SMTP id
 oa6-20020a17090b1bc600b002a294640f58mr1129947pjb.49.1713407490560; Wed, 17
 Apr 2024 19:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416005633.877153-1-ming.lei@redhat.com> <20240416152842.13933-1-snitzer@kernel.org>
In-Reply-To: <20240416152842.13933-1-snitzer@kernel.org>
From: Changhui Zhong <czhong@redhat.com>
Date: Thu, 18 Apr 2024 10:31:19 +0800
Message-ID: <CAGVVp+XDaZFEfhVz0XEN4oYQyN6W9_eX9H_E_1nshnsaweED2g@mail.gmail.com>
Subject: Re: [PATCH v2] dm: restore synchronous close of device mapper block device
To: Mike Snitzer <snitzer@kernel.org>
Cc: ming.lei@redhat.com, brauner@kernel.org, dm-devel@lists.linux.dev, 
	jack@suse.cz, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:29=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> =
wrote:
>
> From: Ming Lei <ming.lei@redhat.com>
>
> 'dmsetup remove' and 'dmsetup remove_all' require synchronous bdev
> release. Otherwise dm_lock_for_deletion() may return -EBUSY if the open
> count is > 0, because the open count is dropped in dm_blk_close()
> which occurs after fput() completes.
>
> So if dm_blk_close() is delayed because of asynchronous fput(), this
> device mapper device is skipped during remove, which is a regression.
>
> Fix the issue by using __fput_sync().
>
> Also: DM device removal has long supported being made asynchronous by
> setting the DMF_DEFERRED_REMOVE flag on the DM device. So leverage
> using async fput() in close_table_device() if DMF_DEFERRED_REMOVE flag
> is set.
>
> Reported-by: Zhong Changhui <czhong@redhat.com>
> Fixes: a28d893eb327 ("md: port block device access to file")
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [snitzer: editted commit header, use fput() if DMF_DEFERRED_REMOVE set]
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  drivers/md/dm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 56aa2a8b9d71..7d0746b37c8e 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -765,7 +765,7 @@ static struct table_device *open_table_device(struct =
mapped_device *md,
>         return td;
>
>  out_blkdev_put:
> -       fput(bdev_file);
> +       __fput_sync(bdev_file);
>  out_free_td:
>         kfree(td);
>         return ERR_PTR(r);
> @@ -778,7 +778,13 @@ static void close_table_device(struct table_device *=
td, struct mapped_device *md
>  {
>         if (md->disk->slave_dir)
>                 bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> -       fput(td->dm_dev.bdev_file);
> +
> +       /* Leverage async fput() if DMF_DEFERRED_REMOVE set */
> +       if (unlikely(test_bit(DMF_DEFERRED_REMOVE, &md->flags)))
> +               fput(td->dm_dev.bdev_file);
> +       else
> +               __fput_sync(td->dm_dev.bdev_file);
> +
>         put_dax(td->dm_dev.dax_dev);
>         list_del(&td->list);
>         kfree(td);
> --
> 2.40.0
>

I tried to apply this patch and looks this issue has solved by this patch

