Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC33C491
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505669; cv=none; b=kgitCsfjGN3c8Hfp6W7piaDyYGE4KW10+zCMP9FovhbnILIEN7RA8KSKwSQzjFETipuNzx7ZAD0zz+G0/7Mgc5LT/SIWaKynXPZbQ72x2QIj3w27FyOuHC3HBKY520qhHlUVrv4l2DH5KUy1uQnk1A5O/rtK5W5ss4va0w1AvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505669; c=relaxed/simple;
	bh=2NgUwvfZdrQh9ZRbSVqH29RAvKgtexOe8rCtXYWRjgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S10FWkKcXm2R+Dnc1YtqXE3qBdPR019Xw95NynKlosTNPV7XJgUqEJYJYETaocf9HD01H9Yz8ju9e1EaKYnedXZ9wlRZHOiBuSPqAsOH41xCjngfbEGglNTf3fYv6Wj/nfQBI0FYV5PZjnmgdQVtrvqvpxnA0COPwQaD5/qyRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iacn0OgR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iacn0OgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708505666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aa6IJ6CRYW0QfS5+/e4MLVcpT9eNEPJElpfVMWa7G1c=;
	b=iacn0OgRECJoBdK8NImAF7RPsh5u+d78LHX3BYZLauKPb0BzHcQmXHodaqLCdJFoCKMZlz
	X2UyJMpbKc3kRJFptRzlk96NrG2jG0MOBFy0GHIlcQ9UHu/FXBPztz1TE7c0QH7+R0DfpK
	6hDBreMogBukFgCxjVx6AKkk4o89c5M=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-iSxUGynYO7uHBrg_eXjmLA-1; Wed, 21 Feb 2024 03:54:24 -0500
X-MC-Unique: iSxUGynYO7uHBrg_eXjmLA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-46d1e3394a0so832631137.0
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 00:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708505664; x=1709110464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aa6IJ6CRYW0QfS5+/e4MLVcpT9eNEPJElpfVMWa7G1c=;
        b=ISHsMNyBHYErTEEC6n/cDoeFJ1v/GrBPLg8IFM9TFQLFCVdcDKAPuNYcPkPUBh78Ln
         H8twcdlUefy0fTzncOS1kWqkpAe3/5ovwmcquAzxtZosSj1DSec8vIOW1hOjyFCXUuAD
         BDyKq+Qv5XT2Kqh2+S6BC3Wp08NO5QD/utwiLw6Fcjxw6ipyzJM17Ju6VDfmwnU+Xn3+
         6+afyKA/kjPqEzeT5ImITPpSxBTz65a+5jQ6GfTCnxKWGd1bMvpYVUWDZaHnQzq5Flul
         EAkIcvb3iNfGKca//0E8dxHYrWZXL7/ovAPjkPxVTlGsZg3j6DQPvTvHgH4EecizM57x
         GybA==
X-Forwarded-Encrypted: i=1; AJvYcCWnCChAa3CXc5V13SkHMVxXJD43r2qVtolxbLM5yULIn96JPm8i8soFa0OU5TKY4Xz21c4mFdHOQ/VYCTqi/kqnc3WbMkonDg+7Rq4=
X-Gm-Message-State: AOJu0YychO/nBnNW7cqQkA2JNFIsyG1wJ8ag/2HOuFR8d/0qCkYg9JCZ
	z8cMWcfICK2KZuNRodyaYwPVKXPWy6DwbzDG2YWQ7rUECd+4E6TDrPvUmNmzNz2jzhnbwobUzYA
	kj9Zcis099TUaY2TaaYiLdMgsJWBqHxzSqdDxhkXww6/ufjABbYe5A1WKuHW7MXQEINIv6umDw4
	gE0dJR0AmJi0dIrW7BrZA3y57elapkkp1oS60=
X-Received: by 2002:a05:6102:c54:b0:471:8752:353e with SMTP id y20-20020a0561020c5400b004718752353emr801292vss.0.1708505664097;
        Wed, 21 Feb 2024 00:54:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqHgupk1BTFecC2Ow7PC6zkxJPt+D1G20Tzfc7ybhs5+zWguGx8LWDYO4u2atQojdw11SN5ESq6rbVU8WY3uY=
X-Received: by 2002:a05:6102:c54:b0:471:8752:353e with SMTP id
 y20-20020a0561020c5400b004718752353emr801285vss.0.1708505663776; Wed, 21 Feb
 2024 00:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220204127.1937085-1-kbusch@meta.com> <132449a7-634c-41b6-b14c-863cb198133e@nvidia.com>
 <ZdVrDbaQ2DbSKQtL@kbusch-mbp>
In-Reply-To: <ZdVrDbaQ2DbSKQtL@kbusch-mbp>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 21 Feb 2024 16:54:12 +0800
Message-ID: <CAFj5m9Jf-WXLoTEtok_+FzuAUEcRRoO+-DaPCh2U-884D2uXdw@mail.gmail.com>
Subject: Re: [PATCH] blk-lib: let user kill a zereout process
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@meta.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "axboe@kernel.org" <axboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:16=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Wed, Feb 21, 2024 at 03:05:30AM +0000, Chaitanya Kulkarni wrote:
> > On 2/20/24 12:41, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > @@ -190,6 +190,8 @@ static int __blkdev_issue_zero_pages(struct block=
_device *bdev,
> > >                             break;
> > >             }
> > >             cond_resched();
> > > +           if (fatal_signal_pending(current))
> > > +                   break;
> > >     }
> > >
> > >     *biop =3D bio;
> >
> > We are exiting before completion of the whole I/O request, does it make=
s
> > sense to return 0 =3D=3D success if I/O is interrupted by the signal ?
> > that means I/O not completed, hence it is actually an error, can we ret=
urn
> > the -EINTR when you are handling outstanding signal ?
>
> I initially thought so too, but it doesn't matter. Once the process
> returns to user space, the signal kills it and the exit status reflects
> accordingly. That's true even before this patch, but it would just take
> longer for the exit.

The zeroout API could be called from FS code in user context, and this way
may confuse FS code, given it returns successfully, but actually it does no=
t.

Thanks,

