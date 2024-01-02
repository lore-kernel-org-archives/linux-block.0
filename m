Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52284171B9
	for <linux-block@vger.kernel.org>; Tue,  2 Jan 2024 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx9hJG3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704233518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBOv2jm2vjkJK88t9NbUPVCUIzSLH16o/dGCZ37tOWs=;
	b=Tx9hJG3mZktLh9g2RKUU7RXpOsDllfXZYaR6l65OKvN+d9kLuRV5rZ1CNkefmPfP1+g/f/
	eb1sgBmnnt8ZXcQ3reihgJLjN1X6bPqzXcIoqqBCP2qkDhPYCVullJcliT5vJNcw0SquU+
	qpDlm9CORFpR6OAuaTnFXMEctBgLXcQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-PsybdUqqNPG6qTnyqyqHmg-1; Tue, 02 Jan 2024 17:11:56 -0500
X-MC-Unique: PsybdUqqNPG6qTnyqyqHmg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5e73bd9079eso181350727b3.2
        for <linux-block@vger.kernel.org>; Tue, 02 Jan 2024 14:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704233516; x=1704838316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBOv2jm2vjkJK88t9NbUPVCUIzSLH16o/dGCZ37tOWs=;
        b=OwvuyYGEJuQVIoIYjdiB72rVhsWvmcUbXybtdDmew/H9N/i6uPYuF50J20+KXGzUF2
         JiP42x++uM4R8nT6+DmoV77XKJy2L42mPH6OPJRjrgJfnndV4AnMiBbIw8jfqQbefFQg
         XOrkF9H4iUDXKSnqecxZ/8rN8RMKkdr+7B19Ue1QkPT8x67jCrStiGqhd02IJCIDNm3z
         oRaAKzJ0v2D6hO47r4JmeNwg5ojPkIUN3yty2u7P/69D2NzK2IxG63FWAo8HSE0FgFso
         QyHzOG9xQjqQZpOTG08sDvX27MIg89A5K+bz7IUQZIMry0y8LXRKFa+fdBX0kI5viYOx
         Mh+Q==
X-Gm-Message-State: AOJu0Ywj+YuxqErf/2Tjwmkm93KWTYVT4/IIPECtUMKFhgw43IpTm/rT
	wnQ5gqwPd8rOp/dCgKwgTLRh6Gtmi65Q46ygglgJqvPSJMY6XZJz0RrJ5IxtN0fGNLkQnDhBTfX
	kFHDQP7ndAtHySphMsHgfOzkhiN1k4SdavZBWnsRsNnEIJH8=
X-Received: by 2002:a0d:e615:0:b0:5e7:5246:8f7b with SMTP id p21-20020a0de615000000b005e752468f7bmr10650773ywe.79.1704233516165;
        Tue, 02 Jan 2024 14:11:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnz4shpbyeonHylop6FDEDEEVcbaCqR7iBp2aclsXjzz7g8rllaGLNWxCJxvlxS1qvAvVXIZDM72VDn9UiZCA=
X-Received: by 2002:a0d:e615:0:b0:5e7:5246:8f7b with SMTP id
 p21-20020a0de615000000b005e752468f7bmr10650769ywe.79.1704233515934; Tue, 02
 Jan 2024 14:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228075545.362768-1-hch@lst.de> <20231228075545.362768-4-hch@lst.de>
In-Reply-To: <20231228075545.362768-4-hch@lst.de>
From: John Pittman <jpittman@redhat.com>
Date: Tue, 2 Jan 2024 17:11:19 -0500
Message-ID: <CA+RJvhwg3YXAzSk81nMGw=_3OMo6P=XcXBUFUAXSBcyXH6gkDg@mail.gmail.com>
Subject: Re: [PATCH 3/9] block: default the discard granularity to sector size
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Josef Bacik <josef@toxicpanda.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
	nbd@other.debian.org, linux-bcache@vger.kernel.org, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph, is there a reason you used 512 instead of SECTOR_SIZE
from include/linux/blk_types.h?  Thanks!

On Thu, Dec 28, 2023 at 2:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Current the discard granularity defaults to 0 and must be initialized by
> any driver that wants to support discard.  Default to the sector size
> instead, which is the smallest possible value, and a very useful default.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index ba6e0e97118c08..d993d20dab3c6d 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -48,7 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>         lim->max_discard_sectors =3D 0;
>         lim->max_hw_discard_sectors =3D 0;
>         lim->max_secure_erase_sectors =3D 0;
> -       lim->discard_granularity =3D 0;
> +       lim->discard_granularity =3D 512;
>         lim->discard_alignment =3D 0;
>         lim->discard_misaligned =3D 0;
>         lim->logical_block_size =3D lim->physical_block_size =3D lim->io_=
min =3D 512;
> @@ -309,6 +309,9 @@ void blk_queue_logical_block_size(struct request_queu=
e *q, unsigned int size)
>
>         limits->logical_block_size =3D size;
>
> +       if (limits->discard_granularity < limits->logical_block_size)
> +               limits->discard_granularity =3D limits->logical_block_siz=
e;
> +
>         if (limits->physical_block_size < size)
>                 limits->physical_block_size =3D size;
>
> --
> 2.39.2
>
>

