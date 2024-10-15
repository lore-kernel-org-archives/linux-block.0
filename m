Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5278276
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994533; cv=none; b=V2AReRg8hIiQLawaLQ1MC51CkkoRr8QyAq95Sr0Cbwk2DYTCiIUwrjlwIWrOz7dXtsYNDeexiEAQ6GK9ulC/0ViimMP7twgI6Arna1uzuGS0/9FhV7rgF3WwSHipJgO8308TAp70NBTF+pSDCQE/X8FeFPTiR2Ozi1gw0K62iy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994533; c=relaxed/simple;
	bh=u1V8qrRKdiQ/BpZQ41whQCdHzdLpDEF9SZUqfV0n2MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jz+p0b0O7jid+7wiSs8RN1hHhlelTiQgZzyYc2R4HurN36DmtKZ4u0Qv7kPPr1U2ZGt3ANyHrsorS0w+uamJrDWDspMYuoufyakxMR+4gpwc91DWmxedmTPXOvuGEO6NseHEZnIGuAorMbjq3hr64qUpB08MNI6uYCgQPWi2XDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBZrqH95; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBZrqH95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728994530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq/PQF5lEppp30Xz6W2160dKbLoGKnHh5iasCOZ9FEw=;
	b=gBZrqH95h0/SO5RMd+MlpPkaenWhylABYqlinS3FReQ2EXjN7dVGQQO8IUzOmptE1KIec8
	7vIRLsCr4ExANQbfwCPtbvjOg3f6b3EQN40XMUb0YFnHLDpal03XZv3lqGgjG2sVcBDSz/
	0GiJSA+TemWuJtsHsxAbt+M4Zy9J7dk=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-YlNwFtGpOkOlajpmGFkReg-1; Tue, 15 Oct 2024 08:15:28 -0400
X-MC-Unique: YlNwFtGpOkOlajpmGFkReg-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-50d45b97422so310179e0c.3
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 05:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728994528; x=1729599328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq/PQF5lEppp30Xz6W2160dKbLoGKnHh5iasCOZ9FEw=;
        b=WPhtXNq6pd9rPg9UgPpQk27hZX9J3VPULOVgs2zFSb0aZajgqhdCkGjfO8BcQAR258
         VsWSsnl4tJi1Ltyt2b57J2MOnehc2U9vaTNBt9bzCxHt7EclUMbQ1nsNkyaUWf03+siF
         E18b2K+qRSx4UIQYKLO20FUyr6stDYs9QAuEfynebEjzOkwqqRVHX+PIYBuMnOcKHryA
         BPCikJAJYDwBhgPlji8GMS7cojfeh73/3CyjDsEFRPD75gSNbpdEpx2OdU/me0MalCkE
         vFMzDKKtSHUR0Hyvrpm1JMaK+/YatdV4u8ZZjXoq0XO8xP7eTpZ6MHg+In3bDVt3+G5Y
         Z9QA==
X-Forwarded-Encrypted: i=1; AJvYcCXl228OBmEIwTuncQtzPykyLeveE7hQ2sxncB889Ds9dbI0E+lw80yWBoI3TA9MyAYjvf/lQRXz6QcuGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+rlSEh+jSoliuOQSYPFtCsHdd0mlrOIapsj0DUYWqCSvhJl3
	28RKb0bhcOvmthE9vwjEexcmTFxA3u1cfmHafbuDAmuBw8pR58gcRVWW4iQbQH+U3nDtTncJMKl
	4H3j0gDO6DFu9Cn8dcl5BCifB9f9D7PmXJWsn7c+LKoqwoRl8DNufXTlAzy/eOV2jcGQj+P2bIX
	qCbn1YK4934qUWfFDDkT24uWG1Tfg1fcIYRQZeunfYZc/Uggno
X-Received: by 2002:a05:6122:88a:b0:50c:4b84:dafb with SMTP id 71dfb90a1353d-50d1f56e07cmr10936262e0c.10.1728994528266;
        Tue, 15 Oct 2024 05:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn1pA32UBFCkbb/WQoJDNazzuBco3F3A4TWc8WaKbVDnfzcdcNGxAWSU+Opf1qk6gKxA7vU/zhHsypev0RCbY=
