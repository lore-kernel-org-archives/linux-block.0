Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9AC10FF
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723686162; cv=none; b=XFlUO69Zn/UIhj2xa3CHlJLVNI68YfulfRcoRhOriGSssESW54ZeZXZ52PQW0XVUWJP0qkIirGL8bDUDa2BSqdWcQDC9jLhi2QqSA2T3JUkmxk6surIchZNiV8glDwvvtgnRyYk7+aPjy3Azhzlm/h7PpstkwAE0V5dgchWsDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723686162; c=relaxed/simple;
	bh=E6FKHKidRonGKOHEN40H7P70gEg4mgWPuWn21CDjAUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aglzQvK3YCAJkEWh0cEc6bdVvYGu/OWP/A8HV3NcHjYWjM5X4x9oZFX7AoyC7M5nlL4KfY2MGRMx0ARJcCHG7zky3hxZNk3f6qhWwRodci13oO6ekOX2Wzf/EmnJjyP/54TFhs2Z6VJb6GhxkZsBseZAjmugAsjXe0lFlU6Tmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UecL9i5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UecL9i5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723686159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDO7p1/rCt/Ulp3/NJW+f3wt6sswEX3iXmzKx2IC/YQ=;
	b=UecL9i5DgLJ1s01aef+sVOxzH2/5byQVcBFlxc/qAvJaLA9tYFgHsvK0Zqx2QvKvPVCBsf
	M8mOvsF+C8wrdpKHpSmC9iwnF+fDsFi9/nJ+VOHoXHpd09OH8Yi5JchwmmzBdKwnc1++p6
	NqFtoCh+cy/LkHsbXVpBtw/5zL9YL2o=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-2If6Px_OM5quuGkZX88g6g-1; Wed, 14 Aug 2024 21:42:37 -0400
X-MC-Unique: 2If6Px_OM5quuGkZX88g6g-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-81ef745969aso2708241.1
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2024 18:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723686157; x=1724290957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDO7p1/rCt/Ulp3/NJW+f3wt6sswEX3iXmzKx2IC/YQ=;
        b=ao5iXXDPwtK5cO0hyWyJmJG/FfTuDREnfa1oqI7pNXLQ4tZWwdeAKp2UGP551JQBc1
         etkBg11QpyYCmglx9xb7pXCuCDzxXTefCRxWz0wAwoR8ElffFEkOEUddynY5cXxHtmdc
         Lk5vMpF1VUmAIbMTCspYQLsSGBGYhywI4S8FNo7NhX+K5gKZFO2xXBl52ApRrfcdqB5W
         fwCYd4Ox8dsYH2c78peRNvrCqWEKhq89xzobn+PWlNHEYPIMRPSvOcV3SjIm3DR+84bh
         H9b78De/tCHTSKDD+xWFUQq/Swtixm96hTvlJn8zhuGHMwEXGye7ygqmiT8Gk+rwSgN+
         UXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkSh3YT3RaGkizAAgnDhFGVsIBCU2SQAjWYbMzM0RUycIChLwgw1NPFdix35PBnV7RQg9kZ4LBtcAY8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDwyoS97ryU2ASZ/8/vm+slqgN44/pE5fdVM80Y1+Cx7/6orM
	+x8rOnW3V5FO9GjkLqtmPbb/5DZ4Rd+hYmKoBLhr0D+oxgDYt1SY9isLVhICmQVmFgYMbpcaAoi
	pLfkmbIZF4794UiElJOw/iGFXkYKoceYgC7saMcAjldiHm3qOyDZ+zO7kW6z+gjip7xFFY1QIol
	aPsqo4zFGUWNY1/+IqFaYN/izvB4NbgYJGypg=
X-Received: by 2002:a05:6122:1685:b0:4f5:312a:658a with SMTP id 71dfb90a1353d-4fc5aa5ccdamr732816e0c.0.1723686157202;
        Wed, 14 Aug 2024 18:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGkXgg3KEei4df4ZQe2BBMOv0cgXLjhI//+DZyaCr9SlaZy09JMcILmazo/fy8v4koEzrDcRzwJjOp/HiyDrY=
X-Received: by 2002:a05:6122:1685:b0:4f5:312a:658a with SMTP id
 71dfb90a1353d-4fc5aa5ccdamr732804e0c.0.1723686156775; Wed, 14 Aug 2024
 18:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723601133.git.asml.silence@gmail.com> <6ecd7ab3386f63f1656dc766c1b5b038ff5353c2.1723601134.git.asml.silence@gmail.com>
In-Reply-To: <6ecd7ab3386f63f1656dc766c1b5b038ff5353c2.1723601134.git.asml.silence@gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 15 Aug 2024 09:42:24 +0800
Message-ID: <CAFj5m9+CXS_b5kgFioFHTWivb6O+R9HytsSQEHcEzUM5SqHfgw@mail.gmail.com>
Subject: Re: [RFC 5/5] block: implement io_uring discard cmd
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Conrad Meyer <conradmeyer@meta.com>, linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:46=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> Add ->uring_cmd callback for block device files and use it to implement
> asynchronous discard. Normally, it first tries to execute the command
> from non-blocking context, which we limit to a single bio because
> otherwise one of sub-bios may need to wait for other bios, and we don't
> want to deal with partial IO. If non-blocking attempt fails, we'll retry
> it in a blocking context.
>
> Suggested-by: Conrad Meyer <conradmeyer@meta.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/blk.h             |  1 +
>  block/fops.c            |  2 +
>  block/ioctl.c           | 94 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h |  2 +
>  4 files changed, 99 insertions(+)
>
> diff --git a/block/blk.h b/block/blk.h
> index e180863f918b..5178c5ba6852 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -571,6 +571,7 @@ blk_mode_t file_to_blk_mode(struct file *file);
>  int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
>                 loff_t lstart, loff_t lend);
>  long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
> +int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)=
;
>  long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long =
arg);
>
>  extern const struct address_space_operations def_blk_aops;
> diff --git a/block/fops.c b/block/fops.c
> index 9825c1713a49..8154b10b5abf 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -17,6 +17,7 @@
>  #include <linux/fs.h>
>  #include <linux/iomap.h>
>  #include <linux/module.h>
> +#include <linux/io_uring/cmd.h>
>  #include "blk.h"
>
>  static inline struct inode *bdev_file_inode(struct file *file)
> @@ -873,6 +874,7 @@ const struct file_operations def_blk_fops =3D {
>         .splice_read    =3D filemap_splice_read,
>         .splice_write   =3D iter_file_splice_write,
>         .fallocate      =3D blkdev_fallocate,
> +       .uring_cmd      =3D blkdev_uring_cmd,

Just be curious, we have IORING_OP_FALLOCATE already for sending
discard to block device, why is .uring_cmd added for this purpose?

Thanks,

