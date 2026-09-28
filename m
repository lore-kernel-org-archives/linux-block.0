Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C674E021E
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608157; cv=pass; b=E2ECxBO5rbEMLHEPQ45uhLb7Ren2xVa/VB6IofrBrDIyA4Hzu6bvsMEkSGoH+5E/QV7i7se0kd/9jACZXasn03ZLXci5isYonkccubHUTys0mtza8POudLoqrGtkj3m2A2SZWvngNKLSvQtXXoB1ffF70MrRUAQvEIUZoqLUJd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608157; c=relaxed/simple;
	bh=tf/lMLnfEkd4XBBYB0HDsWtgBfU2mvcJMYwKWgwYVE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xp/cKKjLnNNN5wfJEL4mbiNE0KVzIx+XX0CsvCSNKyfBS/9wUP3qeTLzWor82HUzreFp+kBuVL5HDf0EvEmplRN/LsdO2S/Fp3Pc9pt+B+i7YhuHv2g9jvLPNcG5f1g+hvUoMgS3TgTRHpQdOCJXuGIOc2SPobMhT0MbEOggwr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKbbKIZH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZS44mltT; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKbbKIZH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZS44mltT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790608154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JzwIQlJou2cKoXFRlxragLvVGFjjNACZv+ODl0Exo0=;
	b=cKbbKIZHpZwAH8xn+7V79o5tlYaqZ98mPmJJg4E56uwebLgsJhwpXnxhFacbIUdDWODvQ9
	h74iQY2/XDIddfpAUQbn4xSRWqyMVjsJFimn/6wtyzC/W2MG6G0AoCT3rIcAbUdWivMZO6
	vxhzHdlT/jpInlbpYnqAW+7IKtEGQ+Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-wVZwrlP8PRWRzKZzV9LIvg-1; Mon, 28 Sep 2026 11:09:13 -0400