X-Received: by 2002:a05:6122:88a:b0:50c:4b84:dafb with SMTP id
 71dfb90a1353d-50d1f56e07cmr10936241e0c.10.1728994527872; Tue, 15 Oct 2024
 05:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zw5CNDIde6xkq_Sf@redhat.com> <CAFj5m9LXwcH7vc2Fk_i+VhfUA+tevzhciJzKc1am49y_5jgC2Q@mail.gmail.com>
 <Zw5b1mwk3aG01NTg@fedora>
In-Reply-To: <Zw5b1mwk3aG01NTg@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 15 Oct 2024 20:15:17 +0800
Message-ID: <CAFj5m9+x+tiAAKj3dX_WcFczkdSNaR6nguDHm9FXuYjQHd8YcA@mail.gmail.com>
Subject: Re: Kernel NBD client waits on wrong cookie, aborts connection
To: Kevin Wolf <kwolf@redhat.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	nbd@other.debian.org, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 8:11=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Oct 15, 2024 at 08:01:43PM +0800, Ming Lei wrote:
> > On Tue, Oct 15, 2024 at 6:22=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> w=
rote:
> > >
> > > Hi all,
> > >
> > > the other day I was running some benchmarks to compare different QEMU
> > > block exports, and one of the scenarios I was interested in was
> > > exporting NBD from qemu-storage-daemon over a unix socket and attachi=
ng
> > > it as a block device using the kernel NBD client. I would then run a =
VM
> > > on top of it and fio inside of it.
> > >
> > > Unfortunately, I couldn't get any numbers because the connection alwa=
ys
> > > aborted with messages like "Double reply on req ..." or "Unexpected
> > > reply ..." in the host kernel log.
> > >
> > > Yesterday I found some time to have a closer look why this is happeni=
ng,
> > > and I think I have a rough understanding of what's going on now. Look=
 at
> > > these trace events:
> > >
> > >         qemu-img-51025   [005] ..... 19503.285423: nbd_header_sent: n=
bd transport event: request 000000002df03708, handle 0x0000150c0000005a
> > > [...]
> > >         qemu-img-51025   [008] ..... 19503.285500: nbd_payload_sent: =
nbd transport event: request 000000002df03708, handle 0x0000150c0000005d
> > > [...]
> > >    kworker/u49:1-47350   [004] ..... 19503.285514: nbd_header_receive=
d: nbd transport event: request 00000000b79e7443, handle 0x0000150c0000005a
> > >
> > > This is the same request, but the handle has changed between
> > > nbd_header_sent and nbd_payload_sent! I think this means that we hit =
one
> > > of the cases where the request is requeued, and then the next time it
> > > is executed with a different blk-mq tag, which is something the nbd
> > > driver doesn't seem to expect.
> > >
> > > Of course, since the cookie is transmitted in the header, the server
> > > replies with the original handle that contains the tag from the first
> > > call, while the kernel is only waiting for a handle with the new tag =
and
> > > is confused by the server response.
> > >
> > > I'm not sure yet which of the following options should be considered =
the
> > > real problem here, so I'm only describing the situation without tryin=
g
> > > to provide a patch:
> > >
> > > 1. Is it that blk-mq should always re-run the request with the same t=
ag?
> > >    I don't expect so, though in practice I was surprised to see that =
it
> > >    happens quite often after nbd requeues a request that it actually
> > >    does end up with the same cookie again.
> >
> > No.
> >
> > request->tag will change, but we may take ->internal_tag(sched) or
> > ->tag(none), which won't change.
> >
> > I guess was_interrupted() in nbd_send_cmd() is triggered, then the payl=
oad
> > is sent with a different tag.
> >
> > I will try to cook one patch soon.
>
> Please try the following patch:

Oops, please ignore the patch, it can't work since
nbd_handle_reply() doesn't know static tag.

Thanks,

