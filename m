Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2922CCD5
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753077; cv=none; b=Ts4l6HHAZ7oPxe89WrLHnl1N7VNGJb4KHwJOZ7WfJm3GBRNsQMCO5T3qoTPsuV8b5El7HcJtUT2yvlopzjbh5Yg8F6jUp+nHCYj/FjU0M4O5OTO9SWVM9tfE0OA9rii+ziFaHQ5yUxjI0xj4M4GYW4QKrjA31OFegxsBdRWONYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753077; c=relaxed/simple;
	bh=OzajHx4z68xs8tPqrnPYw9OsFnlbTp5GcuZhIkKMmfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww2hpt/qjtV6TYEiP502DaZBGzpLuytpSIPEQ57XqZZ5GTdYKT4tx+4O3gF+cKaN3fstpm7fTX+TcgNxzHyVO/SmASCNm+S+cwGFMQ+VzvfPVx192XdCnln/yRgzsOIaKJ4SXpzGGN22eDnannaXWbkqxjev+ZyEqR/e4VMWAEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYwoItm7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYwoItm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710753074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZU3vJhylCU9TNOivqnxQtoow878x5O9ODjNAR+f+JGc=;
	b=VYwoItm7bul4DMGKOT5Rt/zeoGtwFfVilyawfWmSFgNhqXel5wHPTCWzk+ahkdu6BMbM8D
	dS829FhZTkNYnglMpfjvvRW6ooZkhQHnhq6o8DT3SgVMw2BwqIx3zoXBARmnj+bHQl9UYq
	as8g+jVNJvSrcY5XKfnO6zkS/GDaVyk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-SAdmbRYfOxymje5tfTQddQ-1; Mon, 18 Mar 2024 05:11:12 -0400
X-MC-Unique: SAdmbRYfOxymje5tfTQddQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29de982f09aso2733889a91.1
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 02:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753070; x=1711357870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZU3vJhylCU9TNOivqnxQtoow878x5O9ODjNAR+f+JGc=;
        b=XqNbRtPgiAmVWmLAEBFKfc7KuleVGsdGv8aARE9S5qF7/B65i21mWkmeeAGz1mpDZs
         FZPYAA19spmeIad46eAXyDbVMuoAWI3uvC1ewNo1hLdvnM6lBD6AI8g2L1YtjY8q2McA
         r1A5mplyfGbjgv4p44tMqaUDy7N1hOlMDRanedYRaaq2DlV7mFrW/sH8uTu57GKKDW9p
         hhlQHbc202tfonSUrRIoIlHdqw9+YuUsU6eTe3ugHhYi976sA+L9IrfuMNIYgq0YlwCV
         tOeLtMQNnDKeVm4Oc61GTrYsX3c4WVwfgw7FWc/piWHune+6gW3O6JOWNyZH3qBZJVF6
         u1kw==
X-Forwarded-Encrypted: i=1; AJvYcCVGMkglx5BtWc2Eq+Q91+9DCuVkMrBkc/RDvE3aXMomdLN8EJ+tgQ58ZyQ8N8PAM3NrziPL+99IWLAcSui5/Duqj2zMDwdBH8dkK/4=
X-Gm-Message-State: AOJu0YyuFQ2WKVqfXItmaZPskEtTpPaxQD0iBjw6hEZmviIgFH7XjBFu
	JE5SujTdN7k4t863pIZSlvVzNHrbz3yM07j3TLiNIiEzSraMNQBs/SQ2sH7ANVSes+4Wu+qAo3k
	netO3uwJj7sgmwK5zQN72L+vu47XII+uNbrOemwL7paKTFV4P45kYVQvx1J2xvOuiffWA9wkN61
	pvSxXDDa45Fecj8FBm58O/oN+NtIzkP8FNDwYs6i19E5XHtjLM
X-Received: by 2002:a17:90a:f282:b0:29c:3c24:a5da with SMTP id fs2-20020a17090af28200b0029c3c24a5damr8153306pjb.27.1710753070740;
        Mon, 18 Mar 2024 02:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6HKiBb8ynkHMj2VAmb3CTXQVsv84Z7FCXl2ZuDKWEA6vzbgNRPG/xW3tOTbgV4aBho30uFlX6LHEnOH5bDu0=
X-Received: by 2002:a17:90a:f282:b0:29c:3c24:a5da with SMTP id
 fs2-20020a17090af28200b0029c3c24a5damr8153290pjb.27.1710753070388; Mon, 18
 Mar 2024 02:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314165814.tne3leyfmb4sqk2t@quack3> <20240315-freibad-annehmbar-ca68c375af91@brauner>
