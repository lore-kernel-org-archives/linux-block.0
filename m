Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2B1C77B7A
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 16:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbjEYQDp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 12:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbjEYQDm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 12:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EB0199
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685030573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiRt50oXKhasmrzR2kh6FHaULiNwoG0spSQORGoTHTA=;
        b=AmdPm0GVc2ScJcy5NpFbB+p1e9mZQ6eAdRv8tf0CtKxWPILivh683GbnyFdHlp4I/O9Vob
        LOFNi5Jh8YSahTb83IuTGOwkFjJAQEwlZ8QzNfIp/pJh6S/V1KfkHMLb1Zv39UweGktiZ2
        X0IMjLQBRt/ZZvZT5iXLosOHbuoDnEY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-mjTZwWWIPLOfSMwB_AF-tg-1; Thu, 25 May 2023 12:02:51 -0400
X-MC-Unique: mjTZwWWIPLOfSMwB_AF-tg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1ae8ed0a9dfso9940815ad.1
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 09:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030570; x=1687622570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiRt50oXKhasmrzR2kh6FHaULiNwoG0spSQORGoTHTA=;
        b=cbrKSB6Ct5Svm1xOKVvBb1Tdmzags6uhw8zxR8JKUkpiPVbogvzCHcz/kxha8HpFHU
         G2IBt8h8iz1xj2ZCfTrpX0qM7eIVtaSWSd42ozdO0A2NhBvNz1XQiLQAL59Vll3cgrI8
         2OxL4uRtxAa7nyjf3+dEWe00KZT5I569hVW9ru2CmHt6J7ouBrXi0zNEBsHGAA1u4S+h
         llNrxn4c82Us99cbELuaATEQp/VwLdfWtMa+a12FlozWLxHHzz7/zKWd4wUnrM93dUkb
         TZQ3ELoJ6ZvZpNLC9TUFyHxSIdnfbCbTK8RBs7lIizvvmw16o+GxySkV5qgph5TCz/Lh
         b+0Q==
X-Gm-Message-State: AC+VfDxjmPIoe/+xCfeqMP+wiW351Iwm0qLnqfVPlLVIHxrFx1jt87T9
        UAohQza7HP5ooh1ho4NE+23Q0p9nXl+gqBH98VGuY3rDuvTC1VS8TO5T42KUZslupITxwSfo3na
        SBA3/xGtYLhprHaVHcSqnYj4oHdJJQ+62Ldbq4co=
X-Received: by 2002:a17:902:f54c:b0:1af:f64c:f363 with SMTP id h12-20020a170902f54c00b001aff64cf363mr3052065plf.15.1685030569933;
        Thu, 25 May 2023 09:02:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IxaSUVZPKltFK7HOITIsIRGnmd5NzIdTwh6dJNU2vgkdbKhe1zl+1aodXLLyyl7kcWSFpgVAL2XCU4JAoynY=
X-Received: by 2002:a17:902:f54c:b0:1af:f64c:f363 with SMTP id
 h12-20020a170902f54c00b001aff64cf363mr3052030plf.15.1685030569588; Thu, 25
 May 2023 09:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230524063810.1595778-1-hch@lst.de> <20230524063810.1595778-8-hch@lst.de>
In-Reply-To: <20230524063810.1595778-8-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 25 May 2023 18:02:37 +0200
Message-ID: <CAHc6FU6akk6yg1YGpgq-XqMv7soOLA4_Jg17T1M+NKn1PRmJkg@mail.gmail.com>
Subject: Re: [PATCH 07/11] iomap: update ki_pos in iomap_file_buffered_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 8:54=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> All callers of iomap_file_buffered_write need to updated ki_pos, move it
> into common code.

Thanks for this set of cleanups, especially for the patch killing
current->backing_dev_info.

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/gfs2/file.c         | 4 +---
>  fs/iomap/buffered-io.c | 9 ++++++---
>  fs/xfs/xfs_file.c      | 2 --
>  fs/zonefs/file.c       | 4 +---
>  4 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 904a0d6ac1a1a9..c6a7555d5ad8bb 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -1044,10 +1044,8 @@ static ssize_t gfs2_file_buffered_write(struct kio=
cb *iocb,
>         pagefault_disable();
>         ret =3D iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
>         pagefault_enable();
> -       if (ret > 0) {
> -               iocb->ki_pos +=3D ret;
> +       if (ret > 0)
>                 written +=3D ret;
> -       }
>
>         if (inode =3D=3D sdp->sd_rindex)
>                 gfs2_glock_dq_uninit(statfs_gh);
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 063133ec77f49e..550525a525c45c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -864,16 +864,19 @@ iomap_file_buffered_write(struct kiocb *iocb, struc=
t iov_iter *i,
>                 .len            =3D iov_iter_count(i),
>                 .flags          =3D IOMAP_WRITE,
>         };
> -       int ret;
> +       ssize_t ret;
>
>         if (iocb->ki_flags & IOCB_NOWAIT)
>                 iter.flags |=3D IOMAP_NOWAIT;
>
>         while ((ret =3D iomap_iter(&iter, ops)) > 0)
>                 iter.processed =3D iomap_write_iter(&iter, i);
> -       if (iter.pos =3D=3D iocb->ki_pos)
> +
> +       if (unlikely(ret < 0))
>                 return ret;
> -       return iter.pos - iocb->ki_pos;
> +       ret =3D iter.pos - iocb->ki_pos;
> +       iocb->ki_pos +=3D ret;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 431c3fd0e2b598..d57443db633637 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -720,8 +720,6 @@ xfs_file_buffered_write(
>         trace_xfs_file_buffered_write(iocb, from);
>         ret =3D iomap_file_buffered_write(iocb, from,
>                         &xfs_buffered_write_iomap_ops);
> -       if (likely(ret >=3D 0))
> -               iocb->ki_pos +=3D ret;
>
>         /*
>          * If we hit a space limit, try to free up some lingering preallo=
cated
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 132f01d3461f14..e212d0636f848e 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -643,9 +643,7 @@ static ssize_t zonefs_file_buffered_write(struct kioc=
b *iocb,
>                 goto inode_unlock;
>
>         ret =3D iomap_file_buffered_write(iocb, from, &zonefs_write_iomap=
_ops);
> -       if (ret > 0)
> -               iocb->ki_pos +=3D ret;
> -       else if (ret =3D=3D -EIO)
> +       if (ret =3D=3D -EIO)
>                 zonefs_io_error(inode, true);
>
>  inode_unlock:
> --
> 2.39.2
>