X-MC-Unique: wVZwrlP8PRWRzKZzV9LIvg-1
X-Mimecast-MFC-AGG-ID: wVZwrlP8PRWRzKZzV9LIvg_1790608152
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-486f18da958so2206297f8f.0
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 08:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608152; cv=none;
        d=google.com; s=arc-20260327;
        b=onQ83SxhBZM5wJn4Gll38DaVDzQsTAqJihxjhmWdE4zZG4Evi1BvJ5SvWQHuQ2zjI1
         9eMl2aFOD9YfrTnOQtV2ooW1KmJyLZPLGBpNZjZssNCyzCsO8LA5pTqtxK0uR2rMOgs7
         XXmCCOZNAANGGhxnLHfQWOJRLLhhJ5d/3lyxFSzzGOMDXQI1G8rfR4+0xF+K0ED0W2zO
         r0AuJBCUfGUnWqVLhaZgRCq2OPu2Z1VcdzYL2nmKkK18z6/DIgT0u4wPv9n1VTC5KERR
         XL35PPMN2N+RseNgIpwDJAjG8CYpZovEVhfxhIRdqYDlCQj/OdNKKuY7Eqbf/zLBXVmU
         BupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7JzwIQlJou2cKoXFRlxragLvVGFjjNACZv+ODl0Exo0=;
        fh=j/LlMtc4QH0I3mfw4FWdh72uvPtFy2fvalwZxFSUUUQ=;
        b=AM57ZCpWpjWuzr1JMo+qMv6tke4MB1nCrxtpdwsrjJ37aG22nHFRO67EbRYV8GMIa7
         rnrD2aj0kCtmFFqGvY3GSLKRN+FORh/d2rz9c692c2zr0mWgkO3/1rX0hAXuMffQmgdF
         DLnuZMeHtsMWE87zIco8t3DmwHrD9WVHfg4saQ9dCFIM20D6HNb7mIPx6tGHEhP8CRjj
         42hoa3UQHTeZsSGZ8PO7bgvk2Jvxb9fpL1lNJhl5RL00yfSWuaMKXbV7ycEEhYbtGMVi
         M40Jva5yyKG6HSrzHdMKA6V1pPxxmAWgfWrK2amHf5xIjvQ83aWVwyDT5PeNaskJORWQ
         0c1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790608152; x=1791212952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7JzwIQlJou2cKoXFRlxragLvVGFjjNACZv+ODl0Exo0=;
        b=ZS44mltTmMf0SyNxMZyeKj2hlI1jstoJYS3HkeryJ83V+5l7tCNohVRT/AQt3rpA9C
         sIQCirdNUtuQLy6nN7+uGDH9K14nxGz3UJe08tUBpuGEreNiLnjxf79QrS9jB12LttT+
         ZbL/BL2pP3g8GLWRr3NBm7SztBKA+77LG8fHLIMQWEqxDZsKdjSccbXQFBMxTtTXtYIQ
         cgMGptMREIzj2YovrtJbRrSfIcznsk5IF2uf1R5+z/I2tX3qhNyd/2wEvO1+vVaHjX7a
         6OQMGtUV6yWsS490D+EhkKYUmv0kF0czjUAk8ZJLxW+sfeBV0Z91zDMTtQtdlXheijhd
         o8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608152; x=1791212952;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JzwIQlJou2cKoXFRlxragLvVGFjjNACZv+ODl0Exo0=;
        b=ui3jnHYjtAfce4884lVAShAD6JGCpG0yRBvQPa4tlAJGx+f/pEb7oxEWGNCxsZzaT/
         lyAxWUfjjvua3eYPqiz0yqD6rLaTCXKkCOJjJKDS/+oBPK0KtFXJFB5DTXkMeBw3aDz3
         FOKn8tbU8Kyo8DpM6p7D2BluMijfHukldX0CBXxhJex+Wy4pzmtIHnuTjQC7m2YJ8Rne
         XRDPUqhQSkghKRySSICoMw2nZ1WuuKA1AWWkvbQ3jbl+aYMNpuADvV6mislWbX77Zb7c
         vfJHBtHmrOjxGALU8SmO1U+oHdZsUhaNFgztysM8Mv+3RX+Wnc+7sZ3D/TxbYbHTYdkT
         8NTQ==
X-Forwarded-Encrypted: i=1; AKwUvByG0iQiFiw9M1ObReIEbw2ogpnGAEMMinrLcloxS+CfUlo3+IkI/HPw8a+sORNkaGpKMQgwzryUrxBdaw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLfMvVpGGHxiOY2tIXMDYZfsRy9igelpEiScHmmzmD5vR15vUED
	/2exrTfR4UhghRaRMu6MnPTUyuDEaehkdpFQc2zgOdc2zgQRyJ5p+raX4NhE90ofiEOHFMaHEVX
	jiK4dzOugzubVmzUqhoEVf+koGSLw8rXBBarH0Gl6ENvBxtbME1mMBEgHL5L2yP67so44S9ztHr
	dpcI9oYJhRYTbkz4++w/zAdOgminxFoK/OSG2EcwA=
X-Gm-Gg: AYBFou0ymItA219EJhA/NlzbrK2tlH1UXKeagFBrby6TqbfelyOYInIctvsa2YfeOg7
	GWfVY8l7wBhgPzYTlBz654IE54DyzENP67Lqjf0YeI1yAV+7N0qvROlrtavxxnXHaZJRA0F7mvN
	8HOrC9aEHIIprTBhmLGoMD31++hdSi6ne7rzEiuFuNCXc0snWIjdC35MkG0M0PuWxZ+7mY6BGie
	ESmSSCpjZJEPcX67g==
X-Received: by 2002:a05:6000:2083:b0:487:342:eb28 with SMTP id ffacd0b85a97d-488716f2354mr27611166f8f.24.1790608151741;
        Mon, 28 Sep 2026 08:09:11 -0700 (PDT)