In-Reply-To: <20240315-freibad-annehmbar-ca68c375af91@brauner>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 18 Mar 2024 17:10:57 +0800
Message-ID: <CAHj4cs8F0KzdqDdJcOaTf2Nk4P7Dg1H8ooBFrZQM-iMwBx=OWw@mail.gmail.com>
Subject: Re: [PATCH] fs,block: get holder during claim
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:23=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Now that we open block devices as files we need to deal with the
> realities that closing is a deferred operation. An operation on the
> block device such as e.g., freeze, thaw, or removal that runs
> concurrently with umount, tries to acquire a stable reference on the
> holder. The holder might already be gone though. Make that reliable by
> grabbing a passive reference to the holder during bdev_open() and
> releasing it during bdev_release().
>
> Fixes: f3a608827d1f ("bdev: open block device as files") # mainline only
> Reported-by: Christoph Hellwig <hch@infradead.org>
> Link: https://lore.kernel.org/r/ZfEQQ9jZZVes0WCZ@infradead.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Verified the blktests ndb/003 panic issue was fixed by this patch,
feel free to add:

Tested-by: Yi Zhang <yi.zhang@redhat.com>




> ---
> Hey all,
>
> I ran blktests with nbd enabled which contains a reliable repro for the
> issue. Thanks to Christoph for pointing in that direction. The
> underlying issue is not reproducible anymore with this patch applied.
> xfstests and blktests pass.
>
> Thanks!
> Christian
> ---
>  block/bdev.c           |  7 +++++++
>  fs/super.c             | 18 ++++++++++++++++++
>  include/linux/blkdev.h | 10 ++++++++++
>  3 files changed, 35 insertions(+)
>
> diff --git a/block/bdev.c b/block/bdev.c
> index e7adaaf1c219..7a5f611c3d2e 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -583,6 +583,9 @@ static void bd_finish_claiming(struct block_device *b=
dev, void *holder,
>         mutex_unlock(&bdev->bd_holder_lock);
>         bd_clear_claiming(whole, holder);
>         mutex_unlock(&bdev_lock);
> +
> +       if (hops && hops->get_holder)
> +               hops->get_holder(holder);
>  }
>
>  /**
> @@ -605,6 +608,7 @@ EXPORT_SYMBOL(bd_abort_claiming);
>  static void bd_end_claim(struct block_device *bdev, void *holder)
>  {
>         struct block_device *whole =3D bdev_whole(bdev);
> +       const struct blk_holder_ops *hops =3D bdev->bd_holder_ops;
>         bool unblock =3D false;
>
>         /*
> @@ -627,6 +631,9 @@ static void bd_end_claim(struct block_device *bdev, v=
oid *holder)
>                 whole->bd_holder =3D NULL;
>         mutex_unlock(&bdev_lock);
>
> +       if (hops && hops->put_holder)
> +               hops->put_holder(holder);
> +
>         /*
>          * If this was the last claim, remove holder link and unblock evp=
oll if
>          * it was a write holder.
> diff --git a/fs/super.c b/fs/super.c
> index ee05ab6b37e7..71d9779c42b1 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1515,11 +1515,29 @@ static int fs_bdev_thaw(struct block_device *bdev=
)
>         return error;
>  }
>
> +static void fs_bdev_super_get(void *data)
> +{
> +       struct super_block *sb =3D data;
> +
> +       spin_lock(&sb_lock);
> +       sb->s_count++;
> +       spin_unlock(&sb_lock);
> +}
> +
> +static void fs_bdev_super_put(void *data)
> +{
> +       struct super_block *sb =3D data;
> +
> +       put_super(sb);
> +}
> +
>  const struct blk_holder_ops fs_holder_ops =3D {
>         .mark_dead              =3D fs_bdev_mark_dead,
>         .sync                   =3D fs_bdev_sync,
>         .freeze                 =3D fs_bdev_freeze,
>         .thaw                   =3D fs_bdev_thaw,
> +       .get_holder             =3D fs_bdev_super_get,
> +       .put_holder             =3D fs_bdev_super_put,
>  };
>  EXPORT_SYMBOL_GPL(fs_holder_ops);
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f9b87c39cab0..c3e8f7cf96be 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1505,6 +1505,16 @@ struct blk_holder_ops {
>          * Thaw the file system mounted on the block device.
>          */
>         int (*thaw)(struct block_device *bdev);
> +
> +       /*
> +        * If needed, get a reference to the holder.
> +        */
> +       void (*get_holder)(void *holder);
> +
> +       /*
> +        * Release the holder.
> +        */
> +       void (*put_holder)(void *holder);
>  };
>
>  /*
> --
> 2.43.0
>
>


--
Best Regards,
  Yi Zhang

