Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB902036F3
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344632; cv=none; b=rFzbE7Ar4go/mZ6QwNtnyB+PDRuqBCiVBlb4D6yddfuCzLmj+nWka4/HA1+byjYd755sgrsHNK5loY9Y4amtoU8P+ig0oBYYvOxBfqctNBv56+Q2YsWvpsmg2q23D54ANUmWm4J7ZKRglZMhXdIZqGu6aAunyDVyBIwvJqVuVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344632; c=relaxed/simple;
	bh=2XX3E0IH8ishDR9MK6kWsOiO7vDqmqVnxmnRnxHXd1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOksbufev+woowuFJlTkUjw12xAIQxU8SiKrVO/V/1axRw8qoRPhBR35oJr4vJJalPXwHNkbjdW0EGsgh2cNRkHwLSEzDcfyAZbMbo9VCjQKSAfdT1+V1gyuZvBXqyMxabisVuou7zvc4Vu/I70CGkgDuucsC3FWWoiG+5g4dwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUVhrB4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUVhrB4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734344629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJcwxIokippDLEGmOLSsMdzfJJziVp7aAF/Ta+P0mDo=;
	b=hUVhrB4aaVtQNgMU88CMnozzOaOdywNVw5wgHOLU6njYAmH6AB0Qsm5foQINvvsGb8s8ck
	mQNsmq/8dzUQu/cgytB31wzGNyoIOUhBcIH765uM4uhCxGKiO8tbpL9L2kyBA83cwQcJZq
	u8A4tx8G1VKgb9xWvJYgE/dAEN4tOms=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-Go2GwshpOd2N_Bp9tz0iwQ-1; Mon, 16 Dec 2024 05:23:48 -0500
X-MC-Unique: Go2GwshpOd2N_Bp9tz0iwQ-1
X-Mimecast-MFC-AGG-ID: Go2GwshpOd2N_Bp9tz0iwQ
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4afe8c469f3so2758862137.0
        for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 02:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344628; x=1734949428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJcwxIokippDLEGmOLSsMdzfJJziVp7aAF/Ta+P0mDo=;
        b=E9w45+6gsXkAZznUCSmzW9FANnKee4qMezBzvTgQG9hPlfY8wIBZlyRLE7VPCMI12r
         HCZOrn6ffqlrZLCy/4MIBK97/2w8YhqyKvVmLhF+cF/d3kxuj7DLBEwnTX3iQp8IJob5
         qnm+SyiixlrmvhVK14kHGFQGkfNrqlXmF5FHRJQeq/EMghyAApa61THUFJ6HhIlTXcJx
         htP54Ik6/cHXbxTMK+RhbkhAmPT29a/UsGj5/vGbjSUN8Dy+qlmVLOnMAzZqp992Zron
         4KLQjeopDy+SGfMvMmUbDYC9x4Vgp8UDapwpwRMuLxet7uxo5jwCePzj2/EH8FGoJhF/
         Vi4g==
X-Forwarded-Encrypted: i=1; AJvYcCWWe2ScLVk+JyPNtylF5RA11QMQ+zYzSzUuqUfn3pcZ3x4N8fVmZDHPdt+UkgQoIyrgp29vu2Fx8VQgtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/ycK8sPAl4at3al6TqvYeu1gJGETgJZuf4Mwue7nrzjBinpS
	mvuzsVz35I4vY4zJHDYQHffUbtFxc2akp5kGgQvq6WrbW5z/jDaKI6gnXl7V0YHk0h0tTz10pq9
	cTUugAz6jqEED+8H17WOUBvA3wD6hp4wPoPMoNTFgbElG0hu54DADD8Wg0aHIBLkkBUwnANTusk
	lm6qBTUEA/jej36wluOxTg1tb8/Kp7bwmRZqM=
X-Gm-Gg: ASbGncs7bL25W4WHlTmbN9D3vrzouxRJFIUaHf23V2b3YXgaZcIHvcwDaZDFvYNj2/X
	Vu4Kb+xIlx3D2ypEJVE5VtbVcSrdqqm/a6/mzjJY=
X-Received: by 2002:a05:6102:4429:b0:4b2:49ff:e470 with SMTP id ada2fe7eead31-4b25db3af8dmr10656211137.21.1734344628081;
        Mon, 16 Dec 2024 02:23:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWgSqRtLOuNkBzntYjpPcstXq1/HmQRBLuSGUi/bM5OVCIjhSFTH920y7viqRb3c8aGdcrUoqEC78K21wnR44=
X-Received: by 2002:a05:6102:4429:b0:4b2:49ff:e470 with SMTP id
 ada2fe7eead31-4b25db3af8dmr10656192137.21.1734344627848; Mon, 16 Dec 2024
 02:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214031050.1337920-1-mcgrof@kernel.org> <20241214031050.1337920-10-mcgrof@kernel.org>
 <9fadee49-b545-440e-b0c9-e552bec1f079@oracle.com> <CAFj5m9J0Lkr9hYx_3Vm2krC9Ja5+-xjmqkqjVjY0jvimjWbmTw@mail.gmail.com>
 <f872429f-9c81-444b-a4ea-ecb5af495e51@oracle.com>
In-Reply-To: <f872429f-9c81-444b-a4ea-ecb5af495e51@oracle.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 16 Dec 2024 18:23:37 +0800
Message-ID: <CAFj5m9JOOS8yQSk1jksJdYz-wqQT8aAAQG08J-wWg2OF2jc3nQ@mail.gmail.com>
Subject: Re: [RFC v2 09/11] block/bdev: lift block size restrictions and use
 common definition
To: John Garry <john.g.garry@oracle.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de, hare@suse.de, 
	dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org, 
	ritesh.list@gmail.com, kbusch@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	kernel@pankajraghav.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 6:14=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 16/12/2024 09:19, Ming Lei wrote:
> > On Mon, Dec 16, 2024 at 4:58=E2=80=AFPM John Garry <john.g.garry@oracle=
.com> wrote:
> >>
> >> On 14/12/2024 03:10, Luis Chamberlain wrote:
> >>> index 167d82b46781..b57dc4bff81b 100644
> >>> --- a/block/bdev.c
> >>> +++ b/block/bdev.c
> >>> @@ -157,8 +157,7 @@ int set_blocksize(struct file *file, int size)
> >>>        struct inode *inode =3D file->f_mapping->host;
> >>>        struct block_device *bdev =3D I_BDEV(inode);
> >>>
> >>> -     /* Size must be a power of two, and between 512 and PAGE_SIZE *=
/
> >>> -     if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
> >>> +     if (blk_validate_block_size(size))
> >>>                return -EINVAL;
> >>
> >> I suppose that this can be sent as a separate patch to be merged now.
> >
> > There have been some bugs found in case that PAGE_SIZE =3D=3D 64K, and =
I
> > think it is bad to use PAGE_SIZE for validating many hw/queue limits, w=
e might
> > have to fix them first.
>
> I am just suggesting to remove duplicated code, as these checks are same
> as blk_validate_block_size()

My fault, misunderstood your point as pushing this single patch only.

>
> >
> > Such as:
>
> Aren't the below list just enforcing block layer requirements? And so
> only block drivers need fixing for PAGE_SIZE > 4K (or cannot be used for
> PAGE_SIZE > 4K), right?

It is block layer which should be fixed to support  PAGE_SIZE > 4K.

Thanks,