X-Received: by 2002:a05:6000:2083:b0:487:342:eb28 with SMTP id
 ffacd0b85a97d-488716f2354mr27611104f8f.24.1790608151341; Mon, 28 Sep 2026
 08:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902200547.184734-1-jtaubepe@redhat.com> <20260902200547.184734-8-jtaubepe@redhat.com>
 <ab97f32b-31dd-4975-a8b2-b445110ae3a9@suse.de> <CADRr4bePoiDnWX_XrMWtQe=1g4Yrw1_dK86EV2k9XZR0HnL+UQ@mail.gmail.com>
 <d4879e78-2735-4f86-beab-8aa319e9162c@suse.de> <CADRr4bcSvLwzfSiV0LTxnhZR7oo3F1b2XEo+wwqi668Gr2BBQA@mail.gmail.com>
 <a7a60b61-24b4-429b-8ccb-ee5b6f06a5ed@suse.de>
In-Reply-To: <a7a60b61-24b4-429b-8ccb-ee5b6f06a5ed@suse.de>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Mon, 28 Sep 2026 11:08:59 -0400
X-Gm-Features: AclHuK8rEa0dRLnGnsUacjiVX3fDsEVHWVQeb9zJZDMDBAnfAXNWF2dGmvnsVw0
Message-ID: <CADRr4bfJtQOKYFjDoR+khaPvQW6-UzN70pZ-nfGJnQ22nUkskw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] nvme: fcloop: Add set_marginal_rport to sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, John Meneghini <jmeneghi@redhat.com>, 
	Bryan Gurney <bgurney@redhat.com>, Chris Leech <cleech@redhat.com>, 
	"Ewan D . Milne" <emilne@redhat.com>, shinichiro.kawasaki@wdc.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:10=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 9/23/26 6:16 PM, Jesse Taube wrote:
> > On Wed, Sep 23, 2026 at 11:34=E2=80=AFAM Hannes Reinecke <hare@suse.de>=
 wrote:
> >>
> >> On 9/23/26 4:56 PM, Jesse Taube wrote:
> >>> On Mon, Sep 21, 2026 at 10:03=E2=80=AFAM Hannes Reinecke <hare@suse.d=
e> wrote:
> >>>>
> [ .. ]
> >>>>> @@ -1671,6 +1719,7 @@ static DEVICE_ATTR(del_remote_port, 0200, NUL=
L, fcloop_delete_remote_port);
> >>>>>     static DEVICE_ATTR(add_target_port, 0200, NULL, fcloop_create_t=
arget_port);
> >>>>>     static DEVICE_ATTR(del_target_port, 0200, NULL, fcloop_delete_t=
arget_port);
> >>>>>     static DEVICE_ATTR(set_cmd_drop, 0200, NULL, fcloop_set_cmd_dro=
p);
> >>>>> +static DEVICE_ATTR(set_marginal_rport, 0200, NULL, fcloop_set_marg=
inal_rport);
> >>>>>
> >>>>>     static struct attribute *fcloop_dev_attrs[] =3D {
> >>>>>         &dev_attr_add_local_port.attr,
> >>>>> @@ -1680,6 +1729,7 @@ static struct attribute *fcloop_dev_attrs[] =
=3D {
> >>>>>         &dev_attr_add_target_port.attr,
> >>>>>         &dev_attr_del_target_port.attr,
> >>>>>         &dev_attr_set_cmd_drop.attr,
> >>>>> +     &dev_attr_set_marginal_rport.attr,
> >>>>>         NULL
> >>>>>     };
> >>>>>
> >>>> Please don't make it a fabrics option.
> >>>
> >>> What do you mean by fabrics option? How should I fix this?
> >>>
> >> Your patch does two things; one is to modify the parser in
> >> fcloop_parse_options, and the other is to implement a new
> >> sysfs rport attribute 'set_marginal_rport()'.
> >> My suggestion is to drop the first part;
> >
> > You want to drop the parser?
> >
> Yes. 'set_marginal_rport()' sets a boolean value.
> You don't really need a parser for that.

Yes, but we need the parser to get the WWPN and WWNN.

Thanks,
Jesse Taube
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>

