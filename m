Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B51B0F11
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 04:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554838; cv=none; b=Kr6HHPDr229FJ3kBH4I6MvWD/k4bakSm34wUMhWRDXBwvL2v4IeBFNobT4irAFvshbkaYOTlXQV7YxuZh/u0jIfacMktm2zcDI4JOaHAxhFAGCgHQxmVZsEpVGIVQbGPZl4vj1Op7hAlhOrzwCJXbyT4npUJEBUvuzbev7FAzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554838; c=relaxed/simple;
	bh=5Q3Mom89Oc9y3zyftp+jFydfEqxQLSJpVyDACzdoa/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMjLzo+gJ6h/1LqCZ/nDjAAC8wVPMnUaavbX/LHkNxkzjPqsfFK3+SbC8enOEy5yOFRcTt/Q/FlvQDNqXYauBLXAFQdQ/Ezhg2a9ZHBjyItq28U45mbSZMn4z7taNAgaT5NsRccQ4VM5gFIcmTgj0X2elb3QEeAfnI3rPWHeTlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7nsCJNO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7nsCJNO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745554835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xR/fWMDLnjbCwmdvRYjaVgsHQjS4Hxv9j2CoZGyvr/0=;
	b=d7nsCJNOltJU9v1AJNfQhq8WfcFQUpTZQWI3OiaCcyT7+JX82b5U0EWtxZxT+hl2tn0V3D
	mfx0mUG41SK0Th3fNz/HPmx+aYPJoSeGH/bcQHLu3lQE6iyMAK8Dz6A77VUVRbcPsyEejw
	GYO74tkpdgU3M+YYhNEXe0pUsXfBi6Y=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-GHVTuVHaMU67PTmTt4Vm6g-1; Fri, 25 Apr 2025 00:20:33 -0400
X-MC-Unique: GHVTuVHaMU67PTmTt4Vm6g-1
X-Mimecast-MFC-AGG-ID: GHVTuVHaMU67PTmTt4Vm6g_1745554833
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-86d376bc992so1795601241.3
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 21:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745554833; x=1746159633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xR/fWMDLnjbCwmdvRYjaVgsHQjS4Hxv9j2CoZGyvr/0=;
        b=BB2zSKlCNx8oy6ehD8Kitv4SiM5bgxxIJSt9DOdbTgLCI81C52JXD8S27fk25f5D3f
         BkCi93oeLOAveOD2JuZ0Vqi2+RsWknWwSj52o3ZIpWBZHGHQosXRdQMbhkCCT0YVrUG7
         +3frav2xdYlydjvcpJxAOfKdtNh3swDQ6cf2CTABaQuv1FisB+EEZ89ilReMCWM9vXcZ
         G4zaEmPBI7N9tUcv3QznUEEBSH+w5dTcwPZo5/UrMumcl18j0fkVb9GdMP9PJ98j0Q3L
         /mAWKQVvlN38fCgTaXnnBYibOWdxeNc387c2cSvOn4/HWsaAsv6UU2mbXP44/VtT6ERP
         CKCA==
X-Forwarded-Encrypted: i=1; AJvYcCWcNz3f0DD7OeP+YCB3eXwvEHh4acLjDZYAVT/7m7ZwHWWrjDz6xEucLsMLLnetvNBxLYcWxhy9kmvIEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+Wgu6SC2mrOhpxrs+IeLQ48Vz3VWXibHCuuCTzpIw4NY0hld
	IgIVNjMDL1K+thP5YDClXKqaV0s6K40tgsOjLe5ZtRzh6+XBpnX4wYNItSFoO5kp8aBpwO3FJMq
	KfUimoxGP/IXvFko0Km2rxYJlumXZOimUqZqWEAmijhkKqUhRRptpbIHyZKsQ3MiBqzI+GfplIo
	HlFPe6qvw7kNlMPn6epYjt+p327sm5R7IxZmPYJahHS5TtErXx
X-Gm-Gg: ASbGncsTQwloao+zMLW8irqD9BhcXocRKIkJW0eTdOnp/GRg/60M1etc7KQw8CxNLvk
	a0MWQcPcThZJkk+rhjT0QZ7lbLkE5UoZjugJPoqu4Z9gqYPnfarxcrIt7SbX2j25MaCLOQw==
X-Received: by 2002:a05:6102:941:b0:4bb:e511:15a6 with SMTP id ada2fe7eead31-4d543dc0dc9mr280596137.11.1745554833006;
        Thu, 24 Apr 2025 21:20:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+ZaX5/u4IXJPFGkEDtJPh4I/uc6bTX0tC38RQ0tu4F39TadHB0MpGm548SRCfGfhXtl8n0CBmffMVWNLeV5U=
X-Received: by 2002:a05:6102:941:b0:4bb:e511:15a6 with SMTP id
 ada2fe7eead31-4d543dc0dc9mr280594137.11.1745554832743; Thu, 24 Apr 2025
 21:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <680a45db.050a0220.10d98e.000a.GAE@google.com> <20250425034057.3133195-1-lizhi.xu@windriver.com>
In-Reply-To: <20250425034057.3133195-1-lizhi.xu@windriver.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 25 Apr 2025 12:20:21 +0800
X-Gm-Features: ATxdqUFraUfCfMCyRx3c37eHUblN-XwH6RIB8Ql5xT1vd1m9qRDtL4b-jAdR2_A
Message-ID: <CAFj5m9LVuekp_n6pEfs17n6QB3Q0yu-qRP67NOJb9ZXRNyhP3Q@mail.gmail.com>
Subject: Re: [PATCH] loop: Add sanity check for read/write_iter
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 11:41=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> =
wrote:
>
> Some file systems do not support read_iter or write_iter, such as selinux=
fs
> in this issue.
> So before calling them, first confirm that the interface is supported and
> then call it.
>
> Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6af973a3b8dfd2faefdc
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  drivers/block/loop.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 674527d770dc..4f968e3071ed 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -449,10 +449,15 @@ static int lo_rw_aio(struct loop_device *lo, struct=
 loop_cmd *cmd,
>         cmd->iocb.ki_flags =3D IOCB_DIRECT;
>         cmd->iocb.ki_ioprio =3D IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
>
> -       if (rw =3D=3D ITER_SOURCE)
> -               ret =3D file->f_op->write_iter(&cmd->iocb, &iter);
> -       else
> -               ret =3D file->f_op->read_iter(&cmd->iocb, &iter);
> +       ret =3D 0;
> +       if (rw =3D=3D ITER_SOURCE) {
> +               if (likely(file->f_op->write_iter))
> +                       ret =3D file->f_op->write_iter(&cmd->iocb, &iter)=
;
> +       }
> +       else {
> +               if (likely(file->f_op->read_iter))
> +                       ret =3D file->f_op->read_iter(&cmd->iocb, &iter);
> +       }

The check can be added in loop_configure()/loop_change_fd()
instead of fast IO path.

Thanks,

