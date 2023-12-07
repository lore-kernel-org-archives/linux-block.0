Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr9DECGz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4295AAC
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701960939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFUwTkwUasQAuYCMcpY6aWYFjKBTvsfILYuExDUI9Xs=;
	b=Yr9DECGznxnjc0TrfplfnWwAypOnfl0t3UaEapgvHFBxLFXjwdbClWW0ZSaU3b1/SfOj0S
	knH1v6lk035WqfBuTR/963Qg2sZdAFgOQ3tgJkDTkfxRpUWANWLD/IvSkM8fDJVXdyctdm
	dyzPjmvK4IBVY3yZrohiTgd1z0NHwhI=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-KF8f_IniNTuGesuYthoHlQ-1; Thu, 07 Dec 2023 09:55:38 -0500
X-MC-Unique: KF8f_IniNTuGesuYthoHlQ-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4647ae7147fso289805137.3
        for <linux-block@vger.kernel.org>; Thu, 07 Dec 2023 06:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701960937; x=1702565737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFUwTkwUasQAuYCMcpY6aWYFjKBTvsfILYuExDUI9Xs=;
        b=kxPhhn+3pT3ArtsW0HK6Z8lTOCiX+DHz1yje4ZbEKkw7JRTsTJNxpEWBs1GPPgWD+u
         AGJroMp6BI+7R207XbmY3lIpD0G1tKiPi/fsf59qnH7zCzLkZwaOYO6N01Ld95fM9LNV
         vQ58eT+ZyEOmQeChNEZD1xeIaKRmvo34KSvMVdgLGYVUsKxzJy+WIme3UuqCgJcBuo5R
         VE/CpcHbFuOOSMDU4XD2SPGzm/Bht0W27I1nFJ2FL17PH+tzjE953T0aM3qSD1Uik/VH
         mmFAmUgRAgiBCvylxY5Ts/nImnP6gOrGYBZ5a5OOWa9Akh8aWfalm7j7tsbDjo1LWSkl
         r9Mw==
X-Gm-Message-State: AOJu0Yw+2/7jcl6yyLbJkUTM2OvBTgkxpD0SXlLcGBmPl0Gnt77kZxOC
	hnny2bTVhKi5+Jbj9DVRn7lucgbjj9tReytoYPSAbQ5oS1ne9832+R9Vrm+eAjQOSIGpjT0aqMo
	nXsxsgv+vQVQfzLV/aAqdhGk5TeI9Vp+nELEmZf0=
X-Received: by 2002:a67:fb0e:0:b0:464:7c84:f2ce with SMTP id d14-20020a67fb0e000000b004647c84f2cemr2428522vsr.33.1701960937524;
        Thu, 07 Dec 2023 06:55:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExPh5/hFE8CE6pwdTcln4SPXa7YsxLmil/VdfPW34AuIerYiD738D5CYb9gwkY7cCXF4lnoAE2qa1q+zUlTFA=
X-Received: by 2002:a67:fb0e:0:b0:464:7c84:f2ce with SMTP id
 d14-20020a67fb0e000000b004647c84f2cemr2428507vsr.33.1701960937193; Thu, 07
 Dec 2023 06:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com> <20231207145159.GB2147383@fedora>
In-Reply-To: <20231207145159.GB2147383@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 7 Dec 2023 15:55:17 +0100
Message-ID: <CABgObfYJUH0hF8QfNUAZS9ztR7LqeHGOXeTa0JO904svJw23_g@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 3:52=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
> > virtio-blk is generally used in cloud computing scenarios, where the
> > performance of virtual disks is very important. The mq-deadline schedul=
er
> > has a big performance drop compared to none with single queue. In my te=
sts,
> > mq-deadline 4k readread iops were 270k compared to 450k for none. So he=
re
> > the default scheduler of virtio-blk is set to "none".
> >
> > Signed-off-by: Li Feng <fengli@smartx.com>
> > ---
> >  drivers/block/virtio_blk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This seems similar to commit f8b12e513b95 ("virtio_blk: revert
> QUEUE_FLAG_VIRT addition") where changing the default sounded good in
> theory but exposed existing users to performance regressions. [...]
> I don't want to be overly conservative. The virtio_blk driver has
> undergone changes in this regard from the legacy block layer to blk-mq
> (without an I/O scheduler) to blk-mq (mq-deadline).

IIRC there were also regressions in both virtio-blk and virtio-scsi
when switching from the legacy block layer to blk-mq. So perhaps I
*am* a bit more conservative, but based on past experience, this patch
seems not to be a great idea for practical use cases.

Paolo

> Performance changed
> at each step and that wasn't a showstopper, so I think we could default
> to 'none' without a lot of damage. Let's just get more data.
>
> Stefan
>
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index d53d6aa8ee69..5183ec8e00be 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device *vd=
ev)
> >       vblk->tag_set.ops =3D &virtio_mq_ops;
> >       vblk->tag_set.queue_depth =3D queue_depth;
> >       vblk->tag_set.numa_node =3D NUMA_NO_NODE;
> > -     vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
> > +     vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED=
_BY_DEFAULT;
> >       vblk->tag_set.cmd_size =3D
> >               sizeof(struct virtblk_req) +
> >               sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> > --
> > 2.42.0
> >

